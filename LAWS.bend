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
  {C.article_v_state_application(34n, C.StatesCount{50n}) == True{} : Bool}

law article_v_33_of_50_applications_fail:
  {C.article_v_state_application(33n, C.StatesCount{50n}) == False{} : Bool}

law article_v_38_of_50_ratifications_pass:
  {C.article_v_ratification(38n, C.StatesCount{50n}) == True{} : Bool}

law article_v_37_of_50_ratifications_fail:
  {C.article_v_ratification(37n, C.StatesCount{50n}) == False{} : Bool}

law article_v_full_congress_boundary_passes:
  {C.article_v_congress_proposal(290n, C.ChamberCount{435n, 435n}, 67n, C.ChamberCount{100n, 100n}) == True{} : Bool}

law article_v_house_below_boundary_fails:
  {C.article_v_congress_proposal(289n, C.ChamberCount{435n, 435n}, 67n, C.ChamberCount{100n, 100n}) == False{} : Bool}

law treaty_67_of_100_passes:
  {C.treaty_approved(67n, C.ChamberCount{100n, 100n}) == True{} : Bool}

law treaty_66_of_100_fails:
  {C.treaty_approved(66n, C.ChamberCount{100n, 100n}) == False{} : Bool}

law impeachment_67_of_100_passes:
  {C.impeachment_conviction(67n, C.ChamberCount{100n, 100n}) == True{} : Bool}

law impeachment_66_of_100_fails:
  {C.impeachment_conviction(66n, C.ChamberCount{100n, 100n}) == False{} : Bool}

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
  {C.bill_becomes_law(True{}, True{}, True{}, True{}, False{}, 0n, C.ChamberCount{1n, 1n}, 0n, C.ChamberCount{1n, 1n}, False{}, False{}) == True{} : Bool}

law veto_override_path:
  {C.bill_becomes_law(True{}, True{}, True{}, False{}, True{}, 290n, C.ChamberCount{435n, 435n}, 67n, C.ChamberCount{100n, 100n}, False{}, False{}) == True{} : Bool}

law pocket_veto_path_fails:
  {C.bill_becomes_law(True{}, True{}, True{}, False{}, False{}, 0n, C.ChamberCount{1n, 1n}, 0n, C.ChamberCount{1n, 1n}, True{}, True{}) == False{} : Bool}

law ten_day_nonreturn_path_passes:
  {C.bill_becomes_law(True{}, True{}, True{}, False{}, False{}, 0n, C.ChamberCount{1n, 1n}, 0n, C.ChamberCount{1n, 1n}, True{}, False{}) == True{} : Bool}

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
  {C.rule_a1s3_senate_trial(67n, C.ChamberCount{100n, 100n}) == True{} : Bool}

law a1s3_senate_trial_acquits:
  {C.rule_a1s3_senate_trial(66n, C.ChamberCount{100n, 100n}) == False{} : Bool}

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
  {C.rule_a1s7_presentment(True{}, True{}, True{}, True{}, False{}, 0n, C.ChamberCount{1n, 1n}, 0n, C.ChamberCount{1n, 1n}, False{}, False{}) == True{} : Bool}

law a1s7_presentment_pocket_veto:
  {C.rule_a1s7_presentment(True{}, True{}, True{}, False{}, False{}, 0n, C.ChamberCount{1n, 1n}, 0n, C.ChamberCount{1n, 1n}, True{}, True{}) == False{} : Bool}

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
  {C.rule_a5_congress_proposal(290n, C.ChamberCount{435n, 435n}, 67n, C.ChamberCount{100n, 100n}) == True{} : Bool}

law a5_congress_proposal_fail:
  {C.rule_a5_congress_proposal(289n, C.ChamberCount{435n, 435n}, 67n, C.ChamberCount{100n, 100n}) == False{} : Bool}

law a5_convention_application_pass:
  {C.rule_a5_convention_application(34n, C.StatesCount{50n}) == True{} : Bool}

law a5_convention_application_fail:
  {C.rule_a5_convention_application(33n, C.StatesCount{50n}) == False{} : Bool}

law a5_ratification_pass:
  {C.rule_a5_ratification(38n, C.StatesCount{50n}) == True{} : Bool}

law a5_ratification_fail:
  {C.rule_a5_ratification(37n, C.StatesCount{50n}) == False{} : Bool}

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
  {C.rule_am25s2_vp_confirmation(218n, C.ChamberCount{435n, 435n}, 51n, C.ChamberCount{100n, 100n}) == True{} : Bool}

law am25s2_vp_confirmation_fail:
  {C.rule_am25s2_vp_confirmation(217n, C.ChamberCount{435n, 435n}, 51n, C.ChamberCount{100n, 100n}) == False{} : Bool}

law am25s3_voluntary_transfer_declared:
  {C.rule_am25s3_voluntary_transfer(True{}, C.UnableToDischarge{}, True{}) == True{} : Bool}

law am25s3_voluntary_transfer_wrong_term:
  {C.rule_am25s3_voluntary_transfer(True{}, C.DueProcess{}, True{}) == False{} : Bool}

law am25s4_congress_decision_pass:
  {C.rule_am25s4_congress_decision(290n, C.ChamberCount{435n, 435n}, 67n, C.ChamberCount{100n, 100n}) == True{} : Bool}

law am25s4_congress_decision_fail:
  {C.rule_am25s4_congress_decision(289n, C.ChamberCount{435n, 435n}, 67n, C.ChamberCount{100n, 100n}) == False{} : Bool}

# AM26S1
law am26s1_vote_age_18:
  {C.rule_am26s1_vote_age(18n) == True{} : Bool}

law am26s1_vote_age_17:
  {C.rule_am26s1_vote_age(17n) == False{} : Bool}

# === Interpretation environment (TASKS.md item 2) ===

law interp_lookup_hit:
  {C.eval_interp(C.env_extend(C.interp_env_empty(), C.NaturalBornCitizen{}, True{}), C.NaturalBornCitizen{}) == C.Known{True{}} : C.InterpValue}

law interp_lookup_miss_is_unknown:
  {C.eval_interp(C.interp_env_empty(), C.Speedy{}) == C.Unknown{} : C.InterpValue}

law interp_resolved_false_is_not_unknown:
  {C.eval_interp(C.env_extend(C.interp_env_empty(), C.Speedy{}, False{}), C.Speedy{}) == C.Known{False{}} : C.InterpValue}

law interp_extend_first_wins:
  {C.eval_interp(C.env_extend(C.env_extend(C.interp_env_empty(), C.NaturalBornCitizen{}, True{}), C.NaturalBornCitizen{}, False{}), C.NaturalBornCitizen{}) == C.Known{False{}} : C.InterpValue}

law interp_extend_leaves_others_undisturbed:
  {C.eval_interp(C.env_extend(C.interp_env_empty(), C.NaturalBornCitizen{}, True{}), C.Speedy{}) == C.Unknown{} : C.InterpValue}

law interp_extend_visible:
  {C.eval_interp(C.env_extend(C.interp_env_empty(), C.Impartial{}, True{}), C.Impartial{}) == C.Known{True{}} : C.InterpValue}

law eval_natural_born_true_env:
  {C.eval_rule_a2s1_natural_born(C.env_extend(C.interp_env_empty(), C.NaturalBornCitizen{}, True{}), C.NaturalBornCitizen{}) == C.Known{True{}} : C.InterpValue}

law eval_natural_born_false_env_flips:
  {C.eval_rule_a2s1_natural_born(C.env_extend(C.interp_env_empty(), C.NaturalBornCitizen{}, False{}), C.NaturalBornCitizen{}) == C.Known{False{}} : C.InterpValue}

law eval_natural_born_absent_is_unknown:
  {C.eval_rule_a2s1_natural_born(C.interp_env_empty(), C.NaturalBornCitizen{}) == C.Unknown{} : C.InterpValue}

law eval_natural_born_wrong_term_fails:
  {C.eval_rule_a2s1_natural_born(C.env_extend(C.interp_env_empty(), C.Speedy{}, True{}), C.Speedy{}) == C.Known{False{}} : C.InterpValue}

law eval_natural_born_coherent_with_direct_rule:
  {C.eval_rule_a2s1_natural_born(C.env_extend(C.interp_env_empty(), C.NaturalBornCitizen{}, True{}), C.NaturalBornCitizen{}) == C.Known{C.rule_a2s1_natural_born(C.NaturalBornCitizen{}, True{})} : C.InterpValue}

law eval_jury_trial_env_all_met:
  {C.eval_rule_a3s2_jury_trial(C.env_extend(C.env_extend(C.interp_env_empty(), C.Speedy{}, True{}), C.Impartial{}, True{}), True{}, C.Speedy{}, C.Impartial{}) == C.Known{True{}} : C.InterpValue}

law eval_jury_trial_env_speedy_denied_flips:
  {C.eval_rule_a3s2_jury_trial(C.env_extend(C.env_extend(C.interp_env_empty(), C.Speedy{}, False{}), C.Impartial{}, True{}), True{}, C.Speedy{}, C.Impartial{}) == C.Known{False{}} : C.InterpValue}

law eval_jury_trial_env_missing_term_unknown:
  {C.eval_rule_a3s2_jury_trial(C.env_extend(C.interp_env_empty(), C.Speedy{}, True{}), True{}, C.Speedy{}, C.Impartial{}) == C.Unknown{} : C.InterpValue}

law eval_prohibition_env_applies:
  {C.eval_rule_am18s1_prohibition(C.env_extend(C.interp_env_empty(), C.IntoxicatingLiquor{}, True{}), True{}, True{}, C.IntoxicatingLiquor{}) == C.Known{False{}} : C.InterpValue}

law eval_prohibition_env_term_narrow:
  {C.eval_rule_am18s1_prohibition(C.env_extend(C.interp_env_empty(), C.IntoxicatingLiquor{}, False{}), True{}, True{}, C.IntoxicatingLiquor{}) == C.Known{True{}} : C.InterpValue}

law eval_transfer_env_unable:
  {C.eval_rule_am25s3_voluntary_transfer(C.env_extend(C.interp_env_empty(), C.UnableToDischarge{}, True{}), True{}, C.UnableToDischarge{}) == C.Known{True{}} : C.InterpValue}

law eval_transfer_env_able_flips:
  {C.eval_rule_am25s3_voluntary_transfer(C.env_extend(C.interp_env_empty(), C.UnableToDischarge{}, False{}), True{}, C.UnableToDischarge{}) == C.Known{False{}} : C.InterpValue}

law eval_clause_dispatcher_natural_born:
  {C.eval_clause_under_env(C.CL_A2S1_NaturalBorn{}, C.env_extend(C.interp_env_empty(), C.NaturalBornCitizen{}, True{}), C.NaturalBornCitizen{}, C.Speedy{}, True{}, True{}) == C.Known{True{}} : C.InterpValue}

law eval_clause_dispatcher_jury_trial:
  {C.eval_clause_under_env(C.CL_A3S2_JuryTrial{}, C.env_extend(C.env_extend(C.interp_env_empty(), C.Speedy{}, True{}), C.Impartial{}, True{}), C.Speedy{}, C.Impartial{}, True{}, True{}) == C.Known{True{}} : C.InterpValue}

law eval_clause_term_free_env_inert:
  {C.eval_clause_under_env(C.CL_A1S2_Qualifications{}, C.env_extend(C.interp_env_empty(), C.NaturalBornCitizen{}, True{}), C.NaturalBornCitizen{}, C.Speedy{}, True{}, True{}) == C.Unknown{} : C.InterpValue}

law eval_clause_term_free_env_inert_other_env:
  {C.eval_clause_under_env(C.CL_A1S2_Qualifications{}, C.interp_env_empty(), C.Speedy{}, C.Impartial{}, False{}, False{}) == C.Unknown{} : C.InterpValue}

# --- Denominator policies (TASKS.md item 4): the basis selector picks the field ---

# Same yes-count, different basis, different verdict: the selector reads
# `present` under PresentMembers ...
law denominator_present_selects_present:
  {C.two_thirds(60n, C.ChamberCount{90n, 100n}, C.PresentMembers{}) == True{} : Bool}

# ... and `membership` under FullMembership.
law denominator_membership_selects_membership:
  {C.two_thirds(60n, C.ChamberCount{90n, 100n}, C.FullMembership{}) == False{} : Bool}

# State votes take the states bundle: 34 of 50 is two thirds of the states.
law denominator_states_two_thirds_pass:
  {C.states_two_thirds(34n, C.StatesCount{50n}) == True{} : Bool}

law denominator_states_two_thirds_fail:
  {C.states_two_thirds(33n, C.StatesCount{50n}) == False{} : Bool}

# A1S5 quorum: a majority of the membership present.
law denominator_quorum_met:
  {C.quorum_met(C.ChamberCount{218n, 435n}) == True{} : Bool}

law denominator_quorum_not_met:
  {C.quorum_met(C.ChamberCount{217n, 435n}) == False{} : Bool}

# AM12: a majority of the whole number of electors (538 appointed).
law denominator_appointed_electors_whole_number:
  {C.majority(270n, C.ChamberCount{538n, 538n}, C.AppointedElectors{}) == True{} : Bool}

# The present basis is fixed by impeachment_conviction's signature: 60 of 90
# present convicts even though 60 is short of two thirds of the 100-member body.
law impeachment_basis_is_present_members:
  {C.impeachment_conviction(60n, C.ChamberCount{90n, 100n}) == True{} : Bool}

# The membership basis is fixed by article_v_congress_proposal's signature: 250
# clears two thirds of the 300 present but not of the 435-member House.
law article_v_basis_is_membership:
  {C.article_v_congress_proposal(250n, C.ChamberCount{300n, 435n}, 67n, C.ChamberCount{100n, 100n}) == False{} : Bool}

# --- Clause completion wave: boundary laws for the 46 remaining blocks ---


# A1S1
law a1s1_vesting_pass:
  {C.rule_a1s1_vesting(True{}) == True{} : Bool}

law a1s1_vesting_fail:
  {C.rule_a1s1_vesting(False{}) == False{} : Bool}


# A1S5
law a1s5_quorum_pass:
  {C.rule_a1s5_quorum(C.ChamberCount{51n, 100n}) == True{} : Bool}

law a1s5_quorum_fail:
  {C.rule_a1s5_quorum(C.ChamberCount{50n, 100n}) == False{} : Bool}

law a1s5_expulsion_pass:
  {C.rule_a1s5_expulsion(67n, C.ChamberCount{100n, 100n}) == True{} : Bool}

law a1s5_expulsion_fail:
  {C.rule_a1s5_expulsion(66n, C.ChamberCount{100n, 100n}) == False{} : Bool}

law a1s5_yeas_nays_pass:
  {C.rule_a1s5_yeas_nays(20n, 100n) == True{} : Bool}

law a1s5_yeas_nays_fail:
  {C.rule_a1s5_yeas_nays(19n, 100n) == False{} : Bool}

law a1s5_adjournment_pass:
  {C.rule_a1s5_adjournment(3n, False{}) == True{} : Bool}

law a1s5_adjournment_fail:
  {C.rule_a1s5_adjournment(4n, False{}) == False{} : Bool}


# A1S6
law a1s6_arrest_privilege_pass:
  {C.rule_a1s6_arrest_privilege(True{}, False{}, False{}, False{}) == True{} : Bool}

law a1s6_arrest_privilege_fail:
  {C.rule_a1s6_arrest_privilege(True{}, True{}, False{}, False{}) == False{} : Bool}

law a1s6_speech_debate_pass:
  {C.rule_a1s6_speech_debate(False{}) == True{} : Bool}

law a1s6_speech_debate_fail:
  {C.rule_a1s6_speech_debate(True{}) == False{} : Bool}

law a1s6_incompatible_pass:
  {C.rule_a1s6_incompatible(True{}, False{}) == True{} : Bool}

law a1s6_incompatible_fail:
  {C.rule_a1s6_incompatible(True{}, True{}) == False{} : Bool}

law a1s6_emolument_pass:
  {C.rule_a1s6_emolument(False{}, False{}) == True{} : Bool}

law a1s6_emolument_fail:
  {C.rule_a1s6_emolument(True{}, False{}) == False{} : Bool}


# A1S8
law a1s8_tax_pass:
  {C.rule_a1s8_tax(True{}, True{}) == True{} : Bool}

law a1s8_tax_fail:
  {C.rule_a1s8_tax(True{}, False{}) == False{} : Bool}

law a1s8_commerce_pass:
  {C.rule_a1s8_commerce(C.Commerce{}, True{}) == True{} : Bool}

law a1s8_commerce_fail:
  {C.rule_a1s8_commerce(C.Commerce{}, False{}) == False{} : Bool}

law a1s8_naturalization_bankruptcy_pass:
  {C.rule_a1s8_naturalization_bankruptcy(True{}) == True{} : Bool}

law a1s8_naturalization_bankruptcy_fail:
  {C.rule_a1s8_naturalization_bankruptcy(False{}) == False{} : Bool}

law a1s8_coin_weights_pass:
  {C.rule_a1s8_coin_weights(True{}) == True{} : Bool}

law a1s8_coin_weights_fail:
  {C.rule_a1s8_coin_weights(False{}) == False{} : Bool}

law a1s8_declare_war_pass:
  {C.rule_a1s8_declare_war(True{}) == True{} : Bool}

law a1s8_declare_war_fail:
  {C.rule_a1s8_declare_war(False{}) == False{} : Bool}

law a1s8_necessary_proper_pass:
  {C.rule_a1s8_necessary_proper(C.NecessaryAndProper{}, True{}) == True{} : Bool}

law a1s8_necessary_proper_fail:
  {C.rule_a1s8_necessary_proper(C.NecessaryAndProper{}, False{}) == False{} : Bool}


# A1S9
law a1s9_habeas_pass:
  {C.rule_a1s9_habeas(True{}, True{}, False{}) == True{} : Bool}

law a1s9_habeas_fail:
  {C.rule_a1s9_habeas(True{}, False{}, False{}) == False{} : Bool}

law a1s9_attainder_pass:
  {C.rule_a1s9_attainder(False{}) == True{} : Bool}

law a1s9_attainder_fail:
  {C.rule_a1s9_attainder(True{}) == False{} : Bool}

law a1s9_direct_tax_pass:
  {C.rule_a1s9_direct_tax(False{}, False{}) == True{} : Bool}

law a1s9_direct_tax_fail:
  {C.rule_a1s9_direct_tax(True{}, False{}) == False{} : Bool}

law a1s9_export_tax_pass:
  {C.rule_a1s9_export_tax(False{}) == True{} : Bool}

law a1s9_export_tax_fail:
  {C.rule_a1s9_export_tax(True{}) == False{} : Bool}

law a1s9_appropriations_pass:
  {C.rule_a1s9_appropriations(False{}, False{}) == True{} : Bool}

law a1s9_appropriations_fail:
  {C.rule_a1s9_appropriations(True{}, False{}) == False{} : Bool}

law a1s9_titles_pass:
  {C.rule_a1s9_titles(False{}) == True{} : Bool}

law a1s9_titles_fail:
  {C.rule_a1s9_titles(True{}) == False{} : Bool}


# A1S10
law a1s10_treaty_alliance_pass:
  {C.rule_a1s10_treaty_alliance(False{}) == True{} : Bool}

law a1s10_treaty_alliance_fail:
  {C.rule_a1s10_treaty_alliance(True{}) == False{} : Bool}

law a1s10_coin_tender_pass:
  {C.rule_a1s10_coin_tender(False{}) == True{} : Bool}

law a1s10_coin_tender_fail:
  {C.rule_a1s10_coin_tender(True{}) == False{} : Bool}

law a1s10_imposts_pass:
  {C.rule_a1s10_imposts(True{}, True{}, False{}) == True{} : Bool}

law a1s10_imposts_fail:
  {C.rule_a1s10_imposts(True{}, False{}, False{}) == False{} : Bool}

law a1s10_state_war_pass:
  {C.rule_a1s10_state_war(True{}, False{}, True{}, False{}) == True{} : Bool}

law a1s10_state_war_fail:
  {C.rule_a1s10_state_war(True{}, False{}, False{}, False{}) == False{} : Bool}


# A2S2
law a2s2_commander_in_chief_pass:
  {C.rule_a2s2_commander_in_chief(True{}) == True{} : Bool}

law a2s2_commander_in_chief_fail:
  {C.rule_a2s2_commander_in_chief(False{}) == False{} : Bool}

law a2s2_pardons_pass:
  {C.rule_a2s2_pardons(True{}, False{}) == True{} : Bool}

law a2s2_pardons_fail:
  {C.rule_a2s2_pardons(True{}, True{}) == False{} : Bool}

law a2s2_treaty_pass:
  {C.rule_a2s2_treaty(67n, C.ChamberCount{100n, 100n}) == True{} : Bool}

law a2s2_treaty_fail:
  {C.rule_a2s2_treaty(66n, C.ChamberCount{100n, 100n}) == False{} : Bool}

law a2s2_appointments_pass:
  {C.rule_a2s2_appointments(True{}, True{}) == True{} : Bool}

law a2s2_appointments_fail:
  {C.rule_a2s2_appointments(True{}, False{}) == False{} : Bool}

law a2s2_recess_pass:
  {C.rule_a2s2_recess(True{}, True{}) == True{} : Bool}

law a2s2_recess_fail:
  {C.rule_a2s2_recess(True{}, False{}) == False{} : Bool}


# A2S3
law a2s3_take_care_pass:
  {C.rule_a2s3_take_care(True{}) == True{} : Bool}

law a2s3_take_care_fail:
  {C.rule_a2s3_take_care(False{}) == False{} : Bool}

law a2s3_convene_pass:
  {C.rule_a2s3_convene(C.ExtraordinaryOccasion{}, True{}) == True{} : Bool}

law a2s3_convene_fail:
  {C.rule_a2s3_convene(C.ExtraordinaryOccasion{}, False{}) == False{} : Bool}


# A2S4
law a2s4_removal_pass:
  {C.rule_a2s4_removal(True{}, True{}, C.HighCrimesAndMisdemeanors{}, True{}) == True{} : Bool}

law a2s4_removal_fail:
  {C.rule_a2s4_removal(True{}, True{}, C.HighCrimesAndMisdemeanors{}, False{}) == False{} : Bool}


# A3S1
law a3s1_vesting_pass:
  {C.rule_a3s1_vesting(True{}) == True{} : Bool}

law a3s1_vesting_fail:
  {C.rule_a3s1_vesting(False{}) == False{} : Bool}

law a3s1_tenure_pass:
  {C.rule_a3s1_tenure(C.GoodBehavior{}, True{}) == True{} : Bool}

law a3s1_tenure_fail:
  {C.rule_a3s1_tenure(C.GoodBehavior{}, False{}) == False{} : Bool}

law a3s1_compensation_pass:
  {C.rule_a3s1_compensation(False{}) == True{} : Bool}

law a3s1_compensation_fail:
  {C.rule_a3s1_compensation(True{}) == False{} : Bool}


# A3S3
law a3s3_treason_definition_pass:
  {C.rule_a3s3_treason_definition(True{}, False{}) == True{} : Bool}

law a3s3_treason_definition_fail:
  {C.rule_a3s3_treason_definition(False{}, False{}) == False{} : Bool}

law a3s3_corruption_of_blood_pass:
  {C.rule_a3s3_corruption_of_blood(False{}) == True{} : Bool}

law a3s3_corruption_of_blood_fail:
  {C.rule_a3s3_corruption_of_blood(True{}) == False{} : Bool}


# A4S1
law a4s1_full_faith_credit_pass:
  {C.rule_a4s1_full_faith_credit(True{}) == True{} : Bool}

law a4s1_full_faith_credit_fail:
  {C.rule_a4s1_full_faith_credit(False{}) == False{} : Bool}


# A4S2
law a4s2_privileges_immunities_pass:
  {C.rule_a4s2_privileges_immunities(True{}) == True{} : Bool}

law a4s2_privileges_immunities_fail:
  {C.rule_a4s2_privileges_immunities(False{}) == False{} : Bool}

law a4s2_extradition_pass:
  {C.rule_a4s2_extradition(True{}, True{}, True{}) == True{} : Bool}

law a4s2_extradition_fail:
  {C.rule_a4s2_extradition(True{}, True{}, False{}) == False{} : Bool}

law a4s2_fugitive_labor_pass:
  {C.rule_a4s2_fugitive_labor(True{}) == True{} : Bool}

law a4s2_fugitive_labor_fail:
  {C.rule_a4s2_fugitive_labor(False{}) == False{} : Bool}


# A4S3
law a4s3_new_state_pass:
  {C.rule_a4s3_new_state(False{}, False{}, True{}, True{}) == True{} : Bool}

law a4s3_new_state_fail:
  {C.rule_a4s3_new_state(True{}, False{}, False{}, True{}) == False{} : Bool}

law a4s3_territory_pass:
  {C.rule_a4s3_territory(True{}) == True{} : Bool}

law a4s3_territory_fail:
  {C.rule_a4s3_territory(False{}) == False{} : Bool}


# A4S4
law a4s4_republican_form_pass:
  {C.rule_a4s4_republican_form(C.RepublicanForm{}, True{}) == True{} : Bool}

law a4s4_republican_form_fail:
  {C.rule_a4s4_republican_form(C.RepublicanForm{}, False{}) == False{} : Bool}

law a4s4_protection_pass:
  {C.rule_a4s4_protection(True{}, False{}, False{}) == True{} : Bool}

law a4s4_protection_fail:
  {C.rule_a4s4_protection(False{}, True{}, False{}) == False{} : Bool}


# A6
law a6_supremacy_pass:
  {C.rule_a6_supremacy(True{}) == True{} : Bool}

law a6_supremacy_fail:
  {C.rule_a6_supremacy(False{}) == False{} : Bool}

law a6_oaths_pass:
  {C.rule_a6_oaths(True{}) == True{} : Bool}

law a6_oaths_fail:
  {C.rule_a6_oaths(False{}) == False{} : Bool}


# A7
law a7_ratification_pass:
  {C.rule_a7_ratification(9n) == True{} : Bool}

law a7_ratification_fail:
  {C.rule_a7_ratification(8n) == False{} : Bool}


# AM1
law am1_religion_pass:
  {C.rule_am1_religion(C.EstablishmentOfReligion{}, True{}, C.FreeExercise{}, True{}) == True{} : Bool}

law am1_religion_fail:
  {C.rule_am1_religion(C.EstablishmentOfReligion{}, False{}, C.FreeExercise{}, True{}) == False{} : Bool}

law am1_expression_pass:
  {C.rule_am1_expression(False{}) == True{} : Bool}

law am1_expression_fail:
  {C.rule_am1_expression(True{}) == False{} : Bool}


# AM2
law am2_arms_pass:
  {C.rule_am2_arms(C.WellRegulatedMilitia{}, True{}, C.KeepAndBearArms{}, True{}) == True{} : Bool}

law am2_arms_fail:
  {C.rule_am2_arms(C.WellRegulatedMilitia{}, True{}, C.KeepAndBearArms{}, False{}) == False{} : Bool}


# AM3
law am3_quartering_pass:
  {C.rule_am3_quartering(False{}, False{}, True{}) == True{} : Bool}

law am3_quartering_fail:
  {C.rule_am3_quartering(True{}, False{}, False{}) == False{} : Bool}


# AM4
law am4_search_pass:
  {C.rule_am4_search(C.Unreasonable{}, False{}) == True{} : Bool}

law am4_search_fail:
  {C.rule_am4_search(C.Unreasonable{}, True{}) == False{} : Bool}

law am4_warrant_pass:
  {C.rule_am4_warrant(C.ProbableCause{}, True{}, True{}) == True{} : Bool}

law am4_warrant_fail:
  {C.rule_am4_warrant(C.ProbableCause{}, False{}, True{}) == False{} : Bool}


# AM5
law am5_grand_jury_pass:
  {C.rule_am5_grand_jury(C.InfamousCrime{}, True{}, True{}) == True{} : Bool}

law am5_grand_jury_fail:
  {C.rule_am5_grand_jury(C.InfamousCrime{}, True{}, False{}) == False{} : Bool}

law am5_double_jeopardy_pass:
  {C.rule_am5_double_jeopardy(C.SameOffence{}, False{}) == True{} : Bool}

law am5_double_jeopardy_fail:
  {C.rule_am5_double_jeopardy(C.SameOffence{}, True{}) == False{} : Bool}

law am5_due_process_pass:
  {C.rule_am5_due_process(C.DueProcess{}, False{}) == True{} : Bool}

law am5_due_process_fail:
  {C.rule_am5_due_process(C.DueProcess{}, True{}) == False{} : Bool}

law am5_takings_pass:
  {C.rule_am5_takings(True{}, True{}) == True{} : Bool}

law am5_takings_fail:
  {C.rule_am5_takings(True{}, False{}) == False{} : Bool}


# AM6
law am6_trial_pass:
  {C.rule_am6_trial(True{}, C.Speedy{}, True{}, C.Impartial{}, True{}) == True{} : Bool}

law am6_trial_fail:
  {C.rule_am6_trial(True{}, C.Speedy{}, False{}, C.Impartial{}, True{}) == False{} : Bool}

law am6_counsel_pass:
  {C.rule_am6_counsel(True{}) == True{} : Bool}

law am6_counsel_fail:
  {C.rule_am6_counsel(False{}) == False{} : Bool}


# AM7
law am7_civil_jury_pass:
  {C.rule_am7_civil_jury(21n) == True{} : Bool}

law am7_civil_jury_fail:
  {C.rule_am7_civil_jury(20n) == False{} : Bool}

law am7_reexamination_pass:
  {C.rule_am7_reexamination(C.CommonLawSuit{}, False{}) == True{} : Bool}

law am7_reexamination_fail:
  {C.rule_am7_reexamination(C.CommonLawSuit{}, True{}) == False{} : Bool}


# AM8
law am8_excessive_pass:
  {C.rule_am8_excessive(C.Excessive{}, False{}) == True{} : Bool}

law am8_excessive_fail:
  {C.rule_am8_excessive(C.Excessive{}, True{}) == False{} : Bool}

law am8_cruel_unusual_pass:
  {C.rule_am8_cruel_unusual(C.CruelAndUnusual{}, False{}) == True{} : Bool}

law am8_cruel_unusual_fail:
  {C.rule_am8_cruel_unusual(C.CruelAndUnusual{}, True{}) == False{} : Bool}


# AM9
law am9_retained_pass:
  {C.rule_am9_retained(C.RetainedRight{}, False{}) == True{} : Bool}

law am9_retained_fail:
  {C.rule_am9_retained(C.RetainedRight{}, True{}) == False{} : Bool}


# AM10
law am10_reserved_pass:
  {C.rule_am10_reserved(C.DelegatedPower{}, True{}) == True{} : Bool}

law am10_reserved_fail:
  {C.rule_am10_reserved(C.DelegatedPower{}, False{}) == False{} : Bool}


# AM11
law am11_immunity_pass:
  {C.rule_am11_immunity(True{}, False{}) == True{} : Bool}

law am11_immunity_fail:
  {C.rule_am11_immunity(True{}, True{}) == False{} : Bool}


# AM13S2
law am13s2_enforcement_pass:
  {C.rule_am13s2_enforcement(C.AppropriateLegislation{}, True{}) == True{} : Bool}

law am13s2_enforcement_fail:
  {C.rule_am13s2_enforcement(C.AppropriateLegislation{}, False{}) == False{} : Bool}


# AM14S1
law am14s1_citizenship_pass:
  {C.rule_am14s1_citizenship(True{}, True{}) == True{} : Bool}

law am14s1_citizenship_fail:
  {C.rule_am14s1_citizenship(True{}, False{}) == False{} : Bool}

law am14s1_dp_ep_pass:
  {C.rule_am14s1_dp_ep(C.DueProcess{}, True{}, C.EqualProtection{}, True{}) == True{} : Bool}

law am14s1_dp_ep_fail:
  {C.rule_am14s1_dp_ep(C.DueProcess{}, True{}, C.EqualProtection{}, False{}) == False{} : Bool}

law am14s1_privileges_pass:
  {C.rule_am14s1_privileges(C.PrivilegesOrImmunities{}, False{}) == True{} : Bool}

law am14s1_privileges_fail:
  {C.rule_am14s1_privileges(C.PrivilegesOrImmunities{}, True{}) == False{} : Bool}


# AM14S3
law am14s3_disability_removed_pass:
  {C.rule_am14s3_disability_removed(290n, C.ChamberCount{435n, 435n}, 67n, C.ChamberCount{100n, 100n}) == True{} : Bool}

law am14s3_disability_removed_fail:
  {C.rule_am14s3_disability_removed(289n, C.ChamberCount{435n, 435n}, 67n, C.ChamberCount{100n, 100n}) == False{} : Bool}


# AM14S4
law am14s4_debt_pass:
  {C.rule_am14s4_debt(C.ValidPublicDebt{}, False{}) == True{} : Bool}

law am14s4_debt_fail:
  {C.rule_am14s4_debt(C.ValidPublicDebt{}, True{}) == False{} : Bool}


# AM14S5
law am14s5_enforcement_pass:
  {C.rule_am14s5_enforcement(C.AppropriateLegislation{}, True{}) == True{} : Bool}

law am14s5_enforcement_fail:
  {C.rule_am14s5_enforcement(C.AppropriateLegislation{}, False{}) == False{} : Bool}


# AM15S1
law am15s1_vote_pass:
  {C.rule_am15s1_vote(False{}) == True{} : Bool}

law am15s1_vote_fail:
  {C.rule_am15s1_vote(True{}) == False{} : Bool}


# AM15S2
law am15s2_enforcement_pass:
  {C.rule_am15s2_enforcement(C.AppropriateLegislation{}, True{}) == True{} : Bool}

law am15s2_enforcement_fail:
  {C.rule_am15s2_enforcement(C.AppropriateLegislation{}, False{}) == False{} : Bool}


# AM19
law am19_vote_pass:
  {C.rule_am19_vote(False{}) == True{} : Bool}

law am19_vote_fail:
  {C.rule_am19_vote(True{}) == False{} : Bool}


# AM20S5
law am20s5_effective_pass:
  {C.rule_am20s5_effective(True{}) == True{} : Bool}

law am20s5_effective_fail:
  {C.rule_am20s5_effective(False{}) == False{} : Bool}


# AM20S6
law am20s6_deadline_pass:
  {C.rule_am20s6_deadline(True{}) == True{} : Bool}

law am20s6_deadline_fail:
  {C.rule_am20s6_deadline(False{}) == False{} : Bool}


# AM21S2
law am21s2_transportation_pass:
  {C.rule_am21s2_transportation(C.IntoxicatingLiquor{}, True{}) == True{} : Bool}

law am21s2_transportation_fail:
  {C.rule_am21s2_transportation(C.IntoxicatingLiquor{}, False{}) == False{} : Bool}


# AM21S3
law am21s3_deadline_pass:
  {C.rule_am21s3_deadline(True{}) == True{} : Bool}

law am21s3_deadline_fail:
  {C.rule_am21s3_deadline(False{}) == False{} : Bool}


# AM23S1
law am23s1_electors_pass:
  {C.rule_am23s1_electors(True{}, 3n, 3n) == True{} : Bool}

law am23s1_electors_fail:
  {C.rule_am23s1_electors(True{}, 3n, 4n) == False{} : Bool}


# AM23S2
law am23s2_enforcement_pass:
  {C.rule_am23s2_enforcement(C.AppropriateLegislation{}, True{}) == True{} : Bool}

law am23s2_enforcement_fail:
  {C.rule_am23s2_enforcement(C.AppropriateLegislation{}, False{}) == False{} : Bool}


# AM24S1
law am24s1_poll_tax_pass:
  {C.rule_am24s1_poll_tax(False{}) == True{} : Bool}

law am24s1_poll_tax_fail:
  {C.rule_am24s1_poll_tax(True{}) == False{} : Bool}


# AM24S2
law am24s2_enforcement_pass:
  {C.rule_am24s2_enforcement(C.AppropriateLegislation{}, True{}) == True{} : Bool}

law am24s2_enforcement_fail:
  {C.rule_am24s2_enforcement(C.AppropriateLegislation{}, False{}) == False{} : Bool}


# AM26S2
law am26s2_enforcement_pass:
  {C.rule_am26s2_enforcement(C.AppropriateLegislation{}, True{}) == True{} : Bool}

law am26s2_enforcement_fail:
  {C.rule_am26s2_enforcement(C.AppropriateLegislation{}, False{}) == False{} : Bool}


# AM27
law am27_timing_pass:
  {C.rule_am27_timing(True{}, True{}) == True{} : Bool}

law am27_timing_fail:
  {C.rule_am27_timing(True{}, False{}) == False{} : Bool}

# --- Temporal activation (TASKS.md item 3) ---
#
# Linearity note: Bend 2.0.27 consumes every variable exactly once, so a
# closed interval such as AM18's [1920, 1933] cannot be tested with two
# comparisons on one year variable. The temporal API therefore exposes both
# sides separately — `clause_commenced` (has the text taken effect by t?) and
# `clause_unexpired` (has the text lapsed by t?) — each one-sided and directly
# checkable. The full "operative at t" reading is their conjunction, stated
# explicitly in the window laws below.

# A1S9 migration/importation bar on Congress: operative strictly before 1808.
law temporal_a1s9_unexpired_1807:
  {C.clause_unexpired(C.CL_A1S9_MigrationRestriction{}, C.Year{1807n}) == True{} : Bool}

law temporal_a1s9_expired_1808:
  {C.clause_unexpired(C.CL_A1S9_MigrationRestriction{}, C.Year{1808n}) == False{} : Bool}

# The clause rule and the temporal predicate agree (wiring coherence).
law temporal_a1s9_rule_coherent_1807:
  {C.rule_a1s9_migration_restriction(C.Year{1807n}) == C.clause_unexpired(C.CL_A1S9_MigrationRestriction{}, C.Year{1807n}) : Bool}

# Original-text clause: commenced from the start, no expiry in the text.
law temporal_a1s9_commenced_1807:
  {C.clause_commenced(C.CL_A1S9_MigrationRestriction{}, C.Year{1807n}) == True{} : Bool}

# AM18: commenced 1920 (effective one year after 1919 ratification, AM18S3).
law temporal_am18_commenced_1920:
  {C.clause_commenced(C.CL_AM18S1_Prohibition{}, C.Year{1920n}) == True{} : Bool}

law temporal_am18_uncommenced_1919:
  {C.clause_commenced(C.CL_AM18S1_Prohibition{}, C.Year{1919n}) == False{} : Bool}

# AM18: unexpired through 1933; repealed by AM21 (ratified 1933-12-05), so
# expired from 1934 at year granularity.
law temporal_am18_unexpired_1933:
  {C.clause_unexpired(C.CL_AM18S1_Prohibition{}, C.Year{1933n}) == True{} : Bool}

law temporal_am18_expired_1934:
  {C.clause_unexpired(C.CL_AM18S1_Prohibition{}, C.Year{1934n}) == False{} : Bool}

# The operative window 1920-1933 is the conjunction of both sides.
law temporal_am18_window_1932:
  {Bool.and(C.clause_commenced(C.CL_AM18S1_Prohibition{}, C.Year{1932n}), C.clause_unexpired(C.CL_AM18S1_Prohibition{}, C.Year{1932n})) == True{} : Bool}

law temporal_am18_window_1919:
  {Bool.and(C.clause_commenced(C.CL_AM18S1_Prohibition{}, C.Year{1919n}), C.clause_unexpired(C.CL_AM18S1_Prohibition{}, C.Year{1919n})) == False{} : Bool}

law temporal_am18_window_1934:
  {Bool.and(C.clause_commenced(C.CL_AM18S1_Prohibition{}, C.Year{1934n}), C.clause_unexpired(C.CL_AM18S1_Prohibition{}, C.Year{1934n})) == False{} : Bool}

# Combined reading: the timeless repeal mark dominates, so AM18 is never
# "effective" in the present-day sense, even inside its historical window.
law temporal_am18_effective_never_1932:
  {Bool.and(C.clause_in_force(C.CL_AM18S1_Prohibition{}), Bool.and(C.clause_commenced(C.CL_AM18S1_Prohibition{}, C.Year{1932n}), C.clause_unexpired(C.CL_AM18S1_Prohibition{}, C.Year{1932n}))) == False{} : Bool}

# A clause with no temporal provision is commenced and unexpired at any time.
law temporal_ordinary_clause_commenced_1807:
  {C.clause_commenced(C.CL_AM26S1_VoteAge{}, C.Year{1807n}) == True{} : Bool}

law temporal_ordinary_clause_unexpired_2026:
  {C.clause_unexpired(C.CL_AM26S1_VoteAge{}, C.Year{2026n}) == True{} : Bool}

# Ratification deadlines: the text is silent, so the corpus default is none.
law temporal_deadline_silent_am18:
  {C.ratification_deadline_for(C.AM18S1{}) == C.NoDeadlineInText{} : C.RatificationDeadline}

law temporal_deadline_silent_a5:
  {C.ratification_deadline_for(C.A5{}) == C.NoDeadlineInText{} : C.RatificationDeadline}

# Explicit deadlines (caller-supplied, e.g. from proposing resolutions).
law temporal_ratification_timely_7yr:
  {C.ratification_timely(1917n, 1919n, C.YearsAfterProposal{7n}) == True{} : Bool}

law temporal_ratification_untimely_7yr:
  {C.ratification_timely(1917n, 1925n, C.YearsAfterProposal{7n}) == False{} : Bool}

law temporal_ratification_no_deadline_always_timely:
  {C.ratification_timely(1917n, 1992n, C.NoDeadlineInText{}) == True{} : Bool}

# Succession: AM25 activates in 1967.
law temporal_succession_vacancy_1968:
  {C.succession_rule_effective(True{}, C.Year{1968n}) == True{} : Bool}

law temporal_succession_vacancy_1966:
  {C.succession_rule_effective(True{}, C.Year{1966n}) == False{} : Bool}

law temporal_acting_president_inability_1968:
  {C.acting_president_serves(True{}, C.Year{1968n}) == True{} : Bool}

law temporal_acting_president_inability_1966:
  {C.acting_president_serves(True{}, C.Year{1966n}) == False{} : Bool}

# AM20S1 term commencement activates in 1933.
law temporal_term_jan20_1933:
  {C.term_commencement_jan20(C.Year{1933n}) == True{} : Bool}

law temporal_term_jan20_1932:
  {C.term_commencement_jan20(C.Year{1932n}) == False{} : Bool}
