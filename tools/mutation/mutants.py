"""Mutation operators for the Laws gate (TASKS.md item 2).

Each mutant is a precise, minimal corruption of a *copy* of the repo. The
runner (run.py) applies one mutant per temp copy and asserts the gate
(check.sh + differential) FAILS. A mutant the gate does not catch is a
SURVIVOR and fails the suite.

Mutant dict fields:
  name      short id, used in reports
  file      repo-relative file the mutant touches
  kind      "replace": exact old->new string swap (count must match exactly)
            "func":    callable(root: Path) doing a structured edit
  invariant what high-value property this mutant attacks
  expect    gate components expected to catch it: subset of
            {"audit", "escape", "bend", "differential"}
            (informational: run.py records what *actually* caught it)
"""
from pathlib import Path
import json


def _drop_last_sourcemap_entry(root: Path):
    p = root / "sourcemap.json"
    doc = json.loads(p.read_text())
    doc["clauses"] = doc["clauses"][:-1]
    p.write_text(json.dumps(doc, indent=1) + "\n")


def _corrupt_sourcemap_index(root: Path):
    p = root / "sourcemap.json"
    doc = json.loads(p.read_text())
    doc["clauses"][0]["index"] = 999
    p.write_text(json.dumps(doc, indent=1) + "\n")


def _corrupt_sourcemap_url(root: Path):
    p = root / "sourcemap.json"
    doc = json.loads(p.read_text())
    doc["clauses"][0]["transcript"] = "https://example.com/not-archives"
    p.write_text(json.dumps(doc, indent=1) + "\n")


def _drop_inventory_block(root: Path):
    p = root / "INVENTORY.json"
    doc = json.loads(p.read_text())
    doc["source_blocks"].remove("AM27")
    p.write_text(json.dumps(doc, indent=1) + "\n")


def _inject_question_escape(root: Path):
    p = root / "PROOF.bend"
    p.write_text(p.read_text() + "\n# mutation probe\ndef sneaky_probe?:\n  True{}\n")


def _inject_unsafe_comment(root: Path):
    p = root / "PROOF.bend"
    p.write_text(p.read_text() + "\n# @unsafe bypass note (mutation probe)\n")


MUTANTS = [
    # ---- model mutants: laws.bend (expect: bend PROOF.bend fails) ----
    dict(
        name="threshold_boundary",
        file="laws.bend", kind="replace", count=1,
        old=("def two_thirds(yes: Nat, counts: ChamberCount, basis: DenominatorBasis) -> Bool:\n"
             "  Nat.is_le(Nat.mul(2n, chamber_basis_count(counts, basis)), Nat.mul(3n, yes))"),
        new=("def two_thirds(yes: Nat, counts: ChamberCount, basis: DenominatorBasis) -> Bool:\n"
             "  Nat.is_lt(Nat.mul(2n, chamber_basis_count(counts, basis)), Nat.mul(3n, yes))"),
        invariant="two-thirds boundary arithmetic: an exact 2/3 (e.g. 60/90, 67/100) passes",
        expect=["bend"],
    ),
    dict(
        name="denominator_swap",
        file="laws.bend", kind="replace", count=1,
        old=('  # of the Members present" \u2014 the present basis is fixed by the signature.\n'
             "  two_thirds(senate_yes, counts, PresentMembers{})"),
        new=('  # of the Members present" \u2014 the present basis is fixed by the signature.\n'
             "  two_thirds(senate_yes, counts, FullMembership{})"),
        invariant="impeachment_conviction fixes the transcript's present-members basis in its signature",
        expect=["bend"],
    ),
    dict(
        name="quorum_arg_swap",
        file="laws.bend", kind="replace", count=1,
        old=("def quorum_met(counts: ChamberCount) -> Bool:\n"
             "  match counts:\n"
             "    case ChamberCount{present, membership}:\n"
             "      Nat.is_lt(membership, Nat.mul(2n, present))"),
        new=("def quorum_met(counts: ChamberCount) -> Bool:\n"
             "  match counts:\n"
             "    case ChamberCount{present, membership}:\n"
             "      Nat.is_lt(present, Nat.mul(2n, membership))"),
        invariant="quorum tests present-against-membership, not the reverse",
        expect=["bend"],
    ),
    dict(
        name="states_fraction",
        file="laws.bend", kind="replace", count=1,
        old=("def states_three_fourths(yes: Nat, counts: StatesCount) -> Bool:\n"
             "  match counts:\n"
             "    case StatesCount{states}:\n"
             "      Nat.is_le(Nat.mul(3n, states), Nat.mul(4n, yes))"),
        new=("def states_three_fourths(yes: Nat, counts: StatesCount) -> Bool:\n"
             "  match counts:\n"
             "    case StatesCount{states}:\n"
             "      Nat.is_le(Nat.mul(3n, states), Nat.mul(3n, yes))"),
        invariant="three-fourths-of-states arithmetic (38/50 passes)",
        expect=["bend"],
    ),
    dict(
        name="am18_repeal_drop",
        file="laws.bend", kind="replace", count=1,
        old="    case CL_AM18S1_Prohibition{}:\n      False{}\n",
        new="",
        invariant="AM18 S1 stays marked not-in-force (repealed, text preserved)",
        expect=["bend"],
    ),
    dict(
        name="temporal_1808",
        file="laws.bend", kind="replace", count=1,
        old=("def rule_a1s9_migration_restriction(t: TimePoint) -> Bool:\n"
             "  match t:\n"
             "    case Year{year}:\n"
             "      Nat.is_lt(year, 1808n)"),
        new=("def rule_a1s9_migration_restriction(t: TimePoint) -> Bool:\n"
             "  match t:\n"
             "    case Year{year}:\n"
             "      Nat.is_lt(year, 1809n)"),
        invariant="A1S9 restriction expires exactly at 1808 (transcript year)",
        expect=["bend"],
    ),
    dict(
        name="am18_expiry",
        file="laws.bend", kind="replace", count=3,
        old="      Nat.is_le(year, 1933n)",
        new="      Nat.is_le(year, 1932n)",
        invariant="AM18 provisions unexpired through 1933 (AM21 ratified Dec 1933)",
        expect=["bend"],
    ),
    dict(
        name="clause_index_dup",
        file="laws.bend", kind="replace", count=1,
        old="    case CL_A1S9_MigrationRestriction{}:\n      132n",
        new="    case CL_A1S9_MigrationRestriction{}:\n      131n",
        invariant="clause_index arms are a contiguous 0..132 range (no dup/missing)",
        expect=["audit"],
    ),
    dict(
        name="clause_count",
        file="laws.bend", kind="replace", count=1,
        old="def clause_count() -> Nat:\n  133n",
        new="def clause_count() -> Nat:\n  132n",
        invariant="clause_count() equals the constructor count (133)",
        expect=["bend", "differential"],
    ),
    # ---- law mutants: LAWS.bend (contract weakened) ----
    dict(
        name="law_weaken",
        file="LAWS.bend", kind="replace", count=1,
        old=("law impeachment_66_of_100_fails:\n"
             "  {C.impeachment_conviction(66n, C.ChamberCount{100n, 100n}) == False{} : Bool}"),
        new=("law impeachment_66_of_100_fails:\n"
             "  {C.impeachment_conviction(66n, C.ChamberCount{100n, 100n}) == True{} : Bool}"),
        invariant="law statements pin the true boundary verdicts (66/100 fails)",
        expect=["bend", "differential"],
    ),
    dict(
        name="law_delete",
        file="LAWS.bend", kind="replace", count=1,
        old=("law denominator_quorum_not_met:\n"
             "  {C.quorum_met(C.ChamberCount{217n, 435n}) == False{} : Bool}\n\n"),
        new="",
        invariant="every law keeps its proof obligation (no silent law removal)",
        expect=["bend"],
    ),
    # ---- proof mutants: PROOF.bend ----
    dict(
        name="proof_delete",
        file="PROOF.bend", kind="replace", count=1,
        old="def Laws.denominator_quorum_not_met():\n  {==}\n",
        new="",
        invariant="every law has a proof def (audit is the enforcer)",
        expect=["audit"],
    ),
    dict(
        name="escape_inject",
        file="PROOF.bend", kind="func", func=_inject_question_escape,
        invariant="no `def name?` proof escape anywhere in *.bend",
        expect=["escape"],
    ),
    dict(
        name="unsafe_comment",
        file="PROOF.bend", kind="func", func=_inject_unsafe_comment,
        invariant="no @unsafe token anywhere in *.bend (even in comments)",
        expect=["escape"],
    ),
    # ---- source-map mutants: sourcemap.json ----
    dict(
        name="map_drop",
        file="sourcemap.json", kind="func", func=_drop_last_sourcemap_entry,
        invariant="every clause has exactly one source-map entry",
        expect=["audit"],
    ),
    dict(
        name="map_index",
        file="sourcemap.json", kind="func", func=_corrupt_sourcemap_index,
        invariant="map indices match laws.bend clause_index arms",
        expect=["audit"],
    ),
    dict(
        name="map_url",
        file="sourcemap.json", kind="func", func=_corrupt_sourcemap_url,
        invariant="map transcripts are National Archives URLs",
        expect=["audit"],
    ),
    # ---- inventory mutant ----
    dict(
        name="inventory_count",
        file="INVENTORY.json", kind="func", func=_drop_inventory_block,
        invariant="inventory lists exactly the 74 source blocks",
        expect=["audit"],
    ),
]
