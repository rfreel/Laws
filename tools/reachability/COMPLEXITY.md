# Reachability: complexity and decidability notes

All claims below are about the **abstract 8-state `ConstState` system** in
`laws.bend` (wave 2), not about the real Constitution. The abstraction —
three flags, over-approximated attacker — is the bound on every claim here.

## 1. Validating an amendment sequence is linear in its length

One `amendment_step` evaluates `amendment_valid`: two `two_thirds`
propositions (`2·total ≤ 3·yes`), one `states_three_fourths`
(`3·states ≤ 4·yes`), and a 3-way match on the target for permissibility —
a fixed, constant number of closed-form integer comparisons, then one
flag update. No loops, no recursion over the state. Validating a k-step
sequence is therefore **Θ(k) step-evaluations**. (Honest footnote: `Nat`
arithmetic cost grows with the magnitude of the numbers, but vote counts
are bounded by chamber sizes in every real use; the sequence length k is
the variable that matters.)

## 2. Bounded-k reachability is decidable by finite unfolding

Fix the chamber sizes. A step's effect depends on the vote counts **only
through the validity bit**: the threshold predicates are monotone
non-decreasing in yes-votes (`2·total ≤ 3·yes` can only flip False→True
as `yes` grows — verified in `laws.bend`, `two_thirds` /
`states_three_fourths`), and permissibility is vote-independent. So for a
fixed `(affected_consent, self_amendment_ok)`, maximum yes-votes dominate
every other vote configuration for the attacker: any flag cleared at
fewer votes is also cleared at max votes. The effective transition system
is finite: 8 states, at most 3 targets × 2 validity outcomes per state.

Machine-checked bound: **k ≤ 3**, pinned by the `reach_*` laws —
constructive 2-step witness (self_ok=True), 1-step impossibility per
target, and the no-op/idempotence transition lemmas plus three explicit
3-step chains (self_ok=False). The step from "pinned configurations" to
"all vote configurations" rests on the documented monotonicity argument
above, not on a machine-checked universal — Bend 2.0.27 `{==}` laws are
ground equations.

## 3. Unbounded-k reachability over the abstract state is decidable too

The state space is finite: **2³ = 8 states**. Unbounded reachability
("is dictatorship reachable in *any* number of steps?") is therefore
decidable by fixpoint iteration on the explicit 8-node graph — at most 8
rounds to compute the full reachable set from `const_init()`. Under
`self_amendment_ok=False` the reachable set is
`{{T,T,T}, {T,F,T}}` (closure shown by the transition lemmas:
`ArticleVProcedure` is validity-False at all vote counts when
permissibility fails, `EqualSuffrageDeprivation` changes no flags,
`OrdinaryAmendment` is idempotent after the first success) — dictatorship
is outside it. Under `self_amendment_ok=True` the 2-step witness puts
dictatorship inside it. No unbounded claim is machine-proved; the
fixpoint argument is documented mathematics over the finite abstraction.

## 4. Where undecidability WOULD bite

Enrich the state and decidability evaporates:

- **Unbounded amendment text**: if states carried the actual amended text
  (arbitrary strings), the state space is infinite and reachability over
  text-rewriting is undecidable in general (Post/Turing territory).
- **Non-monotone vote predicates**: thresholds that could flip True→False
  as yes-votes grow would break the max-votes-dominate argument and with
  it the finite effective branching.
- **Adversarial open terms**: resolving `InterpretiveTerm`s adversarially
  mid-sequence turns the transition system into a game against an
  unconstrained opponent — no longer a finite check.
- **The convention path**: unbounded delegate configurations were
  deliberately excluded from `amendment_valid` (documented path choice).

## 5. What this does NOT establish

- The ground laws pin specific vote configurations; universality over all
  configurations is a documented argument, not a checked proof.
- The model over-approximates attacker power (every valid ordinary
  amendment is treated as rights-eroding). Unreachability is therefore a
  strong statement *about the model*; reachability exhibits one
  model-permitted path, not a real-world prediction.
- Nothing here is a claim about the actual U.S. Constitution — only about
  the 8-state abstraction, at the stated bounds.
