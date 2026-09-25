#!/usr/bin/env bash
# Install pinned Bend from pins/bend.json (single source of truth).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
PIN_FILE="${ROOT}/pins/bend.json"

if [[ ! -f "${PIN_FILE}" ]]; then
  echo "missing pin file: ${PIN_FILE}" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required to read ${PIN_FILE}" >&2
  exit 1
fi

OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH_RAW="$(uname -m)"
case "${ARCH_RAW}" in
  x86_64|amd64) ARCH="x64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *)
    echo "unsupported architecture: ${ARCH_RAW}" >&2
    exit 1
    ;;
esac

case "${OS}" in
  linux) PLATFORM="linux-${ARCH}" ;;
  darwin) PLATFORM="darwin-${ARCH}" ;;
  *)
    echo "unsupported OS: ${OS}" >&2
    exit 1
    ;;
esac

eval "$(
  PIN_FILE="${PIN_FILE}" PLATFORM="${PLATFORM}" python3 - <<'PY'
import json, os, shlex
pin = json.load(open(os.environ["PIN_FILE"]))
plat = os.environ["PLATFORM"]
art = pin["artifacts"].get(plat)
if not art:
    raise SystemExit(f"no artifact for platform {plat}")
print(f"VERSION={shlex.quote(pin['version'])}")
print(f"REPO={shlex.quote(pin['repo'])}")
print(f"TAG={shlex.quote(pin['tag'])}")
print(f"ARTIFACT_NAME={shlex.quote(art['name'])}")
print(f"ARTIFACT_SHA256={shlex.quote(art['sha256'])}")
print(f"BASE_GLOB={shlex.quote(pin.get('base_bend_path_glob', '*/bend2/base.bend'))}")
PY
)"

# Resolve install prefix
REPO_PREFIX="${ROOT}/.bend-prefix"
if [[ -n "${PREFIX:-}" ]]; then
  :
elif [[ -n "${DESTDIR:-}" ]]; then
  PREFIX="/usr/local"
else
  if [[ -w /usr/local/bin ]] 2>/dev/null || (command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null); then
    PREFIX="/usr/local"
  else
    PREFIX="${REPO_PREFIX}"
  fi
fi

# DESTDIR is prepended for staged installs (optional)
INSTALL_ROOT="${DESTDIR:-}${PREFIX}"

BIN_DIR="${INSTALL_ROOT}/bin"
BEND2_DIR="${INSTALL_ROOT}/bend2"

# Idempotent: already installed at this prefix with matching binary
if [[ -x "${BIN_DIR}/bend" && -f "${BEND2_DIR}/base.bend" ]]; then
  # Re-run is fine; still verify we can refresh from pin if needed.
  :
fi

WORKDIR="$(mktemp -d "${TMPDIR:-/tmp}/bend-install.XXXXXX")"
cleanup() { rm -rf "${WORKDIR}"; }
trap cleanup EXIT

TARBALL="${WORKDIR}/${ARTIFACT_NAME}"
URL="https://github.com/${REPO}/releases/download/${TAG}/${ARTIFACT_NAME}"

echo "Installing Bend ${VERSION} (${PLATFORM}) -> ${INSTALL_ROOT}"
echo "Downloading ${URL}"
curl -fL --retry 3 -o "${TARBALL}" "${URL}"

ACTUAL_SHA="$(
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "${TARBALL}" | awk '{print $1}'
  else
    shasum -a 256 "${TARBALL}" | awk '{print $1}'
  fi
)"
if [[ "${ACTUAL_SHA}" != "${ARTIFACT_SHA256}" ]]; then
  echo "sha256 mismatch for ${ARTIFACT_NAME}" >&2
  echo "  expected: ${ARTIFACT_SHA256}" >&2
  echo "  actual:   ${ACTUAL_SHA}" >&2
  exit 1
fi
echo "sha256 ok: ${ACTUAL_SHA}"

EXTRACT_DIR="${WORKDIR}/extract"
mkdir -p "${EXTRACT_DIR}"
tar -xzf "${TARBALL}" -C "${EXTRACT_DIR}"

BEND_BIN="$(find "${EXTRACT_DIR}" -type f -name bend -perm -111 | head -n 1)"
BASE_BEND="$(find "${EXTRACT_DIR}" -type f -path '*/bend2/base.bend' | head -n 1)"
if [[ -z "${BEND_BIN}" || -z "${BASE_BEND}" ]]; then
  echo "could not locate bend binary or bend2/base.bend in archive" >&2
  find "${EXTRACT_DIR}" -type f | head -50 >&2 || true
  exit 1
fi

maybe_sudo() {
  if [[ -w "$(dirname "$1")" ]] 2>/dev/null || [[ -w "$1" ]] 2>/dev/null; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    "$@"
  fi
}

# Create dirs (use sudo only when needed)
mkdir_install() {
  local dir="$1"
  if mkdir -p "${dir}" 2>/dev/null; then
    return 0
  fi
  if command -v sudo >/dev/null 2>&1; then
    sudo mkdir -p "${dir}"
  else
    echo "cannot create ${dir}" >&2
    exit 1
  fi
}

install_file() {
  local mode="$1" src="$2" dest="$3"
  if install -m "${mode}" "${src}" "${dest}" 2>/dev/null; then
    return 0
  fi
  if command -v sudo >/dev/null 2>&1; then
    sudo install -m "${mode}" "${src}" "${dest}"
  else
    echo "cannot install ${src} -> ${dest}" >&2
    exit 1
  fi
}

copy_tree() {
  local src="$1" dest="$2"
  if cp -R "${src}/." "${dest}/" 2>/dev/null; then
    return 0
  fi
  if command -v sudo >/dev/null 2>&1; then
    sudo cp -R "${src}/." "${dest}/"
  else
    echo "cannot copy ${src} -> ${dest}" >&2
    exit 1
  fi
}

mkdir_install "${BIN_DIR}"
mkdir_install "${BEND2_DIR}"
install_file 0755 "${BEND_BIN}" "${BIN_DIR}/bend"
copy_tree "$(dirname "${BASE_BEND}")" "${BEND2_DIR}"

test -x "${BIN_DIR}/bend"
test -f "${BEND2_DIR}/base.bend"

# Smoke check if this prefix is already on PATH or we can invoke directly
"${BIN_DIR}/bend" --help >/dev/null

echo "Installed: ${BIN_DIR}/bend"
echo "Stdlib:    ${BEND2_DIR}/base.bend"

case ":${PATH}:" in
  *":${BIN_DIR}:"*) ;;
  *)
    if [[ "${PREFIX}" == "${REPO_PREFIX}" || "${INSTALL_ROOT}" == "${REPO_PREFIX}"* ]]; then
      echo
      echo "Add Bend to your PATH for this shell:"
      echo "  export PATH=\"${BIN_DIR}:\$PATH\""
    fi
    ;;
esac
