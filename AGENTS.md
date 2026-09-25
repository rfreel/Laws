# AGENTS.md

- Target Bend 2.0.27 exactly.
- Read `bend guide` before Bend edits.
- Keep source distinctions in `laws.bend`; do not erase superseded text.
- Do not replace `InterpretiveTerm` values with invented definitions.
- Do not use `@unsafe`, `def name?`, or `?TODO`.
- Do not weaken `LAWS.bend` to make `PROOF.bend` pass.
- Run `bend PROOF.bend` after every Bend change.
- A green Bend proof establishes only the stated formal laws, not correctness of legal interpretation or completeness of doctrine.
