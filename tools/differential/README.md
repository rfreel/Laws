# Differential testing: independent Python model

A from-scratch Python re-implementation of the Laws executable semantics,
used to cross-check every `law` statement in `LAWS.bend` against an
independent code path.

## Run

```sh
python3 tools/differential/run.py [--laws LAWS.bend]
```

Exit codes: `0` = all laws agree; `1` = at least one mismatch (names the
law); `2` = a law could not be evaluated (parse gap or missing model
function) — a harness gap, never a silent pass.

## What it checks

`run.py` parses each law's `{ LHS == RHS : ANN }` statement (including
nested `C.f(...)` calls on either side, `Bool.and/or/not` at the top
level, and the two `for x: C.Type` quantified laws), evaluates both sides
in `model.py`, and compares. The annotation is kind-checked (`: Bool`
must be a bool, anything else must be a Data constructor).

Current result (2026-09-24, branch `feat/differential` @ wave2-merged):

- **358 / 358 laws evaluated, 0 failed, 0 skipped.**
- The two quantified laws iterate fully: 74 `SourceBlock` + 133 `Clause`
  constructors.

Coverage by area (all passing):

| Area | Laws | Notes |
|---|---|---|
| Thresholds & denominator bases | 12 | exact-boundary arithmetic (`<=` vs `<` distinguished) |
| Eligibility (25/7, 30/9, 35/14) | 6 | |
| Presentment / veto / pocket veto | 4 | |
| Treason evidence, AM22 limits, AM26 age floor, AM18 repeal mark | 9 | |
| Clause rules, batch 1 (Preamble–AM26) | 88 | pass/fail boundaries |
| Clause rules, batch 2 (A1S1–AM27) | 176 | pass/fail boundaries |
| Temporal windows (1808, AM18 [1920,1933], succession, deadlines) | 25 | |
| Interpretation environment | 22 | lookup, shadowing, Known/Unknown, 4 eval fns, dispatcher |
| `clause_in_force`, `source/clause_index_in_range` | 6 | quantified |

## Falsifiability (negative controls, run 2026-09-24)

- Flipping one law's expected value (`treaty_67_of_100_passes` True→False):
  runner reports `FAIL treaty_67_of_100_passes: got True, want False`,
  exit 1.
- Weakening the model's `two_thirds` (`<=` → `<`): runner reports FAILs
  on every exact-boundary law (60/90, 67/100, AM14S3/AM25S4 boundaries),
  exit 1. Restoring the model returns the suite to green.

## Honest boundaries — what this does NOT establish

1. **Shared spec.** The model is written from the same law statements it
   checks. Agreement proves the Bend computation implements the stated
   contract; it does **not** prove the contract matches the constitutional
   transcript. Transcript fidelity is the audit's job (`Laws-audit/`).
2. **Mechanical index tables.** `SourceBlock` 0–73 and `Clause` 0–132 are
   arbitrary declaration order, not logic. `model.py` reads them (and the
   counts) mechanically from `laws.bend`. What is genuinely checked: every
   constructor has an index arm, every index is in range, and each count
   equals its constructor count (asserted at import; a mismatch aborts).
3. **Unexercised functions.** No law calls `clause_source`,
   `clause_effect`, or any `interpretive_term_is_*` guard directly, so
   those functions have **zero** differential coverage. They are covered
   only transitively where rules embed the same constructor checks.
4. **The Bend proofs themselves** (`PROOF.bend`) are not evaluated here;
   `bend PROOF.bend` remains the proof gate (`bash tools/check.sh`).
5. **Not wired into `check.sh`.** Deliberately: the parent decides at
   final consolidation whether this becomes a gate.

## Files

- `model.py` — the independent model (~190 functions) plus mechanical
  index-table extraction and import-time consistency assertions.
- `run.py` — law-statement parser, evaluator, reporter.
- `README.md` — this file.
