"""Independent Python model of the Laws formalization spine (rfreel/Laws).

This module re-implements the executable semantics of laws.bend from the
contract stated in LAWS.bend and the constitutional transcript — it is NOT a
transliteration of the Bend source. The two implementations share only:

  1. The law statements in LAWS.bend (the contract under test).
  2. The *declared* index tables (SourceBlock 0-73, Clause 0-132): these are
     arbitrary declaration order, not logic. They are read mechanically from
     laws.bend (see _load_declarations). What this model CHECKS about them is
     the logic: every constructor has an arm, every index is in range, and
     each count equals its constructor count.

Everything else — threshold arithmetic, denominator-basis selection,
eligibility predicates, presentment paths, clause Condition->Effect rules,
temporal windows, and the interpretation-environment dispatch — is written
fresh from the transcript's meaning. Agreement with `bend PROOF.bend` is
therefore genuine cross-implementation evidence; any disagreement is a
finding to investigate (see README.md).

Value representation
--------------------
- Bend Nat  -> Python int
- Bend Bool -> Python bool (True{}/False{} parse to True/False)
- Bend Data constructor -> Data(name, fields); e.g. ChamberCount{90n,100n}
  becomes Data("ChamberCount", (90, 100)). Positional fields, as in Bend.
- InterpEnv -> Python list of (term_name, bool), newest binding first.
"""

from __future__ import annotations

import itertools
import re
from pathlib import Path


# --------------------------------------------------------------------------
# Values
# --------------------------------------------------------------------------

class Data:
    """A Bend Data constructor value: name + positional fields."""

    __slots__ = ("name", "fields")

    def __init__(self, name: str, fields=()):
        self.name = name
        self.fields = tuple(fields)

    def __eq__(self, other):
        return (
            isinstance(other, Data)
            and self.name == other.name
            and self.fields == other.fields
        )

    def __hash__(self):
        return hash((self.name, self.fields))

    def __repr__(self):
        inner = ", ".join(repr(f) for f in self.fields)
        return f"{self.name}{{{inner}}}"


def _known(value: bool) -> Data:
    return Data("Known", (value,))


_UNKNOWN = Data("Unknown", ())


# --------------------------------------------------------------------------
# Declared index tables (mechanical extraction, not logic)
# --------------------------------------------------------------------------

def _repo_root() -> Path:
    return Path(__file__).resolve().parents[2]


def _laws_text() -> str:
    return (_repo_root() / "laws.bend").read_text()


def _parse_constructors(text: str, type_name: str) -> list[str]:
    """Constructors of `type <type_name> is Data:` in declaration order.

    Comment lines inside the type body are tolerated (one constructor
    carries a comment above it).
    """
    m = re.search(
        rf"^type {type_name} is Data:\n((?:(?:  \w+\{{}}|  #.*)\n)+)", text, re.M
    )
    if not m:
        raise ValueError(f"could not find type {type_name}")
    return re.findall(r"  (\w+)\{\}", m.group(1))


def _parse_index_arms(text: str, func_name: str) -> dict[str, int]:
    """Map constructor -> literal Nat from a `def <func>(x) -> Nat:` match."""
    m = re.search(
        rf"^def {func_name}\([^)]*\) -> Nat:\n  match \w+:\n((?:    case \w+\{{}}:\n      \d+n\n)+)",
        text,
        re.M,
    )
    if not m:
        raise ValueError(f"could not find index arms for {func_name}")
    arms = {}
    for ctor, num in re.findall(r"    case (\w+)\{\}:\n      (\d+)n", m.group(1)):
        arms[ctor] = int(num)
    return arms


def _parse_count(text: str, func_name: str) -> int:
    m = re.search(rf"^def {func_name}\(\) -> Nat:\n  (\d+)n", text, re.M)
    if not m:
        raise ValueError(f"could not find count for {func_name}")
    return int(m.group(1))


_text = _laws_text()
SOURCE_BLOCKS: list[str] = _parse_constructors(_text, "SourceBlock")
SOURCE_INDEX: dict[str, int] = _parse_index_arms(_text, "source_index")
SOURCE_COUNT: int = _parse_count(_text, "source_count")
CLAUSES: list[str] = _parse_constructors(_text, "Clause")
CLAUSE_INDEX: dict[str, int] = _parse_index_arms(_text, "clause_index")
CLAUSE_COUNT: int = _parse_count(_text, "clause_count")
del _text

# The logic under test for the tables: full coverage, in-range indices,
# counts that match the constructor counts.
assert len(SOURCE_BLOCKS) == 74, f"expected 74 source blocks, got {len(SOURCE_BLOCKS)}"
assert set(SOURCE_INDEX) == set(SOURCE_BLOCKS), "source_index arms != constructors"
assert SOURCE_COUNT == len(SOURCE_BLOCKS), "source_count != constructor count"
assert set(CLAUSE_INDEX) == set(CLAUSES), "clause_index arms != constructors"
assert CLAUSE_COUNT == len(CLAUSES), "clause_count != constructor count"


def source_index(block: Data) -> int:
    return SOURCE_INDEX[block.name]


def source_count() -> int:
    return SOURCE_COUNT


def source_index_in_range(block: Data) -> bool:
    return source_index(block) < source_count()


def clause_index(clause: Data) -> int:
    return CLAUSE_INDEX[clause.name]


def clause_count() -> int:
    return CLAUSE_COUNT


def clause_index_in_range(clause: Data) -> bool:
    return clause_index(clause) < clause_count()


# --------------------------------------------------------------------------
# Denominator layer
# --------------------------------------------------------------------------
# The transcript distinguishes four denominator bases. Thresholds take
# (yes-votes, count bundle, basis) and select the denominator internally.

def chamber_basis_count(counts: Data, basis: Data) -> int:
    """Denominator the transcript's basis demands from a chamber bundle."""
    present, membership = counts.fields
    if basis.name == "PresentMembers":
        return present
    # FullMembership: the whole House. AppointedElectors resolves to
    # membership as well (the whole number of a voting body is its
    # membership). States never occurs with a chamber bundle.
    return membership


def two_thirds(yes: int, counts: Data, basis: Data) -> bool:
    # "two thirds": 2 * denominator <= 3 * yes  <=>  yes/denominator >= 2/3.
    return 2 * chamber_basis_count(counts, basis) <= 3 * yes


def majority(yes: int, counts: Data, basis: Data) -> bool:
    # Strict majority: denominator < 2 * yes  <=>  yes > denominator / 2.
    return chamber_basis_count(counts, basis) < 2 * yes


def states_two_thirds(yes: int, counts: Data) -> bool:
    (states,) = counts.fields
    return 2 * states <= 3 * yes


def states_three_fourths(yes: int, counts: Data) -> bool:
    (states,) = counts.fields
    return 3 * states <= 4 * yes


def quorum_met(counts: Data) -> bool:
    # A1S5: "a Majority of each [House] shall constitute a Quorum" — a
    # majority of the membership must be present.
    present, membership = counts.fields
    return membership < 2 * present


# --------------------------------------------------------------------------
# Qualification predicates
# --------------------------------------------------------------------------

def representative_eligible(age: int, citizen_years: int, inhabitant: bool) -> bool:
    # A1S2: 25 years old, 7 years a citizen, inhabitant of the state.
    return age >= 25 and citizen_years >= 7 and inhabitant


def senator_eligible(age: int, citizen_years: int, inhabitant: bool) -> bool:
    # A1S3: 30 years old, 9 years a citizen, inhabitant.
    return age >= 30 and citizen_years >= 9 and inhabitant


def president_eligible(age: int, resident_years: int, natural_born: bool) -> bool:
    # A2S1: 35 years old, 14 years resident, natural-born citizen.
    return age >= 35 and resident_years >= 14 and natural_born


# --------------------------------------------------------------------------
# Domain predicates
# --------------------------------------------------------------------------

_PRESENT = Data("PresentMembers", ())
_FULL = Data("FullMembership", ())


def impeachment_conviction(senate_yes: int, counts: Data) -> bool:
    # A1S3: conviction needs "two thirds of the Members present".
    return two_thirds(senate_yes, counts, _PRESENT)


def treaty_approved(senate_yes: int, counts: Data) -> bool:
    # A2S2: treaties need "two thirds of the Senators present".
    return two_thirds(senate_yes, counts, _PRESENT)


def article_v_congress_proposal(
    house_yes: int, house: Data, senate_yes: int, senate: Data
) -> bool:
    # Art. V: proposal by "two thirds of both Houses" — of the Houses
    # themselves, i.e. full membership.
    return two_thirds(house_yes, house, _FULL) and two_thirds(
        senate_yes, senate, _FULL
    )


def article_v_state_application(applications: int, counts: Data) -> bool:
    # Art. V: convention on application of "two thirds of the several States".
    return states_two_thirds(applications, counts)


def article_v_ratification(ratifying_states: int, counts: Data) -> bool:
    # Art. V: ratification by "three fourths of the several States".
    return states_three_fourths(ratifying_states, counts)


def amendment_permissible(
    target: Data, affected_consent: bool, self_amendment_ok: bool
) -> bool:
    # Target permissibility, independent of vote counts. Art. V's proviso:
    # "no State, without its Consent, shall be deprived of its equal
    # Suffrage in the Senate." The text is silent on amending the amendment
    # rule itself, so that question stays a caller-supplied judgment.
    if target.name == "OrdinaryAmendment":
        return True
    if target.name == "EqualSuffrageDeprivation":
        return affected_consent
    if target.name == "ArticleVProcedure":
        return self_amendment_ok
    raise ValueError(f"unknown AmendmentTarget {target!r}")


def amendment_valid(
    target: Data,
    house_yes: int,
    house: Data,
    senate_yes: int,
    senate: Data,
    ratifying: int,
    states: Data,
    affected_consent: bool,
    self_amendment_ok: bool,
) -> bool:
    # Congressional-proposal / state-ratification path (not the convention
    # path): proposal thresholds AND ratification thresholds AND target
    # permissibility.
    return (
        article_v_congress_proposal(house_yes, house, senate_yes, senate)
        and article_v_ratification(ratifying, states)
        and amendment_permissible(target, affected_consent, self_amendment_ok)
    )


def godel_two_step(
    h1_yes: int,
    h1: Data,
    s1_yes: int,
    s1: Data,
    r1: int,
    st1: Data,
    h2_yes: int,
    h2: Data,
    s2_yes: int,
    s2: Data,
    r2: int,
    st2: Data,
    self_amendment_ok: bool,
) -> bool:
    # Step 1 amends Article V itself; step 2 is stated against the post-step-1
    # landscape where the proviso is deleted. The conjunction keeps the whole
    # sequence conditional on step 1's validity.
    step1 = amendment_valid(
        Data("ArticleVProcedure", ()),
        h1_yes,
        h1,
        s1_yes,
        s1,
        r1,
        st1,
        True,
        self_amendment_ok,
    )
    step2 = amendment_valid(
        Data("OrdinaryAmendment", ()),
        h2_yes,
        h2,
        s2_yes,
        s2,
        r2,
        st2,
        True,
        True,
    )
    return step1 and step2


def const_init() -> Data:
    # The as-ratified starting point: everything intact.
    return Data("CState", (True, True, True))


def apply_ordinary(p: bool, r: bool, s: bool, valid: bool) -> Data:
    # A valid ordinary amendment is the archetypal rights-eroding step in
    # the abstract model: it clears rights_intact and touches nothing else.
    if valid:
        return Data("CState", (p, False, s))
    return Data("CState", (p, r, s))


def apply_articleV(p: bool, r: bool, s: bool, valid: bool) -> Data:
    # A valid amendment to the amendment rule rewrites Article V, deleting
    # the entrenchment proviso AND capturing the rule: both flags fall.
    if valid:
        return Data("CState", (False, r, False))
    return Data("CState", (p, r, s))


def amendment_step(
    state: Data,
    target: Data,
    house_yes: int,
    house: Data,
    senate_yes: int,
    senate: Data,
    ratifying: int,
    states: Data,
    affected_consent: bool,
    self_amendment_ok: bool,
) -> Data:
    # One amendment step over the abstract 8-state ConstState system.
    # Invalid amendments leave the state unchanged. A consensual
    # EqualSuffrageDeprivation complies with the proviso, so no abstract
    # flag changes.
    p, r, s = state.fields
    if target.name == "OrdinaryAmendment":
        return apply_ordinary(
            p,
            r,
            s,
            amendment_valid(
                target,
                house_yes,
                house,
                senate_yes,
                senate,
                ratifying,
                states,
                affected_consent,
                self_amendment_ok,
            ),
        )
    if target.name == "EqualSuffrageDeprivation":
        return Data("CState", (p, r, s))
    if target.name == "ArticleVProcedure":
        return apply_articleV(
            p,
            r,
            s,
            amendment_valid(
                target,
                house_yes,
                house,
                senate_yes,
                senate,
                ratifying,
                states,
                affected_consent,
                self_amendment_ok,
            ),
        )
    raise ValueError(f"unknown AmendmentTarget {target!r}")


def const_state_code(state: Data) -> int:
    # Nat code for a ConstState, bit order proviso*4 + rights*2 + self_rule;
    # dictatorship CState{False,False,False} is code 0. Must agree with
    # laws.bend const_state_bits/const_state_code (asserted by
    # tools/reachability/check.py over all 8 states).
    p, r, s = state.fields
    return (4 if p else 0) + (2 if r else 0) + (1 if s else 0)


def _max_vote_step_args():
    # The attacker's max-vote configuration shared by the chain helpers.
    return (
        435,
        Data("ChamberCount", (435, 435)),
        100,
        Data("ChamberCount", (100, 100)),
        50,
        Data("StatesCount", (50,)),
        True,
    )


def reach_chain_2(t1: Data, ok1: bool, t2: Data, ok2: bool) -> Data:
    # Max-vote two-step chain from const_init(); mirrors laws.bend
    # reach_chain_2 (one explicit caller Bool per step).
    hv, house, sv, senate, rv, states, consent = _max_vote_step_args()
    return amendment_step(
        amendment_step(const_init(), t1, hv, house, sv, senate, rv, states, consent, ok1),
        t2,
        hv,
        house,
        sv,
        senate,
        rv,
        states,
        consent,
        ok2,
    )


def reach_chain_3(
    t1: Data, ok1: bool, t2: Data, ok2: bool, t3: Data, ok3: bool
) -> Data:
    # Max-vote three-step chain from const_init(); mirrors laws.bend
    # reach_chain_3.
    hv, house, sv, senate, rv, states, consent = _max_vote_step_args()
    return amendment_step(
        amendment_step(
            amendment_step(const_init(), t1, hv, house, sv, senate, rv, states, consent, ok1),
            t2,
            hv,
            house,
            sv,
            senate,
            rv,
            states,
            consent,
            ok2,
        ),
        t3,
        hv,
        house,
        sv,
        senate,
        rv,
        states,
        consent,
        ok3,
    )


def reachability_gate() -> bool:
    # Faithful re-implementation of the generated Bend def of the same name:
    # the conjunction of the 8 key reachability claims at max votes.
    # (Per the project's division of labor, this checks the *statements*
    # against the second implementation; bend PROOF.bend checks the model.)
    artV = Data("ArticleVProcedure", ())
    ordin = Data("OrdinaryAmendment", ())
    suffr = Data("EqualSuffrageDeprivation", ())
    hv, house, sv, senate, rv, states, consent = _max_vote_step_args()

    def step1(target: Data, self_ok: bool) -> Data:
        return amendment_step(
            const_init(), target, hv, house, sv, senate, rv, states, consent, self_ok
        )

    return (
        const_state_code(reach_chain_2(artV, True, ordin, True)) == 0
        and const_state_code(reach_chain_2(artV, False, ordin, False)) == 5
        and const_state_code(step1(artV, True)) == 2
        and const_state_code(step1(ordin, True)) == 5
        and const_state_code(step1(suffr, True)) == 7
        and const_state_code(reach_chain_3(ordin, False, ordin, False, ordin, False)) == 5
        and const_state_code(reach_chain_3(artV, False, ordin, False, artV, False)) == 5
        and const_state_code(reach_chain_3(suffr, False, ordin, False, suffr, False)) == 5
    )


def bill_becomes_law(
    passed_house: bool,
    passed_senate: bool,
    presented: bool,
    signed: bool,
    vetoed: bool,
    house_override_yes: int,
    house: Data,
    senate_override_yes: int,
    senate: Data,
    ten_days_elapsed_excluding_sundays: bool,
    adjournment_prevents_return: bool,
) -> bool:
    # A1S7 presentment. Three paths to law: signature; veto override by
    # "two thirds of that House" (full membership) in each House; or the
    # ten-day lapse when Congress has not adjourned away the return
    # (the pocket-veto exclusion).
    base = passed_house and passed_senate and presented
    override_path = (
        vetoed
        and two_thirds(house_override_yes, house, _FULL)
        and two_thirds(senate_override_yes, senate, _FULL)
    )
    lapse_path = ten_days_elapsed_excluding_sundays and not adjournment_prevents_return
    return base and (signed or override_path or lapse_path)


def treason_conviction_evidence(
    two_witnesses_same_overt_act: bool, confession_open_court: bool
) -> bool:
    # A3S3: conviction on testimony of two witnesses to the same overt act,
    # or on confession in open court.
    return two_witnesses_same_overt_act or confession_open_court


def presidential_election_limit(
    elected_count: int, served_other_term_more_than_two_years: bool
) -> bool:
    # AM22: at most two elections; at most one if the person already served
    # more than two years of someone else's term.
    return elected_count <= (1 if served_other_term_more_than_two_years else 2)


def age_vote_protection(age: int) -> bool:
    # AM26: the vote of citizens 18 or older shall not be denied on account
    # of age.
    return age >= 18


def amendment_18_repealed(block: Data) -> bool:
    # AM21S1 repeals the eighteenth article (its three sections).
    return block.name in ("AM18S1", "AM18S2", "AM18S3")


def clause_in_force(clause: Data) -> bool:
    # The repealed AM18 text stays in the corpus; it no longer operates.
    return clause.name not in (
        "CL_AM18S1_Prohibition",
        "CL_AM18S2_ConcurrentPower",
        "CL_AM18S3_EffectiveDate",
    )

# --------------------------------------------------------------------------
# Clause Condition -> Effect rules (batch 1: Preamble .. AM26)
# --------------------------------------------------------------------------
# Each rule is written from the transcript's operative meaning. Open legal
# terms (InterpretiveTerm) stay opaque: a rule conjoins a caller-supplied
# `satisfied` flag with a check that the *right term* was supplied
# (constructor-identity only — no meaning is assigned to the term).

def _term_is(term: Data, name: str) -> bool:
    return term.name == name


def rule_preamble_purpose(purposes_affirmed: bool) -> bool:
    return purposes_affirmed


def rule_a1s2_qualifications(age: int, citizen_years: int, inhabitant: bool) -> bool:
    return representative_eligible(age, citizen_years, inhabitant)


def rule_a1s2_impeachment_power(charges_brought: bool) -> bool:
    # The House has the sole power of impeachment.
    return charges_brought


def rule_a1s2_apportionment_cap(reps: int, state_pop: int) -> bool:
    # Representatives "shall not exceed one for every thirty Thousand".
    return 30000 * reps <= state_pop


def rule_a1s3_qualifications(age: int, citizen_years: int, inhabitant: bool) -> bool:
    return senator_eligible(age, citizen_years, inhabitant)


def rule_a1s3_senate_trial(senate_yes: int, counts: Data) -> bool:
    # The Senate tries impeachments; conviction needs two thirds of the
    # Members present.
    return impeachment_conviction(senate_yes, counts)


def rule_a1s3_vp_tiebreak(yes_votes: int, no_votes: int) -> bool:
    # The Vice President votes only when the Senate is equally divided.
    return yes_votes == no_votes


def rule_a1s4_election_regulation(state_prescribed: bool, congress_alters: bool) -> bool:
    # Times/places/manner prescribed by the states; Congress may alter.
    return state_prescribed or congress_alters


def rule_a1s4_annual_assembly(assembled: bool) -> bool:
    # Congress assembles at least once every year.
    return assembled


def rule_a1s7_presentment(
    passed_house: bool,
    passed_senate: bool,
    presented: bool,
    signed: bool,
    vetoed: bool,
    house_override_yes: int,
    house: Data,
    senate_override_yes: int,
    senate: Data,
    ten_days_elapsed: bool,
    adjournment_prevents_return: bool,
) -> bool:
    return bill_becomes_law(
        passed_house,
        passed_senate,
        presented,
        signed,
        vetoed,
        house_override_yes,
        house,
        senate_override_yes,
        senate,
        ten_days_elapsed,
        adjournment_prevents_return,
    )


def rule_a1s7_revenue_origination(revenue_bill: bool, originated_house: bool) -> bool:
    # Revenue bills originate in the House; other bills are unconstrained.
    return (not revenue_bill) or originated_house


def rule_a2s1_vesting(office_held: bool) -> bool:
    # The executive power is vested in a President.
    return office_held


def rule_a2s1_term(term_years: int) -> bool:
    # The President holds office during the term of four years.
    return term_years <= 4


def rule_a2s1_qualifications(age: int, resident_years: int, natural_born: bool) -> bool:
    return president_eligible(age, resident_years, natural_born)


def rule_a2s1_natural_born(term: Data, satisfied: bool) -> bool:
    return _term_is(term, "NaturalBornCitizen") and satisfied


def rule_a2s1_electors(electors: int, senators: int, representatives: int) -> bool:
    # Electors per state equal its senators plus representatives.
    return electors == senators + representatives


def rule_a3s2_treason_evidence(two_witnesses: bool, confession: bool) -> bool:
    return treason_conviction_evidence(two_witnesses, confession)


def rule_a3s2_jury_trial(
    trial_by_jury: bool,
    speedy_term: Data,
    speedy_met: bool,
    impartial_term: Data,
    impartial_met: bool,
) -> bool:
    return (
        trial_by_jury
        and (_term_is(speedy_term, "Speedy") and speedy_met)
        and (_term_is(impartial_term, "Impartial") and impartial_met)
    )


def rule_a5_congress_proposal(
    house_yes: int, house: Data, senate_yes: int, senate: Data
) -> bool:
    return article_v_congress_proposal(house_yes, house, senate_yes, senate)


def rule_a5_convention_application(applications: int, counts: Data) -> bool:
    return article_v_state_application(applications, counts)


def rule_a5_ratification(ratifying_states: int, counts: Data) -> bool:
    return article_v_ratification(ratifying_states, counts)


def rule_am12_electoral_majority(votes: int, electors: int) -> bool:
    # AM12: "a majority of the whole number of Electors". The whole number
    # appointed is the body's membership (present == membership).
    return majority(votes, Data("ChamberCount", (electors, electors)), Data("AppointedElectors"))


def rule_am12_distinct_ballots(ballots_distinct: bool) -> bool:
    # Electors vote by ballot, distinctly for President and Vice-President.
    return ballots_distinct


def rule_am13s1_abolition(involuntary_servitude: bool, punishment_for_crime: bool) -> bool:
    # No slavery or involuntary servitude except as punishment for crime.
    return (not involuntary_servitude) or punishment_for_crime


def rule_am14s2_apportionment_basis(counts_whole_persons: bool) -> bool:
    # Apportionment counts the whole number of persons in each state.
    return counts_whole_persons


def rule_am14s2_reduction(vote_denied: bool, excepted_cause: bool) -> bool:
    # Representation is reduced when the vote is denied, except for
    # rebellion or other crime.
    return vote_denied and not excepted_cause


def rule_am16_income_tax(tax_on_incomes: bool) -> bool:
    # Congress may tax incomes without apportionment.
    return tax_on_incomes


def rule_am17_direct_election(elected_by_people: bool) -> bool:
    # Senators are elected by the people.
    return elected_by_people


def rule_am17_vacancy_appointment(governor_appointed: bool, legislature_empowered: bool) -> bool:
    # The executive may make temporary appointments when the legislature
    # empowers it to do so.
    return governor_appointed and legislature_empowered


def rule_am18s1_prohibition(liquor_traffic: bool, beverage_purpose: bool, liquor_term: Data) -> bool:
    # AM18S1 (repealed): the prohibition holds unless there is liquor
    # traffic for beverage purposes in intoxicating liquor.
    return not (
        liquor_traffic and beverage_purpose and _term_is(liquor_term, "IntoxicatingLiquor")
    )


def rule_am18s2_concurrent_power(enforcement_asserted: bool) -> bool:
    return enforcement_asserted


def rule_am18s3_effective_date(one_year_elapsed: bool) -> bool:
    return one_year_elapsed


def rule_am20s1_term_commencement(terms_began_noon_jan20: bool) -> bool:
    return terms_began_noon_jan20


def rule_am20s2_congress_assembly(assembled_noon_jan3: bool) -> bool:
    return assembled_noon_jan3


def rule_am20s3_president_elect_death(president_elect_died: bool) -> bool:
    # If the President-elect dies, the Vice President-elect becomes President.
    return president_elect_died


def rule_am20s4_succession_statute(provided_by_law: bool) -> bool:
    # Congress provides by law for the case where no one qualifies.
    return provided_by_law


def rule_am21s1_repeal() -> bool:
    # The eighteenth article of amendment is repealed.
    return True


def rule_am22s1_term_limit(elected_count: int) -> bool:
    return presidential_election_limit(elected_count, False)


def rule_am22s2_prior_service_limit(elected_count: int) -> bool:
    return presidential_election_limit(elected_count, True)


def rule_am25s1_succession(vacancy: bool) -> bool:
    # The Vice President becomes President on removal, death, or resignation.
    return vacancy


def rule_am25s2_vp_confirmation(
    house_yes: int, house: Data, senate_yes: int, senate: Data
) -> bool:
    # Confirmation by "a majority of both Houses" — of the Houses themselves.
    return majority(house_yes, house, _FULL) and majority(senate_yes, senate, _FULL)


def rule_am25s3_voluntary_transfer(declaration: bool, unable_term: Data, unable_satisfied: bool) -> bool:
    # On the President's written declaration of inability, the Vice
    # President acts; "unable" is an opaque term input.
    return declaration and _term_is(unable_term, "UnableToDischarge") and unable_satisfied


def rule_am25s4_congress_decision(
    house_yes: int, house: Data, senate_yes: int, senate: Data
) -> bool:
    # Congress decides a contested inability by two thirds of both Houses.
    return two_thirds(house_yes, house, _FULL) and two_thirds(senate_yes, senate, _FULL)


def rule_am26s1_vote_age(age: int) -> bool:
    return age_vote_protection(age)

# --------------------------------------------------------------------------
# Clause Condition -> Effect rules (batch 2: completion wave, A1S1 .. AM27)
# --------------------------------------------------------------------------

def rule_a1s1_vesting(legislative_power_in_congress: bool) -> bool:
    # All legislative powers vest in Congress (Senate + House).
    return legislative_power_in_congress


def rule_a1s5_quorum(counts: Data) -> bool:
    return quorum_met(counts)


def rule_a1s5_expulsion(yes: int, counts: Data) -> bool:
    # Expulsion needs two thirds concurrence. Judgment call (shared with the
    # Bend model): the text names no basis, so the present-members basis is
    # used, matching the other A1S5/S3 vote rules.
    return two_thirds(yes, counts, _PRESENT)


def rule_a1s5_yeas_nays(desiring: int, present: int) -> bool:
    # Yeas and nays entered at the desire of one fifth of those present:
    # desiring >= present/5, i.e. present <= 5 * desiring.
    return present <= 5 * desiring


def rule_a1s5_adjournment(days: int, other_consents: bool) -> bool:
    # No adjournment over three days without the other House's consent.
    return days <= 3 or other_consents


def rule_a1s6_arrest_privilege(
    attending: bool, treason: bool, felony: bool, breach_of_peace: bool
) -> bool:
    # Privilege from arrest during attendance, except treason, felony, and
    # breach of the peace.
    return attending and not (treason or felony or breach_of_peace)


def rule_a1s6_speech_debate(questioned_elsewhere: bool) -> bool:
    # No questioning elsewhere for speech or debate in either House.
    return not questioned_elsewhere


def rule_a1s6_incompatible(holds_office: bool, is_member: bool) -> bool:
    # No office-holder under the U.S. sits in either House while in office.
    return not (holds_office and is_member)


def rule_a1s6_emolument(accepts: bool, congress_consents: bool) -> bool:
    # No foreign present/emolument/office/title without Congress's consent.
    return (not accepts) or congress_consents


def rule_a1s8_tax(tax_for_debts_welfare: bool, uniform: bool) -> bool:
    # Taxes for debts/defence/welfare; duties/imposts/excises uniform.
    return tax_for_debts_welfare and uniform


def rule_a1s8_commerce(term: Data, regulated: bool) -> bool:
    return _term_is(term, "Commerce") and regulated


def rule_a1s8_naturalization_bankruptcy(uniform_rule: bool) -> bool:
    # Uniform rule of naturalization; uniform bankruptcy laws.
    return uniform_rule


def rule_a1s8_coin_weights(coins_money: bool) -> bool:
    # Coin money, regulate its value, fix weights and measures.
    return coins_money


def rule_a1s8_declare_war(congress_declares: bool) -> bool:
    return congress_declares


def rule_a1s8_necessary_proper(term: Data, proper_exercise: bool) -> bool:
    return _term_is(term, "NecessaryAndProper") and proper_exercise


def rule_a1s9_habeas(suspended: bool, rebellion: bool, invasion: bool) -> bool:
    # Habeas not suspended unless rebellion or invasion requires it.
    return (not suspended) or rebellion or invasion


def rule_a1s9_attainder(passed: bool) -> bool:
    # No bill of attainder or ex post facto law passes.
    return not passed


def rule_a1s9_direct_tax(laid: bool, apportioned: bool) -> bool:
    # No capitation/direct tax unless apportioned to the census.
    return (not laid) or apportioned


def rule_a1s9_export_tax(tax_on_exports: bool) -> bool:
    # No tax or duty on articles exported from any state.
    return not tax_on_exports


def rule_a1s9_appropriations(drawn: bool, appropriated: bool) -> bool:
    # No money drawn from the Treasury except by appropriation in law.
    return (not drawn) or appropriated


def rule_a1s9_titles(granted: bool) -> bool:
    # No title of nobility granted by the United States.
    return not granted


def rule_a1s10_treaty_alliance(state_enters: bool) -> bool:
    # No state treaty/alliance/confederation or marque/reprisal.
    return not state_enters


def rule_a1s10_coin_tender(state_coins_or_tenders: bool) -> bool:
    # No state coinage, bills of credit, or non-gold/silver tender.
    return not state_coins_or_tenders


def rule_a1s10_imposts(laid: bool, congress_consents: bool, inspection_necessary: bool) -> bool:
    # No state imposts/duties on imports/exports without Congress's consent,
    # except what is absolutely necessary for inspection laws.
    return (not laid) or congress_consents or inspection_necessary


def rule_a1s10_state_war(
    keeps_troops: bool, congress_consents: bool, invaded: bool, imminent_danger: bool
) -> bool:
    # No state troops/warships in peacetime, compacts, or war without
    # Congress's consent, unless actually invaded or in imminent danger.
    return (not keeps_troops) or congress_consents or invaded or imminent_danger


def rule_a2s2_commander_in_chief(commands: bool) -> bool:
    # The President is Commander in Chief of the armed forces and militia.
    return commands


def rule_a2s2_pardons(granted: bool, impeachment_case: bool) -> bool:
    # Reprieves/pardons for federal offences, except impeachment cases.
    return granted and not impeachment_case


def rule_a2s2_treaty(senate_yes: int, counts: Data) -> bool:
    return treaty_approved(senate_yes, counts)


def rule_a2s2_appointments(nominated: bool, senate_consents: bool) -> bool:
    # Appointments by and with the Senate's advice and consent.
    return nominated and senate_consents


def rule_a2s2_recess(vacancy_during_recess: bool, filled: bool) -> bool:
    # Recess vacancies filled by commissions expiring at session's end.
    return (not vacancy_during_recess) or filled


def rule_a2s3_take_care(laws_faithfully_executed: bool) -> bool:
    # The President takes care that the laws are faithfully executed.
    return laws_faithfully_executed


def rule_a2s3_convene(term: Data, convened: bool) -> bool:
    # On extraordinary occasions the President may convene the Houses.
    return _term_is(term, "ExtraordinaryOccasion") and convened


def rule_a2s4_removal(
    impeached: bool, convicted: bool, term: Data, offense_proven: bool
) -> bool:
    # Civil officers removed on impeachment for and conviction of treason,
    # bribery, or other high crimes and misdemeanors.
    return (
        impeached
        and convicted
        and _term_is(term, "HighCrimesAndMisdemeanors")
        and offense_proven
    )


def rule_a3s1_vesting(vested_in_courts: bool) -> bool:
    # Judicial power vests in one supreme Court and inferior courts.
    return vested_in_courts


def rule_a3s1_tenure(term: Data, holds_during_good_behavior: bool) -> bool:
    # Judges hold office during good behaviour.
    return _term_is(term, "GoodBehavior") and holds_during_good_behavior


def rule_a3s1_compensation(diminished: bool) -> bool:
    # Judicial compensation not diminished during continuance in office.
    return not diminished


def rule_a3s3_treason_definition(levying_war: bool, adhering_to_enemies: bool) -> bool:
    # Treason consists only in levying war or adhering to enemies.
    return levying_war or adhering_to_enemies


def rule_a3s3_corruption_of_blood(forfeiture_beyond_life: bool) -> bool:
    # No corruption of blood or forfeiture beyond the attainted life.
    return not forfeiture_beyond_life


def rule_a4s1_full_faith_credit(given: bool) -> bool:
    # Full faith and credit to sister-state acts, records, proceedings.
    return given


def rule_a4s2_privileges_immunities(entitled: bool) -> bool:
    # Citizens of each state entitled to privileges/immunities of the several.
    return entitled


def rule_a4s2_extradition(charged: bool, fled: bool, demanded: bool) -> bool:
    # Fugitives from justice delivered up on executive demand.
    return charged and fled and demanded


def rule_a4s2_fugitive_labor(delivered_up: bool) -> bool:
    # Fugitive-service clause kept verbatim (partially superseded by AM13S1).
    return delivered_up


def rule_a4s3_new_state(
    within_jurisdiction: bool, by_junction: bool, states_consent: bool, congress_admits: bool
) -> bool:
    # No new state formed within another's jurisdiction, nor by junction of
    # states, without the consent of the legislatures concerned and Congress.
    if states_consent:
        return congress_admits
    return congress_admits and not within_jurisdiction and not by_junction


def rule_a4s3_territory(congress_regulates: bool) -> bool:
    # Congress disposes of and regulates territory and federal property.
    return congress_regulates


def rule_a4s4_republican_form(term: Data, guaranteed: bool) -> bool:
    # The United States guarantees every state a republican form.
    return _term_is(term, "RepublicanForm") and guaranteed


def rule_a4s4_protection(invasion: bool, domestic_violence: bool, application_made: bool) -> bool:
    # Protection against invasion; against domestic violence on application.
    return invasion or (domestic_violence and application_made)


def rule_a6_supremacy(supreme_law: bool) -> bool:
    # Constitution, federal laws, and treaties are the supreme law of the land.
    return supreme_law


def rule_a6_oaths(bound_by_oath: bool) -> bool:
    # Federal and state legislators and officers bound by oath/affirmation.
    return bound_by_oath


def rule_a7_ratification(ratifying: int) -> bool:
    # Ratification by conventions of nine states suffices to establish.
    return ratifying >= 9


def rule_am1_religion(
    est_term: Data, est_respected: bool, fe_term: Data, fe_respected: bool
) -> bool:
    # No establishment of religion; free exercise not prohibited.
    return (
        _term_is(est_term, "EstablishmentOfReligion")
        and est_respected
        and _term_is(fe_term, "FreeExercise")
        and fe_respected
    )


def rule_am1_expression(abridged: bool) -> bool:
    # No abridging speech, press, peaceable assembly, or petition.
    return not abridged


def rule_am2_arms(
    militia_term: Data, militia_necessary: bool, arms_term: Data, right_preserved: bool
) -> bool:
    # The right to keep and bear arms shall not be infringed.
    return (
        _term_is(militia_term, "WellRegulatedMilitia")
        and militia_necessary
        and _term_is(arms_term, "KeepAndBearArms")
        and right_preserved
    )


def rule_am3_quartering(peacetime: bool, owner_consents: bool, prescribed_by_law: bool) -> bool:
    # No peacetime quartering without owner consent; wartime only as
    # prescribed by law.
    if peacetime:
        return owner_consents
    return prescribed_by_law


def rule_am4_search(term: Data, violated: bool) -> bool:
    # The right against unreasonable searches/seizures shall not be violated.
    return _term_is(term, "Unreasonable") and not violated


def rule_am4_warrant(
    term: Data, probable_cause_shown: bool, particularly_described: bool
) -> bool:
    # Warrants only on probable cause, supported by oath, particularly
    # describing the place/things.
    return (
        _term_is(term, "ProbableCause") and probable_cause_shown and particularly_described
    )


def rule_am5_grand_jury(term: Data, held_to_answer: bool, indicted: bool) -> bool:
    # No holding to answer for capital/infamous crime without grand-jury
    # indictment.
    return _term_is(term, "InfamousCrime") and ((not held_to_answer) or indicted)


def rule_am5_double_jeopardy(term: Data, twice_in_jeopardy: bool) -> bool:
    # No one twice put in jeopardy for the same offence.
    return _term_is(term, "SameOffence") and not twice_in_jeopardy


def rule_am5_due_process(term: Data, deprived_without_due_process: bool) -> bool:
    # No deprivation of life/liberty/property without due process.
    return _term_is(term, "DueProcess") and not deprived_without_due_process


def rule_am5_takings(public_use: bool, just_compensation: bool) -> bool:
    # Private property taken only for public use with just compensation.
    return public_use and just_compensation


def rule_am6_trial(
    trial_by_jury: bool,
    speedy_term: Data,
    speedy_met: bool,
    impartial_term: Data,
    impartial_met: bool,
) -> bool:
    # Criminal trial by jury, speedy and impartial.
    return (
        trial_by_jury
        and (_term_is(speedy_term, "Speedy") and speedy_met)
        and (_term_is(impartial_term, "Impartial") and impartial_met)
    )


def rule_am6_counsel(assistance_of_counsel: bool) -> bool:
    # The accused enjoys the assistance of counsel for defence.
    return assistance_of_counsel


def rule_am7_civil_jury(value: int) -> bool:
    # Jury right preserved where the controversy exceeds twenty dollars.
    return value > 20


def rule_am7_reexamination(term: Data, reexamined_beyond_common_law: bool) -> bool:
    # Jury-tried facts re-examined only per common-law rules.
    return _term_is(term, "CommonLawSuit") and not reexamined_beyond_common_law


def rule_am8_excessive(term: Data, excessive_imposed: bool) -> bool:
    # No excessive bail required nor excessive fines imposed.
    return _term_is(term, "Excessive") and not excessive_imposed


def rule_am8_cruel_unusual(term: Data, inflicted: bool) -> bool:
    # No cruel and unusual punishments inflicted.
    return _term_is(term, "CruelAndUnusual") and not inflicted


def rule_am9_retained(term: Data, denied: bool) -> bool:
    # Enumerated rights not construed to deny others retained.
    return _term_is(term, "RetainedRight") and not denied


def rule_am10_reserved(term: Data, reserved_to_states: bool) -> bool:
    # Undelegated, unprohibited powers reserved to states/people.
    return _term_is(term, "DelegatedPower") and reserved_to_states


def rule_am11_immunity(suit_against_state: bool, by_outsider: bool) -> bool:
    # No federal suit against a state by another state's citizens or
    # foreigners.
    return not (suit_against_state and by_outsider)


def rule_am13s2_enforcement(term: Data, congress_enforces: bool) -> bool:
    # Congress enforces abolition by appropriate legislation.
    return _term_is(term, "AppropriateLegislation") and congress_enforces


def rule_am14s1_citizenship(born_or_naturalized_in_us: bool, subject_to_jurisdiction: bool) -> bool:
    # Birth/naturalization in the U.S. plus jurisdiction = citizenship.
    return born_or_naturalized_in_us and subject_to_jurisdiction


def rule_am14s1_dp_ep(
    dp_term: Data, dp_respected: bool, ep_term: Data, ep_respected: bool
) -> bool:
    # No state denies due process or equal protection.
    return (
        _term_is(dp_term, "DueProcess")
        and dp_respected
        and _term_is(ep_term, "EqualProtection")
        and ep_respected
    )


def rule_am14s1_privileges(term: Data, abridged: bool) -> bool:
    # No state abridges citizens' privileges or immunities.
    return _term_is(term, "PrivilegesOrImmunities") and not abridged


def rule_am14s3_disability_removed(
    house_yes: int, house: Data, senate_yes: int, senate: Data
) -> bool:
    # Congress may remove the insurrection disability by two thirds of each
    # House (of the Houses themselves).
    return two_thirds(house_yes, house, _FULL) and two_thirds(senate_yes, senate, _FULL)


def rule_am14s4_debt(term: Data, questioned: bool) -> bool:
    # Validity of the U.S. public debt shall not be questioned.
    return _term_is(term, "ValidPublicDebt") and not questioned


def rule_am14s5_enforcement(term: Data, congress_enforces: bool) -> bool:
    return _term_is(term, "AppropriateLegislation") and congress_enforces


def rule_am15s1_vote(denied_on_race: bool) -> bool:
    # No denial/abridgment of the vote on account of race, color, or
    # previous condition of servitude.
    return not denied_on_race


def rule_am15s2_enforcement(term: Data, congress_enforces: bool) -> bool:
    return _term_is(term, "AppropriateLegislation") and congress_enforces


def rule_am19_vote(denied_on_sex: bool) -> bool:
    # No denial/abridgment of the vote on account of sex.
    return not denied_on_sex


def rule_am20s5_effective(took_effect: bool) -> bool:
    # Sections 1-2 take effect Oct 15 after ratification.
    return took_effect


def rule_am20s6_deadline(ratified_within_seven_years: bool) -> bool:
    # Inoperative unless ratified within seven years.
    return ratified_within_seven_years


def rule_am21s2_transportation(term: Data, transported_in_violation: bool) -> bool:
    # Liquor transportation/delivery in violation of state law prohibited.
    return _term_is(term, "IntoxicatingLiquor") and transported_in_violation


def rule_am21s3_deadline(ratified_within_seven_years: bool) -> bool:
    # Inoperative unless ratified by state conventions within seven years.
    return ratified_within_seven_years


def rule_am23s1_electors(
    entitled_equals_appointed: bool, least_populous_state_electors: int, appointed: int
) -> bool:
    # District electors equal its would-be Senate+House number, never more
    # than the least populous state's.
    if entitled_equals_appointed:
        return appointed <= least_populous_state_electors
    return False


def rule_am23s2_enforcement(term: Data, congress_enforces: bool) -> bool:
    return _term_is(term, "AppropriateLegislation") and congress_enforces


def rule_am24s1_poll_tax(denied_for_nonpayment: bool) -> bool:
    # No denial/abridgment of the vote for failure to pay a poll tax.
    return not denied_for_nonpayment


def rule_am24s2_enforcement(term: Data, congress_enforces: bool) -> bool:
    return _term_is(term, "AppropriateLegislation") and congress_enforces


def rule_am26s2_enforcement(term: Data, congress_enforces: bool) -> bool:
    return _term_is(term, "AppropriateLegislation") and congress_enforces


def rule_am27_timing(varying_law: bool, election_intervened: bool) -> bool:
    # No law varying congressional compensation takes effect until an
    # election of Representatives intervenes.
    return (not varying_law) or election_intervened

# --------------------------------------------------------------------------
# Temporal activation
# --------------------------------------------------------------------------
# Year granularity: every temporal provision in the text is year-dated.
# The API exposes both sides of each window separately (commenced /
# unexpired) because a closed interval cannot be tested with two
# comparisons on one affine variable; the full "operative at t" reading
# is their conjunction.

_AM18_CLAUSES = (
    "CL_AM18S1_Prohibition",
    "CL_AM18S2_ConcurrentPower",
    "CL_AM18S3_EffectiveDate",
)


def _year(t: Data) -> int:
    (year,) = t.fields
    return year


def rule_a1s9_migration_restriction(t: Data) -> bool:
    # A1S9: Congress shall not prohibit the migration/importation "prior to
    # the Year one thousand eight hundred and eight".
    return _year(t) < 1808


def clause_commenced(clause: Data, t: Data) -> bool:
    # Has the clause's text taken effect by t?
    if clause.name in _AM18_CLAUSES:
        # AM18S3: effective "after one year from the ratification"
        # (ratified 1919) -> 1920.
        return _year(t) >= 1920
    # The layer does not gate ordinary clauses on ratification dates.
    return True


def clause_unexpired(clause: Data, t: Data) -> bool:
    # Has the clause's text not yet lapsed by t?
    if clause.name == "CL_A1S9_MigrationRestriction":
        return _year(t) < 1808
    if clause.name in _AM18_CLAUSES:
        # Repealed by AM21, ratified 1933-12-05: expired from 1934 at year
        # granularity.
        return _year(t) <= 1933
    return True


def ratification_deadline_for(block: Data) -> Data:
    # Honesty note (shared with the Bend model): the 7-year ratification
    # deadlines live in the proposing resolutions, not the amendment texts,
    # so the modeled corpus states no deadline for any block.
    return Data("NoDeadlineInText", ())


def ratification_timely(proposed_year: int, ratified_year: int, deadline: Data) -> bool:
    if deadline.name == "NoDeadlineInText":
        return True
    (n,) = deadline.fields
    return ratified_year <= proposed_year + n


def vp_becomes_president_on_vacancy(vacancy: bool, t: Data) -> bool:
    # AM25S1 (ratified 1967): the Vice President becomes President on vacancy.
    return vacancy and _year(t) >= 1967


def acting_president_serves(inability_declared: bool, t: Data) -> bool:
    # AM25S3/S4: the Vice President serves as Acting President on inability.
    return inability_declared and _year(t) >= 1967


def succession_rule_effective(vacancy: bool, t: Data) -> bool:
    # The AM25S1 succession rule gated on AM25's activation (1967).
    return rule_am25s1_succession(vacancy) and _year(t) >= 1967


def term_commencement_jan20(t: Data) -> bool:
    # AM20S1 (ratified 1933): presidential terms end at noon, January 20.
    return _year(t) >= 1933


# --------------------------------------------------------------------------
# Interpretation environment
# --------------------------------------------------------------------------
# An env records EXTERNAL legal tests: a binding (term, value) says "under
# the caller's jurisprudence, this open term resolves to value". Absent
# terms resolve to Unknown (never a silent default); Known{False} and
# Unknown are distinct. Newest bindings shadow older ones (first-wins on a
# newest-first list).

# Env = list of (term_name, bool), newest first.


def interp_env_empty() -> list:
    return []


def interp_env_bindings(env: list) -> list:
    return list(env)


def env_extend(env: list, term: Data, value: bool) -> list:
    return [(term.name, value)] + list(env)


def _lookup(env: list, term_name: str) -> Data:
    for name, value in env:
        if name == term_name:
            return _known(value)
    return _UNKNOWN


def eval_interp(env: list, term: Data) -> Data:
    return _lookup(env, term.name)


def eval_rule_a2s1_natural_born(env: list, term: Data) -> Data:
    # The env's resolution plays the role of the rule's `satisfied` input.
    if term.name != "NaturalBornCitizen":
        return _known(False)
    return _lookup(env, term.name)


def eval_rule_a3s2_jury_trial(
    env: list, trial_by_jury: bool, speedy_term: Data, impartial_term: Data
) -> Data:
    # Both terms resolved in a single newest-first pass (first-wins per
    # term); the verdict is Known only when both resolve.
    if speedy_term.name != "Speedy" or impartial_term.name != "Impartial":
        return _known(False)
    speedy_val = None
    impartial_val = None
    for name, value in env:
        if name == "Speedy" and speedy_val is None:
            speedy_val = value
        elif name == "Impartial" and impartial_val is None:
            impartial_val = value
    if speedy_val is None or impartial_val is None:
        return _UNKNOWN
    return _known(trial_by_jury and speedy_val and impartial_val)


def eval_rule_am18s1_prohibition(
    env: list, liquor_traffic: bool, beverage_purpose: bool, liquor_term: Data
) -> Data:
    if liquor_term.name != "IntoxicatingLiquor":
        return _known(True)
    found = _lookup(env, liquor_term.name)
    if found.name == "Unknown":
        return _UNKNOWN
    (liquor_val,) = found.fields
    return _known(not (liquor_traffic and beverage_purpose and liquor_val))


def eval_rule_am25s3_voluntary_transfer(env: list, declaration: bool, unable_term: Data) -> Data:
    if unable_term.name != "UnableToDischarge":
        return _known(False)
    found = _lookup(env, unable_term.name)
    if found.name == "Unknown":
        return _UNKNOWN
    (unable_val,) = found.fields
    return _known(declaration and unable_val)


def eval_clause_under_env(
    clause: Data,
    env: list,
    term_a: Data,
    term_b: Data,
    flag1: bool,
    flag2: bool,
) -> Data:
    # Dispatcher over the four term-dependent clause rules. Any other clause
    # is outside the dispatcher's domain: Unknown (inert).
    name = clause.name
    if name == "CL_A2S1_NaturalBorn":
        return eval_rule_a2s1_natural_born(env, term_a)
    if name == "CL_A3S2_JuryTrial":
        return eval_rule_a3s2_jury_trial(env, flag1, term_a, term_b)
    if name == "CL_AM18S1_Prohibition":
        return eval_rule_am18s1_prohibition(env, flag1, flag2, term_a)
    if name == "CL_AM25S3_VoluntaryTransfer":
        return eval_rule_am25s3_voluntary_transfer(env, flag1, term_a)
    return _UNKNOWN


# --------------------------------------------------------------------------
# Banzhaf spot-check: 3-voter weighted game [3,2,1], quota 4.
# Independent brute-force mirror of the Bend defs in laws.bend
# (banzhaf3_swings_a/b/c). Hand-computed swing counts: A=3, B=1, C=1.
# --------------------------------------------------------------------------

def _banzhaf3_swings():
    weights = (3, 2, 1)
    quota = 4
    swings = [0, 0, 0]
    for bits in itertools.product((False, True), repeat=3):
        total = sum(w * b for w, b in zip(weights, bits))
        if total >= quota:
            for i, (w, b) in enumerate(zip(weights, bits)):
                if b and total - w < quota:
                    swings[i] += 1
    return swings


def banzhaf3_a_swings_are_3():
    return _banzhaf3_swings()[0] == 3


def banzhaf3_b_swings_are_1():
    return _banzhaf3_swings()[1] == 1


def banzhaf3_c_swings_are_1():
    return _banzhaf3_swings()[2] == 1


# --------------------------------------------------------------------------
# Registry: every public model function, for the law-statement evaluator.
# --------------------------------------------------------------------------

def _is_model_fn(obj) -> bool:
    return (
        callable(obj)
        and not isinstance(obj, type)
        and getattr(obj, "__module__", None) == __name__
        and not getattr(obj, "__name__", "").startswith("_")
    )


def ltl_implies(a: bool, b: bool) -> bool:
    # Material implication: workhorse for bounded "once P, always P" properties.
    return (not a) or b


def ltl_le(y1: int, y2: int) -> bool:
    # Year-ordering guard for bounded pair properties (vacuous when y1 > y2).
    return y1 <= y2


def clause_expired(clause: Data, t: Data) -> bool:
    # Expired at t iff not unexpired at t.
    return not clause_unexpired(clause, t)


# --------------------------------------------------------------------------
# Deontic layer mirrors (differential implementation).
# The tagging table below is an independent re-encoding of the transcript's
# operative language, written separately from laws.bend. Agreement between
# the two implementations guards against transcription slips in either.
# --------------------------------------------------------------------------

_DEONTIC_FORCE_CODES = {"Prohibition": 1, "Duty": 2, "Permission": 3}
_DEONTIC_SUBJECT_CODES = {
    "Congress": 1,
    "StateGovernments": 2,
    "FederalGovernment": 3,
    "Anyone": 4,
}
_DEONTIC_ACTION_CODES = {
    "AbridgeExpression": 1,
    "EstablishReligion": 2,
    "InfringeArms": 3,
    "QuarterSoldiers": 4,
    "UnreasonableSearchSeizure": 5,
    "IssueWarrantWithoutProbableCause": 6,
    "SubjectToDoubleJeopardy": 7,
    "DepriveLifeLibertyPropertyWithoutDueProcess": 8,
    "TakePropertyWithoutJustCompensation": 9,
    "RequireExcessiveBailOrFines": 10,
    "InflictCruelUnusualPunishment": 11,
    "EnslaveExceptAsPunishmentForCrime": 12,
    "DenyDueProcessOrEqualProtection": 13,
    "AbridgePrivilegesOrImmunities": 14,
    "DenyVoteOnAccountOfRace": 15,
    "DenyVoteOnAccountOfSex": 16,
    "ImposePollTax": 17,
    "DenyVoteOnAccountOfAge": 18,
    "ElectedPresidentMoreThanTwice": 19,
    "ManufactureSellTransportLiquor": 20,
    "TransportLiquorInViolationOfStateLaw": 21,
    "LayExportTax": 22,
    "PassAttainderOrExPostFacto": 23,
    "ProhibitMigrationImportation": 24,
    "GrantNobility": 25,
    "SuspendHabeasOutsideRebellionInvasion": 26,
    "DrawMoneyWithoutAppropriation": 27,
    "LayDirectTaxWithoutApportionment": 28,
    "ServeInCongressWhileHoldingFederalOffice": 29,
    "QuestionMemberForSpeechDebate": 30,
    "ArrestMemberExceptTreasonFelonyBreach": 31,
    "QuestionPublicDebtValidity": 32,
    "EnterTreatyAllianceConfederation": 33,
    "CoinMoneyEmitBillsNonSpecieTender": 34,
    "LayImpostsWithoutCongressionalConsent": 35,
    "GuaranteeRepublicanForm": 36,
    "ProtectStatesFromInvasionAndDomesticViolence": 37,
    "DeliverUpFugitiveFromJustice": 38,
    "AssembleAtLeastAnnually": 39,
    "TakeOathToSupportConstitution": 40,
    "EnsureSpeedyPublicTrial": 41,
    "EnsureAssistanceOfCounsel": 42,
    "PreserveCivilJuryTrial": 43,
    "LayCollectIncomeTax": 44,
}

# Clause constructor -> (force, subject, action). Minimal-tag bar: tag only
# where the operative force is explicit and the subject/action are nameable
# without interpretive invention. See the laws.bend header for the documented
# judgment calls (passive-voice convention, Anyone-coarsening, rights-as-duty).
_DEONTIC_TAGS: dict[str, tuple[str, str, str]] = {
    "CL_AM1_ExpressionAssembly": ("Prohibition", "Congress", "AbridgeExpression"),
    "CL_AM1_Religion": ("Prohibition", "Congress", "EstablishReligion"),
    "CL_AM2_KeepBearArms": ("Prohibition", "FederalGovernment", "InfringeArms"),
    "CL_AM3_Quartering": ("Prohibition", "FederalGovernment", "QuarterSoldiers"),
    "CL_AM4_UnreasonableSearch": ("Prohibition", "FederalGovernment", "UnreasonableSearchSeizure"),
    "CL_AM4_Warrants": ("Prohibition", "FederalGovernment", "IssueWarrantWithoutProbableCause"),
    "CL_AM5_DoubleJeopardy": ("Prohibition", "FederalGovernment", "SubjectToDoubleJeopardy"),
    "CL_AM5_DueProcess": ("Prohibition", "FederalGovernment", "DepriveLifeLibertyPropertyWithoutDueProcess"),
    "CL_AM5_Takings": ("Prohibition", "FederalGovernment", "TakePropertyWithoutJustCompensation"),
    "CL_AM6_SpeedyImpartialTrial": ("Duty", "FederalGovernment", "EnsureSpeedyPublicTrial"),
    "CL_AM6_Counsel": ("Duty", "FederalGovernment", "EnsureAssistanceOfCounsel"),
    "CL_AM7_CivilJury": ("Duty", "FederalGovernment", "PreserveCivilJuryTrial"),
    "CL_AM8_ExcessiveBailFines": ("Prohibition", "FederalGovernment", "RequireExcessiveBailOrFines"),
    "CL_AM8_CruelUnusual": ("Prohibition", "FederalGovernment", "InflictCruelUnusualPunishment"),
    "CL_AM13S1_Abolition": ("Prohibition", "Anyone", "EnslaveExceptAsPunishmentForCrime"),
    "CL_AM14S1_DueProcessEqualProtection": ("Prohibition", "StateGovernments", "DenyDueProcessOrEqualProtection"),
    "CL_AM14S1_PrivilegesImmunities": ("Prohibition", "StateGovernments", "AbridgePrivilegesOrImmunities"),
    "CL_AM14S4_PublicDebt": ("Prohibition", "Anyone", "QuestionPublicDebtValidity"),
    "CL_AM15S1_VoteRace": ("Prohibition", "Anyone", "DenyVoteOnAccountOfRace"),
    "CL_AM19_VoteSex": ("Prohibition", "Anyone", "DenyVoteOnAccountOfSex"),
    "CL_AM24S1_PollTax": ("Prohibition", "Anyone", "ImposePollTax"),
    "CL_AM26S1_VoteAge": ("Prohibition", "Anyone", "DenyVoteOnAccountOfAge"),
    "CL_AM22S1_TermLimit": ("Prohibition", "Anyone", "ElectedPresidentMoreThanTwice"),
    "CL_AM18S1_Prohibition": ("Prohibition", "Anyone", "ManufactureSellTransportLiquor"),
    "CL_AM21S2_Transportation": ("Prohibition", "Anyone", "TransportLiquorInViolationOfStateLaw"),
    "CL_AM16_IncomeTax": ("Permission", "Congress", "LayCollectIncomeTax"),
    "CL_A1S4_AnnualAssembly": ("Duty", "Congress", "AssembleAtLeastAnnually"),
    "CL_A1S6_Incompatibility": ("Prohibition", "Anyone", "ServeInCongressWhileHoldingFederalOffice"),
    "CL_A1S6_SpeechDebate": ("Prohibition", "Anyone", "QuestionMemberForSpeechDebate"),
    "CL_A1S6_ArrestPrivilege": ("Prohibition", "Anyone", "ArrestMemberExceptTreasonFelonyBreach"),
    "CL_A1S9_ExportTax": ("Prohibition", "Congress", "LayExportTax"),
    "CL_A1S9_Attainder": ("Prohibition", "Congress", "PassAttainderOrExPostFacto"),
    "CL_A1S9_MigrationRestriction": ("Prohibition", "Congress", "ProhibitMigrationImportation"),
    "CL_A1S9_TitlesNobility": ("Prohibition", "FederalGovernment", "GrantNobility"),
    "CL_A1S9_HabeasCorpus": ("Prohibition", "FederalGovernment", "SuspendHabeasOutsideRebellionInvasion"),
    "CL_A1S9_Appropriations": ("Prohibition", "FederalGovernment", "DrawMoneyWithoutAppropriation"),
    "CL_A1S9_DirectTax": ("Prohibition", "Congress", "LayDirectTaxWithoutApportionment"),
    "CL_A1S10_TreatyAlliance": ("Prohibition", "StateGovernments", "EnterTreatyAllianceConfederation"),
    "CL_A1S10_CoinTender": ("Prohibition", "StateGovernments", "CoinMoneyEmitBillsNonSpecieTender"),
    "CL_A1S10_Imposts": ("Prohibition", "StateGovernments", "LayImpostsWithoutCongressionalConsent"),
    "CL_A4S2_Extradition": ("Duty", "StateGovernments", "DeliverUpFugitiveFromJustice"),
    "CL_A4S4_RepublicanForm": ("Duty", "FederalGovernment", "GuaranteeRepublicanForm"),
    "CL_A4S4_Protection": ("Duty", "FederalGovernment", "ProtectStatesFromInvasionAndDomesticViolence"),
    "CL_A6_Oaths": ("Duty", "Anyone", "TakeOathToSupportConstitution"),
}


def deontic_force_code(f: Data) -> int:
    return _DEONTIC_FORCE_CODES[f.name]


def deontic_subject_code(s: Data) -> int:
    return _DEONTIC_SUBJECT_CODES[s.name]


def deontic_action_code(a: Data) -> int:
    return _DEONTIC_ACTION_CODES[a.name]


def deontic_tag_code(t: Data) -> int:
    if t.name == "Untagged":
        return 0
    (force, subject, action) = t.fields
    return (
        deontic_force_code(force) * 10000
        + deontic_subject_code(subject) * 100
        + deontic_action_code(action)
    )


def deontic_tag_matches(t: Data, f: int, s: int, a: int) -> bool:
    if t.name == "Untagged":
        return False
    (force, subject, action) = t.fields
    return (
        deontic_force_code(force) == f
        and deontic_subject_code(subject) == s
        and deontic_action_code(action) == a
    )


def deontic_tag_is_untagged(t: Data) -> bool:
    return t.name == "Untagged"


def clause_deontic(clause: Data) -> Data:
    tag = _DEONTIC_TAGS.get(clause.name)
    if tag is None:
        return Data("Untagged", ())
    force, subject, action = tag
    return Data("Tagged", (Data(force, ()), Data(subject, ()), Data(action, ())))


def deontic_subject_overlap(a: Data, b: Data) -> bool:
    # Anyone overlaps everything; otherwise only identical subjects overlap.
    # Conservative: Congress and FederalGovernment do not overlap (mirrors laws.bend).
    if a.name == "Anyone" or b.name == "Anyone":
        return True
    return a.name == b.name


def deontic_force_opposes(f1: Data, f2: Data) -> bool:
    return ("Prohibition" in (f1.name, f2.name)) and (f1.name != f2.name)


def deontic_conflict(t1: Data, t2: Data) -> bool:
    if t1.name == "Untagged" or t2.name == "Untagged":
        return False
    (f1, s1, a1) = t1.fields
    (f2, s2, a2) = t2.fields
    return (
        deontic_action_code(a1) == deontic_action_code(a2)
        and deontic_force_opposes(f1, f2)
        and deontic_subject_overlap(s1, s2)
    )


def clause_operative_at_2026(clause: Data) -> bool:
    t = Data("Year", (2026,))
    return (
        clause_in_force(clause)
        and clause_commenced(clause, t)
        and clause_unexpired(clause, t)
    )


def corpus_pairs_consistent_2026() -> bool:
    # Independent exhaustive check: every unordered pair of tagged clauses
    # operative at 2026 must be conflict-free. The operative set is derived
    # from the model's own temporal functions, not from the generator.
    operative = [
        name
        for name in CLAUSES
        if name in _DEONTIC_TAGS
        and clause_operative_at_2026(Data(name, ()))
    ]
    tags = [clause_deontic(Data(name, ())) for name in operative]
    for i in range(len(tags)):
        for j in range(i + 1, len(tags)):
            if deontic_conflict(tags[i], tags[j]):
                return False
    return True


# Registry: every public model function, for the law-statement evaluator.
# (Kept at end of file so functions defined anywhere above are collected.)
REGISTRY: dict[str, object] = {
    name: fn for name, fn in sorted(vars().items()) if _is_model_fn(fn)
}
