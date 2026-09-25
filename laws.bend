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

# === Denominator policies (TASKS.md item 4) ===
#
# The transcript distinguishes four denominator bases for thresholds. The basis
# is now part of every threshold call shape: primitives take (yes, bundle,
# basis) and select the denominator internally, so a caller cannot silently
# pass the wrong basis — the commitment lives in signatures, not test code.
# Bare-Nat threshold calls no longer exist.

type DenominatorBasis is Data:
  # "two thirds of the Members present" (A1S3 impeachment), "two thirds of the
  # Senators present" (A2S2 treaties).
  PresentMembers{}
  # "two thirds of both Houses" (Art. V proposal), "two thirds of that House"
  # (A1S7 veto override), "a Majority of each [House]" (A1S5 quorum).
  FullMembership{}
  # "a majority of the whole number of Electors" (AM12). For a voting body the
  # whole number is its membership; reserved for elector-vote modeling.
  AppointedElectors{}
  # "two thirds of the several States" (Art. V), "a majority of all the states"
  # (AM12 House choice). Used with StatesCount; never with a chamber bundle.
  States{}

# The counts the transcript distinguishes for a chamber vote.
type ChamberCount is Data:
  ChamberCount{present: Nat, membership: Nat}

# The counts for a vote of the states.
type StatesCount is Data:
  StatesCount{states: Nat}

# Select the denominator the transcript's basis demands from a chamber bundle.
def chamber_basis_count(counts: ChamberCount, basis: DenominatorBasis) -> Nat:
  match counts:
    case ChamberCount{present, membership}:
      match basis:
        case PresentMembers{}:
          present
        case _:
          # FullMembership: the whole House. AppointedElectors resolves to
          # membership as well (the whole number of a body is its membership).
          # States never occurs with a chamber bundle — state votes take
          # StatesCount and fix their basis internally — so this arm keeps the
          # selector total without inventing a meaning.
          membership

def two_thirds(yes: Nat, counts: ChamberCount, basis: DenominatorBasis) -> Bool:
  Nat.is_le(Nat.mul(2n, chamber_basis_count(counts, basis)), Nat.mul(3n, yes))

def majority(yes: Nat, counts: ChamberCount, basis: DenominatorBasis) -> Bool:
  Nat.is_lt(chamber_basis_count(counts, basis), Nat.mul(2n, yes))

def states_two_thirds(yes: Nat, counts: StatesCount) -> Bool:
  match counts:
    case StatesCount{states}:
      Nat.is_le(Nat.mul(2n, states), Nat.mul(3n, yes))

def states_three_fourths(yes: Nat, counts: StatesCount) -> Bool:
  match counts:
    case StatesCount{states}:
      Nat.is_le(Nat.mul(3n, states), Nat.mul(4n, yes))

# A1S5: "a Majority of each [House] shall constitute a Quorum" — a majority of
# the House's membership must be present.
def quorum_met(counts: ChamberCount) -> Bool:
  match counts:
    case ChamberCount{present, membership}:
      Nat.is_lt(membership, Nat.mul(2n, present))

def representative_eligible(age: Nat, citizen_years: Nat, inhabitant: Bool) -> Bool:
  Bool.and(Nat.is_le(25n, age), Bool.and(Nat.is_le(7n, citizen_years), inhabitant))

def senator_eligible(age: Nat, citizen_years: Nat, inhabitant: Bool) -> Bool:
  Bool.and(Nat.is_le(30n, age), Bool.and(Nat.is_le(9n, citizen_years), inhabitant))

def president_eligible(age: Nat, resident_years: Nat, natural_born: Bool) -> Bool:
  Bool.and(Nat.is_le(35n, age), Bool.and(Nat.is_le(14n, resident_years), natural_born))

def impeachment_conviction(senate_yes: Nat, counts: ChamberCount) -> Bool:
  # A1S3: "no Person shall be convicted without the Concurrence of two thirds
  # of the Members present" — the present basis is fixed by the signature.
  two_thirds(senate_yes, counts, PresentMembers{})

def treaty_approved(senate_yes: Nat, counts: ChamberCount) -> Bool:
  # A2S2: treaties by "the Advice and Consent of the Senate ... provided two
  # thirds of the Senators present concur" — the present basis is fixed.
  two_thirds(senate_yes, counts, PresentMembers{})

def article_v_congress_proposal(house_yes: Nat, house: ChamberCount, senate_yes: Nat, senate: ChamberCount) -> Bool:
  # Art. V: "two thirds of both Houses" — of the Houses themselves, i.e. full
  # membership, not of those present. The membership basis is fixed.
  Bool.and(two_thirds(house_yes, house, FullMembership{}), two_thirds(senate_yes, senate, FullMembership{}))

def article_v_state_application(applications: Nat, counts: StatesCount) -> Bool:
  # Art. V: "two thirds of the several States".
  states_two_thirds(applications, counts)

def article_v_ratification(ratifying_states: Nat, counts: StatesCount) -> Bool:
  # Art. V: "three fourths of the several States".
  states_three_fourths(ratifying_states, counts)

def bill_becomes_law(
  passed_house: Bool,
  passed_senate: Bool,
  presented: Bool,
  signed: Bool,
  vetoed: Bool,
  house_override_yes: Nat,
  house: ChamberCount,
  senate_override_yes: Nat,
  senate: ChamberCount,
  ten_days_elapsed_excluding_sundays: Bool,
  adjournment_prevents_return: Bool
) -> Bool:
  base = Bool.and(passed_house, Bool.and(passed_senate, presented))
  # A1S7: override requires "two thirds of that House" — of the House itself,
  # i.e. full membership. The membership basis is fixed by the signature.
  override_path = Bool.and(vetoed, Bool.and(two_thirds(house_override_yes, house, FullMembership{}), two_thirds(senate_override_yes, senate, FullMembership{})))
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

# A1S3: the Senate tries impeachments; conviction needs two thirds of the
# Members present (basis fixed inside impeachment_conviction).
def rule_a1s3_senate_trial(senate_yes: Nat, counts: ChamberCount) -> Bool:
  impeachment_conviction(senate_yes, counts)

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
# Override counts are chamber bundles; the membership basis is fixed inside
# bill_becomes_law ("two thirds of that House").
def rule_a1s7_presentment(
  passed_house: Bool,
  passed_senate: Bool,
  presented: Bool,
  signed: Bool,
  vetoed: Bool,
  house_override_yes: Nat,
  house: ChamberCount,
  senate_override_yes: Nat,
  senate: ChamberCount,
  ten_days_elapsed: Bool,
  adjournment_prevents_return: Bool
) -> Bool:
  bill_becomes_law(
    passed_house, passed_senate, presented, signed, vetoed,
    house_override_yes, house, senate_override_yes,
    senate, ten_days_elapsed, adjournment_prevents_return)

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

# A5: Congress proposes amendments by two thirds of both houses (full
# membership basis, fixed inside article_v_congress_proposal).
def rule_a5_congress_proposal(house_yes: Nat, house: ChamberCount, senate_yes: Nat, senate: ChamberCount) -> Bool:
  article_v_congress_proposal(house_yes, house, senate_yes, senate)

# A5: a convention is called on application of two thirds of the states.
def rule_a5_convention_application(applications: Nat, counts: StatesCount) -> Bool:
  article_v_state_application(applications, counts)

# A5: ratification by three fourths of the states.
def rule_a5_ratification(ratifying_states: Nat, counts: StatesCount) -> Bool:
  article_v_ratification(ratifying_states, counts)

# AM12: a majority of the whole number of electors appoints the President. The
# whole number appointed is the body's membership (present == membership here).
def rule_am12_electoral_majority(votes: Nat, +electors: Nat) -> Bool:
  majority(votes, ChamberCount{electors, electors}, AppointedElectors{})

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
# of both houses. "Of both Houses" without "present": full membership basis,
# fixed by the signature.
def rule_am25s2_vp_confirmation(house_yes: Nat, house: ChamberCount, senate_yes: Nat, senate: ChamberCount) -> Bool:
  Bool.and(majority(house_yes, house, FullMembership{}), majority(senate_yes, senate, FullMembership{}))

# AM25S3: on the President's written declaration of inability, the Vice
# President acts; "unable" is an opaque term input.
def rule_am25s3_voluntary_transfer(declaration: Bool, unable_term: InterpretiveTerm, unable_satisfied: Bool) -> Bool:
  Bool.and(declaration, Bool.and(interpretive_term_is_unable_to_discharge(unable_term), unable_satisfied))

# AM25S4: Congress decides a contested inability by two thirds of both houses.
# "Of both Houses": full membership basis, fixed by the signature.
def rule_am25s4_congress_decision(house_yes: Nat, house: ChamberCount, senate_yes: Nat, senate: ChamberCount) -> Bool:
  Bool.and(two_thirds(house_yes, house, FullMembership{}), two_thirds(senate_yes, senate, FullMembership{}))

# AM26S1: the right to vote of citizens 18 or older shall not be denied on
# account of age.
def rule_am26s1_vote_age(age: Nat) -> Bool:
  age_vote_protection(age)
# === Interpretation environment (TASKS.md item 2) ===
#
# An InterpEnv records EXTERNAL legal tests: a binding (term, value) says
# "under the caller's jurisprudence, this open term resolves to value".
# The env assigns no meaning to any InterpretiveTerm; it only records
# caller-supplied resolutions, keeping the reified-not-defined discipline.
#
# Absent-term policy: a term with no binding resolves to Unknown{}, never to
# a silent default. Known{False{}} (resolved false) and Unknown{} (no
# resolution supplied) are distinct values.
#
# Duplicate-binding policy: scanners are FIRST-WINS on the binding list, and
# env_extend prepends, so the most recent extension shadows earlier ones
# (last extension wins). Extending never disturbs other terms' slots.
#
# Representation note: the env is `is Type`, not `is Data`, because Bend
# 2.0.27's Base List cannot appear as a field of a Data type. Lookup uses one
# self-recursive scanner per term constructor: Bend 2.0.27 cannot match on a
# computed value and requires callees to be defined before callers, so a
# generic term-equality helper cannot drive the scan. The scanners below are
# mechanical; each is structurally recursive on the binding list.

type InterpValue is Data:
  Known{value: Bool}
  Unknown{}

type InterpBinding is Data:
  InterpBinding{term: InterpretiveTerm, value: Bool}

type InterpEnv is Type:
  InterpEnv{bindings: List<InterpBinding>}

def interp_env_empty() -> InterpEnv:
  InterpEnv{Nil{}}

def interp_env_bindings(env: InterpEnv) -> List<InterpBinding>:
  match env:
    case InterpEnv{bindings}:
      bindings

def scan_interp_good_behavior(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case GoodBehavior{}:
          Known{bv}
        case _:
          scan_interp_good_behavior(rest)

def scan_interp_natural_born_citizen(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case NaturalBornCitizen{}:
          Known{bv}
        case _:
          scan_interp_natural_born_citizen(rest)

def scan_interp_necessary_and_proper(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case NecessaryAndProper{}:
          Known{bv}
        case _:
          scan_interp_necessary_and_proper(rest)

def scan_interp_general_welfare(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case GeneralWelfare{}:
          Known{bv}
        case _:
          scan_interp_general_welfare(rest)

def scan_interp_common_defence(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case CommonDefence{}:
          Known{bv}
        case _:
          scan_interp_common_defence(rest)

def scan_interp_commerce(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case Commerce{}:
          Known{bv}
        case _:
          scan_interp_commerce(rest)

def scan_interp_public_safety_requires(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case PublicSafetyRequires{}:
          Known{bv}
        case _:
          scan_interp_public_safety_requires(rest)

def scan_interp_high_crimes_and_misdemeanors(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case HighCrimesAndMisdemeanors{}:
          Known{bv}
        case _:
          scan_interp_high_crimes_and_misdemeanors(rest)

def scan_interp_republican_form(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case RepublicanForm{}:
          Known{bv}
        case _:
          scan_interp_republican_form(rest)

def scan_interp_due_process(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case DueProcess{}:
          Known{bv}
        case _:
          scan_interp_due_process(rest)

def scan_interp_equal_protection(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case EqualProtection{}:
          Known{bv}
        case _:
          scan_interp_equal_protection(rest)

def scan_interp_privileges_or_immunities(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case PrivilegesOrImmunities{}:
          Known{bv}
        case _:
          scan_interp_privileges_or_immunities(rest)

def scan_interp_unreasonable(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case Unreasonable{}:
          Known{bv}
        case _:
          scan_interp_unreasonable(rest)

def scan_interp_probable_cause(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case ProbableCause{}:
          Known{bv}
        case _:
          scan_interp_probable_cause(rest)

def scan_interp_excessive(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case Excessive{}:
          Known{bv}
        case _:
          scan_interp_excessive(rest)

def scan_interp_cruel_and_unusual(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case CruelAndUnusual{}:
          Known{bv}
        case _:
          scan_interp_cruel_and_unusual(rest)

def scan_interp_establishment_of_religion(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case EstablishmentOfReligion{}:
          Known{bv}
        case _:
          scan_interp_establishment_of_religion(rest)

def scan_interp_free_exercise(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case FreeExercise{}:
          Known{bv}
        case _:
          scan_interp_free_exercise(rest)

def scan_interp_freedom_of_speech(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case FreedomOfSpeech{}:
          Known{bv}
        case _:
          scan_interp_freedom_of_speech(rest)

def scan_interp_freedom_of_press(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case FreedomOfPress{}:
          Known{bv}
        case _:
          scan_interp_freedom_of_press(rest)

def scan_interp_peaceably_assemble(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case PeaceablyAssemble{}:
          Known{bv}
        case _:
          scan_interp_peaceably_assemble(rest)

def scan_interp_petition_redress(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case PetitionRedress{}:
          Known{bv}
        case _:
          scan_interp_petition_redress(rest)

def scan_interp_well_regulated_militia(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case WellRegulatedMilitia{}:
          Known{bv}
        case _:
          scan_interp_well_regulated_militia(rest)

def scan_interp_keep_and_bear_arms(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case KeepAndBearArms{}:
          Known{bv}
        case _:
          scan_interp_keep_and_bear_arms(rest)

def scan_interp_infamous_crime(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case InfamousCrime{}:
          Known{bv}
        case _:
          scan_interp_infamous_crime(rest)

def scan_interp_same_offence(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case SameOffence{}:
          Known{bv}
        case _:
          scan_interp_same_offence(rest)

def scan_interp_public_use(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case PublicUse{}:
          Known{bv}
        case _:
          scan_interp_public_use(rest)

def scan_interp_just_compensation(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case JustCompensation{}:
          Known{bv}
        case _:
          scan_interp_just_compensation(rest)

def scan_interp_speedy(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case Speedy{}:
          Known{bv}
        case _:
          scan_interp_speedy(rest)

def scan_interp_impartial(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case Impartial{}:
          Known{bv}
        case _:
          scan_interp_impartial(rest)

def scan_interp_common_law_suit(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case CommonLawSuit{}:
          Known{bv}
        case _:
          scan_interp_common_law_suit(rest)

def scan_interp_retained_right(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case RetainedRight{}:
          Known{bv}
        case _:
          scan_interp_retained_right(rest)

def scan_interp_delegated_power(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case DelegatedPower{}:
          Known{bv}
        case _:
          scan_interp_delegated_power(rest)

def scan_interp_appropriate_legislation(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case AppropriateLegislation{}:
          Known{bv}
        case _:
          scan_interp_appropriate_legislation(rest)

def scan_interp_insurrection_or_rebellion(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case InsurrectionOrRebellion{}:
          Known{bv}
        case _:
          scan_interp_insurrection_or_rebellion(rest)

def scan_interp_aid_or_comfort_enemies(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case AidOrComfortEnemies{}:
          Known{bv}
        case _:
          scan_interp_aid_or_comfort_enemies(rest)

def scan_interp_valid_public_debt(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case ValidPublicDebt{}:
          Known{bv}
        case _:
          scan_interp_valid_public_debt(rest)

def scan_interp_unable_to_discharge(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case UnableToDischarge{}:
          Known{bv}
        case _:
          scan_interp_unable_to_discharge(rest)

def scan_interp_intoxicating_liquor(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case IntoxicatingLiquor{}:
          Known{bv}
        case _:
          scan_interp_intoxicating_liquor(rest)

def scan_interp_beverage_purpose(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case BeveragePurpose{}:
          Known{bv}
        case _:
          scan_interp_beverage_purpose(rest)

def scan_interp_extraordinary_occasion(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case ExtraordinaryOccasion{}:
          Known{bv}
        case _:
          scan_interp_extraordinary_occasion(rest)

def scan_interp_office_of_trust_or_profit(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case OfficeOfTrustOrProfit{}:
          Known{bv}
        case _:
          scan_interp_office_of_trust_or_profit(rest)

def scan_interp_office_of_honor_trust_or_profit(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case OfficeOfHonorTrustOrProfit{}:
          Known{bv}
        case _:
          scan_interp_office_of_honor_trust_or_profit(rest)

def scan_interp_imminent_danger_no_delay(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case ImminentDangerNoDelay{}:
          Known{bv}
        case _:
          scan_interp_imminent_danger_no_delay(rest)

def scan_interp_actual_invasion(bs: List<InterpBinding>) -> InterpValue:
  match bs:
    case Nil{}:
      Unknown{}
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case ActualInvasion{}:
          Known{bv}
        case _:
          scan_interp_actual_invasion(rest)

def interp_lookup(env: InterpEnv, term: InterpretiveTerm) -> InterpValue:
  match term:
    case GoodBehavior{}:
      scan_interp_good_behavior(interp_env_bindings(env))

    case NaturalBornCitizen{}:
      scan_interp_natural_born_citizen(interp_env_bindings(env))

    case NecessaryAndProper{}:
      scan_interp_necessary_and_proper(interp_env_bindings(env))

    case GeneralWelfare{}:
      scan_interp_general_welfare(interp_env_bindings(env))

    case CommonDefence{}:
      scan_interp_common_defence(interp_env_bindings(env))

    case Commerce{}:
      scan_interp_commerce(interp_env_bindings(env))

    case PublicSafetyRequires{}:
      scan_interp_public_safety_requires(interp_env_bindings(env))

    case HighCrimesAndMisdemeanors{}:
      scan_interp_high_crimes_and_misdemeanors(interp_env_bindings(env))

    case RepublicanForm{}:
      scan_interp_republican_form(interp_env_bindings(env))

    case DueProcess{}:
      scan_interp_due_process(interp_env_bindings(env))

    case EqualProtection{}:
      scan_interp_equal_protection(interp_env_bindings(env))

    case PrivilegesOrImmunities{}:
      scan_interp_privileges_or_immunities(interp_env_bindings(env))

    case Unreasonable{}:
      scan_interp_unreasonable(interp_env_bindings(env))

    case ProbableCause{}:
      scan_interp_probable_cause(interp_env_bindings(env))

    case Excessive{}:
      scan_interp_excessive(interp_env_bindings(env))

    case CruelAndUnusual{}:
      scan_interp_cruel_and_unusual(interp_env_bindings(env))

    case EstablishmentOfReligion{}:
      scan_interp_establishment_of_religion(interp_env_bindings(env))

    case FreeExercise{}:
      scan_interp_free_exercise(interp_env_bindings(env))

    case FreedomOfSpeech{}:
      scan_interp_freedom_of_speech(interp_env_bindings(env))

    case FreedomOfPress{}:
      scan_interp_freedom_of_press(interp_env_bindings(env))

    case PeaceablyAssemble{}:
      scan_interp_peaceably_assemble(interp_env_bindings(env))

    case PetitionRedress{}:
      scan_interp_petition_redress(interp_env_bindings(env))

    case WellRegulatedMilitia{}:
      scan_interp_well_regulated_militia(interp_env_bindings(env))

    case KeepAndBearArms{}:
      scan_interp_keep_and_bear_arms(interp_env_bindings(env))

    case InfamousCrime{}:
      scan_interp_infamous_crime(interp_env_bindings(env))

    case SameOffence{}:
      scan_interp_same_offence(interp_env_bindings(env))

    case PublicUse{}:
      scan_interp_public_use(interp_env_bindings(env))

    case JustCompensation{}:
      scan_interp_just_compensation(interp_env_bindings(env))

    case Speedy{}:
      scan_interp_speedy(interp_env_bindings(env))

    case Impartial{}:
      scan_interp_impartial(interp_env_bindings(env))

    case CommonLawSuit{}:
      scan_interp_common_law_suit(interp_env_bindings(env))

    case RetainedRight{}:
      scan_interp_retained_right(interp_env_bindings(env))

    case DelegatedPower{}:
      scan_interp_delegated_power(interp_env_bindings(env))

    case AppropriateLegislation{}:
      scan_interp_appropriate_legislation(interp_env_bindings(env))

    case InsurrectionOrRebellion{}:
      scan_interp_insurrection_or_rebellion(interp_env_bindings(env))

    case AidOrComfortEnemies{}:
      scan_interp_aid_or_comfort_enemies(interp_env_bindings(env))

    case ValidPublicDebt{}:
      scan_interp_valid_public_debt(interp_env_bindings(env))

    case UnableToDischarge{}:
      scan_interp_unable_to_discharge(interp_env_bindings(env))

    case IntoxicatingLiquor{}:
      scan_interp_intoxicating_liquor(interp_env_bindings(env))

    case BeveragePurpose{}:
      scan_interp_beverage_purpose(interp_env_bindings(env))

    case ExtraordinaryOccasion{}:
      scan_interp_extraordinary_occasion(interp_env_bindings(env))

    case OfficeOfTrustOrProfit{}:
      scan_interp_office_of_trust_or_profit(interp_env_bindings(env))

    case OfficeOfHonorTrustOrProfit{}:
      scan_interp_office_of_honor_trust_or_profit(interp_env_bindings(env))

    case ImminentDangerNoDelay{}:
      scan_interp_imminent_danger_no_delay(interp_env_bindings(env))

    case ActualInvasion{}:
      scan_interp_actual_invasion(interp_env_bindings(env))


# eval_interp is the primary interpretation call: resolve one open term
# under the caller's env.
def eval_interp(env: InterpEnv, term: InterpretiveTerm) -> InterpValue:
  interp_lookup(env, term)

# env_extend prepends, so the new binding shadows any earlier binding for
# the same term (first-wins scan sees the newest binding first).
def env_extend(env: InterpEnv, term: InterpretiveTerm, value: Bool) -> InterpEnv:
  InterpEnv{Con{InterpBinding{term, value}, interp_env_bindings(env)}}

# A2S1 natural-born condition under an env: the env's resolution plays the
# role of the rule's `satisfied` input. Absent term -> Unknown{}.
def eval_rule_a2s1_natural_born(env: InterpEnv, term: InterpretiveTerm) -> InterpValue:
  match term:
    case NaturalBornCitizen{}:
      interp_lookup(env, term)
    case _:
      Known{False{}}

# A3S2 jury-trial under an env (Speedy and Impartial resolved from the env).
# Bend 2.0.27 is linear: every variable is use-once, so the env cannot be
# looked up twice. Both terms are therefore resolved in a SINGLE pass over
# the bindings (first-wins per term, via the accumulators below).
type JuryTerms is Data:
  JuryTerms{speedy: InterpValue, impartial: InterpValue}

def jury_terms_empty() -> JuryTerms:
  JuryTerms{Unknown{}, Unknown{}}

def jury_acc_speedy(acc: JuryTerms, bv: Bool) -> JuryTerms:
  match acc:
    case JuryTerms{speedy, impartial}:
      match speedy:
        case Known{v}:
          JuryTerms{Known{v}, impartial}
        case Unknown{}:
          JuryTerms{Known{bv}, impartial}

def jury_acc_impartial(acc: JuryTerms, bv: Bool) -> JuryTerms:
  match acc:
    case JuryTerms{speedy, impartial}:
      match impartial:
        case Known{v}:
          JuryTerms{speedy, Known{v}}
        case Unknown{}:
          JuryTerms{speedy, Known{bv}}

def scan_jury_terms(bs: List<InterpBinding>, acc: JuryTerms) -> JuryTerms:
  match bs:
    case Nil{}:
      acc
    case Con{InterpBinding{bt, bv}, rest}:
      match bt:
        case Speedy{}:
          scan_jury_terms(rest, jury_acc_speedy(acc, bv))
        case Impartial{}:
          scan_jury_terms(rest, jury_acc_impartial(acc, bv))
        case _:
          scan_jury_terms(rest, acc)

def eval_jury_terms(env: InterpEnv) -> JuryTerms:
  scan_jury_terms(interp_env_bindings(env), jury_terms_empty())

def eval_jury_resolved(trial_by_jury: Bool, terms: JuryTerms) -> InterpValue:
  match terms:
    case JuryTerms{speedy, impartial}:
      match speedy:
        case Known{sv}:
          match impartial:
            case Known{iv}:
              Known{Bool.and(trial_by_jury, Bool.and(sv, iv))}
            case Unknown{}:
              Unknown{}
        case Unknown{}:
          Unknown{}

def eval_jury_after_speedy_term(env: InterpEnv, trial_by_jury: Bool, impartial_term: InterpretiveTerm) -> InterpValue:
  match impartial_term:
    case Impartial{}:
      eval_jury_resolved(trial_by_jury, eval_jury_terms(env))
    case _:
      Known{False{}}

def eval_rule_a3s2_jury_trial(env: InterpEnv, trial_by_jury: Bool, speedy_term: InterpretiveTerm, impartial_term: InterpretiveTerm) -> InterpValue:
  match speedy_term:
    case Speedy{}:
      eval_jury_after_speedy_term(env, trial_by_jury, impartial_term)
    case _:
      Known{False{}}

# AM18S1 prohibition under an env (kept for the record; not in force).
def eval_prohibition_resolved(liquor_traffic: Bool, beverage_purpose: Bool, liquor_found: InterpValue) -> InterpValue:
  match liquor_found:
    case Known{lv}:
      Known{Bool.not(Bool.and(liquor_traffic, Bool.and(beverage_purpose, lv)))}
    case Unknown{}:
      Unknown{}

def eval_rule_am18s1_prohibition(env: InterpEnv, liquor_traffic: Bool, beverage_purpose: Bool, liquor_term: InterpretiveTerm) -> InterpValue:
  match liquor_term:
    case IntoxicatingLiquor{}:
      eval_prohibition_resolved(liquor_traffic, beverage_purpose, interp_lookup(env, liquor_term))
    case _:
      Known{True{}}

# AM25S3 voluntary transfer under an env.
def eval_transfer_resolved(declaration: Bool, unable_found: InterpValue) -> InterpValue:
  match unable_found:
    case Known{uv}:
      Known{Bool.and(declaration, uv)}
    case Unknown{}:
      Unknown{}

def eval_rule_am25s3_voluntary_transfer(env: InterpEnv, declaration: Bool, unable_term: InterpretiveTerm) -> InterpValue:
  match unable_term:
    case UnableToDischarge{}:
      eval_transfer_resolved(declaration, interp_lookup(env, unable_term))
    case _:
      Known{False{}}

# Clause dispatcher: evaluates the four term-dependent clause rules under an
# env. Parameter mapping per clause (unused params are ignored):
#   CL_A2S1_NaturalBorn:         term_a = term to check (expect NaturalBornCitizen{})
#   CL_A3S2_JuryTrial:           term_a = speedy term, term_b = impartial term,
#                                flag1 = trial_by_jury
#   CL_AM18S1_Prohibition:       term_a = liquor term, flag1 = liquor_traffic,
#                                flag2 = beverage_purpose
#   CL_AM25S3_VoluntaryTransfer: term_a = unable term, flag1 = declaration
# Any other clause has no interpretive-term dependency: the dispatcher is
# inert for it (Unknown{} = out of domain). Term-free clauses are evaluated
# by their direct rules; the env cannot change their verdicts.
def eval_clause_under_env(clause: Clause, env: InterpEnv, term_a: InterpretiveTerm, term_b: InterpretiveTerm, flag1: Bool, flag2: Bool) -> InterpValue:
  match clause:
    case CL_A2S1_NaturalBorn{}:
      eval_rule_a2s1_natural_born(env, term_a)
    case CL_A3S2_JuryTrial{}:
      eval_rule_a3s2_jury_trial(env, flag1, term_a, term_b)
    case CL_AM18S1_Prohibition{}:
      eval_rule_am18s1_prohibition(env, flag1, flag2, term_a)
    case CL_AM25S3_VoluntaryTransfer{}:
      eval_rule_am25s3_voluntary_transfer(env, flag1, term_a)
    case _:
      Unknown{}
