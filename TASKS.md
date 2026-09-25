# Work ledger

## Completed
- [x] Reify the constitutional source-block inventory.
- [x] Reify core interpretive terms instead of assigning fake numeric meanings.
- [x] Encode known amendment-to-earlier-text relations.
- [x] Encode Article I presentment and veto-override arithmetic.
- [x] Encode House, Senate, and President textual qualification thresholds.
- [x] Encode impeachment and treaty two-thirds thresholds.
- [x] Encode Article V two-thirds / three-fourths threshold functions.
- [x] Encode Article III treason evidence alternatives.
- [x] Encode Twenty-Second Amendment election-count boundary.
- [x] Encode Twenty-Sixth Amendment age floor.
- [x] Add Bend laws for threshold edge cases and source coverage.
- [x] Add proof definitions for every declared Bend law.
- [x] Add CI policy checks for proof holes and unsafe definitions.
- [x] Pin Bend release artifact and SHA-256 in CI.

## Remaining after first verified green gate
- [x] Expand each source block into clause-level typed Condition -> Effect rules.
- [x] Add an interpretation environment and evaluator for explicit InterpretiveTerm inputs.
- [x] Add temporal activation for pre-1808, ratification-deadline, repeal, and succession provisions.
- [x] Add explicit denominator policies where the text distinguishes present members, membership, appointed electors, or states.
- [x] Cross-check every normalized clause against the authoritative transcript with a separately maintained source map.
- [x] Add mutation tests that intentionally break each high-value procedure and require proof/check failure.
- [x] Add a second independent implementation of threshold/reference semantics for differential testing.

## Math frontier (v0.3.0) — 2026-09-25
- [x] Model amendment targets: AmendmentTarget (ordinary / suffrage-deprivation / amendment-to-Article-V) with amendment_permissible; the Article V proviso ("no State, without its Consent, shall be deprived of its equal Suffrage in the Senate") is now encoded; self-amendment validity stays an explicit caller input (Gödel's two-step as a machine-checked conditional theorem, exhibit-not-close).
- [x] Temporal-logic properties as bounded machine-checked laws: repeal monotonicity (AM18), commencement monotonicity, non-return (A1S9 post-1808, AM18 post-1934); ex post facto property skipped and documented (would require inventing a conduct timeline).
- [x] Banzhaf voting-power analysis (tools/voting_power/): DP-based indices for Senate, House, Electoral College (2024 apportionment), contingent House election; algorithm logic pinned in the proof gate on a hand-computed 3-voter game; equiprobable-coalition assumption documented.
- [x] Amendment reachability as bounded model checking: abstract 8-state constitution model with amendment_step transitions; dictatorship reachable in 2 steps iff self-amendment held valid, unreachable in 1 step, unreachable (k<=3) when denied; tools/reachability/COMPLEXITY.md with honest decidability bounds.
- [x] Merge all frontier branches + CI bend-install fix (125a92c) into release branch; full gate green (450/450 laws, 18/18 mutants killed).
