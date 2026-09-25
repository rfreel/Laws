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
