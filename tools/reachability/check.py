#!/usr/bin/env python3
"""Exhaustive reachability check over the abstract 8-state ConstState model.

Route: uses the differential model's own transition functions
(tools/differential/model.py: const_init, amendment_step, const_state_code),
independent of both the hand-written laws.bend defs and the generated Bend
chain code. Division of labor: this sweep checks the reachability
*statements* against the second implementation; the Bend model itself is
checked by `bend PROOF.bend`, never by this script.

Checks, all from the as-ratified start state const_init():
  A. 1-step: all 12 (target x self_ok x vote-config) transitions; none may
     reach dictatorship.
  B. 2-step iff: all 36 chains per self_amendment_ok value; dictatorship is
     reached (BFS minimum exactly 2 steps) iff self_amendment_ok=True.
  C. 3-step: all 216 chains with self_amendment_ok=False; none may reach
     dictatorship.
  D. Fixpoint: the reachable set from init with self_amendment_ok=False
     excludes dictatorship (expected {(T,T,T),(T,F,T)}); with True it
     includes dictatorship.
  E. Code-map cross-check: the model's const_state_code agrees with the
     bit-order definition (proviso*4 + rights*2 + self_rule) on all 8 states.

Finite-reduction argument (documented, not machine-proved): a step's effect
depends on the vote counts ONLY through the validity bit — the threshold
predicates are monotone non-decreasing in yes-votes, and permissibility is
vote-independent. MAXV (every threshold met) realizes validity=True whenever
any vote configuration does; ZEROV (zero yes-votes) always realizes
validity=False (2*total > 0 for every positive chamber). Hence the
2 vote configs x 3 targets x 2 self_ok values = 12 transitions per state
are the complete effective transition system; enumerating them is
exhaustive over all vote configurations, not a sample.

Deterministic: fixed orders, no randomness, no I/O beyond stdout.
Exits nonzero on any violation.
"""

import sys
from itertools import product
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO / "tools" / "differential"))

from model import (  # noqa: E402
    Data,
    amendment_step,
    const_init,
    const_state_code,
)

TARGETS = ["OrdinaryAmendment", "EqualSuffrageDeprivation", "ArticleVProcedure"]
HOUSE = Data("ChamberCount", (435, 435))
SENATE = Data("ChamberCount", (100, 100))
STATES = Data("StatesCount", (50,))
VOTE_CONFIGS = {
    "max": (435, HOUSE, 100, SENATE, 50, STATES),
    "zero": (0, HOUSE, 0, SENATE, 0, STATES),
}
STATES8 = [Data("CState", (p, r, s)) for p in (False, True)
           for r in (False, True) for s in (False, True)]
DICTATORSHIP = Data("CState", (False, False, False))
INIT = const_init()


def step(state: Data, target: str, vote_cfg: str, self_ok: bool) -> Data:
    hv, house, sv, senate, rv, states = VOTE_CONFIGS[vote_cfg]
    return amendment_step(
        state, Data(target, ()), hv, house, sv, senate, rv, states,
        True,  # affected_consent: held True (Suffrage step is a no-op either way)
        self_ok,
    )


def successors(state: Data, self_ok: bool) -> set:
    return {
        step(state, t, v, self_ok)
        for t in TARGETS
        for v in VOTE_CONFIGS
    }


def chains_from_init(length: int, self_ok: bool):
    """Yield (chain_description, end_state) for every effective chain."""
    options = [(t, v) for t in TARGETS for v in VOTE_CONFIGS]
    for combo in product(options, repeat=length):
        s = INIT
        for t, v in combo:
            s = step(s, t, v, self_ok)
        yield combo, s


def bfs_min_steps(self_ok: bool):
    """Minimum steps from init to dictatorship (None if unreachable)."""
    seen = {INIT}
    frontier = [INIT]
    depth = 0
    while frontier:
        depth += 1
        nxt = []
        for st in frontier:
            for ns in successors(st, self_ok):
                if ns == DICTATORSHIP:
                    return depth
                if ns not in seen:
                    seen.add(ns)
                    nxt.append(ns)
        frontier = nxt
    return None


def reachable_set(self_ok: bool) -> set:
    seen = {INIT}
    frontier = [INIT]
    while frontier:
        nxt = []
        for st in frontier:
            for ns in successors(st, self_ok):
                if ns not in seen:
                    seen.add(ns)
                    nxt.append(ns)
        frontier = nxt
    return seen


def fmt(state: Data) -> str:
    p, r, s = ("T" if x else "F" for x in state.fields)
    return f"{{{p},{r},{s}}}"


def main() -> int:
    assert len(STATES8) == 8, f"expected 8 states, got {len(STATES8)}"
    assert INIT == Data("CState", (True, True, True)), "const_init is not all-intact"
    violations: list[str] = []

    # E. Code-map cross-check on all 8 states.
    for st in STATES8:
        p, r, s = st.fields
        want = 4 * p + 2 * r + s
        got = const_state_code(st)
        if got != want:
            violations.append(f"code map: {fmt(st)} -> {got}, want {want}")

    # A. 1-step: no transition from init reaches dictatorship.
    one_hits = [
        (t, v, ok)
        for t in TARGETS
        for v in VOTE_CONFIGS
        for ok in (False, True)
        if step(INIT, t, v, ok) == DICTATORSHIP
    ]
    if one_hits:
        violations.append(f"1-step dictatorship reachable: {one_hits}")

    # B. 2-step iff self_amendment_ok.
    two_hits: dict[bool, list] = {}
    for ok in (False, True):
        two_hits[ok] = [c for c, s in chains_from_init(2, ok) if s == DICTATORSHIP]
    if not two_hits[True]:
        violations.append("2-step: no dictatorship chain with self_amendment_ok=True")
    if two_hits[False]:
        violations.append(
            f"2-step: dictatorship reachable with self_amendment_ok=False: {two_hits[False]}"
        )
    min_true, min_false = bfs_min_steps(True), bfs_min_steps(False)
    if min_true != 2:
        violations.append(f"BFS min steps (self_ok=True) = {min_true}, want exactly 2")
    if min_false is not None:
        violations.append(f"BFS (self_ok=False) reaches dictatorship in {min_false} steps")

    # C. 3-step chains with self_amendment_ok=False.
    three_hits = [c for c, s in chains_from_init(3, False) if s == DICTATORSHIP]
    if three_hits:
        violations.append(f"3-step dictatorship chains (self_ok=False): {three_hits}")

    # D. Fixpoint reachable sets.
    reach_false = reachable_set(False)
    reach_true = reachable_set(True)
    if DICTATORSHIP in reach_false:
        violations.append("fixpoint (self_ok=False) contains dictatorship")
    if DICTATORSHIP not in reach_true:
        violations.append("fixpoint (self_ok=True) misses dictatorship")

    print("abstract states           : 8 (proviso x rights x self_rule)")
    print("transitions per state     : 12 (3 targets x 2 vote-configs x 2 self_ok)")
    print("1-step transitions checked: 12")
    print("1-step dictatorship hits  : 0" if not one_hits else f"  HITS: {one_hits}")
    print(f"2-step chains (self_ok=T) : 36, dictatorship hits: {len(two_hits[True])}")
    for c in two_hits[True][:4]:
        print(f"    witness: {' -> '.join(f'{t}/{v}' for t, v in c)}")
    print(f"2-step chains (self_ok=F) : 36, dictatorship hits: {len(two_hits[False])}")
    print(f"BFS min steps to dictatorship: self_ok=True -> {min_true}, self_ok=False -> {min_false}")
    print(f"3-step chains (self_ok=F) : 216, dictatorship hits: {len(three_hits)}")
    print(f"fixpoint reachable (F)    : {sorted(fmt(s) for s in reach_false)}")
    print(f"fixpoint reachable (T)    : {sorted(fmt(s) for s in reach_true)}")
    print(f"code-map cross-check      : {'ok' if not any(v.startswith('code map') for v in violations) else 'FAILED'}")

    if violations:
        print("VIOLATIONS:")
        for v in violations:
            print(f"  - {v}")
        return 1
    print("reachability check ok: 2-step iff self_amendment_ok; 1-step and 3-step(-denied) blocked")
    return 0


if __name__ == "__main__":
    sys.exit(main())
