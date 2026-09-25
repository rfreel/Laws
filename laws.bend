import Base

type SourceBlock is Data:
  Preamble{}
  A1S1{}
  A1S2{}
  A1S3{}
  A1S4{}
  A1S5{}
  A1S6{}
  A1S7{}
  A1S8{}
  A1S9{}
  A1S10{}
  A2S1{}
  A2S2{}
  A2S3{}
  A2S4{}
  A3S1{}
  A3S2{}
  A3S3{}
  A4S1{}
  A4S2{}
  A4S3{}
  A4S4{}
  A5{}
  A6{}
  A7{}
  AM1{}
  AM2{}
  AM3{}
  AM4{}
  AM5{}
  AM6{}
  AM7{}
  AM8{}
  AM9{}
  AM10{}
  AM11{}
  AM12{}
  AM13S1{}
  AM13S2{}
  AM14S1{}
  AM14S2{}
  AM14S3{}
  AM14S4{}
  AM14S5{}
  AM15S1{}
  AM15S2{}
  AM16{}
  AM17{}
  AM18S1{}
  AM18S2{}
  AM18S3{}
  AM19{}
  AM20S1{}
  AM20S2{}
  AM20S3{}
  AM20S4{}
  AM20S5{}
  AM20S6{}
  AM21S1{}
  AM21S2{}
  AM21S3{}
  AM22S1{}
  AM22S2{}
  AM23S1{}
  AM23S2{}
  AM24S1{}
  AM24S2{}
  AM25S1{}
  AM25S2{}
  AM25S3{}
  AM25S4{}
  AM26S1{}
  AM26S2{}
  AM27{}

type InterpretiveTerm is Data:
  GoodBehavior{}
  NaturalBornCitizen{}
  NecessaryAndProper{}
  GeneralWelfare{}
  CommonDefence{}
  Commerce{}
  PublicSafetyRequires{}
  HighCrimesAndMisdemeanors{}
  RepublicanForm{}
  DueProcess{}
  EqualProtection{}
  PrivilegesOrImmunities{}
  Unreasonable{}
  ProbableCause{}
  Excessive{}
  CruelAndUnusual{}
  EstablishmentOfReligion{}
  FreeExercise{}
  FreedomOfSpeech{}
  FreedomOfPress{}
  PeaceablyAssemble{}
  PetitionRedress{}
  WellRegulatedMilitia{}
  KeepAndBearArms{}
  InfamousCrime{}
  SameOffence{}
  PublicUse{}
  JustCompensation{}
  Speedy{}
  Impartial{}
  CommonLawSuit{}
  RetainedRight{}
  DelegatedPower{}
  AppropriateLegislation{}
  InsurrectionOrRebellion{}
  AidOrComfortEnemies{}
  ValidPublicDebt{}
  UnableToDischarge{}
  IntoxicatingLiquor{}
  BeveragePurpose{}
  ExtraordinaryOccasion{}
  OfficeOfTrustOrProfit{}
  OfficeOfHonorTrustOrProfit{}
  ImminentDangerNoDelay{}
  ActualInvasion{}

type Interpretation is Data:
  Interpretation{term: InterpretiveTerm, value: Bool}

type RelationKind is Data:
  PartialRestriction{}
  PartialSupersession{}
  Repeal{}

type AmendmentRelation is Data:
  R_AM11_A3S2{}
  R_AM12_A2S1{}
  R_AM13S1_A4S2{}
  R_AM14S2_A1S2{}
  R_AM16_A1S9{}
  R_AM17_A1S3{}
  R_AM20S2_A1S4{}
  R_AM20S3_AM12{}
  R_AM21S1_AM18S1{}
  R_AM21S1_AM18S2{}
  R_AM21S1_AM18S3{}
  R_AM25S1_A2S1{}
  R_AM25S3_A2S1{}
  R_AM25S4_A2S1{}
  R_AM26S1_AM14S2{}

def relation_newer(r: AmendmentRelation) -> SourceBlock:
  match r:
    case R_AM11_A3S2{}:
      AM11{}
    case R_AM12_A2S1{}:
      AM12{}
    case R_AM13S1_A4S2{}:
      AM13S1{}
    case R_AM14S2_A1S2{}:
      AM14S2{}
    case R_AM16_A1S9{}:
      AM16{}
    case R_AM17_A1S3{}:
      AM17{}
    case R_AM20S2_A1S4{}:
      AM20S2{}
    case R_AM20S3_AM12{}:
      AM20S3{}
    case R_AM21S1_AM18S1{}:
      AM21S1{}
    case R_AM21S1_AM18S2{}:
      AM21S1{}
    case R_AM21S1_AM18S3{}:
      AM21S1{}
    case R_AM25S1_A2S1{}:
      AM25S1{}
    case R_AM25S3_A2S1{}:
      AM25S3{}
    case R_AM25S4_A2S1{}:
      AM25S4{}
    case R_AM26S1_AM14S2{}:
      AM26S1{}

def relation_older(r: AmendmentRelation) -> SourceBlock:
  match r:
    case R_AM11_A3S2{}:
      A3S2{}
    case R_AM12_A2S1{}:
      A2S1{}
    case R_AM13S1_A4S2{}:
      A4S2{}
    case R_AM14S2_A1S2{}:
      A1S2{}
    case R_AM16_A1S9{}:
      A1S9{}
    case R_AM17_A1S3{}:
      A1S3{}
    case R_AM20S2_A1S4{}:
      A1S4{}
    case R_AM20S3_AM12{}:
      AM12{}
    case R_AM21S1_AM18S1{}:
      AM18S1{}
    case R_AM21S1_AM18S2{}:
      AM18S2{}
    case R_AM21S1_AM18S3{}:
      AM18S3{}
    case R_AM25S1_A2S1{}:
      A2S1{}
    case R_AM25S3_A2S1{}:
      A2S1{}
    case R_AM25S4_A2S1{}:
      A2S1{}
    case R_AM26S1_AM14S2{}:
      AM14S2{}

def relation_kind(r: AmendmentRelation) -> RelationKind:
  match r:
    case R_AM11_A3S2{}:
      PartialRestriction{}
    case R_AM12_A2S1{}:
      PartialSupersession{}
    case R_AM13S1_A4S2{}:
      PartialSupersession{}
    case R_AM14S2_A1S2{}:
      PartialSupersession{}
    case R_AM16_A1S9{}:
      PartialSupersession{}
    case R_AM17_A1S3{}:
      PartialSupersession{}
    case R_AM20S2_A1S4{}:
      PartialSupersession{}
    case R_AM20S3_AM12{}:
      PartialSupersession{}
    case R_AM21S1_AM18S1{}:
      Repeal{}
    case R_AM21S1_AM18S2{}:
      Repeal{}
    case R_AM21S1_AM18S3{}:
      Repeal{}
    case R_AM25S1_A2S1{}:
      PartialSupersession{}
    case R_AM25S3_A2S1{}:
      PartialSupersession{}
    case R_AM25S4_A2S1{}:
      PartialSupersession{}
    case R_AM26S1_AM14S2{}:
      PartialSupersession{}

def source_count() -> Nat:
  74n

def source_index(block: SourceBlock) -> Nat:
  match block:
    case Preamble{}:
      0n
    case A1S1{}:
      1n
    case A1S2{}:
      2n
    case A1S3{}:
      3n
    case A1S4{}:
      4n
    case A1S5{}:
      5n
    case A1S6{}:
      6n
    case A1S7{}:
      7n
    case A1S8{}:
      8n
    case A1S9{}:
      9n
    case A1S10{}:
      10n
    case A2S1{}:
      11n
    case A2S2{}:
      12n
    case A2S3{}:
      13n
    case A2S4{}:
      14n
    case A3S1{}:
      15n
    case A3S2{}:
      16n
    case A3S3{}:
      17n
    case A4S1{}:
      18n
    case A4S2{}:
      19n
    case A4S3{}:
      20n
    case A4S4{}:
      21n
    case A5{}:
      22n
    case A6{}:
      23n
    case A7{}:
      24n
    case AM1{}:
      25n
    case AM2{}:
      26n
    case AM3{}:
      27n
    case AM4{}:
      28n
    case AM5{}:
      29n
    case AM6{}:
      30n
    case AM7{}:
      31n
    case AM8{}:
      32n
    case AM9{}:
      33n
    case AM10{}:
      34n
    case AM11{}:
      35n
    case AM12{}:
      36n
    case AM13S1{}:
      37n
    case AM13S2{}:
      38n
    case AM14S1{}:
      39n
    case AM14S2{}:
      40n
    case AM14S3{}:
      41n
    case AM14S4{}:
      42n
    case AM14S5{}:
      43n
    case AM15S1{}:
      44n
    case AM15S2{}:
      45n
    case AM16{}:
      46n
    case AM17{}:
      47n
    case AM18S1{}:
      48n
    case AM18S2{}:
      49n
    case AM18S3{}:
      50n
    case AM19{}:
      51n
    case AM20S1{}:
      52n
    case AM20S2{}:
      53n
    case AM20S3{}:
      54n
    case AM20S4{}:
      55n
    case AM20S5{}:
      56n
    case AM20S6{}:
      57n
    case AM21S1{}:
      58n
    case AM21S2{}:
      59n
    case AM21S3{}:
      60n
    case AM22S1{}:
      61n
    case AM22S2{}:
      62n
    case AM23S1{}:
      63n
    case AM23S2{}:
      64n
    case AM24S1{}:
      65n
    case AM24S2{}:
      66n
    case AM25S1{}:
      67n
    case AM25S2{}:
      68n
    case AM25S3{}:
      69n
    case AM25S4{}:
      70n
    case AM26S1{}:
      71n
    case AM26S2{}:
      72n
    case AM27{}:
      73n

def source_index_in_range(block: SourceBlock) -> Bool:
  Nat.is_lt(source_index(block), source_count())

def majority(yes: Nat, total: Nat) -> Bool:
  Nat.is_lt(total, Nat.mul(2n, yes))

def two_thirds(yes: Nat, total: Nat) -> Bool:
  Nat.is_le(Nat.mul(2n, total), Nat.mul(3n, yes))

def three_fourths(yes: Nat, total: Nat) -> Bool:
  Nat.is_le(Nat.mul(3n, total), Nat.mul(4n, yes))

def representative_eligible(age: Nat, citizen_years: Nat, inhabitant: Bool) -> Bool:
  Bool.and(Nat.is_le(25n, age), Bool.and(Nat.is_le(7n, citizen_years), inhabitant))

def senator_eligible(age: Nat, citizen_years: Nat, inhabitant: Bool) -> Bool:
  Bool.and(Nat.is_le(30n, age), Bool.and(Nat.is_le(9n, citizen_years), inhabitant))

def president_eligible(age: Nat, resident_years: Nat, natural_born: Bool) -> Bool:
  Bool.and(Nat.is_le(35n, age), Bool.and(Nat.is_le(14n, resident_years), natural_born))

def impeachment_conviction(senate_yes: Nat, senate_present: Nat) -> Bool:
  two_thirds(senate_yes, senate_present)

def treaty_approved(senate_yes: Nat, senate_present: Nat) -> Bool:
  two_thirds(senate_yes, senate_present)

def article_v_congress_proposal(house_yes: Nat, house_basis: Nat, senate_yes: Nat, senate_basis: Nat) -> Bool:
  Bool.and(two_thirds(house_yes, house_basis), two_thirds(senate_yes, senate_basis))

def article_v_state_application(applications: Nat, state_count: Nat) -> Bool:
  two_thirds(applications, state_count)

def article_v_ratification(ratifying_states: Nat, state_count: Nat) -> Bool:
  three_fourths(ratifying_states, state_count)

def bill_becomes_law(
  passed_house: Bool,
  passed_senate: Bool,
  presented: Bool,
  signed: Bool,
  vetoed: Bool,
  house_override_yes: Nat,
  house_override_basis: Nat,
  senate_override_yes: Nat,
  senate_override_basis: Nat,
  ten_days_elapsed_excluding_sundays: Bool,
  adjournment_prevents_return: Bool
) -> Bool:
  base = Bool.and(passed_house, Bool.and(passed_senate, presented))
  override_path = Bool.and(vetoed, Bool.and(two_thirds(house_override_yes, house_override_basis), two_thirds(senate_override_yes, senate_override_basis)))
  lapse_path = Bool.and(ten_days_elapsed_excluding_sundays, Bool.not(adjournment_prevents_return))
  Bool.and(base, Bool.or(signed, Bool.or(override_path, lapse_path)))

def treason_conviction_evidence(two_witnesses_same_overt_act: Bool, confession_open_court: Bool) -> Bool:
  Bool.or(two_witnesses_same_overt_act, confession_open_court)

def presidential_election_limit(elected_count: Nat, served_other_term_more_than_two_years: Bool) -> Bool:
  match served_other_term_more_than_two_years:
    case False{}:
      Nat.is_le(elected_count, 2n)
    case True{}:
      Nat.is_le(elected_count, 1n)

def age_vote_protection(age: Nat) -> Bool:
  Nat.is_le(18n, age)

def amendment_18_repealed(block: SourceBlock) -> Bool:
  match block:
    case AM18S1{}:
      True{}
    case AM18S2{}:
      True{}
    case AM18S3{}:
      True{}
    case _:
      False{}

# ---------------------------------------------------------------------------
# Clause layer (TASKS.md remaining item 1).
#
# Each `Clause` is one operative clause of the Constitution, keyed to its
# `SourceBlock` by `clause_source`. Every clause has a Condition -> Effect
# rule: a def `rule_<name>` whose Bool result is True exactly when the
# clause's legal effect obtains in the given situation (eligibility holds,
# power is validly exercised, procedure succeeds, prohibition is respected,
# succession occurs). Conditions may reuse the threshold and qualification
# functions above and may take `InterpretiveTerm` values as opaque inputs;
# the `interpretive_term_is_*` helpers only check WHICH term was supplied,
# never what the term means. Repealed text is kept: the AM18 clauses stay
# in the type and `clause_in_force` marks them not in force.
#
# Extension pattern for the remaining blocks: add a `CL_<Block>_<Name>{}`
# constructor, one case in each of `clause_source` / `clause_index` /
# `clause_effect`, a `rule_<name>` def, and pass/fail laws in LAWS.bend
# with `def Laws.<name>` proofs in PROOF.bend.
# ---------------------------------------------------------------------------

type ClauseEffect is Data:
  OfficeEligibility{}
  LegislativeProcedure{}
  ExecutiveSuccession{}
  ElectoralOutcome{}
  JudicialRule{}
  RightsProtection{}
  FederalPower{}
  RepealedProvision{}
  Declaratory{}
type Clause is Data:
  CL_Preamble_Purpose{}
  CL_A1S2_Qualifications{}
  CL_A1S2_ImpeachmentPower{}
  CL_A1S2_ApportionmentCap{}
  CL_A1S3_Qualifications{}
  CL_A1S3_SenateTrial{}
  CL_A1S3_VPTiebreak{}
  CL_A1S4_ElectionRegulation{}
  CL_A1S4_AnnualAssembly{}
  CL_A1S7_Presentment{}
  CL_A1S7_RevenueOrigination{}
  CL_A2S1_Vesting{}
  CL_A2S1_Term{}
  CL_A2S1_Qualifications{}
  CL_A2S1_NaturalBorn{}
  CL_A2S1_Electors{}
  CL_A3S2_TreasonEvidence{}
  CL_A3S2_JuryTrial{}
  CL_A5_CongressProposal{}
  CL_A5_ConventionApplication{}
  CL_A5_Ratification{}
  CL_AM12_ElectoralMajority{}
  CL_AM12_DistinctBallots{}
  CL_AM13S1_Abolition{}
  CL_AM14S2_ApportionmentBasis{}
  CL_AM14S2_Reduction{}
  CL_AM16_IncomeTax{}
  CL_AM17_DirectElection{}
  CL_AM17_VacancyAppointment{}
  CL_AM18S1_Prohibition{}
  CL_AM18S2_ConcurrentPower{}
  CL_AM18S3_EffectiveDate{}
  CL_AM20S1_TermCommencement{}
  CL_AM20S2_CongressAssembly{}
  CL_AM20S3_PresidentElectDeath{}
  CL_AM20S4_SuccessionStatute{}
  CL_AM21S1_Repeal{}
  CL_AM22S1_TermLimit{}
  CL_AM22S2_PriorServiceLimit{}
  CL_AM25S1_Succession{}
  CL_AM25S2_VPConfirmation{}
  CL_AM25S3_VoluntaryTransfer{}
  CL_AM25S4_CongressDecision{}
  CL_AM26S1_VoteAge{}

def clause_source(c: Clause) -> SourceBlock:
  match c:
    case CL_Preamble_Purpose{}:
      Preamble{}
    case CL_A1S2_Qualifications{}:
      A1S2{}
    case CL_A1S2_ImpeachmentPower{}:
      A1S2{}
    case CL_A1S2_ApportionmentCap{}:
      A1S2{}
    case CL_A1S3_Qualifications{}:
      A1S3{}
    case CL_A1S3_SenateTrial{}:
      A1S3{}
    case CL_A1S3_VPTiebreak{}:
      A1S3{}
    case CL_A1S4_ElectionRegulation{}:
      A1S4{}
    case CL_A1S4_AnnualAssembly{}:
      A1S4{}
    case CL_A1S7_Presentment{}:
      A1S7{}
    case CL_A1S7_RevenueOrigination{}:
      A1S7{}
    case CL_A2S1_Vesting{}:
      A2S1{}
    case CL_A2S1_Term{}:
      A2S1{}
    case CL_A2S1_Qualifications{}:
      A2S1{}
    case CL_A2S1_NaturalBorn{}:
      A2S1{}
    case CL_A2S1_Electors{}:
      A2S1{}
    case CL_A3S2_TreasonEvidence{}:
      A3S2{}
    case CL_A3S2_JuryTrial{}:
      A3S2{}
    case CL_A5_CongressProposal{}:
      A5{}
    case CL_A5_ConventionApplication{}:
      A5{}
    case CL_A5_Ratification{}:
      A5{}
    case CL_AM12_ElectoralMajority{}:
      AM12{}
    case CL_AM12_DistinctBallots{}:
      AM12{}
    case CL_AM13S1_Abolition{}:
      AM13S1{}
    case CL_AM14S2_ApportionmentBasis{}:
      AM14S2{}
    case CL_AM14S2_Reduction{}:
      AM14S2{}
    case CL_AM16_IncomeTax{}:
      AM16{}
    case CL_AM17_DirectElection{}:
      AM17{}
    case CL_AM17_VacancyAppointment{}:
      AM17{}
    case CL_AM18S1_Prohibition{}:
      AM18S1{}
    case CL_AM18S2_ConcurrentPower{}:
      AM18S2{}
    case CL_AM18S3_EffectiveDate{}:
      AM18S3{}
    case CL_AM20S1_TermCommencement{}:
      AM20S1{}
    case CL_AM20S2_CongressAssembly{}:
      AM20S2{}
    case CL_AM20S3_PresidentElectDeath{}:
      AM20S3{}
    case CL_AM20S4_SuccessionStatute{}:
      AM20S4{}
    case CL_AM21S1_Repeal{}:
      AM21S1{}
    case CL_AM22S1_TermLimit{}:
      AM22S1{}
    case CL_AM22S2_PriorServiceLimit{}:
      AM22S2{}
    case CL_AM25S1_Succession{}:
      AM25S1{}
    case CL_AM25S2_VPConfirmation{}:
      AM25S2{}
    case CL_AM25S3_VoluntaryTransfer{}:
      AM25S3{}
    case CL_AM25S4_CongressDecision{}:
      AM25S4{}
    case CL_AM26S1_VoteAge{}:
      AM26S1{}

def clause_index(c: Clause) -> Nat:
  match c:
    case CL_Preamble_Purpose{}:
      0n
    case CL_A1S2_Qualifications{}:
      1n
    case CL_A1S2_ImpeachmentPower{}:
      2n
    case CL_A1S2_ApportionmentCap{}:
      3n
    case CL_A1S3_Qualifications{}:
      4n
    case CL_A1S3_SenateTrial{}:
      5n
    case CL_A1S3_VPTiebreak{}:
      6n
    case CL_A1S4_ElectionRegulation{}:
      7n
    case CL_A1S4_AnnualAssembly{}:
      8n
    case CL_A1S7_Presentment{}:
      9n
    case CL_A1S7_RevenueOrigination{}:
      10n
    case CL_A2S1_Vesting{}:
      11n
    case CL_A2S1_Term{}:
      12n
    case CL_A2S1_Qualifications{}:
      13n
    case CL_A2S1_NaturalBorn{}:
      14n
    case CL_A2S1_Electors{}:
      15n
    case CL_A3S2_TreasonEvidence{}:
      16n
    case CL_A3S2_JuryTrial{}:
      17n
    case CL_A5_CongressProposal{}:
      18n
    case CL_A5_ConventionApplication{}:
      19n
    case CL_A5_Ratification{}:
      20n
    case CL_AM12_ElectoralMajority{}:
      21n
    case CL_AM12_DistinctBallots{}:
      22n
    case CL_AM13S1_Abolition{}:
      23n
    case CL_AM14S2_ApportionmentBasis{}:
      24n
    case CL_AM14S2_Reduction{}:
      25n
    case CL_AM16_IncomeTax{}:
      26n
    case CL_AM17_DirectElection{}:
      27n
    case CL_AM17_VacancyAppointment{}:
      28n
    case CL_AM18S1_Prohibition{}:
      29n
    case CL_AM18S2_ConcurrentPower{}:
      30n
    case CL_AM18S3_EffectiveDate{}:
      31n
    case CL_AM20S1_TermCommencement{}:
      32n
    case CL_AM20S2_CongressAssembly{}:
      33n
    case CL_AM20S3_PresidentElectDeath{}:
      34n
    case CL_AM20S4_SuccessionStatute{}:
      35n
    case CL_AM21S1_Repeal{}:
      36n
    case CL_AM22S1_TermLimit{}:
      37n
    case CL_AM22S2_PriorServiceLimit{}:
      38n
    case CL_AM25S1_Succession{}:
      39n
    case CL_AM25S2_VPConfirmation{}:
      40n
    case CL_AM25S3_VoluntaryTransfer{}:
      41n
    case CL_AM25S4_CongressDecision{}:
      42n
    case CL_AM26S1_VoteAge{}:
      43n

def clause_effect(c: Clause) -> ClauseEffect:
  match c:
    case CL_Preamble_Purpose{}:
      Declaratory{}
    case CL_A1S2_Qualifications{}:
      OfficeEligibility{}
    case CL_A1S2_ImpeachmentPower{}:
      LegislativeProcedure{}
    case CL_A1S2_ApportionmentCap{}:
      LegislativeProcedure{}
    case CL_A1S3_Qualifications{}:
      OfficeEligibility{}
    case CL_A1S3_SenateTrial{}:
      LegislativeProcedure{}
    case CL_A1S3_VPTiebreak{}:
      LegislativeProcedure{}
    case CL_A1S4_ElectionRegulation{}:
      LegislativeProcedure{}
    case CL_A1S4_AnnualAssembly{}:
      LegislativeProcedure{}
    case CL_A1S7_Presentment{}:
      LegislativeProcedure{}
    case CL_A1S7_RevenueOrigination{}:
      LegislativeProcedure{}
    case CL_A2S1_Vesting{}:
      ExecutiveSuccession{}
    case CL_A2S1_Term{}:
      ExecutiveSuccession{}
    case CL_A2S1_Qualifications{}:
      OfficeEligibility{}
    case CL_A2S1_NaturalBorn{}:
      OfficeEligibility{}
    case CL_A2S1_Electors{}:
      ElectoralOutcome{}
    case CL_A3S2_TreasonEvidence{}:
      JudicialRule{}
    case CL_A3S2_JuryTrial{}:
      JudicialRule{}
    case CL_A5_CongressProposal{}:
      LegislativeProcedure{}
    case CL_A5_ConventionApplication{}:
      LegislativeProcedure{}
    case CL_A5_Ratification{}:
      LegislativeProcedure{}
    case CL_AM12_ElectoralMajority{}:
      ElectoralOutcome{}
    case CL_AM12_DistinctBallots{}:
      ElectoralOutcome{}
    case CL_AM13S1_Abolition{}:
      RightsProtection{}
    case CL_AM14S2_ApportionmentBasis{}:
      RightsProtection{}
    case CL_AM14S2_Reduction{}:
      RightsProtection{}
    case CL_AM16_IncomeTax{}:
      FederalPower{}
    case CL_AM17_DirectElection{}:
      FederalPower{}
    case CL_AM17_VacancyAppointment{}:
      FederalPower{}
    case CL_AM18S1_Prohibition{}:
      RepealedProvision{}
    case CL_AM18S2_ConcurrentPower{}:
      RepealedProvision{}
    case CL_AM18S3_EffectiveDate{}:
      RepealedProvision{}
    case CL_AM20S1_TermCommencement{}:
      ExecutiveSuccession{}
    case CL_AM20S2_CongressAssembly{}:
      ExecutiveSuccession{}
    case CL_AM20S3_PresidentElectDeath{}:
      ExecutiveSuccession{}
    case CL_AM20S4_SuccessionStatute{}:
      ExecutiveSuccession{}
    case CL_AM21S1_Repeal{}:
      LegislativeProcedure{}
    case CL_AM22S1_TermLimit{}:
      ElectoralOutcome{}
    case CL_AM22S2_PriorServiceLimit{}:
      ElectoralOutcome{}
    case CL_AM25S1_Succession{}:
      ExecutiveSuccession{}
    case CL_AM25S2_VPConfirmation{}:
      ExecutiveSuccession{}
    case CL_AM25S3_VoluntaryTransfer{}:
      ExecutiveSuccession{}
    case CL_AM25S4_CongressDecision{}:
      ExecutiveSuccession{}
    case CL_AM26S1_VoteAge{}:
      RightsProtection{}

def clause_count() -> Nat:
  44n

def clause_index_in_range(c: Clause) -> Bool:
  Nat.is_lt(clause_index(c), clause_count())

# AM18 stays in the type (never erase superseded text); it is marked not in
# force because AM21S1 repeals it. Every other clause is in force.
def clause_in_force(c: Clause) -> Bool:
  match c:
    case CL_AM18S1_Prohibition{}:
      False{}
    case CL_AM18S2_ConcurrentPower{}:
      False{}
    case CL_AM18S3_EffectiveDate{}:
      False{}
    case _:
      True{}

# Open-term guards: these only check which InterpretiveTerm value the caller
# supplied. They assign no meaning to the term itself; the separate Bool
# input records whether the (external) legal test is satisfied.
def interpretive_term_is_natural_born(t: InterpretiveTerm) -> Bool:
  match t:
    case NaturalBornCitizen{}:
      True{}
    case _:
      False{}

def interpretive_term_is_speedy(t: InterpretiveTerm) -> Bool:
  match t:
    case Speedy{}:
      True{}
    case _:
      False{}

def interpretive_term_is_impartial(t: InterpretiveTerm) -> Bool:
  match t:
    case Impartial{}:
      True{}
    case _:
      False{}

def interpretive_term_is_intoxicating_liquor(t: InterpretiveTerm) -> Bool:
  match t:
    case IntoxicatingLiquor{}:
      True{}
    case _:
      False{}

def interpretive_term_is_unable_to_discharge(t: InterpretiveTerm) -> Bool:
  match t:
    case UnableToDischarge{}:
      True{}
    case _:
      False{}
# --- Condition -> Effect rules, one per Clause (same order as the type) ---

# Preamble: ordains and establishes the Constitution for the stated purposes.
def rule_preamble_purpose(purposes_affirmed: Bool) -> Bool:
  purposes_affirmed

# A1S2: House qualifications (25 years, 7 years a citizen, inhabitant).
def rule_a1s2_qualifications(age: Nat, citizen_years: Nat, inhabitant: Bool) -> Bool:
  representative_eligible(age, citizen_years, inhabitant)

# A1S2: the House has the sole power of impeachment.
def rule_a1s2_impeachment_power(charges_brought: Bool) -> Bool:
  charges_brought

# A1S2: representatives shall not exceed one for every thirty thousand.
def rule_a1s2_apportionment_cap(reps: Nat, state_pop: Nat) -> Bool:
  Nat.is_le(Nat.mul(30000n, reps), state_pop)

# A1S3: Senate qualifications (30 years, 9 years a citizen, inhabitant).
def rule_a1s3_qualifications(age: Nat, citizen_years: Nat, inhabitant: Bool) -> Bool:
  senator_eligible(age, citizen_years, inhabitant)

# A1S3: the Senate tries impeachments; conviction needs two thirds present.
def rule_a1s3_senate_trial(senate_yes: Nat, senate_present: Nat) -> Bool:
  impeachment_conviction(senate_yes, senate_present)

# A1S3: the Vice President votes only when the Senate is equally divided.
def rule_a1s3_vp_tiebreak(yes_votes: Nat, no_votes: Nat) -> Bool:
  Nat.is_eq(yes_votes, no_votes)

# A1S4: times/places/manner prescribed by the states; Congress may alter.
def rule_a1s4_election_regulation(state_prescribed: Bool, congress_alters: Bool) -> Bool:
  Bool.or(state_prescribed, congress_alters)

# A1S4: Congress assembles at least once every year.
def rule_a1s4_annual_assembly(assembled: Bool) -> Bool:
  assembled

# A1S7: presentment; a bill becomes law by signature, override, or lapse.
def rule_a1s7_presentment(
  passed_house: Bool,
  passed_senate: Bool,
  presented: Bool,
  signed: Bool,
  vetoed: Bool,
  house_override_yes: Nat,
  house_override_basis: Nat,
  senate_override_yes: Nat,
  senate_override_basis: Nat,
  ten_days_elapsed: Bool,
  adjournment_prevents_return: Bool
) -> Bool:
  bill_becomes_law(
    passed_house, passed_senate, presented, signed, vetoed,
    house_override_yes, house_override_basis, senate_override_yes,
    senate_override_basis, ten_days_elapsed, adjournment_prevents_return)

# A1S7: revenue bills originate in the House.
def rule_a1s7_revenue_origination(revenue_bill: Bool, originated_house: Bool) -> Bool:
  Bool.or(Bool.not(revenue_bill), originated_house)

# A2S1: the executive power is vested in a President.
def rule_a2s1_vesting(office_held: Bool) -> Bool:
  office_held

# A2S1: the President holds office during the term of four years.
def rule_a2s1_term(term_years: Nat) -> Bool:
  Nat.is_le(term_years, 4n)

# A2S1: President qualifications (35 years, 14 years resident, natural born).
def rule_a2s1_qualifications(age: Nat, resident_years: Nat, natural_born: Bool) -> Bool:
  president_eligible(age, resident_years, natural_born)

# A2S1: the natural-born condition, with the term passed as an opaque input.
def rule_a2s1_natural_born(term: InterpretiveTerm, satisfied: Bool) -> Bool:
  Bool.and(interpretive_term_is_natural_born(term), satisfied)

# A2S1: electors per state equal senators plus representatives.
def rule_a2s1_electors(electors: Nat, senators: Nat, representatives: Nat) -> Bool:
  Nat.is_eq(electors, Nat.add(senators, representatives))

# A3S2: treason conviction needs two witnesses to the same overt act or
# confession in open court.
def rule_a3s2_treason_evidence(two_witnesses: Bool, confession: Bool) -> Bool:
  treason_conviction_evidence(two_witnesses, confession)

# A3S2: trial of crimes by jury; Speedy/Impartial are opaque term inputs.
def rule_a3s2_jury_trial(
  trial_by_jury: Bool,
  speedy_term: InterpretiveTerm,
  speedy_met: Bool,
  impartial_term: InterpretiveTerm,
  impartial_met: Bool
) -> Bool:
  Bool.and(trial_by_jury, Bool.and(
    Bool.and(interpretive_term_is_speedy(speedy_term), speedy_met),
    Bool.and(interpretive_term_is_impartial(impartial_term), impartial_met)))

# A5: Congress proposes amendments by two thirds of both houses.
def rule_a5_congress_proposal(house_yes: Nat, house_basis: Nat, senate_yes: Nat, senate_basis: Nat) -> Bool:
  article_v_congress_proposal(house_yes, house_basis, senate_yes, senate_basis)

# A5: a convention is called on application of two thirds of the states.
def rule_a5_convention_application(applications: Nat, state_count: Nat) -> Bool:
  article_v_state_application(applications, state_count)

# A5: ratification by three fourths of the states.
def rule_a5_ratification(ratifying_states: Nat, state_count: Nat) -> Bool:
  article_v_ratification(ratifying_states, state_count)

# AM12: a majority of the whole number of electors appoints the President.
def rule_am12_electoral_majority(votes: Nat, electors: Nat) -> Bool:
  majority(votes, electors)

# AM12: electors vote by ballot, distinctly for President and Vice-President.
def rule_am12_distinct_ballots(ballots_distinct: Bool) -> Bool:
  ballots_distinct

# AM13S1: no slavery or involuntary servitude except as punishment for crime.
def rule_am13s1_abolition(involuntary_servitude: Bool, punishment_for_crime: Bool) -> Bool:
  Bool.or(Bool.not(involuntary_servitude), punishment_for_crime)

# AM14S2: apportionment counts the whole number of persons in each state.
def rule_am14s2_apportionment_basis(counts_whole_persons: Bool) -> Bool:
  counts_whole_persons

# AM14S2: representation is reduced when the vote is denied, except for
# rebellion or other crime.
def rule_am14s2_reduction(vote_denied: Bool, excepted_cause: Bool) -> Bool:
  Bool.and(vote_denied, Bool.not(excepted_cause))

# AM16: Congress may tax incomes without apportionment.
def rule_am16_income_tax(tax_on_incomes: Bool) -> Bool:
  tax_on_incomes

# AM17: senators are elected by the people.
def rule_am17_direct_election(elected_by_people: Bool) -> Bool:
  elected_by_people

# AM17: the executive may make temporary appointments when the legislature
# empowers it to do so.
def rule_am17_vacancy_appointment(governor_appointed: Bool, legislature_empowered: Bool) -> Bool:
  Bool.and(governor_appointed, legislature_empowered)

# AM18S1 (repealed): no manufacture, sale, or transport of intoxicating
# liquors for beverage purposes. Kept for the record; not in force.
def rule_am18s1_prohibition(liquor_traffic: Bool, beverage_purpose: Bool, liquor_term: InterpretiveTerm) -> Bool:
  Bool.not(Bool.and(liquor_traffic, Bool.and(beverage_purpose, interpretive_term_is_intoxicating_liquor(liquor_term))))

# AM18S2 (repealed): concurrent enforcement power. Kept; not in force.
def rule_am18s2_concurrent_power(enforcement_asserted: Bool) -> Bool:
  enforcement_asserted

# AM18S3 (repealed): effective one year after ratification. Kept; not in force.
def rule_am18s3_effective_date(one_year_elapsed: Bool) -> Bool:
  one_year_elapsed

# AM20S1: terms of President and Vice President end at noon on January 20.
def rule_am20s1_term_commencement(terms_began_noon_jan20: Bool) -> Bool:
  terms_began_noon_jan20

# AM20S2: Congress assembles at noon on January 3 each year.
def rule_am20s2_congress_assembly(assembled_noon_jan3: Bool) -> Bool:
  assembled_noon_jan3

# AM20S3: if the President-elect dies, the Vice President-elect becomes
# President.
def rule_am20s3_president_elect_death(president_elect_died: Bool) -> Bool:
  president_elect_died

# AM20S4: Congress provides by law for the case where no one qualifies.
def rule_am20s4_succession_statute(provided_by_law: Bool) -> Bool:
  provided_by_law

# AM21S1: the eighteenth article is repealed. The repealed text stays in the
# type; `clause_in_force` records that it no longer operates.
def rule_am21s1_repeal() -> Bool:
  True{}

# AM22S1: no one is elected President more than twice.
def rule_am22s1_term_limit(elected_count: Nat) -> Bool:
  presidential_election_limit(elected_count, False{})

# AM22S2: prior service of more than two years of another's term reduces the
# limit to a single election.
def rule_am22s2_prior_service_limit(elected_count: Nat) -> Bool:
  presidential_election_limit(elected_count, True{})

# AM25S1: the Vice President becomes President on removal, death, or
# resignation.
def rule_am25s1_succession(vacancy: Bool) -> Bool:
  vacancy

# AM25S2: the President nominates a Vice President, confirmed by a majority
# of both houses.
def rule_am25s2_vp_confirmation(house_yes: Nat, house_basis: Nat, senate_yes: Nat, senate_basis: Nat) -> Bool:
  Bool.and(majority(house_yes, house_basis), majority(senate_yes, senate_basis))

# AM25S3: on the President's written declaration of inability, the Vice
# President acts; "unable" is an opaque term input.
def rule_am25s3_voluntary_transfer(declaration: Bool, unable_term: InterpretiveTerm, unable_satisfied: Bool) -> Bool:
  Bool.and(declaration, Bool.and(interpretive_term_is_unable_to_discharge(unable_term), unable_satisfied))

# AM25S4: Congress decides a contested inability by two thirds of both houses.
def rule_am25s4_congress_decision(house_yes: Nat, house_basis: Nat, senate_yes: Nat, senate_basis: Nat) -> Bool:
  Bool.and(two_thirds(house_yes, house_basis), two_thirds(senate_yes, senate_basis))

# AM26S1: the right to vote of citizens 18 or older shall not be denied on
# account of age.
def rule_am26s1_vote_age(age: Nat) -> Bool:
  age_vote_protection(age)
