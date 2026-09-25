#!/usr/bin/env python3
"""Banzhaf power-index computation via dynamic programming over vote counts.

For a weighted voting game with weights w_1..w_n and quota q, voter i's
Banzhaf swing count is the number of coalitions S of the *other* voters with
    q - w_i <= weight(S) < q
(i.e. coalitions where i's defection flips the outcome). The DP counts, for
each voter, the subsets of the other voters by total weight -- O(n * W)
per distinct weight, never 2^n enumeration.

Games modeled (quotas from the constitutional text / transcript):
  senate_51    100 equal voters, quota 51   (ordinary legislation, A1S7)
  senate_67    100 equal voters, quota 67   (impeachment, treaties: 2/3 present)
  house_218    435 equal voters, quota 218  (ordinary legislation)
  house_290    435 equal voters, quota 290  (veto override: 2/3)
  ec_270       51 weighted jurisdictions, quota 270 (AM12: majority of
               appointed electors)
  contingent_26 50 equal state blocs, quota 26 (AM12 contingent election:
               majority of states)

Electoral-vote data: 2024/2028 apportionment (2020 census), cross-checked
across Wikipedia "United States Electoral College" (current distribution
table), LibreTexts Appendix D, and jagranjosh 2024 stats. Sum verified 538.
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

# --------------------------------------------------------------------------
# Electoral votes, 2024/2028 apportionment (2020 census basis).
# --------------------------------------------------------------------------
ELECTORAL_VOTES_2024: dict[str, int] = {
    "Alabama": 9, "Alaska": 3, "Arizona": 11, "Arkansas": 6,
    "California": 54, "Colorado": 10, "Connecticut": 7, "Delaware": 3,
    "District of Columbia": 3, "Florida": 30, "Georgia": 16, "Hawaii": 4,
    "Idaho": 4, "Illinois": 19, "Indiana": 11, "Iowa": 6, "Kansas": 6,
    "Kentucky": 8, "Louisiana": 8, "Maine": 4, "Maryland": 10,
    "Massachusetts": 11, "Michigan": 15, "Minnesota": 10, "Mississippi": 6,
    "Missouri": 10, "Montana": 4, "Nebraska": 5, "Nevada": 6,
    "New Hampshire": 4, "New Jersey": 14, "New Mexico": 5, "New York": 28,
    "North Carolina": 16, "North Dakota": 3, "Ohio": 17, "Oklahoma": 7,
    "Oregon": 8, "Pennsylvania": 19, "Rhode Island": 4, "South Carolina": 9,
    "South Dakota": 3, "Tennessee": 11, "Texas": 40, "Utah": 6,
    "Vermont": 3, "Virginia": 13, "Washington": 12, "West Virginia": 4,
    "Wisconsin": 10, "Wyoming": 3,
}
assert sum(ELECTORAL_VOTES_2024.values()) == 538, "electoral votes must sum to 538"
assert len(ELECTORAL_VOTES_2024) == 51, "50 states + DC"


# --------------------------------------------------------------------------
# Core algorithm
# --------------------------------------------------------------------------
def swing_counts(weights: list[int], quota: int) -> list[int]:
    """Banzhaf swing count per voter, via DP over subset sums.

    Voters with equal weight are symmetric, so the DP runs once per
    distinct weight.
    """
    n = len(weights)
    if n == 0:
        return []
    total = sum(weights)
    swings = [0] * n
    cache: dict[int, int] = {}
    for i, w in enumerate(weights):
        if w in cache:
            swings[i] = cache[w]
            continue
        dp = [0] * (total + 1)
        dp[0] = 1
        for j, ow in enumerate(weights):
            if j == i:
                continue
            # 0/1 knapsack counting, descending to avoid reuse
            for s in range(total - ow, -1, -1):
                if dp[s]:
                    dp[s + ow] += dp[s]
        lo = max(0, quota - w)
        c = sum(dp[lo:quota]) if lo < quota else 0
        cache[w] = c
        swings[i] = c
    return swings


def normalized_index(swings: list[int]) -> list[float]:
    """Normalized Banzhaf index: swings_i / total swings."""
    t = sum(swings)
    if t == 0:
        return [0.0] * len(swings)
    return [s / t for s in swings]


# --------------------------------------------------------------------------
# Games
# --------------------------------------------------------------------------
def games() -> dict[str, tuple[list[int], int, list[str]]]:
    """name -> (weights, quota, labels)."""
    ec_names = list(ELECTORAL_VOTES_2024.keys())
    ec_weights = [ELECTORAL_VOTES_2024[k] for k in ec_names]
    return {
        "senate_51": ([1] * 100, 51, [f"Senator {i+1}" for i in range(100)]),
        "senate_67": ([1] * 100, 67, [f"Senator {i+1}" for i in range(100)]),
        "house_218": ([1] * 435, 218, [f"Rep {i+1}" for i in range(435)]),
        "house_290": ([1] * 435, 290, [f"Rep {i+1}" for i in range(435)]),
        "ec_270": (ec_weights, 270, ec_names),
        "contingent_26": ([1] * 50, 26, [s for s in ec_names if s != "District of Columbia"]),
    }


def analyze() -> dict:
    out: dict = {"games": {}}
    for name, (weights, quota, labels) in games().items():
        sw = swing_counts(weights, quota)
        idx = normalized_index(sw)
        entries = [
            {
                "label": lab,
                "weight": w,
                "swings": s,
                "banzhaf_index": b,
                "index_per_unit_weight": (b / w) if w else 0.0,
            }
            for lab, w, s, b in zip(labels, weights, sw, idx)
        ]
        out["games"][name] = {
            "n_voters": len(weights),
            "quota": quota,
            "total_weight": sum(weights),
            "total_swings": sum(sw),
            "voters": entries,
        }
    return out


def headline_report(res: dict) -> str:
    L = []
    g = res["games"]
    L.append("Banzhaf power indices (normalized; DP over vote counts)")
    L.append("=" * 60)
    for name in ("senate_51", "senate_67", "house_218", "house_290", "contingent_26"):
        d = g[name]
        v = d["voters"][0]
        L.append(
            f"{name:14s} n={d['n_voters']:3d} quota={d['quota']:3d} "
            f"index/voter={v['banzhaf_index']:.6f} (= 1/{d['n_voters']}) "
            f"swings/voter={v['swings']}"
        )
    ec = g["ec_270"]
    by_label = {v["label"]: v for v in ec["voters"]}
    ca, wy = by_label["California"], by_label["Wyoming"]
    tx = by_label["Texas"]
    L.append("-" * 60)
    L.append("Electoral College, quota 270 (51 jurisdictions, 538 votes):")
    L.append(
        f"  California  w=54  index={ca['banzhaf_index']:.6f}  "
        f"per-EV={ca['index_per_unit_weight']:.6f}  swings={ca['swings']}"
    )
    L.append(
        f"  Texas       w=40  index={tx['banzhaf_index']:.6f}  "
        f"per-EV={tx['index_per_unit_weight']:.6f}  swings={tx['swings']}"
    )
    L.append(
        f"  Wyoming     w=3   index={wy['banzhaf_index']:.6f}  "
        f"per-EV={wy['index_per_unit_weight']:.6f}  swings={wy['swings']}"
    )
    L.append(
        f"  per-electoral-vote power ratio CA/WY: "
        f"{ca['index_per_unit_weight']/wy['index_per_unit_weight']:.2f}x "
        f"(large states hold a slight per-EV edge; the small-state advantage"
    )
    L.append(
        f"   lives in apportionment -- EVs per capita -- not in the index)"
    )
    # Per-capita headline: 2020 census apportionment populations, rounded
    # figures as reported (CA ~39.5M, WY ~576,850).
    ca_pop, wy_pop = 39_500_000, 576_850
    ca_pc = ca["banzhaf_index"] / ca_pop
    wy_pc = wy["banzhaf_index"] / wy_pop
    L.append(
        f"  per-capita power ratio WY/CA (2020 census pops ~39.5M / ~576,850): "
        f"{wy_pc/ca_pc:.1f}x"
    )
    L.append("=" * 60)
    return "\n".join(L)


def main() -> int:
    res = analyze()
    out_path = Path(__file__).resolve().parent / "results.json"
    out_path.write_text(json.dumps(res, indent=1) + "\n")
    print(headline_report(res))
    print(f"\nfull results -> {out_path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
