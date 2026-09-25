# AGENTS.md

- Target Bend **2.0.27** exactly. The pin is `pins/bend.json` (version + artifact URL inputs + sha256). Do not hardcode a different version in workflows or docs.
- Install locally with `bash tools/install_bend.sh` (or `make install-bend`). Prefer the printed `.bend-prefix` PATH when sudo/`/usr/local` is unavailable.
- Before claiming green: `bash tools/check.sh` (or `make check`) — static audit, escape reject, then `bend PROOF.bend`.
- Read `bend guide` before Bend edits.
- Keep source distinctions in `laws.bend`; do not erase superseded text.
- Do not replace `InterpretiveTerm` values with invented definitions.
- Do not use `@unsafe`, `def name?`, or `?TODO`.
- Do not weaken `LAWS.bend` to make `PROOF.bend` pass.
- Run `bend PROOF.bend` after every Bend change.
- A green Bend proof establishes only the stated formal laws, not correctness of legal interpretation or completeness of doctrine.
