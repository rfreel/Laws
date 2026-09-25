# Two-time temporal model + ex post facto

Time-and-change wave, Part A. The v0.3.0 temporal layer modeled only
*clause-text* times (`clause_commenced` / `clause_unexpired`: when a clause's
text takes effect or lapses). This layer adds the missing pair the Ex Post
Facto Clauses are a relation *between*: **conduct-time vs enactment-time**.

## The model

`PunishmentEvent{conduct_year, enact_year, punisher, criminal}` in `laws.bend`:

| Field | Type | Meaning |
|---|---|---|
| `conduct_year` | `Nat` | year of the governed conduct |
| `enact_year` | `Nat` | year the punishing law was enacted |
| `punisher` | `DeonticSubject` | who punishes — reuses the existing `Congress{}` / `StateGovernments{}` constructors (module-global names; nothing new invented) |
| `criminal` | `Bool` | **caller-supplied**: is this punishment criminal? |

`is_ex_post_facto(e)` = `conduct_year < enact_year` AND `criminal`.
The "punishes" conjunct is carried by the event type itself: the predicate is
defined only over `PunishmentEvent`, so a caller who labels a non-punishment
a `PunishmentEvent` has supplied a false premise — the same discipline as
every caller-supplied `Bool` in this repo.

Per the linearity design rule (see skill `bend-formalization` rule 1), the
relation is built from one-sided predicates —
`conduct_predates_enactment`, `punishment_is_criminal`,
`punisher_is_congress`, `punisher_is_states` — conjoined over the reusable
event (`+e`). Years are plain `Nat`: no `Year{..}` construction, no sub-year
claims anywhere (year granularity throughout, the same documented bound as
the v0.3.0 temporal section).

## The two textual clauses

- **A1S9C3** — "No Bill of Attainder or ex post facto Law shall be passed."
  `congress_ex_post_facto_prohibited(e)` = `is_ex_post_facto(e)` AND punisher
  is `Congress{}`. Tagged clause: `CL_A1S9_Attainder`
  (Prohibition / Congress / `PassAttainderOrExPostFacto`).
- **A1S10C1** — "No State shall ... pass any ... ex post facto Law."
  `states_ex_post_facto_prohibited(e)` = `is_ex_post_facto(e)` AND punisher
  is `StateGovernments{}`. **No existing `Clause` constructor covers this
  half of A1S10** (the four A1S10 constructors tag treaty/coin/imposts/war
  only), so the clause is identified by subject and no constructor is
  invented.

Both are proved as conditional theorems **both ways** over the caller inputs
(skill rule 7): retroactive + criminal + right subject → prohibited; wrong
subject, same-year, or non-criminal → not prohibited. 13 laws in `LAWS.bend`,
each with its boundary pair.

## Repeal-then-punish ordering pin

`ex_post_facto_verdict_after_repeal(e, repeal_year)`: the caller supplies a
repeal year; the def asserts the modeled scenario (repeal strictly after
enactment) and returns the verdict unchanged. Two boundary laws pin that a
post-enactment repeal flips the verdict **neither way**. This is the full
temporal ordering the model encodes.

## Explicit boundaries — what this does NOT establish

1. **Criminal-only scope.** Whether a real punishment is criminal (vs civil,
   regulatory, administrative) is decided by the caller's `criminal` Bool,
   never by the model. The model says nothing about civil cases.
2. **No Calder v. Bull.** The model does NOT encode the Calder categories or
   any other ex post facto doctrine; it states only the bare temporal
   relation the two clauses share. Nothing doctrinal is established beyond
   the text.
3. **No post-repeal punishability.** The repeal pin establishes that a repeal
   year does not change *this model's* verdict. Whether punishment imposed
   after a repeal is lawful is textually silent and not modeled.
4. **Textually-silent questions stay caller inputs.** Whether a given
   historical punishment "counts" (its years, its criminal character, who
   punished) arrives as caller-supplied values; the laws exhibit the
   consequences both ways without inventing the premises.
5. **Year granularity.** Sub-year orderings (e.g. conduct in January,
   enactment in March of the same year) are invisible to the model by
   design; same-year is never retroactive here.

## Verification

- `bend PROOF.bend`: all 13 new laws prove (`def Laws.<name>` in PROOF.bend).
- Differential: `tools/differential/model.py` re-implements every new def
  independently; `run.py` agrees on all 495 laws, 0 skipped.
- Mutation: `expostfacto_boundary` (`Nat.is_lt` → `Nat.is_le` in
  `conduct_predates_enactment`) is killed by `bend` via the same-year
  boundary laws.
