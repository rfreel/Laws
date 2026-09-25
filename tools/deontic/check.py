#!/usr/bin/env python3
"""Exhaustive deontic-conflict check over the corpus at the reference year 2026.

Route: uses the differential model's own tagging table and temporal functions
(independent of both the hand-written laws.bend table and the generated Bend
pair code). Enumerates all 133 clauses, determines operative status at 2026,
and checks every unordered clause pair (133 choose 2 = 8778) for a deontic
conflict. Fails nonzero on any conflict.

Deterministic: fixed clause order (constructor declaration order), no
randomness, no I/O beyond stdout.
"""

import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO / "tools" / "differential"))

from model import (  # noqa: E402
    CLAUSES,
    Data,
    clause_deontic,
    clause_operative_at_2026,
    deontic_conflict,
    deontic_tag_is_untagged,
)

REFERENCE_YEAR = 2026


def main() -> int:
    clauses = [Data(name, ()) for name in CLAUSES]
    assert len(clauses) == 133, f"expected 133 clauses, got {len(clauses)}"

    tags = {c.name: clause_deontic(c) for c in clauses}
    tagged = sorted(n for n, t in tags.items() if not deontic_tag_is_untagged(t))
    untagged = sorted(n for n, t in tags.items() if deontic_tag_is_untagged(t))
    operative_tagged = sorted(
        n for n in tagged if clause_operative_at_2026(Data(n, ()))
    )
    inoperative_tagged = sorted(set(tagged) - set(operative_tagged))

    pairs = 0
    conflicts: list[tuple[str, str]] = []
    operative_conflicts: list[tuple[str, str]] = []
    names = [c.name for c in clauses]
    for i in range(len(names)):
        for j in range(i + 1, len(names)):
            pairs += 1
            a, b = names[i], names[j]
            if deontic_conflict(tags[a], tags[b]):
                conflicts.append((a, b))
                if a in operative_tagged and b in operative_tagged:
                    operative_conflicts.append((a, b))

    print(f"reference year            : {REFERENCE_YEAR}")
    print(f"clauses                   : {len(clauses)}")
    print(f"tagged                    : {len(tagged)}")
    print(f"untagged                  : {len(untagged)}")
    print(f"tagged operative at 2026  : {len(operative_tagged)}")
    print(f"tagged inoperative at 2026: {len(inoperative_tagged)} {inoperative_tagged}")
    print(f"unordered pairs checked   : {pairs}")
    print(f"conflicts (all pairs)     : {len(conflicts)}")
    print(f"conflicts (operative set) : {len(operative_conflicts)}")
    for a, b in conflicts:
        print(f"  CONFLICT: {a} vs {b}")

    return 1 if conflicts else 0


if __name__ == "__main__":
    sys.exit(main())
