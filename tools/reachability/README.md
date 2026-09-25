# Reachability: the 8-state amendment model, machine-checked

This directory promotes the abstract amendment-reachability model
(`ConstState` in `laws.bend`: the Gödel self-amendment question as bounded
model checking) from documentation into the verification gate, following
the `tools/deontic/` precedent.

## The abstraction — read this before citing any result

`ConstState` tracks only three Booleans:

- `proviso_intact` — the Art. V entrenchment proviso (equal Senate
  suffrage) is still operative text;
- `rights_intact` — substantive rights guarantees are still operative;
- `self_rule_intact` — the amendment rule itself still demands
  supermajorities (not rewritten/captured).

Dictatorship is the all-false state `CState{False,False,False}`: the
proviso gone, rights gone, the rule itself captured. The state space is
2³ = 8 states.

**Over-approximation direction (the load-bearing design decision).**
Every *valid* ordinary amendment is treated as the archetypal
rights-eroding step: it clears `rights_intact` maximally, whatever its
real subject matter. The model therefore gives the attacker *more* power
than reality, never less. Consequences:

- **Unreachability results are STRONG** — they hold even against a
  stronger-than-real attacker. If dictatorship is unreachable here, it is
  unreachable under any model that erodes less per step.
- **Reachability results are EXISTENTIAL** — they exhibit one
  model-permitted attack path (e.g. the 2-step Gödel witness), not a
  prediction about the real world.

**All claims hold in the abstract 8-state model only — never the real
Constitution.** The abstraction omits amendment subject matter beyond the
three flags, the convention path, judicial review, politics, enforcement,
and every open interpretive term. Nothing here is a claim about the
actual U.S. Constitution.

**The self-amendment question stays caller-supplied.** The text is silent
on whether Article V can amend itself, so `self_amendment_ok` is an
explicit `Bool` input, never a model invention. Every headline claim is
proved *conditional both ways* (the boundary pair over the input itself):
dictatorship is 2-step reachable iff the caller holds self-amendment
valid. That is the executable form of an independence result.

## The three checks and what each does NOT establish

1. **`check.py`** — Python exhaustive sweep over the abstract transition
   system, via the *differential* (second) implementation in
   `tools/differential/model.py`. Checks: 1-step impossibility (12
   transitions), the 2-step iff (36 chains per `self_amendment_ok` value,
   BFS minimum exactly 2), all 216 3-step chains blocked when
   self-amendment is denied, the fixpoint reachable sets, and the Nat
   code-map cross-check. Vote configurations are reduced to {max, zero}
   by the documented monotonicity argument (a step's effect depends on
   votes only through the validity bit; thresholds are monotone in
   yes-votes; permissibility is vote-independent), so the 12 transitions
   per state are the complete effective system, not a sample.
   Does NOT establish: anything about the Bend model itself (that is
   `bend PROOF.bend`'s job), universality beyond the documented
   monotonicity argument, or anything outside the 8-state abstraction.

2. **`gen_chains.py`** — generator emitting `reachability_gate()`, a
   balanced `Bool.and` tree of the 8 key claims, into `laws.bend`
   between BEGIN/END markers. It **mechanically asserts its assumptions
   and fails loudly on change**: the `const_state_bits` 8-state
   enumeration is symbolically evaluated over all 8 inputs (codes must
   come out 4p+2r+s, dictatorship 0); the `amendment_step` target arms
   must be exactly the three `AmendmentTarget`s; the validity arms
   exactly True/False; `self_amendment_ok` an explicit caller `Bool`
   (per-step `okN` in the chain helpers — Bend 2.0.27 uses each variable
   at most once); `const_init()` all-intact; chain helpers calling
   `amendment_step` exactly 2/3 times. `law reachability_gate` in
   `LAWS.bend` pins the generated tree in the proof gate, mirroring
   `corpus_deontically_consistent_2026`. Regenerate with
   `python3 tools/reachability/gen_chains.py >> laws.bend` after deleting
   the old block between the markers; `check.sh` runs
   `gen_chains.py --check` to fail the gate on a stale block.

3. **Bend laws** — `law reach_two_step_*` (the iff boundary pair),
   `law reach_one_step_*` (per-target 1-step impossibility plus the
   invalid-amendment no-op boundary), `law reach_articleV/suffrage/
   ordinary_*_when_self_not_ok` (transition lemmas at max votes) and
   `law reach_three_step_*_blocked` (the documented 3-step bound), all
   in `LAWS.bend` with `def Laws.*` proofs in `PROOF.bend`, plus the new
   `law reachability_gate`. A green proof establishes only the stated
   formal equation — not correctness against the source text and not
   doctrinal completeness.

Neither stage shells out to the gate, so no `LAWS_SKIP_MUTATION`-style
recursion guard is needed here (the existing guard in `tools/check.sh`
is preserved for the mutation runner itself).

## Files

- `check.py` — exhaustive Python sweep (wired into `tools/check.sh`).
- `gen_chains.py` — claim-tree generator + `--check` freshness mode
  (wired into `tools/check.sh`).
- `README.md` — this file.
- `COMPLEXITY.md` — complexity/decidability notes for the abstract model
  (linear-time sequence validation, decidable bounded-k reachability,
  where undecidability would bite).

## Headline results (abstract model only)

- Dictatorship reachable in exactly 2 steps **iff**
  `self_amendment_ok=True` (witness: amend Article V at max votes, then
  an ordinary amendment; the reverse order also works).
- Not reachable in 1 step by any target, even at max votes with
  self-amendment held valid.
- Unreachable through all 3-step chains — and indeed unreachable at any
  depth (fixpoint `{{T,T,T},{T,F,T}}`) — when `self_amendment_ok=False`.
