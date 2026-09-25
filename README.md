# Constitution → Bend 2

A typed Bend 2 formalization spine for the U.S. Constitution.

The model separates four things that must not be collapsed:

- source blocks: the Preamble, every Article section, and every Amendment section;
- executable arithmetic/procedure: thresholds, qualifications, presentment, treaty approval, impeachment, Article V, treason evidence, term limits, and the Twenty-Sixth Amendment age floor;
- supersession/repeal: represented explicitly rather than deleting historical text;
- open legal terms: represented as `InterpretiveTerm` values rather than assigned invented numerical meanings.

`LAWS.bend` is the proof contract. `PROOF.bend` must check under Bend 2.0.27. The GitHub workflow also rejects `@unsafe`, `?TODO`, and unsafe-def shorthand before invoking the Bend checker.

Authoritative text inventory:

- National Archives Constitution transcript
- National Archives Bill of Rights transcript
- National Archives Amendments 11–27 transcript

This project does not claim that mathematical normalization resolves contested legal interpretation. Those terms remain explicit inputs to later semantic layers.
