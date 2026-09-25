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
