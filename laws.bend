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
