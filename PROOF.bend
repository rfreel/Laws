import Base
import ./LAWS.bend as Laws
import ./laws.bend as C

def Laws.source_indices_bounded(block):
  match block:
    case C.Preamble{}:
      {==}
    case C.A1S1{}:
      {==}
    case C.A1S2{}:
      {==}
    case C.A1S3{}:
      {==}
    case C.A1S4{}:
      {==}
    case C.A1S5{}:
      {==}
    case C.A1S6{}:
      {==}
    case C.A1S7{}:
      {==}
    case C.A1S8{}:
      {==}
    case C.A1S9{}:
      {==}
    case C.A1S10{}:
      {==}
    case C.A2S1{}:
      {==}
    case C.A2S2{}:
      {==}
    case C.A2S3{}:
      {==}
    case C.A2S4{}:
      {==}
    case C.A3S1{}:
      {==}
    case C.A3S2{}:
      {==}
    case C.A3S3{}:
      {==}
    case C.A4S1{}:
      {==}
    case C.A4S2{}:
      {==}
    case C.A4S3{}:
      {==}
    case C.A4S4{}:
      {==}
    case C.A5{}:
      {==}
    case C.A6{}:
      {==}
    case C.A7{}:
      {==}
    case C.AM1{}:
      {==}
    case C.AM2{}:
      {==}
    case C.AM3{}:
      {==}
    case C.AM4{}:
      {==}
    case C.AM5{}:
      {==}
    case C.AM6{}:
      {==}
    case C.AM7{}:
      {==}
    case C.AM8{}:
      {==}
    case C.AM9{}:
      {==}
    case C.AM10{}:
      {==}
    case C.AM11{}:
      {==}
    case C.AM12{}:
      {==}
    case C.AM13S1{}:
      {==}
    case C.AM13S2{}:
      {==}
    case C.AM14S1{}:
      {==}
    case C.AM14S2{}:
      {==}
    case C.AM14S3{}:
      {==}
    case C.AM14S4{}:
      {==}
    case C.AM14S5{}:
      {==}
    case C.AM15S1{}:
      {==}
    case C.AM15S2{}:
      {==}
    case C.AM16{}:
      {==}
    case C.AM17{}:
      {==}
    case C.AM18S1{}:
      {==}
    case C.AM18S2{}:
      {==}
    case C.AM18S3{}:
      {==}
    case C.AM19{}:
      {==}
    case C.AM20S1{}:
      {==}
    case C.AM20S2{}:
      {==}
    case C.AM20S3{}:
      {==}
    case C.AM20S4{}:
      {==}
    case C.AM20S5{}:
      {==}
    case C.AM20S6{}:
      {==}
    case C.AM21S1{}:
      {==}
    case C.AM21S2{}:
      {==}
    case C.AM21S3{}:
      {==}
    case C.AM22S1{}:
      {==}
    case C.AM22S2{}:
      {==}
    case C.AM23S1{}:
      {==}
    case C.AM23S2{}:
      {==}
    case C.AM24S1{}:
      {==}
    case C.AM24S2{}:
      {==}
    case C.AM25S1{}:
      {==}
    case C.AM25S2{}:
      {==}
    case C.AM25S3{}:
      {==}
    case C.AM25S4{}:
      {==}
    case C.AM26S1{}:
      {==}
    case C.AM26S2{}:
      {==}
    case C.AM27{}:
      {==}

def Laws.representative_minimum_passes():
  {==}

def Laws.representative_age_below_fails():
  {==}

def Laws.senator_minimum_passes():
  {==}

def Laws.senator_age_below_fails():
  {==}

def Laws.president_minimum_passes():
  {==}

def Laws.president_age_below_fails():
  {==}

def Laws.article_v_34_of_50_applications_pass():
  {==}

def Laws.article_v_33_of_50_applications_fail():
  {==}

def Laws.article_v_38_of_50_ratifications_pass():
  {==}

def Laws.article_v_37_of_50_ratifications_fail():
  {==}

def Laws.article_v_full_congress_boundary_passes():
  {==}

def Laws.article_v_house_below_boundary_fails():
  {==}

def Laws.treaty_67_of_100_passes():
  {==}

def Laws.treaty_66_of_100_fails():
  {==}

def Laws.impeachment_67_of_100_passes():
  {==}

def Laws.treason_two_witnesses_suffice():
  {==}

def Laws.treason_confession_suffices():
  {==}

def Laws.treason_no_evidence_fails():
  {==}

def Laws.twenty_second_two_elections_allowed():
  {==}

def Laws.twenty_second_third_election_forbidden():
  {==}

def Laws.twenty_second_prior_service_reduces_limit():
  {==}

def Laws.twenty_sixth_age_18_protected():
  {==}

def Laws.twenty_sixth_age_17_not_covered_by_age_floor():
  {==}

def Laws.amendment_18_sections_marked_repealed():
  {==}

def Laws.signed_bill_path():
  {==}

def Laws.veto_override_path():
  {==}

def Laws.pocket_veto_path_fails():
  {==}

def Laws.ten_day_nonreturn_path_passes():
  {==}

def Laws.clause_indices_bounded(c):
  match c:
    case C.CL_Preamble_Purpose{}:
      {==}
    case C.CL_A1S2_Qualifications{}:
      {==}
    case C.CL_A1S2_ImpeachmentPower{}:
      {==}
    case C.CL_A1S2_ApportionmentCap{}:
      {==}
    case C.CL_A1S3_Qualifications{}:
      {==}
    case C.CL_A1S3_SenateTrial{}:
      {==}
    case C.CL_A1S3_VPTiebreak{}:
      {==}
    case C.CL_A1S4_ElectionRegulation{}:
      {==}
    case C.CL_A1S4_AnnualAssembly{}:
      {==}
    case C.CL_A1S7_Presentment{}:
      {==}
    case C.CL_A1S7_RevenueOrigination{}:
      {==}
    case C.CL_A2S1_Vesting{}:
      {==}
    case C.CL_A2S1_Term{}:
      {==}
    case C.CL_A2S1_Qualifications{}:
      {==}
    case C.CL_A2S1_NaturalBorn{}:
      {==}
    case C.CL_A2S1_Electors{}:
      {==}
    case C.CL_A3S2_TreasonEvidence{}:
      {==}
    case C.CL_A3S2_JuryTrial{}:
      {==}
    case C.CL_A5_CongressProposal{}:
      {==}
    case C.CL_A5_ConventionApplication{}:
      {==}
    case C.CL_A5_Ratification{}:
      {==}
    case C.CL_AM12_ElectoralMajority{}:
      {==}
    case C.CL_AM12_DistinctBallots{}:
      {==}
    case C.CL_AM13S1_Abolition{}:
      {==}
    case C.CL_AM14S2_ApportionmentBasis{}:
      {==}
    case C.CL_AM14S2_Reduction{}:
      {==}
    case C.CL_AM16_IncomeTax{}:
      {==}
    case C.CL_AM17_DirectElection{}:
      {==}
    case C.CL_AM17_VacancyAppointment{}:
      {==}
    case C.CL_AM18S1_Prohibition{}:
      {==}
    case C.CL_AM18S2_ConcurrentPower{}:
      {==}
    case C.CL_AM18S3_EffectiveDate{}:
      {==}
    case C.CL_AM20S1_TermCommencement{}:
      {==}
    case C.CL_AM20S2_CongressAssembly{}:
      {==}
    case C.CL_AM20S3_PresidentElectDeath{}:
      {==}
    case C.CL_AM20S4_SuccessionStatute{}:
      {==}
    case C.CL_AM21S1_Repeal{}:
      {==}
    case C.CL_AM22S1_TermLimit{}:
      {==}
    case C.CL_AM22S2_PriorServiceLimit{}:
      {==}
    case C.CL_AM25S1_Succession{}:
      {==}
    case C.CL_AM25S2_VPConfirmation{}:
      {==}
    case C.CL_AM25S3_VoluntaryTransfer{}:
      {==}
    case C.CL_AM25S4_CongressDecision{}:
      {==}
    case C.CL_AM26S1_VoteAge{}:
      {==}
    case C.CL_A1S1_Vesting{}:
      {==}
    case C.CL_A1S5_Quorum{}:
      {==}
    case C.CL_A1S5_Expulsion{}:
      {==}
    case C.CL_A1S5_YeasNays{}:
      {==}
    case C.CL_A1S5_Adjournment{}:
      {==}
    case C.CL_A1S6_ArrestPrivilege{}:
      {==}
    case C.CL_A1S6_SpeechDebate{}:
      {==}
    case C.CL_A1S6_Incompatibility{}:
      {==}
    case C.CL_A1S6_Emoluments{}:
      {==}
    case C.CL_A1S8_TaxUniformity{}:
      {==}
    case C.CL_A1S8_Commerce{}:
      {==}
    case C.CL_A1S8_NaturalizationBankruptcy{}:
      {==}
    case C.CL_A1S8_CoinWeights{}:
      {==}
    case C.CL_A1S8_WarDeclaration{}:
      {==}
    case C.CL_A1S8_NecessaryProper{}:
      {==}
    case C.CL_A1S9_HabeasCorpus{}:
      {==}
    case C.CL_A1S9_Attainder{}:
      {==}
    case C.CL_A1S9_DirectTax{}:
      {==}
    case C.CL_A1S9_ExportTax{}:
      {==}
    case C.CL_A1S9_Appropriations{}:
      {==}
    case C.CL_A1S9_TitlesNobility{}:
      {==}
    case C.CL_A1S10_TreatyAlliance{}:
      {==}
    case C.CL_A1S10_CoinTender{}:
      {==}
    case C.CL_A1S10_Imposts{}:
      {==}
    case C.CL_A1S10_StateWar{}:
      {==}
    case C.CL_A2S2_CommanderInChief{}:
      {==}
    case C.CL_A2S2_Pardons{}:
      {==}
    case C.CL_A2S2_Treaty{}:
      {==}
    case C.CL_A2S2_Appointments{}:
      {==}
    case C.CL_A2S2_RecessVacancies{}:
      {==}
    case C.CL_A2S3_TakeCare{}:
      {==}
    case C.CL_A2S3_ExtraordinaryConvene{}:
      {==}
    case C.CL_A2S4_Removal{}:
      {==}
    case C.CL_A3S1_Vesting{}:
      {==}
    case C.CL_A3S1_Tenure{}:
      {==}
    case C.CL_A3S1_Compensation{}:
      {==}
    case C.CL_A3S3_TreasonDefinition{}:
      {==}
    case C.CL_A3S3_PunishmentLimits{}:
      {==}
    case C.CL_A4S1_FullFaithCredit{}:
      {==}
    case C.CL_A4S2_PrivilegesImmunities{}:
      {==}
    case C.CL_A4S2_Extradition{}:
      {==}
    case C.CL_A4S2_FugitiveLabor{}:
      {==}
    case C.CL_A4S3_NewStates{}:
      {==}
    case C.CL_A4S3_Territory{}:
      {==}
    case C.CL_A4S4_RepublicanForm{}:
      {==}
    case C.CL_A4S4_Protection{}:
      {==}
    case C.CL_A6_Supremacy{}:
      {==}
    case C.CL_A6_Oaths{}:
      {==}
    case C.CL_A7_Ratification{}:
      {==}
    case C.CL_AM1_Religion{}:
      {==}
    case C.CL_AM1_ExpressionAssembly{}:
      {==}
    case C.CL_AM2_KeepBearArms{}:
      {==}
    case C.CL_AM3_Quartering{}:
      {==}
    case C.CL_AM4_UnreasonableSearch{}:
      {==}
    case C.CL_AM4_Warrants{}:
      {==}
    case C.CL_AM5_GrandJury{}:
      {==}
    case C.CL_AM5_DoubleJeopardy{}:
      {==}
    case C.CL_AM5_DueProcess{}:
      {==}
    case C.CL_AM5_Takings{}:
      {==}
    case C.CL_AM6_SpeedyImpartialTrial{}:
      {==}
    case C.CL_AM6_Counsel{}:
      {==}
    case C.CL_AM7_CivilJury{}:
      {==}
    case C.CL_AM7_Reexamination{}:
      {==}
    case C.CL_AM8_ExcessiveBailFines{}:
      {==}
    case C.CL_AM8_CruelUnusual{}:
      {==}
    case C.CL_AM9_RetainedRights{}:
      {==}
    case C.CL_AM10_ReservedPowers{}:
      {==}
    case C.CL_AM11_SovereignImmunity{}:
      {==}
    case C.CL_AM13S2_Enforcement{}:
      {==}
    case C.CL_AM14S1_Citizenship{}:
      {==}
    case C.CL_AM14S1_DueProcessEqualProtection{}:
      {==}
    case C.CL_AM14S1_PrivilegesImmunities{}:
      {==}
    case C.CL_AM14S3_DisabilityRemoved{}:
      {==}
    case C.CL_AM14S4_PublicDebt{}:
      {==}
    case C.CL_AM14S5_Enforcement{}:
      {==}
    case C.CL_AM15S1_VoteRace{}:
      {==}
    case C.CL_AM15S2_Enforcement{}:
      {==}
    case C.CL_AM19_VoteSex{}:
      {==}
    case C.CL_AM20S5_EffectiveDate{}:
      {==}
    case C.CL_AM20S6_RatificationDeadline{}:
      {==}
    case C.CL_AM21S2_Transportation{}:
      {==}
    case C.CL_AM21S3_RatificationDeadline{}:
      {==}
    case C.CL_AM23S1_Electors{}:
      {==}
    case C.CL_AM23S2_Enforcement{}:
      {==}
    case C.CL_AM24S1_PollTax{}:
      {==}
    case C.CL_AM24S2_Enforcement{}:
      {==}
    case C.CL_AM26S2_Enforcement{}:
      {==}
    case C.CL_AM27_CompensationTiming{}:
      {==}
    case C.CL_A1S9_MigrationRestriction{}:
      {==}

def Laws.preamble_purpose_affirmed_pass():
  {==}

def Laws.preamble_purpose_denied_fail():
  {==}

def Laws.a1s2_qualifications_pass():
  {==}

def Laws.a1s2_qualifications_fail():
  {==}

def Laws.a1s2_impeachment_power_exercised():
  {==}

def Laws.a1s2_impeachment_power_idle():
  {==}

def Laws.a1s2_apportionment_cap_pass():
  {==}

def Laws.a1s2_apportionment_cap_fail():
  {==}

def Laws.a1s3_qualifications_pass():
  {==}

def Laws.a1s3_qualifications_fail():
  {==}

def Laws.a1s3_senate_trial_convicts():
  {==}

def Laws.a1s3_senate_trial_acquits():
  {==}

def Laws.a1s3_vp_tiebreak_tie():
  {==}

def Laws.a1s3_vp_tiebreak_no_tie():
  {==}

def Laws.a1s4_election_regulation_state():
  {==}

def Laws.a1s4_election_regulation_congress():
  {==}

def Laws.a1s4_election_regulation_none():
  {==}

def Laws.a1s4_annual_assembly_met():
  {==}

def Laws.a1s4_annual_assembly_missed():
  {==}

def Laws.a1s7_presentment_signed():
  {==}

def Laws.a1s7_presentment_pocket_veto():
  {==}

def Laws.a1s7_revenue_origination_house():
  {==}

def Laws.a1s7_revenue_origination_senate():
  {==}

def Laws.a1s7_revenue_origination_nonrevenue():
  {==}

def Laws.a2s1_vesting_held():
  {==}

def Laws.a2s1_vesting_vacant():
  {==}

def Laws.a2s1_term_four_years():
  {==}

def Laws.a2s1_term_five_years():
  {==}

def Laws.a2s1_qualifications_pass():
  {==}

def Laws.a2s1_qualifications_fail():
  {==}

def Laws.a2s1_natural_born_satisfied():
  {==}

def Laws.a2s1_natural_born_unsatisfied():
  {==}

def Laws.a2s1_natural_born_wrong_term():
  {==}

def Laws.a2s1_electors_match():
  {==}

def Laws.a2s1_electors_mismatch():
  {==}

def Laws.a3s2_treason_evidence_witnesses():
  {==}

def Laws.a3s2_treason_evidence_none():
  {==}

def Laws.a3s2_jury_trial_sound():
  {==}

def Laws.a3s2_jury_trial_wrong_term():
  {==}

def Laws.a5_congress_proposal_pass():
  {==}

def Laws.a5_congress_proposal_fail():
  {==}

def Laws.a5_convention_application_pass():
  {==}

def Laws.a5_convention_application_fail():
  {==}

def Laws.a5_ratification_pass():
  {==}

def Laws.a5_ratification_fail():
  {==}

def Laws.am12_electoral_majority_pass():
  {==}

def Laws.am12_electoral_majority_fail():
  {==}

def Laws.am12_distinct_ballots_cast():
  {==}

def Laws.am12_distinct_ballots_missing():
  {==}

def Laws.am13s1_abolition_free():
  {==}

def Laws.am13s1_abolition_servitude():
  {==}

def Laws.am13s1_abolition_punishment():
  {==}

def Laws.am14s2_apportionment_basis_whole():
  {==}

def Laws.am14s2_apportionment_basis_partial():
  {==}

def Laws.am14s2_reduction_applies():
  {==}

def Laws.am14s2_reduction_excepted():
  {==}

def Laws.am16_income_tax_applies():
  {==}

def Laws.am16_income_tax_not_income():
  {==}

def Laws.am17_direct_election_by_people():
  {==}

def Laws.am17_direct_election_not():
  {==}

def Laws.am17_vacancy_appointment_valid():
  {==}

def Laws.am17_vacancy_appointment_no_power():
  {==}

def Laws.am18s1_prohibition_compliant():
  {==}

def Laws.am18s1_prohibition_violated():
  {==}

def Laws.am18s2_concurrent_power_asserted():
  {==}

def Laws.am18s2_concurrent_power_idle():
  {==}

def Laws.am18s3_effective_date_reached():
  {==}

def Laws.am18s3_effective_date_pending():
  {==}

def Laws.clause_am18s1_not_in_force():
  {==}

def Laws.clause_am18s2_not_in_force():
  {==}

def Laws.clause_am18s3_not_in_force():
  {==}

def Laws.am20s1_term_commencement_noon():
  {==}

def Laws.am20s1_term_commencement_missed():
  {==}

def Laws.am20s2_congress_assembly_jan3():
  {==}

def Laws.am20s2_congress_assembly_missed():
  {==}

def Laws.am20s3_president_elect_died():
  {==}

def Laws.am20s3_president_elect_living():
  {==}

def Laws.am20s4_succession_statute_provided():
  {==}

def Laws.am20s4_succession_statute_absent():
  {==}

def Laws.am21s1_repeal_effective():
  {==}

def Laws.clause_am21s1_in_force():
  {==}

def Laws.am22s1_two_terms_allowed():
  {==}

def Laws.am22s1_third_term_forbidden():
  {==}

def Laws.am22s2_prior_service_reduces():
  {==}

def Laws.am22s2_single_term_after_service():
  {==}

def Laws.am25s1_succession_vacancy():
  {==}

def Laws.am25s1_succession_occupied():
  {==}

def Laws.am25s2_vp_confirmation_pass():
  {==}

def Laws.am25s2_vp_confirmation_fail():
  {==}

def Laws.am25s3_voluntary_transfer_declared():
  {==}

def Laws.am25s3_voluntary_transfer_wrong_term():
  {==}

def Laws.am25s4_congress_decision_pass():
  {==}

def Laws.am25s4_congress_decision_fail():
  {==}

def Laws.am26s1_vote_age_18():
  {==}

def Laws.am26s1_vote_age_17():
  {==}


def Laws.interp_lookup_hit():
  {==}

def Laws.interp_lookup_miss_is_unknown():
  {==}

def Laws.interp_resolved_false_is_not_unknown():
  {==}

def Laws.interp_extend_first_wins():
  {==}

def Laws.interp_extend_leaves_others_undisturbed():
  {==}

def Laws.interp_extend_visible():
  {==}

def Laws.eval_natural_born_true_env():
  {==}

def Laws.eval_natural_born_false_env_flips():
  {==}

def Laws.eval_natural_born_absent_is_unknown():
  {==}

def Laws.eval_natural_born_wrong_term_fails():
  {==}

def Laws.eval_natural_born_coherent_with_direct_rule():
  {==}

def Laws.eval_jury_trial_env_all_met():
  {==}

def Laws.eval_jury_trial_env_speedy_denied_flips():
  {==}

def Laws.eval_jury_trial_env_missing_term_unknown():
  {==}

def Laws.eval_prohibition_env_applies():
  {==}

def Laws.eval_prohibition_env_term_narrow():
  {==}

def Laws.eval_transfer_env_unable():
  {==}

def Laws.eval_transfer_env_able_flips():
  {==}

def Laws.eval_clause_dispatcher_natural_born():
  {==}

def Laws.eval_clause_dispatcher_jury_trial():
  {==}

def Laws.eval_clause_term_free_env_inert():
  {==}

def Laws.eval_clause_term_free_env_inert_other_env():
  {==}

def Laws.impeachment_66_of_100_fails():
  {==}

def Laws.denominator_present_selects_present():
  {==}

def Laws.denominator_membership_selects_membership():
  {==}

def Laws.denominator_states_two_thirds_pass():
  {==}

def Laws.denominator_states_two_thirds_fail():
  {==}

def Laws.denominator_quorum_met():
  {==}

def Laws.denominator_quorum_not_met():
  {==}

def Laws.denominator_appointed_electors_whole_number():
  {==}

def Laws.impeachment_basis_is_present_members():
  {==}

def Laws.article_v_basis_is_membership():
  {==}

# Clause completion wave proofs

def Laws.a1s1_vesting_pass():
  {==}

def Laws.a1s1_vesting_fail():
  {==}

def Laws.a1s5_quorum_pass():
  {==}

def Laws.a1s5_quorum_fail():
  {==}

def Laws.a1s5_expulsion_pass():
  {==}

def Laws.a1s5_expulsion_fail():
  {==}

def Laws.a1s5_yeas_nays_pass():
  {==}

def Laws.a1s5_yeas_nays_fail():
  {==}

def Laws.a1s5_adjournment_pass():
  {==}

def Laws.a1s5_adjournment_fail():
  {==}

def Laws.a1s6_arrest_privilege_pass():
  {==}

def Laws.a1s6_arrest_privilege_fail():
  {==}

def Laws.a1s6_speech_debate_pass():
  {==}

def Laws.a1s6_speech_debate_fail():
  {==}

def Laws.a1s6_incompatible_pass():
  {==}

def Laws.a1s6_incompatible_fail():
  {==}

def Laws.a1s6_emolument_pass():
  {==}

def Laws.a1s6_emolument_fail():
  {==}

def Laws.a1s8_tax_pass():
  {==}

def Laws.a1s8_tax_fail():
  {==}

def Laws.a1s8_commerce_pass():
  {==}

def Laws.a1s8_commerce_fail():
  {==}

def Laws.a1s8_naturalization_bankruptcy_pass():
  {==}

def Laws.a1s8_naturalization_bankruptcy_fail():
  {==}

def Laws.a1s8_coin_weights_pass():
  {==}

def Laws.a1s8_coin_weights_fail():
  {==}

def Laws.a1s8_declare_war_pass():
  {==}

def Laws.a1s8_declare_war_fail():
  {==}

def Laws.a1s8_necessary_proper_pass():
  {==}

def Laws.a1s8_necessary_proper_fail():
  {==}

def Laws.a1s9_habeas_pass():
  {==}

def Laws.a1s9_habeas_fail():
  {==}

def Laws.a1s9_attainder_pass():
  {==}

def Laws.a1s9_attainder_fail():
  {==}

def Laws.a1s9_direct_tax_pass():
  {==}

def Laws.a1s9_direct_tax_fail():
  {==}

def Laws.a1s9_export_tax_pass():
  {==}

def Laws.a1s9_export_tax_fail():
  {==}

def Laws.a1s9_appropriations_pass():
  {==}

def Laws.a1s9_appropriations_fail():
  {==}

def Laws.a1s9_titles_pass():
  {==}

def Laws.a1s9_titles_fail():
  {==}

def Laws.a1s10_treaty_alliance_pass():
  {==}

def Laws.a1s10_treaty_alliance_fail():
  {==}

def Laws.a1s10_coin_tender_pass():
  {==}

def Laws.a1s10_coin_tender_fail():
  {==}

def Laws.a1s10_imposts_pass():
  {==}

def Laws.a1s10_imposts_fail():
  {==}

def Laws.a1s10_state_war_pass():
  {==}

def Laws.a1s10_state_war_fail():
  {==}

def Laws.a2s2_commander_in_chief_pass():
  {==}

def Laws.a2s2_commander_in_chief_fail():
  {==}

def Laws.a2s2_pardons_pass():
  {==}

def Laws.a2s2_pardons_fail():
  {==}

def Laws.a2s2_treaty_pass():
  {==}

def Laws.a2s2_treaty_fail():
  {==}

def Laws.a2s2_appointments_pass():
  {==}

def Laws.a2s2_appointments_fail():
  {==}

def Laws.a2s2_recess_pass():
  {==}

def Laws.a2s2_recess_fail():
  {==}

def Laws.a2s3_take_care_pass():
  {==}

def Laws.a2s3_take_care_fail():
  {==}

def Laws.a2s3_convene_pass():
  {==}

def Laws.a2s3_convene_fail():
  {==}

def Laws.a2s4_removal_pass():
  {==}

def Laws.a2s4_removal_fail():
  {==}

def Laws.a3s1_vesting_pass():
  {==}

def Laws.a3s1_vesting_fail():
  {==}

def Laws.a3s1_tenure_pass():
  {==}

def Laws.a3s1_tenure_fail():
  {==}

def Laws.a3s1_compensation_pass():
  {==}

def Laws.a3s1_compensation_fail():
  {==}

def Laws.a3s3_treason_definition_pass():
  {==}

def Laws.a3s3_treason_definition_fail():
  {==}

def Laws.a3s3_corruption_of_blood_pass():
  {==}

def Laws.a3s3_corruption_of_blood_fail():
  {==}

def Laws.a4s1_full_faith_credit_pass():
  {==}

def Laws.a4s1_full_faith_credit_fail():
  {==}

def Laws.a4s2_privileges_immunities_pass():
  {==}

def Laws.a4s2_privileges_immunities_fail():
  {==}

def Laws.a4s2_extradition_pass():
  {==}

def Laws.a4s2_extradition_fail():
  {==}

def Laws.a4s2_fugitive_labor_pass():
  {==}

def Laws.a4s2_fugitive_labor_fail():
  {==}

def Laws.a4s3_new_state_pass():
  {==}

def Laws.a4s3_new_state_fail():
  {==}

def Laws.a4s3_territory_pass():
  {==}

def Laws.a4s3_territory_fail():
  {==}

def Laws.a4s4_republican_form_pass():
  {==}

def Laws.a4s4_republican_form_fail():
  {==}

def Laws.a4s4_protection_pass():
  {==}

def Laws.a4s4_protection_fail():
  {==}

def Laws.a6_supremacy_pass():
  {==}

def Laws.a6_supremacy_fail():
  {==}

def Laws.a6_oaths_pass():
  {==}

def Laws.a6_oaths_fail():
  {==}

def Laws.a7_ratification_pass():
  {==}

def Laws.a7_ratification_fail():
  {==}

def Laws.am1_religion_pass():
  {==}

def Laws.am1_religion_fail():
  {==}

def Laws.am1_expression_pass():
  {==}

def Laws.am1_expression_fail():
  {==}

def Laws.am2_arms_pass():
  {==}

def Laws.am2_arms_fail():
  {==}

def Laws.am3_quartering_pass():
  {==}

def Laws.am3_quartering_fail():
  {==}

def Laws.am4_search_pass():
  {==}

def Laws.am4_search_fail():
  {==}

def Laws.am4_warrant_pass():
  {==}

def Laws.am4_warrant_fail():
  {==}

def Laws.am5_grand_jury_pass():
  {==}

def Laws.am5_grand_jury_fail():
  {==}

def Laws.am5_double_jeopardy_pass():
  {==}

def Laws.am5_double_jeopardy_fail():
  {==}

def Laws.am5_due_process_pass():
  {==}

def Laws.am5_due_process_fail():
  {==}

def Laws.am5_takings_pass():
  {==}

def Laws.am5_takings_fail():
  {==}

def Laws.am6_trial_pass():
  {==}

def Laws.am6_trial_fail():
  {==}

def Laws.am6_counsel_pass():
  {==}

def Laws.am6_counsel_fail():
  {==}

def Laws.am7_civil_jury_pass():
  {==}

def Laws.am7_civil_jury_fail():
  {==}

def Laws.am7_reexamination_pass():
  {==}

def Laws.am7_reexamination_fail():
  {==}

def Laws.am8_excessive_pass():
  {==}

def Laws.am8_excessive_fail():
  {==}

def Laws.am8_cruel_unusual_pass():
  {==}

def Laws.am8_cruel_unusual_fail():
  {==}

def Laws.am9_retained_pass():
  {==}

def Laws.am9_retained_fail():
  {==}

def Laws.am10_reserved_pass():
  {==}

def Laws.am10_reserved_fail():
  {==}

def Laws.am11_immunity_pass():
  {==}

def Laws.am11_immunity_fail():
  {==}

def Laws.am13s2_enforcement_pass():
  {==}

def Laws.am13s2_enforcement_fail():
  {==}

def Laws.am14s1_citizenship_pass():
  {==}

def Laws.am14s1_citizenship_fail():
  {==}

def Laws.am14s1_dp_ep_pass():
  {==}

def Laws.am14s1_dp_ep_fail():
  {==}

def Laws.am14s1_privileges_pass():
  {==}

def Laws.am14s1_privileges_fail():
  {==}

def Laws.am14s3_disability_removed_pass():
  {==}

def Laws.am14s3_disability_removed_fail():
  {==}

def Laws.am14s4_debt_pass():
  {==}

def Laws.am14s4_debt_fail():
  {==}

def Laws.am14s5_enforcement_pass():
  {==}

def Laws.am14s5_enforcement_fail():
  {==}

def Laws.am15s1_vote_pass():
  {==}

def Laws.am15s1_vote_fail():
  {==}

def Laws.am15s2_enforcement_pass():
  {==}

def Laws.am15s2_enforcement_fail():
  {==}

def Laws.am19_vote_pass():
  {==}

def Laws.am19_vote_fail():
  {==}

def Laws.am20s5_effective_pass():
  {==}

def Laws.am20s5_effective_fail():
  {==}

def Laws.am20s6_deadline_pass():
  {==}

def Laws.am20s6_deadline_fail():
  {==}

def Laws.am21s2_transportation_pass():
  {==}

def Laws.am21s2_transportation_fail():
  {==}

def Laws.am21s3_deadline_pass():
  {==}

def Laws.am21s3_deadline_fail():
  {==}

def Laws.am23s1_electors_pass():
  {==}

def Laws.am23s1_electors_fail():
  {==}

def Laws.am23s2_enforcement_pass():
  {==}

def Laws.am23s2_enforcement_fail():
  {==}

def Laws.am24s1_poll_tax_pass():
  {==}

def Laws.am24s1_poll_tax_fail():
  {==}

def Laws.am24s2_enforcement_pass():
  {==}

def Laws.am24s2_enforcement_fail():
  {==}

def Laws.am26s2_enforcement_pass():
  {==}

def Laws.am26s2_enforcement_fail():
  {==}

def Laws.am27_timing_pass():
  {==}

def Laws.am27_timing_fail():
  {==}

def Laws.temporal_a1s9_unexpired_1807():
  {==}

def Laws.temporal_a1s9_expired_1808():
  {==}

def Laws.temporal_a1s9_rule_coherent_1807():
  {==}

def Laws.temporal_a1s9_commenced_1807():
  {==}

def Laws.temporal_am18_commenced_1920():
  {==}

def Laws.temporal_am18_uncommenced_1919():
  {==}

def Laws.temporal_am18_unexpired_1933():
  {==}

def Laws.temporal_am18_expired_1934():
  {==}

def Laws.temporal_am18_window_1932():
  {==}

def Laws.temporal_am18_window_1919():
  {==}

def Laws.temporal_am18_window_1934():
  {==}

def Laws.temporal_am18_effective_never_1932():
  {==}

def Laws.temporal_ordinary_clause_commenced_1807():
  {==}

def Laws.temporal_ordinary_clause_unexpired_2026():
  {==}

def Laws.temporal_deadline_silent_am18():
  {==}

def Laws.temporal_deadline_silent_a5():
  {==}

def Laws.temporal_ratification_timely_7yr():
  {==}

def Laws.temporal_ratification_untimely_7yr():
  {==}

def Laws.temporal_ratification_no_deadline_always_timely():
  {==}

def Laws.temporal_succession_vacancy_1968():
  {==}

def Laws.temporal_succession_vacancy_1966():
  {==}

def Laws.temporal_acting_president_inability_1968():
  {==}

def Laws.temporal_acting_president_inability_1966():
  {==}

def Laws.temporal_term_jan20_1933():
  {==}

def Laws.temporal_term_jan20_1932():
  {==}

def Laws.temporal_a1s9_rule_active_1807():
  {==}

def Laws.temporal_a1s9_rule_expired_1808():
  {==}

def Laws.banzhaf3_a_swings_3():
  {==}

def Laws.banzhaf3_b_swings_1():
  {==}

def Laws.banzhaf3_c_swings_1():
  {==}
