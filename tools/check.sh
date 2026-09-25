#!/usr/bin/env bash
# Local + CI gate: static audit, escape reject, bend PROOF.bend
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${ROOT}"

# Prefer repo-local prefix if present
if [[ -x "${ROOT}/.bend-prefix/bin/bend" ]]; then
  export PATH="${ROOT}/.bend-prefix/bin:${PATH}"
fi

echo "==> static inventory and proof audit"
python3 tools/static_audit.py

echo "==> reject proof escapes"
# Exclude local Bend install prefix and VCS metadata
if grep -R -n -E '@unsafe|\?TODO|^[[:space:]]*def[[:space:]]+[A-Za-z0-9_.]+\?' \
  --include='*.bend' \
  --exclude-dir='.bend-prefix' \
  --exclude-dir='.git' \
  --exclude-dir='__pycache__' \
  .; then
  echo 'unsafe Bend proof escape detected' >&2
  exit 1
fi
grep -F 'import ./LAWS.bend as Laws' PROOF.bend >/dev/null

if ! command -v bend >/dev/null 2>&1; then
  echo "bend not found on PATH; run: bash tools/install_bend.sh" >&2
  exit 1
fi

echo "==> bend PROOF.bend ($(command -v bend))"
bend PROOF.bend

echo "==> differential model vs LAWS.bend"
python3 tools/differential/run.py

echo "==> deontic exhaustive pair check (8778 pairs at 2026)"
python3 tools/deontic/check.py

if [[ "${LAWS_SKIP_MUTATION:-0}" != "1" ]]; then
  echo "==> mutation suite (every mutant must be killed)"
  python3 tools/mutation/run.py
fi

echo "check ok"
