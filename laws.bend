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
  CL_A1S1_Vesting{}
  CL_A1S5_Quorum{}
  CL_A1S5_Expulsion{}
  CL_A1S5_YeasNays{}
  CL_A1S5_Adjournment{}
  CL_A1S6_ArrestPrivilege{}
  CL_A1S6_SpeechDebate{}
  CL_A1S6_Incompatibility{}
  CL_A1S6_Emoluments{}
  CL_A1S8_TaxUniformity{}
  CL_A1S8_Commerce{}
  CL_A1S8_NaturalizationBankruptcy{}
  CL_A1S8_CoinWeights{}
  CL_A1S8_WarDeclaration{}
  CL_A1S8_NecessaryProper{}
  CL_A1S9_HabeasCorpus{}
  CL_A1S9_Attainder{}
  CL_A1S9_DirectTax{}
  CL_A1S9_ExportTax{}
  CL_A1S9_Appropriations{}
  CL_A1S9_TitlesNobility{}
  CL_A1S10_TreatyAlliance{}
  CL_A1S10_CoinTender{}
  CL_A1S10_Imposts{}
  CL_A1S10_StateWar{}
  CL_A2S2_CommanderInChief{}
  CL_A2S2_Pardons{}
  CL_A2S2_Treaty{}
  CL_A2S2_Appointments{}
  CL_A2S2_RecessVacancies{}
  CL_A2S3_TakeCare{}
  CL_A2S3_ExtraordinaryConvene{}
  CL_A2S4_Removal{}
  CL_A3S1_Vesting{}
  CL_A3S1_Tenure{}
  CL_A3S1_Compensation{}
  CL_A3S3_TreasonDefinition{}
  CL_A3S3_PunishmentLimits{}
  CL_A4S1_FullFaithCredit{}
  CL_A4S2_PrivilegesImmunities{}
  CL_A4S2_Extradition{}
  CL_A4S2_FugitiveLabor{}
  CL_A4S3_NewStates{}
  CL_A4S3_Territory{}
  CL_A4S4_RepublicanForm{}
  CL_A4S4_Protection{}
  CL_A6_Supremacy{}
  CL_A6_Oaths{}
  CL_A7_Ratification{}
  CL_AM1_Religion{}
  CL_AM1_ExpressionAssembly{}
  CL_AM2_KeepBearArms{}
  CL_AM3_Quartering{}
  CL_AM4_UnreasonableSearch{}
  CL_AM4_Warrants{}
  CL_AM5_GrandJury{}
  CL_AM5_DoubleJeopardy{}
  CL_AM5_DueProcess{}
  CL_AM5_Takings{}
  CL_AM6_SpeedyImpartialTrial{}
  CL_AM6_Counsel{}
  CL_AM7_CivilJury{}
  CL_AM7_Reexamination{}
  CL_AM8_ExcessiveBailFines{}
  CL_AM8_CruelUnusual{}
  CL_AM9_RetainedRights{}
  CL_AM10_ReservedPowers{}
  CL_AM11_SovereignImmunity{}
  CL_AM13S2_Enforcement{}
  CL_AM14S1_Citizenship{}
  CL_AM14S1_DueProcessEqualProtection{}
  CL_AM14S1_PrivilegesImmunities{}
  CL_AM14S3_DisabilityRemoved{}
  CL_AM14S4_PublicDebt{}
  CL_AM14S5_Enforcement{}
  CL_AM15S1_VoteRace{}
  CL_AM15S2_Enforcement{}
  CL_AM19_VoteSex{}
  CL_AM20S5_EffectiveDate{}
  CL_AM20S6_RatificationDeadline{}
  CL_AM21S2_Transportation{}
  CL_AM21S3_RatificationDeadline{}
  CL_AM23S1_Electors{}
  CL_AM23S2_Enforcement{}
  CL_AM24S1_PollTax{}
  CL_AM24S2_Enforcement{}
  CL_AM26S2_Enforcement{}
  CL_AM27_CompensationTiming{}
  # A1S9's migration/importation restriction (temporal: operative before 1808).
  CL_A1S9_MigrationRestriction{}

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
    case CL_A1S1_Vesting{}:
      A1S1{}
    case CL_A1S5_Quorum{}:
      A1S5{}
    case CL_A1S5_Expulsion{}:
      A1S5{}
    case CL_A1S5_YeasNays{}:
      A1S5{}
    case CL_A1S5_Adjournment{}:
      A1S5{}
    case CL_A1S6_ArrestPrivilege{}:
      A1S6{}
    case CL_A1S6_SpeechDebate{}:
      A1S6{}
    case CL_A1S6_Incompatibility{}:
      A1S6{}
    case CL_A1S6_Emoluments{}:
      A1S6{}
    case CL_A1S8_TaxUniformity{}:
      A1S8{}
    case CL_A1S8_Commerce{}:
      A1S8{}
    case CL_A1S8_NaturalizationBankruptcy{}:
      A1S8{}
    case CL_A1S8_CoinWeights{}:
      A1S8{}
    case CL_A1S8_WarDeclaration{}:
      A1S8{}
    case CL_A1S8_NecessaryProper{}:
      A1S8{}
    case CL_A1S9_HabeasCorpus{}:
      A1S9{}
    case CL_A1S9_Attainder{}:
      A1S9{}
    case CL_A1S9_DirectTax{}:
      A1S9{}
    case CL_A1S9_ExportTax{}:
      A1S9{}
    case CL_A1S9_Appropriations{}:
      A1S9{}
    case CL_A1S9_TitlesNobility{}:
      A1S9{}
    case CL_A1S10_TreatyAlliance{}:
      A1S10{}
    case CL_A1S10_CoinTender{}:
      A1S10{}
    case CL_A1S10_Imposts{}:
      A1S10{}
    case CL_A1S10_StateWar{}:
      A1S10{}
    case CL_A2S2_CommanderInChief{}:
      A2S2{}
    case CL_A2S2_Pardons{}:
      A2S2{}
    case CL_A2S2_Treaty{}:
      A2S2{}
    case CL_A2S2_Appointments{}:
      A2S2{}
    case CL_A2S2_RecessVacancies{}:
      A2S2{}
    case CL_A2S3_TakeCare{}:
      A2S3{}
    case CL_A2S3_ExtraordinaryConvene{}:
      A2S3{}
    case CL_A2S4_Removal{}:
      A2S4{}
    case CL_A3S1_Vesting{}:
      A3S1{}
    case CL_A3S1_Tenure{}:
      A3S1{}
    case CL_A3S1_Compensation{}:
      A3S1{}
    case CL_A3S3_TreasonDefinition{}:
      A3S3{}
    case CL_A3S3_PunishmentLimits{}:
      A3S3{}
    case CL_A4S1_FullFaithCredit{}:
      A4S1{}
    case CL_A4S2_PrivilegesImmunities{}:
      A4S2{}
    case CL_A4S2_Extradition{}:
      A4S2{}
    case CL_A4S2_FugitiveLabor{}:
      A4S2{}
    case CL_A4S3_NewStates{}:
      A4S3{}
    case CL_A4S3_Territory{}:
      A4S3{}
    case CL_A4S4_RepublicanForm{}:
      A4S4{}
    case CL_A4S4_Protection{}:
      A4S4{}
    case CL_A6_Supremacy{}:
      A6{}
    case CL_A6_Oaths{}:
      A6{}
    case CL_A7_Ratification{}:
      A7{}
    case CL_AM1_Religion{}:
      AM1{}
    case CL_AM1_ExpressionAssembly{}:
      AM1{}
    case CL_AM2_KeepBearArms{}:
      AM2{}
    case CL_AM3_Quartering{}:
      AM3{}
    case CL_AM4_UnreasonableSearch{}:
      AM4{}
    case CL_AM4_Warrants{}:
      AM4{}
    case CL_AM5_GrandJury{}:
      AM5{}
    case CL_AM5_DoubleJeopardy{}:
      AM5{}
    case CL_AM5_DueProcess{}:
      AM5{}
    case CL_AM5_Takings{}:
      AM5{}
    case CL_AM6_SpeedyImpartialTrial{}:
      AM6{}
    case CL_AM6_Counsel{}:
      AM6{}
    case CL_AM7_CivilJury{}:
      AM7{}
    case CL_AM7_Reexamination{}:
      AM7{}
    case CL_AM8_ExcessiveBailFines{}:
      AM8{}
    case CL_AM8_CruelUnusual{}:
      AM8{}
    case CL_AM9_RetainedRights{}:
      AM9{}
    case CL_AM10_ReservedPowers{}:
      AM10{}
    case CL_AM11_SovereignImmunity{}:
      AM11{}
    case CL_AM13S2_Enforcement{}:
      AM13S2{}
    case CL_AM14S1_Citizenship{}:
      AM14S1{}
    case CL_AM14S1_DueProcessEqualProtection{}:
      AM14S1{}
    case CL_AM14S1_PrivilegesImmunities{}:
      AM14S1{}
    case CL_AM14S3_DisabilityRemoved{}:
      AM14S3{}
    case CL_AM14S4_PublicDebt{}:
      AM14S4{}
    case CL_AM14S5_Enforcement{}:
      AM14S5{}
    case CL_AM15S1_VoteRace{}:
      AM15S1{}
    case CL_AM15S2_Enforcement{}:
      AM15S2{}
    case CL_AM19_VoteSex{}:
      AM19{}
    case CL_AM20S5_EffectiveDate{}:
      AM20S5{}
    case CL_AM20S6_RatificationDeadline{}:
      AM20S6{}
    case CL_AM21S2_Transportation{}:
      AM21S2{}
    case CL_AM21S3_RatificationDeadline{}:
      AM21S3{}
    case CL_AM23S1_Electors{}:
      AM23S1{}
    case CL_AM23S2_Enforcement{}:
      AM23S2{}
    case CL_AM24S1_PollTax{}:
      AM24S1{}
    case CL_AM24S2_Enforcement{}:
      AM24S2{}
    case CL_AM26S2_Enforcement{}:
      AM26S2{}
    case CL_AM27_CompensationTiming{}:
      AM27{}
    case CL_A1S9_MigrationRestriction{}:
      A1S9{}

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
    case CL_A1S1_Vesting{}:
      44n
    case CL_A1S5_Quorum{}:
      45n
    case CL_A1S5_Expulsion{}:
      46n
    case CL_A1S5_YeasNays{}:
      47n
    case CL_A1S5_Adjournment{}:
      48n
    case CL_A1S6_ArrestPrivilege{}:
      49n
    case CL_A1S6_SpeechDebate{}:
      50n
    case CL_A1S6_Incompatibility{}:
      51n
    case CL_A1S6_Emoluments{}:
      52n
    case CL_A1S8_TaxUniformity{}:
      53n
    case CL_A1S8_Commerce{}:
      54n
    case CL_A1S8_NaturalizationBankruptcy{}:
      55n
    case CL_A1S8_CoinWeights{}:
      56n
    case CL_A1S8_WarDeclaration{}:
      57n
    case CL_A1S8_NecessaryProper{}:
      58n
    case CL_A1S9_HabeasCorpus{}:
      59n
    case CL_A1S9_Attainder{}:
      60n
    case CL_A1S9_DirectTax{}:
      61n
    case CL_A1S9_ExportTax{}:
      62n
    case CL_A1S9_Appropriations{}:
      63n
    case CL_A1S9_TitlesNobility{}:
      64n
    case CL_A1S10_TreatyAlliance{}:
      65n
    case CL_A1S10_CoinTender{}:
      66n
    case CL_A1S10_Imposts{}:
      67n
    case CL_A1S10_StateWar{}:
      68n
    case CL_A2S2_CommanderInChief{}:
      69n
    case CL_A2S2_Pardons{}:
      70n
    case CL_A2S2_Treaty{}:
      71n
    case CL_A2S2_Appointments{}:
      72n
    case CL_A2S2_RecessVacancies{}:
      73n
    case CL_A2S3_TakeCare{}:
      74n
    case CL_A2S3_ExtraordinaryConvene{}:
      75n
    case CL_A2S4_Removal{}:
      76n
    case CL_A3S1_Vesting{}:
      77n
    case CL_A3S1_Tenure{}:
      78n
    case CL_A3S1_Compensation{}:
      79n
    case CL_A3S3_TreasonDefinition{}:
      80n
    case CL_A3S3_PunishmentLimits{}:
      81n
    case CL_A4S1_FullFaithCredit{}:
      82n
    case CL_A4S2_PrivilegesImmunities{}:
      83n
    case CL_A4S2_Extradition{}:
      84n
    case CL_A4S2_FugitiveLabor{}:
      85n
    case CL_A4S3_NewStates{}:
      86n
    case CL_A4S3_Territory{}:
      87n
    case CL_A4S4_RepublicanForm{}:
      88n
    case CL_A4S4_Protection{}:
      89n
    case CL_A6_Supremacy{}:
      90n
    case CL_A6_Oaths{}:
      91n
    case CL_A7_Ratification{}:
      92n
    case CL_AM1_Religion{}:
      93n
    case CL_AM1_ExpressionAssembly{}:
      94n
    case CL_AM2_KeepBearArms{}:
      95n
    case CL_AM3_Quartering{}:
      96n
    case CL_AM4_UnreasonableSearch{}:
      97n
    case CL_AM4_Warrants{}:
      98n
    case CL_AM5_GrandJury{}:
      99n
    case CL_AM5_DoubleJeopardy{}:
      100n
    case CL_AM5_DueProcess{}:
      101n
    case CL_AM5_Takings{}:
      102n
    case CL_AM6_SpeedyImpartialTrial{}:
      103n
    case CL_AM6_Counsel{}:
      104n
    case CL_AM7_CivilJury{}:
      105n
    case CL_AM7_Reexamination{}:
      106n
    case CL_AM8_ExcessiveBailFines{}:
      107n
    case CL_AM8_CruelUnusual{}:
      108n
    case CL_AM9_RetainedRights{}:
      109n
    case CL_AM10_ReservedPowers{}:
      110n
    case CL_AM11_SovereignImmunity{}:
      111n
    case CL_AM13S2_Enforcement{}:
      112n
    case CL_AM14S1_Citizenship{}:
      113n
    case CL_AM14S1_DueProcessEqualProtection{}:
      114n
    case CL_AM14S1_PrivilegesImmunities{}:
      115n
    case CL_AM14S3_DisabilityRemoved{}:
      116n
    case CL_AM14S4_PublicDebt{}:
      117n
    case CL_AM14S5_Enforcement{}:
      118n
    case CL_AM15S1_VoteRace{}:
      119n
    case CL_AM15S2_Enforcement{}:
      120n
    case CL_AM19_VoteSex{}:
      121n
    case CL_AM20S5_EffectiveDate{}:
      122n
    case CL_AM20S6_RatificationDeadline{}:
      123n
    case CL_AM21S2_Transportation{}:
      124n
    case CL_AM21S3_RatificationDeadline{}:
      125n
    case CL_AM23S1_Electors{}:
      126n
    case CL_AM23S2_Enforcement{}:
      127n
    case CL_AM24S1_PollTax{}:
      128n
    case CL_AM24S2_Enforcement{}:
      129n
    case CL_AM26S2_Enforcement{}:
      130n
    case CL_AM27_CompensationTiming{}:
      131n
    case CL_A1S9_MigrationRestriction{}:
      132n

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
    case CL_A1S1_Vesting{}:
      LegislativeProcedure{}
    case CL_A1S5_Quorum{}:
      LegislativeProcedure{}
    case CL_A1S5_Expulsion{}:
      LegislativeProcedure{}
    case CL_A1S5_YeasNays{}:
      LegislativeProcedure{}
    case CL_A1S5_Adjournment{}:
      LegislativeProcedure{}
    case CL_A1S6_ArrestPrivilege{}:
      RightsProtection{}
    case CL_A1S6_SpeechDebate{}:
      RightsProtection{}
    case CL_A1S6_Incompatibility{}:
      OfficeEligibility{}
    case CL_A1S6_Emoluments{}:
      OfficeEligibility{}
    case CL_A1S8_TaxUniformity{}:
      FederalPower{}
    case CL_A1S8_Commerce{}:
      FederalPower{}
    case CL_A1S8_NaturalizationBankruptcy{}:
      FederalPower{}
    case CL_A1S8_CoinWeights{}:
      FederalPower{}
    case CL_A1S8_WarDeclaration{}:
      FederalPower{}
    case CL_A1S8_NecessaryProper{}:
      FederalPower{}
    case CL_A1S9_HabeasCorpus{}:
      RightsProtection{}
    case CL_A1S9_Attainder{}:
      RightsProtection{}
    case CL_A1S9_DirectTax{}:
      FederalPower{}
    case CL_A1S9_ExportTax{}:
      FederalPower{}
    case CL_A1S9_Appropriations{}:
      LegislativeProcedure{}
    case CL_A1S9_TitlesNobility{}:
      RightsProtection{}
    case CL_A1S10_TreatyAlliance{}:
      FederalPower{}
    case CL_A1S10_CoinTender{}:
      FederalPower{}
    case CL_A1S10_Imposts{}:
      FederalPower{}
    case CL_A1S10_StateWar{}:
      FederalPower{}
    case CL_A2S2_CommanderInChief{}:
      FederalPower{}
    case CL_A2S2_Pardons{}:
      FederalPower{}
    case CL_A2S2_Treaty{}:
      LegislativeProcedure{}
    case CL_A2S2_Appointments{}:
      FederalPower{}
    case CL_A2S2_RecessVacancies{}:
      FederalPower{}
    case CL_A2S3_TakeCare{}:
      Declaratory{}
    case CL_A2S3_ExtraordinaryConvene{}:
      Declaratory{}
    case CL_A2S4_Removal{}:
      LegislativeProcedure{}
    case CL_A3S1_Vesting{}:
      JudicialRule{}
    case CL_A3S1_Tenure{}:
      JudicialRule{}
    case CL_A3S1_Compensation{}:
      JudicialRule{}
    case CL_A3S3_TreasonDefinition{}:
      JudicialRule{}
    case CL_A3S3_PunishmentLimits{}:
      JudicialRule{}
    case CL_A4S1_FullFaithCredit{}:
      JudicialRule{}
    case CL_A4S2_PrivilegesImmunities{}:
      RightsProtection{}
    case CL_A4S2_Extradition{}:
      JudicialRule{}
    case CL_A4S2_FugitiveLabor{}:
      RightsProtection{}
    case CL_A4S3_NewStates{}:
      LegislativeProcedure{}
    case CL_A4S3_Territory{}:
      FederalPower{}
    case CL_A4S4_RepublicanForm{}:
      FederalPower{}
    case CL_A4S4_Protection{}:
      FederalPower{}
    case CL_A6_Supremacy{}:
      Declaratory{}
    case CL_A6_Oaths{}:
      Declaratory{}
    case CL_A7_Ratification{}:
      LegislativeProcedure{}
    case CL_AM1_Religion{}:
      RightsProtection{}
    case CL_AM1_ExpressionAssembly{}:
      RightsProtection{}
    case CL_AM2_KeepBearArms{}:
      RightsProtection{}
    case CL_AM3_Quartering{}:
      RightsProtection{}
    case CL_AM4_UnreasonableSearch{}:
      RightsProtection{}
    case CL_AM4_Warrants{}:
      RightsProtection{}
    case CL_AM5_GrandJury{}:
      JudicialRule{}
    case CL_AM5_DoubleJeopardy{}:
      JudicialRule{}
    case CL_AM5_DueProcess{}:
      RightsProtection{}
    case CL_AM5_Takings{}:
      RightsProtection{}
    case CL_AM6_SpeedyImpartialTrial{}:
      JudicialRule{}
    case CL_AM6_Counsel{}:
      JudicialRule{}
    case CL_AM7_CivilJury{}:
      JudicialRule{}
    case CL_AM7_Reexamination{}:
      JudicialRule{}
    case CL_AM8_ExcessiveBailFines{}:
      RightsProtection{}
    case CL_AM8_CruelUnusual{}:
      RightsProtection{}
    case CL_AM9_RetainedRights{}:
      RightsProtection{}
    case CL_AM10_ReservedPowers{}:
      FederalPower{}
    case CL_AM11_SovereignImmunity{}:
      JudicialRule{}
    case CL_AM13S2_Enforcement{}:
      FederalPower{}
    case CL_AM14S1_Citizenship{}:
      RightsProtection{}
    case CL_AM14S1_DueProcessEqualProtection{}:
      RightsProtection{}
    case CL_AM14S1_PrivilegesImmunities{}:
      RightsProtection{}
    case CL_AM14S3_DisabilityRemoved{}:
      OfficeEligibility{}
    case CL_AM14S4_PublicDebt{}:
      FederalPower{}
    case CL_AM14S5_Enforcement{}:
      FederalPower{}
    case CL_AM15S1_VoteRace{}:
      RightsProtection{}
    case CL_AM15S2_Enforcement{}:
      FederalPower{}
    case CL_AM19_VoteSex{}:
      RightsProtection{}
    case CL_AM20S5_EffectiveDate{}:
      Declaratory{}
    case CL_AM20S6_RatificationDeadline{}:
      Declaratory{}
    case CL_AM21S2_Transportation{}:
      FederalPower{}
    case CL_AM21S3_RatificationDeadline{}:
      Declaratory{}
    case CL_AM23S1_Electors{}:
      ElectoralOutcome{}
    case CL_AM23S2_Enforcement{}:
      FederalPower{}
    case CL_AM24S1_PollTax{}:
      RightsProtection{}
    case CL_AM24S2_Enforcement{}:
      FederalPower{}
    case CL_AM26S2_Enforcement{}:
      FederalPower{}
    case CL_AM27_CompensationTiming{}:
      LegislativeProcedure{}
    case CL_A1S9_MigrationRestriction{}:
      # A restriction on Congress's power: a FederalPower-scope clause.
      FederalPower{}

def clause_count() -> Nat:
  133n

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
def interpretive_term_is_commerce(t: InterpretiveTerm) -> Bool:
  match t:
    case Commerce{}:
      True{}
    case _:
      False{}
def interpretive_term_is_necessary_proper(t: InterpretiveTerm) -> Bool:
  match t:
    case NecessaryAndProper{}:
      True{}
    case _:
      False{}
def interpretive_term_is_good_behavior(t: InterpretiveTerm) -> Bool:
  match t:
    case GoodBehavior{}:
      True{}
    case _:
      False{}
def interpretive_term_is_extraordinary_occasion(t: InterpretiveTerm) -> Bool:
  match t:
    case ExtraordinaryOccasion{}:
      True{}
    case _:
      False{}
def interpretive_term_is_high_crimes(t: InterpretiveTerm) -> Bool:
  match t:
    case HighCrimesAndMisdemeanors{}:
      True{}
    case _:
      False{}
def interpretive_term_is_republican_form(t: InterpretiveTerm) -> Bool:
  match t:
    case RepublicanForm{}:
      True{}
    case _:
      False{}
def interpretive_term_is_establishment(t: InterpretiveTerm) -> Bool:
  match t:
    case EstablishmentOfReligion{}:
      True{}
    case _:
      False{}
def interpretive_term_is_free_exercise(t: InterpretiveTerm) -> Bool:
  match t:
    case FreeExercise{}:
      True{}
    case _:
      False{}
def interpretive_term_is_militia(t: InterpretiveTerm) -> Bool:
  match t:
    case WellRegulatedMilitia{}:
      True{}
    case _:
      False{}
def interpretive_term_is_keep_bear_arms(t: InterpretiveTerm) -> Bool:
  match t:
    case KeepAndBearArms{}:
      True{}
    case _:
      False{}
def interpretive_term_is_unreasonable(t: InterpretiveTerm) -> Bool:
  match t:
    case Unreasonable{}:
      True{}
    case _:
      False{}
def interpretive_term_is_probable_cause(t: InterpretiveTerm) -> Bool:
  match t:
    case ProbableCause{}:
      True{}
    case _:
      False{}
def interpretive_term_is_infamous_crime(t: InterpretiveTerm) -> Bool:
  match t:
    case InfamousCrime{}:
      True{}
    case _:
      False{}
def interpretive_term_is_same_offence(t: InterpretiveTerm) -> Bool:
  match t:
    case SameOffence{}:
      True{}
    case _:
      False{}
def interpretive_term_is_due_process(t: InterpretiveTerm) -> Bool:
  match t:
    case DueProcess{}:
      True{}
    case _:
      False{}
def interpretive_term_is_common_law_suit(t: InterpretiveTerm) -> Bool:
  match t:
    case CommonLawSuit{}:
      True{}
    case _:
      False{}
def interpretive_term_is_excessive(t: InterpretiveTerm) -> Bool:
  match t:
    case Excessive{}:
      True{}
    case _:
      False{}
def interpretive_term_is_cruel_unusual(t: InterpretiveTerm) -> Bool:
  match t:
    case CruelAndUnusual{}:
      True{}
    case _:
      False{}
def interpretive_term_is_retained_right(t: InterpretiveTerm) -> Bool:
  match t:
    case RetainedRight{}:
      True{}
    case _:
      False{}
def interpretive_term_is_delegated_power(t: InterpretiveTerm) -> Bool:
  match t:
    case DelegatedPower{}:
      True{}
    case _:
      False{}
def interpretive_term_is_privileges_or_immunities(t: InterpretiveTerm) -> Bool:
  match t:
    case PrivilegesOrImmunities{}:
      True{}
    case _:
      False{}
def interpretive_term_is_equal_protection(t: InterpretiveTerm) -> Bool:
  match t:
    case EqualProtection{}:
      True{}
    case _:
      False{}
def interpretive_term_is_valid_public_debt(t: InterpretiveTerm) -> Bool:
  match t:
    case ValidPublicDebt{}:
      True{}
    case _:
      False{}
def interpretive_term_is_appropriate_legislation(t: InterpretiveTerm) -> Bool:
  match t:
    case AppropriateLegislation{}:
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

# --- Condition -> Effect rules: completion wave (46 remaining blocks) ---

# A1S1: all legislative powers vest in Congress (Senate + House).
def rule_a1s1_vesting(legislative_power_in_congress: Bool) -> Bool:
  legislative_power_in_congress

# A1S5: a majority of each House is a quorum to do business.
def rule_a1s5_quorum(counts: ChamberCount) -> Bool:
  quorum_met(counts)

# A1S5: expulsion needs two thirds concurrence. Judgment call: the text names
# no basis; modeled on the present basis (of those voting).
def rule_a1s5_expulsion(yes: Nat, counts: ChamberCount) -> Bool:
  two_thirds(yes, counts, PresentMembers{})

# A1S5: yeas and nays entered at the desire of one fifth of those present.
def rule_a1s5_yeas_nays(desiring: Nat, present: Nat) -> Bool:
  Nat.is_le(present, Nat.mul(5n, desiring))

# A1S5: no adjournment over three days without the other House's consent.
def rule_a1s5_adjournment(days: Nat, other_consents: Bool) -> Bool:
  Bool.or(Nat.is_le(days, 3n), other_consents)

# A1S6: privilege from arrest during attendance, except treason/felony/breach.
def rule_a1s6_arrest_privilege(attending: Bool, treason: Bool, felony: Bool, breach_of_peace: Bool) -> Bool:
  Bool.and(attending, Bool.not(Bool.or(treason, Bool.or(felony, breach_of_peace))))

# A1S6: no questioning elsewhere for speech or debate in either House.
def rule_a1s6_speech_debate(questioned_elsewhere: Bool) -> Bool:
  Bool.not(questioned_elsewhere)

# A1S6: no office-holder under the U.S. sits in either House while in office.
def rule_a1s6_incompatible(holds_office: Bool, is_member: Bool) -> Bool:
  Bool.not(Bool.and(holds_office, is_member))

# A1S6: no foreign present/emolument/office/title without Congress's consent.
def rule_a1s6_emolument(accepts: Bool, congress_consents: Bool) -> Bool:
  Bool.or(Bool.not(accepts), congress_consents)

# A1S8: taxes for debts/defence/welfare; duties/imposts/excises uniform.
def rule_a1s8_tax(tax_for_debts_welfare: Bool, uniform: Bool) -> Bool:
  Bool.and(tax_for_debts_welfare, uniform)

# A1S8: regulate commerce; Commerce is an opaque term input.
def rule_a1s8_commerce(term: InterpretiveTerm, regulated: Bool) -> Bool:
  Bool.and(interpretive_term_is_commerce(term), regulated)

# A1S8: uniform rule of naturalization; uniform bankruptcy laws.
def rule_a1s8_naturalization_bankruptcy(uniform_rule: Bool) -> Bool:
  uniform_rule

# A1S8: coin money, regulate its value, fix weights and measures.
def rule_a1s8_coin_weights(coins_money: Bool) -> Bool:
  coins_money

# A1S8: Congress declares war, grants marque/reprisal, rules captures.
def rule_a1s8_declare_war(congress_declares: Bool) -> Bool:
  congress_declares

# A1S8: necessary-and-proper laws; the term stays an opaque input.
def rule_a1s8_necessary_proper(term: InterpretiveTerm, proper_exercise: Bool) -> Bool:
  Bool.and(interpretive_term_is_necessary_proper(term), proper_exercise)

# A1S9: habeas not suspended unless rebellion/invasion requires it.
def rule_a1s9_habeas(suspended: Bool, rebellion: Bool, invasion: Bool) -> Bool:
  Bool.or(Bool.not(suspended), Bool.or(rebellion, invasion))

# A1S9: no bill of attainder or ex post facto law passes.
def rule_a1s9_attainder(passed: Bool) -> Bool:
  Bool.not(passed)

# A1S9: no capitation/direct tax unless apportioned to the census (AM16
# partially supersedes for income tax; relation R_AM16_A1S9).
def rule_a1s9_direct_tax(laid: Bool, apportioned: Bool) -> Bool:
  Bool.or(Bool.not(laid), apportioned)

# A1S9: no tax or duty on articles exported from any state.
def rule_a1s9_export_tax(tax_on_exports: Bool) -> Bool:
  Bool.not(tax_on_exports)

# A1S9: no money drawn from the Treasury except by appropriation in law.
def rule_a1s9_appropriations(drawn: Bool, appropriated: Bool) -> Bool:
  Bool.or(Bool.not(drawn), appropriated)

# A1S9: no title of nobility granted by the United States.
def rule_a1s9_titles(granted: Bool) -> Bool:
  Bool.not(granted)

# A1S10: no state treaty/alliance/confederation or marque/reprisal.
def rule_a1s10_treaty_alliance(state_enters: Bool) -> Bool:
  Bool.not(state_enters)

# A1S10: no state coinage, bills of credit, or non-gold/silver tender.
def rule_a1s10_coin_tender(state_coins_or_tenders: Bool) -> Bool:
  Bool.not(state_coins_or_tenders)

# A1S10: no state imposts/duties on imports/exports without Congress's
# consent, except inspection-law necessities.
def rule_a1s10_imposts(laid: Bool, congress_consents: Bool, inspection_necessary: Bool) -> Bool:
  Bool.or(Bool.not(laid), Bool.or(congress_consents, inspection_necessary))

# A1S10: no state troops/warships in peacetime, compacts, or war without
# Congress's consent, unless invaded or in imminent no-delay danger.
def rule_a1s10_state_war(keeps_troops: Bool, congress_consents: Bool, invaded: Bool, imminent_danger: Bool) -> Bool:
  Bool.or(Bool.not(keeps_troops), Bool.or(congress_consents, Bool.or(invaded, imminent_danger)))

# A2S2: the President is Commander in Chief of the armed forces and militia.
def rule_a2s2_commander_in_chief(commands: Bool) -> Bool:
  commands

# A2S2: reprieves/pardons for federal offences, except impeachment cases.
def rule_a2s2_pardons(granted: Bool, impeachment_case: Bool) -> Bool:
  Bool.and(granted, Bool.not(impeachment_case))

# A2S2: treaties need two thirds of the Senators present (basis fixed in
# treaty_approved).
def rule_a2s2_treaty(senate_yes: Nat, counts: ChamberCount) -> Bool:
  treaty_approved(senate_yes, counts)

# A2S2: appointments by and with the Senate's advice and consent.
def rule_a2s2_appointments(nominated: Bool, senate_consents: Bool) -> Bool:
  Bool.and(nominated, senate_consents)

# A2S2: recess vacancies filled by commissions expiring at session's end.
def rule_a2s2_recess(vacancy_during_recess: Bool, filled: Bool) -> Bool:
  Bool.or(Bool.not(vacancy_during_recess), filled)

# A2S3: the President takes care that the laws are faithfully executed.
def rule_a2s3_take_care(laws_faithfully_executed: Bool) -> Bool:
  laws_faithfully_executed

# A2S3: on extraordinary occasions the President may convene the Houses.
def rule_a2s3_convene(term: InterpretiveTerm, convened: Bool) -> Bool:
  Bool.and(interpretive_term_is_extraordinary_occasion(term), convened)

# A2S4: civil officers removed on impeachment for and conviction of treason,
# bribery, or other high crimes and misdemeanors (term opaque).
def rule_a2s4_removal(impeached: Bool, convicted: Bool, term: InterpretiveTerm, offense_proven: Bool) -> Bool:
  Bool.and(Bool.and(impeached, convicted), Bool.and(interpretive_term_is_high_crimes(term), offense_proven))

# A3S1: judicial power vests in one supreme Court and inferior courts.
def rule_a3s1_vesting(vested_in_courts: Bool) -> Bool:
  vested_in_courts

# A3S1: judges hold office during good behaviour (term opaque).
def rule_a3s1_tenure(term: InterpretiveTerm, holds_during_good_behavior: Bool) -> Bool:
  Bool.and(interpretive_term_is_good_behavior(term), holds_during_good_behavior)

# A3S1: judicial compensation not diminished during continuance in office.
def rule_a3s1_compensation(diminished: Bool) -> Bool:
  Bool.not(diminished)

# A3S3: treason consists only in levying war or adhering to enemies (evidence
# rule already modeled by treason_conviction_evidence).
def rule_a3s3_treason_definition(levying_war: Bool, adhering_to_enemies: Bool) -> Bool:
  Bool.or(levying_war, adhering_to_enemies)

# A3S3: no corruption of blood or forfeiture beyond the attainted life.
def rule_a3s3_corruption_of_blood(forfeiture_beyond_life: Bool) -> Bool:
  Bool.not(forfeiture_beyond_life)

# A4S1: full faith and credit to sister-state acts, records, proceedings.
def rule_a4s1_full_faith_credit(given: Bool) -> Bool:
  given

# A4S2: citizens of each state entitled to privileges/immunities of the several.
def rule_a4s2_privileges_immunities(entitled: Bool) -> Bool:
  entitled

# A4S2: fugitives from justice delivered up on executive demand.
def rule_a4s2_extradition(charged: Bool, fled: Bool, demanded: Bool) -> Bool:
  Bool.and(charged, Bool.and(fled, demanded))

# A4S2: fugitive-service clause kept verbatim; partially superseded by AM13S1
# (relation R_AM13S1_A4S2) but not repealed, so it stays in force.
def rule_a4s2_fugitive_labor(delivered_up: Bool) -> Bool:
  delivered_up

# A4S3: Congress admits new states; none formed within another's jurisdiction
# or by junction without the states concerned and Congress consenting.
def rule_a4s3_new_state(within_jurisdiction: Bool, by_junction: Bool, states_consent: Bool, congress_admits: Bool) -> Bool:
  match states_consent:
      case True{}:
        congress_admits
      case False{}:
        Bool.and(congress_admits, Bool.and(Bool.not(within_jurisdiction), Bool.not(by_junction)))

# A4S3: Congress disposes of and regulates territory and federal property.
def rule_a4s3_territory(congress_regulates: Bool) -> Bool:
  congress_regulates

# A4S4: the United States guarantees every state a republican form (term opaque).
def rule_a4s4_republican_form(term: InterpretiveTerm, guaranteed: Bool) -> Bool:
  Bool.and(interpretive_term_is_republican_form(term), guaranteed)

# A4S4: protection against invasion; against domestic violence on application
# of the legislature (or executive when it cannot convene).
def rule_a4s4_protection(invasion: Bool, domestic_violence: Bool, application_made: Bool) -> Bool:
  Bool.or(invasion, Bool.and(domestic_violence, application_made))

# A6: Constitution, federal laws, and treaties are the supreme law of the land.
def rule_a6_supremacy(supreme_law: Bool) -> Bool:
  supreme_law

# A6: federal and state legislators and officers bound by oath/affirmation
# to support the Constitution.
def rule_a6_oaths(bound_by_oath: Bool) -> Bool:
  bound_by_oath

# A7: ratification by conventions of nine states suffices to establish.
def rule_a7_ratification(ratifying: Nat) -> Bool:
  Nat.is_le(9n, ratifying)

# AM1: no establishment of religion; free exercise not prohibited (terms opaque).
def rule_am1_religion(est_term: InterpretiveTerm, est_respected: Bool, fe_term: InterpretiveTerm, fe_respected: Bool) -> Bool:
  Bool.and(Bool.and(interpretive_term_is_establishment(est_term), est_respected), Bool.and(interpretive_term_is_free_exercise(fe_term), fe_respected))

# AM1: no abridging speech, press, peaceable assembly, or petition.
def rule_am1_expression(abridged: Bool) -> Bool:
  Bool.not(abridged)

# AM2: the right to keep and bear arms shall not be infringed (terms opaque).
def rule_am2_arms(militia_term: InterpretiveTerm, militia_necessary: Bool, arms_term: InterpretiveTerm, right_preserved: Bool) -> Bool:
  Bool.and(Bool.and(interpretive_term_is_militia(militia_term), militia_necessary), Bool.and(interpretive_term_is_keep_bear_arms(arms_term), right_preserved))

# AM3: no peacetime quartering without owner consent; wartime only as
# prescribed by law.
def rule_am3_quartering(peacetime: Bool, owner_consents: Bool, prescribed_by_law: Bool) -> Bool:
  match peacetime:
      case True{}:
        owner_consents
      case False{}:
        prescribed_by_law

# AM4: the right against unreasonable searches/seizures shall not be violated.
def rule_am4_search(term: InterpretiveTerm, violated: Bool) -> Bool:
  Bool.and(interpretive_term_is_unreasonable(term), Bool.not(violated))

# AM4: warrants only on probable cause, supported by oath, particularly
# describing place/persons/things.
def rule_am4_warrant(term: InterpretiveTerm, probable_cause_shown: Bool, particularly_described: Bool) -> Bool:
  Bool.and(interpretive_term_is_probable_cause(term), Bool.and(probable_cause_shown, particularly_described))

# AM5: no holding to answer for capital/infamous crime without grand-jury
# presentment or indictment.
def rule_am5_grand_jury(term: InterpretiveTerm, held_to_answer: Bool, indicted: Bool) -> Bool:
  Bool.and(interpretive_term_is_infamous_crime(term), Bool.or(Bool.not(held_to_answer), indicted))

# AM5: no one twice put in jeopardy for the same offence (term opaque).
def rule_am5_double_jeopardy(term: InterpretiveTerm, twice_in_jeopardy: Bool) -> Bool:
  Bool.and(interpretive_term_is_same_offence(term), Bool.not(twice_in_jeopardy))

# AM5: no deprivation of life/liberty/property without due process (term opaque).
def rule_am5_due_process(term: InterpretiveTerm, deprived_without_due_process: Bool) -> Bool:
  Bool.and(interpretive_term_is_due_process(term), Bool.not(deprived_without_due_process))

# AM5: private property taken only for public use with just compensation.
def rule_am5_takings(public_use: Bool, just_compensation: Bool) -> Bool:
  Bool.and(public_use, just_compensation)

# AM6: criminal trial by jury, speedy and impartial (terms opaque).
def rule_am6_trial(trial_by_jury: Bool, speedy_term: InterpretiveTerm, speedy_met: Bool, impartial_term: InterpretiveTerm, impartial_met: Bool) -> Bool:
  Bool.and(trial_by_jury, Bool.and(Bool.and(interpretive_term_is_speedy(speedy_term), speedy_met), Bool.and(interpretive_term_is_impartial(impartial_term), impartial_met)))

# AM6: the accused enjoys the assistance of counsel for defence.
def rule_am6_counsel(assistance_of_counsel: Bool) -> Bool:
  assistance_of_counsel

# AM7: jury right preserved where the controversy exceeds twenty dollars.
def rule_am7_civil_jury(value: Nat) -> Bool:
  Nat.is_lt(20n, value)

# AM7: jury-tried facts re-examined only per common-law rules (term opaque).
def rule_am7_reexamination(term: InterpretiveTerm, reexamined_beyond_common_law: Bool) -> Bool:
  Bool.and(interpretive_term_is_common_law_suit(term), Bool.not(reexamined_beyond_common_law))

# AM8: no excessive bail required nor excessive fines imposed (term opaque).
def rule_am8_excessive(term: InterpretiveTerm, excessive_imposed: Bool) -> Bool:
  Bool.and(interpretive_term_is_excessive(term), Bool.not(excessive_imposed))

# AM8: no cruel and unusual punishments inflicted (term opaque).
def rule_am8_cruel_unusual(term: InterpretiveTerm, inflicted: Bool) -> Bool:
  Bool.and(interpretive_term_is_cruel_unusual(term), Bool.not(inflicted))

# AM9: enumerated rights not construed to deny others retained (term opaque).
def rule_am9_retained(term: InterpretiveTerm, denied: Bool) -> Bool:
  Bool.and(interpretive_term_is_retained_right(term), Bool.not(denied))

# AM10: undelegated, unprohibited powers reserved to states/people (term opaque).
def rule_am10_reserved(term: InterpretiveTerm, reserved_to_states: Bool) -> Bool:
  Bool.and(interpretive_term_is_delegated_power(term), reserved_to_states)

# AM11: no federal suit against a state by another state's citizens or
# foreign citizens/subjects.
def rule_am11_immunity(suit_against_state: Bool, by_outsider: Bool) -> Bool:
  Bool.not(Bool.and(suit_against_state, by_outsider))

# AM13S2: Congress enforces abolition by appropriate legislation (term opaque).
def rule_am13s2_enforcement(term: InterpretiveTerm, congress_enforces: Bool) -> Bool:
  Bool.and(interpretive_term_is_appropriate_legislation(term), congress_enforces)

# AM14S1: birth/naturalization in the U.S. plus jurisdiction = citizenship.
def rule_am14s1_citizenship(born_or_naturalized_in_us: Bool, subject_to_jurisdiction: Bool) -> Bool:
  Bool.and(born_or_naturalized_in_us, subject_to_jurisdiction)

# AM14S1: no state denies due process or equal protection (terms opaque).
def rule_am14s1_dp_ep(dp_term: InterpretiveTerm, dp_respected: Bool, ep_term: InterpretiveTerm, ep_respected: Bool) -> Bool:
  Bool.and(Bool.and(interpretive_term_is_due_process(dp_term), dp_respected), Bool.and(interpretive_term_is_equal_protection(ep_term), ep_respected))

# AM14S1: no state abridges citizens' privileges or immunities (term opaque).
def rule_am14s1_privileges(term: InterpretiveTerm, abridged: Bool) -> Bool:
  Bool.and(interpretive_term_is_privileges_or_immunities(term), Bool.not(abridged))

# AM14S3: Congress may remove the insurrection disability by two thirds of
# each House (membership basis).
def rule_am14s3_disability_removed(house_yes: Nat, house: ChamberCount, senate_yes: Nat, senate: ChamberCount) -> Bool:
  Bool.and(two_thirds(house_yes, house, FullMembership{}), two_thirds(senate_yes, senate, FullMembership{}))

# AM14S4: validity of the U.S. public debt shall not be questioned (term opaque).
def rule_am14s4_debt(term: InterpretiveTerm, questioned: Bool) -> Bool:
  Bool.and(interpretive_term_is_valid_public_debt(term), Bool.not(questioned))

# AM14S5: Congress enforces by appropriate legislation (term opaque).
def rule_am14s5_enforcement(term: InterpretiveTerm, congress_enforces: Bool) -> Bool:
  Bool.and(interpretive_term_is_appropriate_legislation(term), congress_enforces)

# AM15S1: no denial/abridgment of the vote on account of race, color, or
# previous servitude.
def rule_am15s1_vote(denied_on_race: Bool) -> Bool:
  Bool.not(denied_on_race)

# AM15S2: Congress enforces by appropriate legislation (term opaque).
def rule_am15s2_enforcement(term: InterpretiveTerm, congress_enforces: Bool) -> Bool:
  Bool.and(interpretive_term_is_appropriate_legislation(term), congress_enforces)

# AM19: no denial/abridgment of the vote on account of sex.
def rule_am19_vote(denied_on_sex: Bool) -> Bool:
  Bool.not(denied_on_sex)

# AM20S5: sections 1-2 take effect Oct 15 after ratification — temporal
# activation belongs to TASKS.md item 3; recorded here as Declaratory.
def rule_am20s5_effective(took_effect: Bool) -> Bool:
  took_effect

# AM20S6: inoperative unless ratified within seven years — temporal; item 3.
def rule_am20s6_deadline(ratified_within_seven_years: Bool) -> Bool:
  ratified_within_seven_years

# AM21S2: liquor transportation/delivery in violation of state law prohibited
# (term opaque).
def rule_am21s2_transportation(term: InterpretiveTerm, transported_in_violation: Bool) -> Bool:
  Bool.and(interpretive_term_is_intoxicating_liquor(term), transported_in_violation)

# AM21S3: inoperative unless ratified by state conventions within seven
# years — temporal; item 3.
def rule_am21s3_deadline(ratified_within_seven_years: Bool) -> Bool:
  ratified_within_seven_years

# AM23S1: District electors equal its would-be Senate+House number, never more
# than the least populous state. The equality is caller-computed (as with the
# Sunday exclusion in presentment); the rule enforces the cap.
def rule_am23s1_electors(entitled_equals_appointed: Bool, least_populous_state_electors: Nat, appointed: Nat) -> Bool:
  match entitled_equals_appointed:
    case True{}:
      Nat.is_le(appointed, least_populous_state_electors)
    case False{}:
      False{}

# AM23S2: Congress enforces by appropriate legislation (term opaque).
def rule_am23s2_enforcement(term: InterpretiveTerm, congress_enforces: Bool) -> Bool:
  Bool.and(interpretive_term_is_appropriate_legislation(term), congress_enforces)

# AM24S1: no denial/abridgment of the vote for failure to pay a poll tax.
def rule_am24s1_poll_tax(denied_for_nonpayment: Bool) -> Bool:
  Bool.not(denied_for_nonpayment)

# AM24S2: Congress enforces by appropriate legislation (term opaque).
def rule_am24s2_enforcement(term: InterpretiveTerm, congress_enforces: Bool) -> Bool:
  Bool.and(interpretive_term_is_appropriate_legislation(term), congress_enforces)

# AM26S2: Congress enforces by appropriate legislation (term opaque).
def rule_am26s2_enforcement(term: InterpretiveTerm, congress_enforces: Bool) -> Bool:
  Bool.and(interpretive_term_is_appropriate_legislation(term), congress_enforces)

# AM27: no law varying congressional compensation takes effect until an
# election of Representatives intervenes.
def rule_am27_timing(varying_law: Bool, election_intervened: Bool) -> Bool:
  Bool.or(Bool.not(varying_law), election_intervened)
# === Temporal activation (TASKS.md item 3) ===
#
# TimePoint uses YEAR granularity. This is a documented modeling choice, not a
# limitation: every temporal provision in the constitutional text is year-dated
# ("the Year one thousand eight hundred and eight"; ratification and repeal
# years). Sub-year events (e.g. AM21 ratified 1933-12-05) resolve to the year
# in which they occurred; the boundary-year choice is documented per
# provision. Finer granularity would not change any verdict the text expresses.
#
# Linearity design note: Bend 2.0.27 consumes every variable exactly once, so
# a closed interval such as AM18's [1920, 1933] cannot be tested with two
# comparisons on one year variable. The temporal API therefore exposes both
# sides separately — `clause_commenced` (has the text taken effect by t?) and
# `clause_unexpired` (has the text lapsed by t?) — each one-sided and directly
# checkable. The full "operative at t" reading is their conjunction, stated at
# the law level where constructor arguments may be repeated freely.
#
# Scope judgment call: these predicates answer whether a clause's TEXT is
# temporally operative at t. Clauses with no temporal provision in the text are
# always commenced and unexpired — the layer does NOT gate ordinary clauses on
# amendment ratification dates (that would import 27 external dates and a
# bigger claim than the task's four provisions: pre-1808, ratification
# deadlines, repeal, succession).

type TimePoint is Data:
  Year{year: Nat}

# A1S9: "The Migration or Importation of such Persons as any of the States now
# existing shall think proper to admit, shall not be prohibited by the Congress
# prior to the Year one thousand eight hundred and eight, but a Tax or duty may
# be imposed on such Importation, not exceeding ten dollars for each Person."
# (National Archives constitution transcript.) The bar on Congress operates
# strictly before 1808; from 1808 Congress may prohibit. True exactly when the
# restriction is operative.
def rule_a1s9_migration_restriction(t: TimePoint) -> Bool:
  match t:
    case Year{year}:
      Nat.is_lt(year, 1808n)

# Has the clause's text COMMENCED operation by t (in effect from)?
def clause_commenced(c: Clause, t: TimePoint) -> Bool:
  match c:
    case CL_AM18S1_Prohibition{}:
      # AM18S3: "after one year from the ratification" (ratified 1919) -> 1920.
      match t:
        case Year{year}:
          Nat.is_le(1920n, year)
    case CL_AM18S2_ConcurrentPower{}:
      match t:
        case Year{year}:
          Nat.is_le(1920n, year)
    case CL_AM18S3_EffectiveDate{}:
      match t:
        case Year{year}:
          Nat.is_le(1920n, year)
    case _:
      # Original text and all other amendments: the layer does not gate
      # ordinary clauses on ratification dates (see scope note above).
      True{}

# Has the clause's text NOT YET EXPIRED by t (not lapsed / not repealed by time)?
def clause_unexpired(c: Clause, t: TimePoint) -> Bool:
  match c:
    case CL_A1S9_MigrationRestriction{}:
      match t:
        case Year{year}:
          Nat.is_lt(year, 1808n)
    case CL_AM18S1_Prohibition{}:
      # Repealed by AM21 ("The eighteenth article of amendment ... is hereby
      # repealed"), ratified 1933-12-05 (National Archives amendments
      # transcript): expired from 1934 at year granularity.
      match t:
        case Year{year}:
          Nat.is_le(year, 1933n)
    case CL_AM18S2_ConcurrentPower{}:
      match t:
        case Year{year}:
          Nat.is_le(year, 1933n)
    case CL_AM18S3_EffectiveDate{}:
      match t:
        case Year{year}:
          Nat.is_le(year, 1933n)
    case _:
      True{}

# --- Ratification deadlines ---
#
# Honesty note: the 7-year ratification deadlines (AM18, AM20, AM21, AM22) live
# in the proposing CONGRESSIONAL RESOLUTIONS, not in the amendment texts. The
# modeled corpus (the constitutional text) states no deadline for any block,
# so `ratification_deadline_for` is honestly `NoDeadlineInText{}` everywhere
# and deadlines arrive as explicit caller-supplied inputs — the same
# record-don't-invent discipline as InterpretiveTerm. Test data such as
# `YearsAfterProposal{7n}` is caller context, not an assertion of
# constitutional text.

type RatificationDeadline is Data:
  NoDeadlineInText{}
  YearsAfterProposal{n: Nat}

def ratification_deadline_for(block: SourceBlock) -> RatificationDeadline:
  # The amendment texts state no deadline; resolutions did. Silent corpus ->
  # silent default for every block.
  match block:
    case _:
      NoDeadlineInText{}

def ratification_timely(proposed_year: Nat, ratified_year: Nat, deadline: RatificationDeadline) -> Bool:
  match deadline:
    case NoDeadlineInText{}:
      True{}
    case YearsAfterProposal{n}:
      Nat.is_le(ratified_year, Nat.add(proposed_year, n))

# --- Succession, time-indexed (AM20, AM25) ---
#
# AM25S1 (ratified 1967-02-10): "the Vice President shall become President" on
# vacancy. Before 1967, A2S1's devolution clause governed ("the Same shall
# devolve on the Vice President"). AM25S3/S4: the VP serves as Acting President
# on inability (1967+).

def vp_becomes_president_on_vacancy(vacancy: Bool, t: TimePoint) -> Bool:
  match t:
    case Year{year}:
      Bool.and(vacancy, Nat.is_le(1967n, year))

def acting_president_serves(inability_declared: Bool, t: TimePoint) -> Bool:
  match t:
    case Year{year}:
      Bool.and(inability_declared, Nat.is_le(1967n, year))

# Reuses the existing AM25S1 clause rule; gates it on AM25's activation.
def succession_rule_effective(vacancy: Bool, t: TimePoint) -> Bool:
  match t:
    case Year{year}:
      Bool.and(rule_am25s1_succession(vacancy), Nat.is_le(1967n, year))

# AM20S1 (ratified 1933-01-23): presidential terms end at noon, January 20.
# The pre-1933 March 4 date was statutory, not constitutional text, so the
# model records only AM20's activation, not a competing textual rule.
def term_commencement_jan20(t: TimePoint) -> Bool:
  match t:
    case Year{year}:
      Nat.is_le(1933n, year)
# === Amendment targets and the Gödel exhibit (math-frontier wave 1A) ===
#
# Article V's text states vote thresholds but almost nothing about *what* an
# amendment may target — except one proviso: "no State, without its Consent,
# shall be deprived of its equal Suffrage in the Senate." The model previously
# checked only the numbers, so an amendment deleting the Bill of Rights and an
# amendment fixing a typo were the same function call. This section adds the
# target dimension.
#
# Design decision (exhibit, don't close): the text is silent on whether
# Article V can amend *itself* — the Gödel self-amendment question. A "strict"
# model would hardcode self-amendment as invalid, but that invents law the
# text does not state. Instead the open question stays an explicit caller
# input (`self_amendment_ok`), the same record-don't-invent discipline as
# InterpretiveTerm. The payoff is a conditional theorem: Gödel's two-step
# (amend Article V to delete the proviso, then amend anything) is exhibited
# as a machine-checked statement *conditional on the caller's interpretive
# judgment* — the executable form of an independence result. What the model
# does NOT establish: whether self-amendment is "really" valid. That remains
# the caller's judgment, by construction.

type AmendmentTarget is Data:
  OrdinaryAmendment{}
  # Triggers the Art. V proviso (equal Senate suffrage).
  EqualSuffrageDeprivation{}
  # An amendment to the amendment rule itself — the Gödel site.
  ArticleVProcedure{}

# Target permissibility, independent of vote counts. The two Bool inputs are
# caller-supplied legal facts/judgments, not model inventions.
def amendment_permissible(target: AmendmentTarget, affected_consent: Bool, self_amendment_ok: Bool) -> Bool:
  match target:
    case OrdinaryAmendment{}:
      # The text bars no ordinary subject matter.
      True{}
    case EqualSuffrageDeprivation{}:
      # Art. V: "no State, without its Consent, shall be deprived of its equal
      # Suffrage in the Senate." Valid only with that State's consent.
      affected_consent
    case ArticleVProcedure{}:
      # The text neither permits nor forbids amending the amendment rule.
      # The caller's interpretive judgment decides; the model records it.
      self_amendment_ok

# Full validity on the congressional-proposal / state-ratification path:
# proposal thresholds AND ratification thresholds AND target permissibility.
# (The convention-application path is not composed here; that is a documented
# path choice, not a claim about the convention route.)
def amendment_valid(target: AmendmentTarget, house_yes: Nat, house: ChamberCount, senate_yes: Nat, senate: ChamberCount, ratifying: Nat, states: StatesCount, affected_consent: Bool, self_amendment_ok: Bool) -> Bool:
  Bool.and(
    Bool.and(
      article_v_congress_proposal(house_yes, house, senate_yes, senate),
      article_v_ratification(ratifying, states)),
    amendment_permissible(target, affected_consent, self_amendment_ok))

# Gödel's two-step as a composed predicate. Step 1 amends Article V itself
# (e.g. deleting the suffrage proviso); step 2 is stated against the
# post-step-1 legal landscape, where the proviso no longer exists, hence its
# OrdinaryAmendment target. The outer conjunction keeps the whole sequence
# conditional on step 1: if step 1 is invalid, the sequence is invalid no
# matter what step 2's hypothetical says. A Bool predicate can express the
# verdict dependency, not the counterfactual world-branching; the comment
# above is the honest statement of what the formula means.
def godel_two_step(h1_yes: Nat, h1: ChamberCount, s1_yes: Nat, s1: ChamberCount, r1: Nat, st1: StatesCount, h2_yes: Nat, h2: ChamberCount, s2_yes: Nat, s2: ChamberCount, r2: Nat, st2: StatesCount, self_amendment_ok: Bool) -> Bool:
  Bool.and(
    amendment_valid(ArticleVProcedure{}, h1_yes, h1, s1_yes, s1, r1, st1, True{}, self_amendment_ok),
    amendment_valid(OrdinaryAmendment{}, h2_yes, h2, s2_yes, s2, r2, st2, True{}, True{}))

# ---------------------------------------------------------------------------
# Amendment reachability (math-frontier wave 2): Gödel's loophole as a
# bounded model-checking query.
#
# ABSTRACT MODEL — read this before citing any reachability result.
# ConstState tracks only what Gödel-style amendment sequences touch:
#   proviso_intact   — the Art. V entrenchment proviso (equal Senate suffrage)
#                      is still operative text;
#   rights_intact    — substantive rights guarantees are still operative;
#   self_rule_intact — the amendment rule itself still demands supermajorities
#                      (it has not been rewritten/captured).
# What the abstraction OMITS (so reachability here does NOT establish about
# the real Constitution): amendment subject matter beyond these three flags,
# the convention path, judicial review, politics, enforcement, and every open
# interpretive term. An OrdinaryAmendment is treated as the archetypal
# rights-eroding amendment: the model OVER-approximates the attacker's power.
# That direction is deliberate. Unreachability results are then strong (they
# hold even against a stronger-than-real attacker); reachability results are
# existential (one model-permitted attack path exists, not a prediction).
# State space: 2^3 = 8 states. Every reachability claim below is about this
# 8-state abstract transition system, at the stated step bound.

type ConstState is Data:
  CState{proviso_intact: Bool, rights_intact: Bool, self_rule_intact: Bool}

# The as-ratified starting point: everything intact.
def const_init() -> ConstState:
  CState{True{}, True{}, True{}}

# Effect helpers take the already-computed validity bit as a parameter.
# (Bend 2.0.27 cannot match on a computed value; matching on a parameter is
# the sanctioned restructure. Each flag is used at most once per branch.)

# A valid ordinary amendment is the archetypal rights-eroding step here: it
# clears rights_intact and touches nothing else.
def apply_ordinary(p: Bool, r: Bool, s: Bool, valid: Bool) -> ConstState:
  match valid:
    case True{}: CState{p, False{}, s}
    case False{}: CState{p, r, s}

# A valid amendment to the amendment rule itself (the Gödel step): it rewrites
# Article V, deleting the entrenchment proviso AND capturing the rule (e.g.
# lowering future thresholds). Both rule-integrity flags fall together.
def apply_articleV(p: Bool, r: Bool, s: Bool, valid: Bool) -> ConstState:
  match valid:
    case True{}: CState{False{}, r, False{}}
    case False{}: CState{p, r, s}

# One amendment step. Invalid amendments leave the state unchanged; valid ones
# flip the flags their target archetype touches. A consensual
# EqualSuffrageDeprivation complies with the proviso, so the proviso text
# remains and no abstract flag changes.
def amendment_step(state: ConstState, target: AmendmentTarget, house_yes: Nat, house: ChamberCount, senate_yes: Nat, senate: ChamberCount, ratifying: Nat, states: StatesCount, affected_consent: Bool, self_amendment_ok: Bool) -> ConstState:
  match state:
    case CState{proviso_intact, rights_intact, self_rule_intact}:
      match target:
        case OrdinaryAmendment{}:
          apply_ordinary(proviso_intact, rights_intact, self_rule_intact, amendment_valid(OrdinaryAmendment{}, house_yes, house, senate_yes, senate, ratifying, states, affected_consent, self_amendment_ok))
        case EqualSuffrageDeprivation{}:
          CState{proviso_intact, rights_intact, self_rule_intact}
        case ArticleVProcedure{}:
          apply_articleV(proviso_intact, rights_intact, self_rule_intact, amendment_valid(ArticleVProcedure{}, house_yes, house, senate_yes, senate, ratifying, states, affected_consent, self_amendment_ok))

# === Temporal-logic properties (LTL-style, explicitly bounded) ===
#
# Each property below is checked over an EXPLICIT finite set of year pairs or
# years, named in each law in LAWS.bend. Bounds are documented per property
# together with what they do NOT establish (nothing outside the checked
# pairs/years). Year granularity throughout (see the temporal section note).
#
# Linearity note: Bend 2.0.27 uses every variable at most once, so multi-year
# properties are composed at the LAW level (where literals repeat freely), not
# inside helpers. The helpers below are all single-use.
#
# Property 4 note (ex post facto): SKIPPED, by design. The model's
# rule_a1s9_attainder(passed) takes only a caller-supplied Bool recording
# whether such a bill passed; it has no conduct-time vs enactment-time
# parameters, and the Ex Post Facto Clause is precisely a relation between
# those two times ("no ... ex post facto Law shall be passed"). Stating a
# temporal property would require inventing a criminal-conduct timeline the
# formalization does not model. The prohibition stays a non-temporal rule.

# Material implication: the workhorse for "once P, always P" over ordered pairs.
def ltl_implies(a: Bool, b: Bool) -> Bool:
  Bool.or(Bool.not(a), b)

# Year-ordering guard: keeps pair-properties honest when y1 > y2 (vacuous there).
def ltl_le(y1: Nat, y2: Nat) -> Bool:
  Nat.is_le(y1, y2)

# A clause's text is expired at t iff it is not unexpired at t.
def clause_expired(c: Clause, t: TimePoint) -> Bool:
  Bool.not(clause_unexpired(c, t))
