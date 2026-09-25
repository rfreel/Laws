import Base
import ./laws.bend as C

law source_indices_bounded:
  for block: C.SourceBlock
  {C.source_index_in_range(block) == True{} : Bool}

law representative_minimum_passes:
  {C.representative_eligible(25n, 7n, True{}) == True{} : Bool}

law representative_age_below_fails:
  {C.representative_eligible(24n, 7n, True{}) == False{} : Bool}

law senator_minimum_passes:
  {C.senator_eligible(30n, 9n, True{}) == True{} : Bool}

law senator_age_below_fails:
  {C.senator_eligible(29n, 9n, True{}) == False{} : Bool}

law president_minimum_passes:
  {C.president_eligible(35n, 14n, True{}) == True{} : Bool}

law president_age_below_fails:
  {C.president_eligible(34n, 14n, True{}) == False{} : Bool}

law article_v_34_of_50_applications_pass:
  {C.article_v_state_application(34n, 50n) == True{} : Bool}

law article_v_33_of_50_applications_fail:
  {C.article_v_state_application(33n, 50n) == False{} : Bool}

law article_v_38_of_50_ratifications_pass:
  {C.article_v_ratification(38n, 50n) == True{} : Bool}

law article_v_37_of_50_ratifications_fail:
  {C.article_v_ratification(37n, 50n) == False{} : Bool}

law article_v_full_congress_boundary_passes:
  {C.article_v_congress_proposal(290n, 435n, 67n, 100n) == True{} : Bool}

law article_v_house_below_boundary_fails:
  {C.article_v_congress_proposal(289n, 435n, 67n, 100n) == False{} : Bool}

law treaty_67_of_100_passes:
  {C.treaty_approved(67n, 100n) == True{} : Bool}

law treaty_66_of_100_fails:
  {C.treaty_approved(66n, 100n) == False{} : Bool}

law impeachment_67_of_100_passes:
  {C.impeachment_conviction(67n, 100n) == True{} : Bool}

law treason_two_witnesses_suffice:
  {C.treason_conviction_evidence(True{}, False{}) == True{} : Bool}

law treason_confession_suffices:
  {C.treason_conviction_evidence(False{}, True{}) == True{} : Bool}

law treason_no_evidence_fails:
  {C.treason_conviction_evidence(False{}, False{}) == False{} : Bool}

law twenty_second_two_elections_allowed:
  {C.presidential_election_limit(2n, False{}) == True{} : Bool}

law twenty_second_third_election_forbidden:
  {C.presidential_election_limit(3n, False{}) == False{} : Bool}

law twenty_second_prior_service_reduces_limit:
  {C.presidential_election_limit(2n, True{}) == False{} : Bool}

law twenty_sixth_age_18_protected:
  {C.age_vote_protection(18n) == True{} : Bool}

law twenty_sixth_age_17_not_covered_by_age_floor:
  {C.age_vote_protection(17n) == False{} : Bool}

law amendment_18_sections_marked_repealed:
  {C.amendment_18_repealed(C.AM18S1{}) == True{} : Bool}

law signed_bill_path:
  {C.bill_becomes_law(True{}, True{}, True{}, True{}, False{}, 0n, 1n, 0n, 1n, False{}, False{}) == True{} : Bool}

law veto_override_path:
  {C.bill_becomes_law(True{}, True{}, True{}, False{}, True{}, 290n, 435n, 67n, 100n, False{}, False{}) == True{} : Bool}

law pocket_veto_path_fails:
  {C.bill_becomes_law(True{}, True{}, True{}, False{}, False{}, 0n, 1n, 0n, 1n, True{}, True{}) == False{} : Bool}

law ten_day_nonreturn_path_passes:
  {C.bill_becomes_law(True{}, True{}, True{}, False{}, False{}, 0n, 1n, 0n, 1n, True{}, False{}) == True{} : Bool}

# --- Clause layer laws (TASKS.md remaining item 1): one boundary law per rule ---

law clause_indices_bounded:
  for c: C.Clause
  {C.clause_index_in_range(c) == True{} : Bool}

# Preamble
law preamble_purpose_affirmed_pass:
  {C.rule_preamble_purpose(True{}) == True{} : Bool}

law preamble_purpose_denied_fail:
  {C.rule_preamble_purpose(False{}) == False{} : Bool}

# A1S2
law a1s2_qualifications_pass:
  {C.rule_a1s2_qualifications(25n, 7n, True{}) == True{} : Bool}

law a1s2_qualifications_fail:
  {C.rule_a1s2_qualifications(24n, 7n, True{}) == False{} : Bool}

law a1s2_impeachment_power_exercised:
  {C.rule_a1s2_impeachment_power(True{}) == True{} : Bool}

law a1s2_impeachment_power_idle:
  {C.rule_a1s2_impeachment_power(False{}) == False{} : Bool}

law a1s2_apportionment_cap_pass:
  {C.rule_a1s2_apportionment_cap(1n, 30000n) == True{} : Bool}

law a1s2_apportionment_cap_fail:
  {C.rule_a1s2_apportionment_cap(2n, 30000n) == False{} : Bool}

# A1S3
law a1s3_qualifications_pass:
  {C.rule_a1s3_qualifications(30n, 9n, True{}) == True{} : Bool}

law a1s3_qualifications_fail:
  {C.rule_a1s3_qualifications(29n, 9n, True{}) == False{} : Bool}

law a1s3_senate_trial_convicts:
  {C.rule_a1s3_senate_trial(67n, 100n) == True{} : Bool}

law a1s3_senate_trial_acquits:
  {C.rule_a1s3_senate_trial(66n, 100n) == False{} : Bool}

law a1s3_vp_tiebreak_tie:
  {C.rule_a1s3_vp_tiebreak(50n, 50n) == True{} : Bool}

law a1s3_vp_tiebreak_no_tie:
  {C.rule_a1s3_vp_tiebreak(51n, 50n) == False{} : Bool}

# A1S4
law a1s4_election_regulation_state:
  {C.rule_a1s4_election_regulation(True{}, False{}) == True{} : Bool}

law a1s4_election_regulation_congress:
  {C.rule_a1s4_election_regulation(False{}, True{}) == True{} : Bool}

law a1s4_election_regulation_none:
  {C.rule_a1s4_election_regulation(False{}, False{}) == False{} : Bool}

law a1s4_annual_assembly_met:
  {C.rule_a1s4_annual_assembly(True{}) == True{} : Bool}

law a1s4_annual_assembly_missed:
  {C.rule_a1s4_annual_assembly(False{}) == False{} : Bool}

# A1S7
law a1s7_presentment_signed:
  {C.rule_a1s7_presentment(True{}, True{}, True{}, True{}, False{}, 0n, 1n, 0n, 1n, False{}, False{}) == True{} : Bool}

law a1s7_presentment_pocket_veto:
  {C.rule_a1s7_presentment(True{}, True{}, True{}, False{}, False{}, 0n, 1n, 0n, 1n, True{}, True{}) == False{} : Bool}

law a1s7_revenue_origination_house:
  {C.rule_a1s7_revenue_origination(True{}, True{}) == True{} : Bool}

law a1s7_revenue_origination_senate:
  {C.rule_a1s7_revenue_origination(True{}, False{}) == False{} : Bool}

law a1s7_revenue_origination_nonrevenue:
  {C.rule_a1s7_revenue_origination(False{}, False{}) == True{} : Bool}

# A2S1
law a2s1_vesting_held:
  {C.rule_a2s1_vesting(True{}) == True{} : Bool}

law a2s1_vesting_vacant:
  {C.rule_a2s1_vesting(False{}) == False{} : Bool}

law a2s1_term_four_years:
  {C.rule_a2s1_term(4n) == True{} : Bool}

law a2s1_term_five_years:
  {C.rule_a2s1_term(5n) == False{} : Bool}

law a2s1_qualifications_pass:
  {C.rule_a2s1_qualifications(35n, 14n, True{}) == True{} : Bool}

law a2s1_qualifications_fail:
  {C.rule_a2s1_qualifications(35n, 13n, True{}) == False{} : Bool}

law a2s1_natural_born_satisfied:
  {C.rule_a2s1_natural_born(C.NaturalBornCitizen{}, True{}) == True{} : Bool}

law a2s1_natural_born_unsatisfied:
  {C.rule_a2s1_natural_born(C.NaturalBornCitizen{}, False{}) == False{} : Bool}

law a2s1_natural_born_wrong_term:
  {C.rule_a2s1_natural_born(C.DueProcess{}, True{}) == False{} : Bool}

law a2s1_electors_match:
  {C.rule_a2s1_electors(3n, 2n, 1n) == True{} : Bool}

law a2s1_electors_mismatch:
  {C.rule_a2s1_electors(4n, 2n, 1n) == False{} : Bool}

# A3S2
law a3s2_treason_evidence_witnesses:
  {C.rule_a3s2_treason_evidence(True{}, False{}) == True{} : Bool}

law a3s2_treason_evidence_none:
  {C.rule_a3s2_treason_evidence(False{}, False{}) == False{} : Bool}

law a3s2_jury_trial_sound:
  {C.rule_a3s2_jury_trial(True{}, C.Speedy{}, True{}, C.Impartial{}, True{}) == True{} : Bool}

law a3s2_jury_trial_wrong_term:
  {C.rule_a3s2_jury_trial(True{}, C.DueProcess{}, True{}, C.Impartial{}, True{}) == False{} : Bool}

# A5
law a5_congress_proposal_pass:
  {C.rule_a5_congress_proposal(290n, 435n, 67n, 100n) == True{} : Bool}

law a5_congress_proposal_fail:
  {C.rule_a5_congress_proposal(289n, 435n, 67n, 100n) == False{} : Bool}

law a5_convention_application_pass:
  {C.rule_a5_convention_application(34n, 50n) == True{} : Bool}

law a5_convention_application_fail:
  {C.rule_a5_convention_application(33n, 50n) == False{} : Bool}

law a5_ratification_pass:
  {C.rule_a5_ratification(38n, 50n) == True{} : Bool}

law a5_ratification_fail:
  {C.rule_a5_ratification(37n, 50n) == False{} : Bool}

# AM12
law am12_electoral_majority_pass:
  {C.rule_am12_electoral_majority(270n, 538n) == True{} : Bool}

law am12_electoral_majority_fail:
  {C.rule_am12_electoral_majority(269n, 538n) == False{} : Bool}

law am12_distinct_ballots_cast:
  {C.rule_am12_distinct_ballots(True{}) == True{} : Bool}

law am12_distinct_ballots_missing:
  {C.rule_am12_distinct_ballots(False{}) == False{} : Bool}

# AM13S1
law am13s1_abolition_free:
  {C.rule_am13s1_abolition(False{}, False{}) == True{} : Bool}

law am13s1_abolition_servitude:
  {C.rule_am13s1_abolition(True{}, False{}) == False{} : Bool}

law am13s1_abolition_punishment:
  {C.rule_am13s1_abolition(True{}, True{}) == True{} : Bool}

# AM14S2
law am14s2_apportionment_basis_whole:
  {C.rule_am14s2_apportionment_basis(True{}) == True{} : Bool}

law am14s2_apportionment_basis_partial:
  {C.rule_am14s2_apportionment_basis(False{}) == False{} : Bool}

law am14s2_reduction_applies:
  {C.rule_am14s2_reduction(True{}, False{}) == True{} : Bool}

law am14s2_reduction_excepted:
  {C.rule_am14s2_reduction(True{}, True{}) == False{} : Bool}

# AM16
law am16_income_tax_applies:
  {C.rule_am16_income_tax(True{}) == True{} : Bool}

law am16_income_tax_not_income:
  {C.rule_am16_income_tax(False{}) == False{} : Bool}

# AM17
law am17_direct_election_by_people:
  {C.rule_am17_direct_election(True{}) == True{} : Bool}

law am17_direct_election_not:
  {C.rule_am17_direct_election(False{}) == False{} : Bool}

law am17_vacancy_appointment_valid:
  {C.rule_am17_vacancy_appointment(True{}, True{}) == True{} : Bool}

law am17_vacancy_appointment_no_power:
  {C.rule_am17_vacancy_appointment(True{}, False{}) == False{} : Bool}

# AM18 (kept in the type; marked not in force)
law am18s1_prohibition_compliant:
  {C.rule_am18s1_prohibition(False{}, True{}, C.IntoxicatingLiquor{}) == True{} : Bool}

law am18s1_prohibition_violated:
  {C.rule_am18s1_prohibition(True{}, True{}, C.IntoxicatingLiquor{}) == False{} : Bool}

law am18s2_concurrent_power_asserted:
  {C.rule_am18s2_concurrent_power(True{}) == True{} : Bool}

law am18s2_concurrent_power_idle:
  {C.rule_am18s2_concurrent_power(False{}) == False{} : Bool}

law am18s3_effective_date_reached:
  {C.rule_am18s3_effective_date(True{}) == True{} : Bool}

law am18s3_effective_date_pending:
  {C.rule_am18s3_effective_date(False{}) == False{} : Bool}

law clause_am18s1_not_in_force:
  {C.clause_in_force(C.CL_AM18S1_Prohibition{}) == False{} : Bool}

law clause_am18s2_not_in_force:
  {C.clause_in_force(C.CL_AM18S2_ConcurrentPower{}) == False{} : Bool}

law clause_am18s3_not_in_force:
  {C.clause_in_force(C.CL_AM18S3_EffectiveDate{}) == False{} : Bool}

# AM20
law am20s1_term_commencement_noon:
  {C.rule_am20s1_term_commencement(True{}) == True{} : Bool}

law am20s1_term_commencement_missed:
  {C.rule_am20s1_term_commencement(False{}) == False{} : Bool}

law am20s2_congress_assembly_jan3:
  {C.rule_am20s2_congress_assembly(True{}) == True{} : Bool}

law am20s2_congress_assembly_missed:
  {C.rule_am20s2_congress_assembly(False{}) == False{} : Bool}

law am20s3_president_elect_died:
  {C.rule_am20s3_president_elect_death(True{}) == True{} : Bool}

law am20s3_president_elect_living:
  {C.rule_am20s3_president_elect_death(False{}) == False{} : Bool}

law am20s4_succession_statute_provided:
  {C.rule_am20s4_succession_statute(True{}) == True{} : Bool}

law am20s4_succession_statute_absent:
  {C.rule_am20s4_succession_statute(False{}) == False{} : Bool}

# AM21S1
law am21s1_repeal_effective:
  {C.rule_am21s1_repeal() == True{} : Bool}

law clause_am21s1_in_force:
  {C.clause_in_force(C.CL_AM21S1_Repeal{}) == True{} : Bool}

# AM22
law am22s1_two_terms_allowed:
  {C.rule_am22s1_term_limit(2n) == True{} : Bool}

law am22s1_third_term_forbidden:
  {C.rule_am22s1_term_limit(3n) == False{} : Bool}

law am22s2_prior_service_reduces:
  {C.rule_am22s2_prior_service_limit(2n) == False{} : Bool}

law am22s2_single_term_after_service:
  {C.rule_am22s2_prior_service_limit(1n) == True{} : Bool}

# AM25
law am25s1_succession_vacancy:
  {C.rule_am25s1_succession(True{}) == True{} : Bool}

law am25s1_succession_occupied:
  {C.rule_am25s1_succession(False{}) == False{} : Bool}

law am25s2_vp_confirmation_pass:
  {C.rule_am25s2_vp_confirmation(218n, 435n, 51n, 100n) == True{} : Bool}

law am25s2_vp_confirmation_fail:
  {C.rule_am25s2_vp_confirmation(217n, 435n, 51n, 100n) == False{} : Bool}

law am25s3_voluntary_transfer_declared:
  {C.rule_am25s3_voluntary_transfer(True{}, C.UnableToDischarge{}, True{}) == True{} : Bool}

law am25s3_voluntary_transfer_wrong_term:
  {C.rule_am25s3_voluntary_transfer(True{}, C.DueProcess{}, True{}) == False{} : Bool}

law am25s4_congress_decision_pass:
  {C.rule_am25s4_congress_decision(290n, 435n, 67n, 100n) == True{} : Bool}

law am25s4_congress_decision_fail:
  {C.rule_am25s4_congress_decision(289n, 435n, 67n, 100n) == False{} : Bool}

# AM26S1
law am26s1_vote_age_18:
  {C.rule_am26s1_vote_age(18n) == True{} : Bool}

law am26s1_vote_age_17:
  {C.rule_am26s1_vote_age(17n) == False{} : Bool}
