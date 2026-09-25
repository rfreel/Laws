#!/usr/bin/env python3
"""Verify the DP swing counts against brute-force enumeration.

Covers the hand-computed tiny game ([3,2,1], quota 4 -> [3,1,1]), 300
random games with n<=14, a few larger games (n=18..20), and degenerate
edge cases. Exit 0 on success, 1 on any disagreement.
"""

from __future__ import annotations

import itertools
import random
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from banzhaf import ELECTORAL_VOTES_2024, swing_counts  # noqa: E402


def brute(weights: list[int], quota: int) -> list[int]:
    n = len(weights)
    sw = [0] * n
    for bits in itertools.product((0, 1), repeat=n):
        s = sum(w * b for w, b in zip(weights, bits))
        if s >= quota:
            for i in range(n):
                if bits[i] and s - weights[i] < quota:
                    sw[i] += 1
    return sw


def main() -> int:
    fails = 0

    def check(weights, quota, tag):
        nonlocal fails
        got, want = swing_counts(weights, quota), brute(weights, quota)
        if got != want:
            fails += 1
            print(f"MISMATCH {tag}: weights={weights} quota={quota}")
            print(f"  dp   ={got}")
            print(f"  brute={want}")

    # 1. Hand-computed tiny game (also pinned in LAWS.bend).
    check([3, 2, 1], 4, "tiny-game")

    # 2. Random small games.
    rng = random.Random(20260924)
    for t in range(300):
        n = rng.randint(1, 14)
        w = [rng.randint(1, 9) for _ in range(n)]
        q = rng.randint(1, sum(w))
        check(w, q, f"random-{t}")

    # 3. Larger games (2^18..2^20 coalitions each -- slow but exact).
    for t in range(3):
        n = rng.randint(18, 20)
        w = [rng.randint(1, 12) for _ in range(n)]
        q = rng.randint(1, sum(w))
        check(w, q, f"large-{t}")

    # 4. Edge cases.
    check([1, 1, 1], 4, "unreachable-quota")   # expect [0,0,0]
    check([5], 5, "dictator")                  # expect [1]
    check([5], 6, "quota-above-total")         # expect [0]
    check([2, 2], 3, "tie-game")               # expect [1,1]
    assert swing_counts([1, 1, 1], 4) == [0, 0, 0]
    assert swing_counts([5], 5) == [1]
    assert swing_counts([2, 2], 3) == [1, 1]

    # 5. Electoral-college sanity checks on the real 2024-apportionment game.
    # NOTE: per-electoral-vote Banzhaf power is slightly HIGHER for large
    # states (CA per-EV 0.002052 > WY per-EV 0.001819) -- the small-state
    # advantage lives in apportionment (EVs per capita), not in the index.
    ec = list(ELECTORAL_VOTES_2024.values())
    sw = swing_counts(ec, 270)
    tot = sum(sw)
    names = list(ELECTORAL_VOTES_2024.keys())
    idx = [s / tot for s in sw]
    if abs(sum(idx) - 1.0) > 1e-9:
        fails += 1
        print("MISMATCH ec-sanity: normalized indices do not sum to 1")
    # Monotonicity: larger weight -> larger-or-equal index.
    order = sorted(zip(ec, idx), key=lambda p: p[0])
    if any(a > b + 1e-12 for (_, a), (_, b) in zip(order, order[1:])):
        fails += 1
        print("MISMATCH ec-sanity: index not monotone in weight")
    # Per-capita: Wyoming voter advantage over California voter
    # (2020 census pops ~576,850 / ~39.5M) must be large and positive.
    wy_pc = idx[names.index("Wyoming")] / 576_850
    ca_pc = idx[names.index("California")] / 39_500_000
    if not wy_pc / ca_pc > 3.0:
        fails += 1
        print("MISMATCH ec-sanity: expected WY per-capita power >> CA")

    if fails:
        print(f"{fails} mismatches")
        return 1
    print("all banzhaf tests passed (tiny + 300 random + 3 large + edges + EC sanity)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
