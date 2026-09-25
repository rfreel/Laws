# Mutation tests for the Laws gate

`run.py` applies each mutant in `mutants.py` to a throwaway copy of the repo
(the working tree is never touched) and asserts the gate fails. A mutant the
gate does not catch is a **survivor**: the suite exits 1 and names it.

The gate under test is two commands:

- `bash tools/check.sh` — static audit (`tools/static_audit.py`, now
  including the `sourcemap.json` cross-checks) → escape reject
  (`@unsafe` / `?TODO` / `def name?` grep) → `bend PROOF.bend`
- `python3 tools/differential/run.py` — the independent Python model
  re-evaluates every `LAWS.bend` statement

## The mutants

| # | Mutant | File | Invariant attacked | Expected catcher |
|---|--------|------|--------------------|------------------|
| 1 | `threshold_boundary` | laws.bend | exact 2/3 boundary passes (`is_le`, not `is_lt`) | bend |
| 2 | `denominator_swap` | laws.bend | impeachment fixes the present-members basis | bend |
| 3 | `quorum_arg_swap` | laws.bend | quorum compares present against membership | bend |
| 4 | `states_fraction` | laws.bend | 3/4-of-states arithmetic (38/50 passes) | bend |
| 5 | `am18_repeal_drop` | laws.bend | AM18 S1 stays marked not-in-force | bend |
| 6 | `temporal_1808` | laws.bend | A1S9 restriction expires exactly at 1808 | bend |
| 7 | `am18_expiry` | laws.bend | AM18 unexpired through 1933 | bend |
| 8 | `clause_index_dup` | laws.bend | clause indices are a contiguous 0..132 range | audit |
| 9 | `clause_count` | laws.bend | `clause_count()` == constructor count | bend + differential |
| 10 | `law_weaken` | LAWS.bend | law statements pin true boundary verdicts | bend + differential |
| 11 | `law_delete` | LAWS.bend | no silent law removal (proof def left dangling) | bend |
| 12 | `proof_delete` | PROOF.bend | every law has a proof def | audit |
| 13 | `escape_inject` | PROOF.bend | no `def name?` escape | escape |
| 14 | `unsafe_comment` | PROOF.bend | no `@unsafe` token, even in comments | escape |
| 15 | `map_drop` | sourcemap.json | every clause has a map entry | audit |
| 16 | `map_index` | sourcemap.json | map indices match the code | audit |
| 17 | `map_url` | sourcemap.json | transcripts are Archives URLs | audit |
| 18 | `inventory_count` | INVENTORY.json | exactly 74 source blocks | audit |

## What the matrix actually demonstrates (read this before citing it)

- **The differential harness does not verify the Bend model.** It
  re-evaluates the *law statements* against the *Python model*; a corrupted
  `laws.bend` that still satisfies every law statement would pass it. The
  Bend model is verified by Bend's own typechecker (`bend PROOF.bend`).
  Mutants 1–7 are caught by `bend`, not by the differential runner — that is
  the intended division of labor, not a gap.
- **The static audit's law↔proof check is one-directional.** It requires
  every law to have a proof def, but not the reverse: deleting a law while
  leaving its proof def behind is caught by `bend` (dangling `Laws.<name>`),
  not by the audit (mutant 11). Deleting a proof def while keeping the law
  is caught by the audit (mutant 12).
- **Escape rejection is lexical, not semantic.** Mutant 14 shows even a
  *comment* containing `@unsafe` trips the gate. That is over-strict by
  design (fail closed); the mutant documents the behavior.
- **Layered defense is real but uneven.** Mutant 8 (duplicated clause
  index) is caught *only* by the static audit — neither `bend` (proofs are
  per-constructor `{==}`, index-agnostic) nor the differential runner
  (reads the index table mechanically) notices. Mutant 9 is caught by
  `bend` (quantified `clause_indices_bounded` law) *and* the differential
  import assert, but not by the static audit, which never reads
  `clause_count()`.

## Running

```
python3 tools/mutation/run.py            # full suite, ~1 min
python3 tools/mutation/run.py --only=threshold_boundary,map_drop
python3 tools/mutation/run.py --keep     # keep temp dirs for inspection
```

Not wired into `tools/check.sh` — that decision belongs to the final
consolidation (parent agent).

## Latest run (2026-09-24, branch feat/mutation-tests)

18 mutants, 17 killed, **1 survivor** (`temporal_1808`), total runtime 10.5s.
Control run on the unmutated tree: `check.sh` → 0, differential → 0.

Per-mutant catchers, observed (not just expected):

| Mutant | Caught by |
|--------|-----------|
| threshold_boundary | bend |
| denominator_swap | bend |
| quorum_arg_swap | bend |
| states_fraction | bend |
| am18_repeal_drop | bend |
| temporal_1808 | **SURVIVOR** |
| am18_expiry | bend |
| clause_index_dup | audit |
| clause_count | bend + differential |
| law_weaken | bend + differential |
| law_delete | bend |
| proof_delete | audit |
| escape_inject | audit (static audit's own escape grep fires before check.sh's) |
| unsafe_comment | audit (same) |
| map_drop / map_index / map_url | audit |
| inventory_count | audit |

### Survivor analysis: `temporal_1808`

The mutant moved the 1808 boundary to 1809 inside
`rule_a1s9_migration_restriction`, and the gate stayed green. Root cause:
**duplicated boundary logic.** `clause_unexpired` carries its own independent
`Nat.is_lt(year, 1808n)` arm for the migration clause, and every boundary law
(`temporal_a1s9_expired_1808`, `temporal_a1s9_unexpired_1807`) pins
`clause_unexpired` — not the rule. The one law touching the rule,
`temporal_a1s9_rule_coherent_1807`, checks coherence only at 1807, where both
copies agree. So the named rule's boundary can drift ±1 year undetected.

Severity: low. The dispatch layer the laws test is correct; the redundancy is
the gap. Recommended fix (for final consolidation, not applied here):
```bend
law temporal_a1s9_rule_expired_1808:
  {C.rule_a1s9_migration_restriction(C.Year{1808n}) == False{} : Bool}
```
plus its `{==}` proof. The same audit-the-duplication question applies to the
AM18 commenced/unexpired arms (currently pinned per-clause, so no survivor
there — but a single-arm drift was not tested).
