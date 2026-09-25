#!/usr/bin/env python3
"""Generate the exhaustive 2026 operative-set pairwise deontic-conflict check.

Reads laws.bend (hand-written tagging table + temporal layer) and emits the
`corpus_pairs_consistent_2026` def, which asserts that no two tagged clauses
operative at the reference year 2026 carry conflicting deontic tags.

Mechanical guards (fail loudly rather than silently mis-generate):
  1. The `clause_in_force` def's False{} arms must be exactly the three AM18
     clauses (their repeal is the timeless in-force mark).
  2. The `clause_unexpired` def's special-cased clauses must be exactly the
     known four (A1S9_MigrationRestriction + three AM18 clauses). If a fifth
     special case is ever added, a human must decide its year-2026 outcome and
     update EXPIRED_AT_2026 below.
  3. Every generated pair's clauses must appear in the tagging table.

Reference-year outcomes for the special-cased unexpired clauses:
  EXPIRED_AT_2026 = {CL_A1S9_MigrationRestriction}  (1808 < 2026; AM18 clauses
  are already excluded via clause_in_force=False).

Usage: python3 tools/deontic/gen_pairs.py >> laws.bend
(The emitted block is delimited by BEGIN/END markers so it can be replaced.)
"""

import re
import sys
from itertools import combinations

REPO = __file__.rsplit("/tools/deontic/gen_pairs.py", 1)[0]
LAWS = REPO + "/laws.bend"

# Clauses whose clause_unexpired(_, Year{2026n}) is False, among the
# special-cased set asserted below.
EXPIRED_AT_2026 = {"CL_A1S9_MigrationRestriction"}


def extract_def(text: str, name: str) -> str:
    m = re.search(rf"^def {name}\(.*?\n(?=^def |\Z)", text, re.M | re.S)
    if not m:
        raise SystemExit(f"gen_pairs: def {name} not found in laws.bend")
    return m.group(0)


def case_clauses(block: str) -> list[str]:
    return re.findall(r"^\s*case (CL_\w+)\{\}", block, re.M)


def main() -> None:
    text = open(LAWS).read()

    # 1. Tagging table: arms of clause_deontic that produce a Tagged{...}.
    deontic = extract_def(text, "clause_deontic")
    tagged = re.findall(r"^\s*case (CL_\w+)\{\}:\s*Tagged\{", deontic, re.M)
    if len(tagged) < 40:
        raise SystemExit(f"gen_pairs: suspiciously few tagged clauses: {len(tagged)}")
    if len(set(tagged)) != len(tagged):
        raise SystemExit("gen_pairs: duplicate arms in clause_deontic")

    # 2. clause_in_force False{} arms must be exactly the three AM18 clauses.
    in_force = extract_def(text, "clause_in_force")
    false_arms = re.findall(
        r"^\s*case (CL_\w+)\{\}:\s*\n\s*False\{\}", in_force, re.M
    )
    expected_false = {
        "CL_AM18S1_Prohibition",
        "CL_AM18S2_ConcurrentPower",
        "CL_AM18S3_EffectiveDate",
    }
    if set(false_arms) != expected_false:
        raise SystemExit(
            "gen_pairs: clause_in_force False{} arms changed; "
            f"got {sorted(false_arms)}, expected {sorted(expected_false)}. "
            "Update this script before regenerating."
        )

    # 3. clause_unexpired special cases must be exactly the known four.
    unexpired = extract_def(text, "clause_unexpired")
    special = set(case_clauses(unexpired)) - {"_"}
    expected_special = expected_false | {"CL_A1S9_MigrationRestriction"}
    if special != expected_special:
        raise SystemExit(
            "gen_pairs: clause_unexpired special cases changed; "
            f"got {sorted(special)}, expected {sorted(expected_special)}. "
            "Update EXPIRED_AT_2026 before regenerating."
        )
    if not EXPIRED_AT_2026 <= special:
        raise SystemExit("gen_pairs: EXPIRED_AT_2026 names a non-special clause")

    operative = sorted(set(tagged) - expected_false - EXPIRED_AT_2026)
    n = len(operative)
    pairs = list(combinations(operative, 2))
    print(
        f"# gen_pairs: {len(tagged)} tagged, {n} operative at 2026 "
        f"({len(pairs)} unordered pairs)",
        file=sys.stderr,
    )

    def leaf(a: str, b: str) -> str:
        return (
            f"Bool.not(deontic_conflict(clause_deontic({a}{{}}), "
            f"clause_deontic({b}{{}})))"
        )

    def balanced(items: list[str]) -> str:
        if len(items) == 1:
            return items[0]
        mid = len(items) // 2
        return f"Bool.and({balanced(items[:mid])}, {balanced(items[mid:])})"

    body = balanced([leaf(a, b) for a, b in pairs])

    print("# === BEGIN GENERATED deontic pairs (tools/deontic/gen_pairs.py) ===")
    print("# Do not hand-edit: regenerate with `python3 tools/deontic/gen_pairs.py`.")
    print("# Exhaustive pairwise check over the tagged clauses operative at 2026.")
    print("# Excluded from the tagged set:")
    print("#   - CL_AM18S1_Prohibition: tagged but inoperative (repealed; clause_in_force=False).")
    print("#   - CL_A1S9_MigrationRestriction: tagged but expired at 2026 (clause_unexpired=False).")
    print("# Claim: corpus_pairs_consistent_2026() == True{} establishes that no two clauses in")
    print("# the 2026 operative set carry conflicting deontic tags — relative to the minimal tag")
    print("# table, the subject-overlap rule, and the declared action vocabulary. It does not")
    print("# establish doctrinal or semantic consistency, and says nothing about other years.")
    print("def corpus_pairs_consistent_2026() -> Bool:")
    print(f"  {body}")
    print("# === END GENERATED deontic pairs ===")


if __name__ == "__main__":
    main()
