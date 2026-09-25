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

## Deontic layer (v0.4.0) — 2026-09-25
- [x] Deontic force/subject/action tags: DeonticForce (Prohibition/Duty/Permission), DeonticSubject (Congress/StateGovernments/FederalGovernment/Anyone), 44 transcript-grounded DeonticActions; clause_deontic tags 44/133 clauses, rest Untagged with documented reasons.
- [x] deontic_conflict predicate: same action + opposing forces + overlapping subjects; conservative overlap rule (Anyone overlaps all; Congress/FederalGovernment disjoint), pinned by law.
- [x] Corpus consistency: tools/deontic/check.py checks all 8778 clause pairs at 2026 — 0 conflicts; generated balanced Bool.and tree over 861 operative pairs wired into check.sh; 32 new laws (predicate boundaries, tag spot-checks, near-miss integrations incl. AM18/AM21).
- [x] Consistency holds relative to the minimal tag table only; untagged clauses out of scope; 2026 snapshot; nothing doctrinal (documented in tools/deontic/README.md).

## Time and change (v0.5.0 wave), Part A — 2026-09-25
- [x] Two-time temporal model: PunishmentEvent{conduct_year, enact_year, punisher, criminal} (plain Nat years, year granularity, no sub-year claims); is_ex_post_facto = conduct_year < enact_year AND criminal, built from one-sided predicates conjoined at the law level (skill rule 1); "punishes" carried by the event type.
- [x] Ex post facto prohibitions for both textual clauses: A1S9C3 via congress_ex_post_facto_prohibited (tagged clause CL_A1S9_Attainder); A1S10C1 via states_ex_post_facto_prohibited (no existing A1S10 constructor covers it — identified by StateGovernments{} subject, no constructor invented).
- [x] 13 new laws with boundary pairs (same-year not retroactive, later conduct not, non-criminal scope boundary not, wrong-subject both ways) + repeal-then-punish ordering pin (verdict stable across a post-enactment repeal year, both directions).
- [x] Criminal-only scope: civil/regulatory explicitly out of scope via the caller-supplied criminal Bool (conditional theorems both ways, skill rule 7); no Calder v. Bull categories, nothing doctrinal beyond the text (documented in tools/temporal/README.md).
- [x] Independent Python model for all new defs; differential agrees on all 495 laws, 0 skipped; new expostfacto_boundary mutant (is_lt -> is_le) killed by bend.
