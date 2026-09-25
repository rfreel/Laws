#!/usr/bin/env python3
"""Mutation-test runner for the Laws gate (TASKS.md item 2).

For each mutant in mutants.py: copy the repo to a temp dir (never touching
the working tree), apply the mutant, run `bash tools/check.sh` and
`python3 tools/differential/run.py`, and assert the gate FAILS. A mutant
neither check catches is a SURVIVOR: reported loudly, suite exits 1.

Usage: python3 tools/mutation/run.py [--keep] [--only NAME,...]
"""
import os
import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from mutants import MUTANTS  # noqa: E402

ROOT = Path(__file__).resolve().parents[2]
BEND_BIN = Path.home() / ".bend" / "bin"

ENV = dict(os.environ, BEND_NO_TELEMETRY="1",
           PATH=f"{BEND_BIN}:{os.environ.get('PATH', '')}")

COPY_IGNORE = {".git", ".bend-prefix", "__pycache__"}


def run(cmd, cwd, timeout):
    p = subprocess.run(cmd, cwd=cwd, env=ENV, timeout=timeout,
                       stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                       text=True)
    return p.returncode, p.stdout


def apply_mutant(tmp_root: Path, m: dict):
    target = tmp_root / m["file"]
    if m["kind"] == "replace":
        text = target.read_text()
        n = text.count(m["old"])
        assert n == m["count"], (
            f"mutant {m['name']}: expected {m['count']} occurrence(s) of "
            f"pattern in {m['file']}, found {n}")
        target.write_text(text.replace(m["old"], m["new"]))
    elif m["kind"] == "func":
        m["func"](tmp_root)
    else:
        raise AssertionError(f"unknown mutant kind {m['kind']}")


def classify_check_failure(output: str) -> str:
    """Which check.sh stage failed?"""
    if "unsafe Bend proof escape detected" in output:
        return "escape"
    if "==> reject proof escapes" not in output:
        return "audit"          # died in the static-audit stage
    if "==> bend PROOF.bend" not in output:
        return "escape"         # died in the grep stage
    return "bend"                # died running bend PROOF.bend


def main():
    only = None
    keep = False
    for a in sys.argv[1:]:
        if a == "--keep":
            keep = True
        elif a.startswith("--only="):
            only = set(a.split("=", 1)[1].split(","))
        else:
            print(f"unknown arg {a}", file=sys.stderr)
            return 2

    # Control run on the pristine tree: the gate must be green before mutants.
    print("== control: unmutated tree ==")
    rc1, out1 = run(["bash", "tools/check.sh"], ROOT, 300)
    rc2, out2 = run(["python3", "tools/differential/run.py"], ROOT, 300)
    print(f"   check.sh -> {rc1}; differential -> {rc2}")
    if rc1 != 0 or rc2 != 0:
        print("CONTROL FAILED: gate is not green on the unmutated tree; "
              "aborting.", file=sys.stderr)
        print(out1[-2000:], file=sys.stderr)
        print(out2[-2000:], file=sys.stderr)
        return 2

    killed, survivors = [], []
    t_all = time.time()
    for m in MUTANTS:
        if only and m["name"] not in only:
            continue
        t0 = time.time()
        tmp = Path(tempfile.mkdtemp(prefix="laws-mut-"))
        work = tmp / "r"
        shutil.copytree(ROOT, work,
                        ignore=shutil.ignore_patterns(*COPY_IGNORE))
        try:
            apply_mutant(work, m)
        except AssertionError as e:
            print(f"   MUTANT DEFINITION BROKEN: {e}", file=sys.stderr)
            return 2
        rc1, out1 = run(["bash", "tools/check.sh"], work, 300)
        rc2, out2 = run(["python3", "tools/differential/run.py"], work, 300)
        catchers = []
        if rc1 != 0:
            catchers.append(classify_check_failure(out1))
        if rc2 != 0:
            catchers.append("differential")
        dt = time.time() - t0
        if catchers:
            killed.append((m["name"], catchers, dt))
            print(f"   KILLED {m['name']:20s} by {','.join(catchers):22s} "
                  f"({dt:.1f}s)")
            if not keep:
                shutil.rmtree(tmp, ignore_errors=True)
        else:
            survivors.append((m["name"], dt))
            print(f"   SURVIVOR {m['name']:20s} gate stayed green "
                  f"({dt:.1f}s) -- kept at {work}")
    total = time.time() - t_all

    print()
    print(f"mutants : {len(killed) + len(survivors)}")
    print(f"killed  : {len(killed)}")
    print(f"survived: {len(survivors)}")
    for name, _dt in survivors:
        m = next(x for x in MUTANTS if x["name"] == name)
        print(f"SURVIVOR DETAIL {name}: invariant '{m['invariant']}'; "
              f"expected catcher(s) {m['expect']} did NOT fire.")
    print(f"total runtime: {total:.1f}s")
    if survivors:
        print("mutation suite: FAIL (survivors present)")
        return 1
    print("mutation suite: ok -- every mutant killed")
    return 0


if __name__ == "__main__":
    sys.exit(main())
