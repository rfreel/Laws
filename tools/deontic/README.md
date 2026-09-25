# Deontic layer

What the Constitution's clauses *require, forbid, or permit* — the repository's
first formal layer about deontic force, as distinct from voting thresholds,
timing, or procedure.

## Methodology: minimal tagging

A clause is tagged only where **all three** hold:

1. Its operative force is explicit in the transcript text — "shall not",
   "no … shall", "shall", "shall have power to", "is hereby prohibited", or a
   close equivalent.
2. The governed act can be named without deciding an open legal term.
3. The bound subject fits the deliberately small subject vocabulary, and the
   clause can be represented honestly by a single `DeonticTag`.

One tag per clause, one clause per tag arm. Everything else is `Untagged{}`.

Result at the reference year: **44 tagged / 89 untagged** of 133 clauses.

### Documented judgment calls

Each is marked at its `clause_deontic` arm in `laws.bend`:

- **(a) Passive-voice convention.** The AM2/AM3/AM4/AM5/AM8 and A1S9
  habeas/appropriations prohibitions name no subject ("shall not be infringed",
  "shall not be suspended"). They are recorded against `FederalGovernment`,
  the sovereign whose ratification made them restraints. Incorporation against
  the states via AM14 is **not** modeled.
- **(b) Anyone-coarsening.** "The United States or any State" (AM15/19/24/26)
  and the enumerated office-holders of the A6 oath clause are recorded as
  `Anyone`, the broadest class in the single-subject type. The overbreadth is
  documented per arm and cannot manufacture a conflict: no opposing force
  exists on these actions in the corpus.
- **(c) Rights-as-duty.** "Shall enjoy the right to …" (AM6/AM7) is recorded
  as the correlative government duty. AM14S4's passive "shall not be
  questioned" is read universally (`Anyone`).
- **Condition folding.** Simple "without X" / "except X" conditions are folded
  into action names (e.g. `DrawMoneyWithoutAppropriation`,
  `EnslaveExceptAsPunishmentForCrime`). The transcript phrase is quoted at the
  arm; conditional *structure* beyond that is not modeled.

### Subject-overlap rule

`deontic_subject_overlap`: two subjects overlap iff identical, or either side
is `Anyone`. Deliberately conservative: `Congress` and `FederalGovernment` do
**not** overlap (pinned by law `deontic_congress_federal_no_overlap`). This
avoids manufacturing conflicts; a real Congress-vs-FederalGovernment conflict
would require the same action with opposing forces, which the corpus does not
contain. `deontic_force_opposes`: Prohibition opposes Duty and Permission;
Duty and Permission are compatible (the flat model has no permission-to-refrain).

## Action vocabulary and source citations

Transcript URLs (from `sourcemap.json`):
- Constitution: <https://www.archives.gov/founding-docs/constitution-transcript>
- Bill of Rights: <https://www.archives.gov/founding-docs/bill-of-rights-transcript>
- Amendments 11–27: <https://www.archives.gov/founding-docs/amendments-11-27>

| Code | Action | Force / Subject | Source clause (transcript) |
|---|---|---|---|
| 1 | AbridgeExpression | Prohibition / Congress | AM1: "Congress shall make no law … abridging the freedom of speech, or of the press; or the right of the people peaceably to assemble, and to petition …" (Bill of Rights) |
| 2 | EstablishReligion | Prohibition / Congress | AM1: "Congress shall make no law respecting an establishment of religion …" (Bill of Rights) |
| 3 | InfringeArms | Prohibition / FederalGovernment* | AM2: "the right of the people to keep and bear Arms, shall not be infringed." (Bill of Rights) |
| 4 | QuarterSoldiers | Prohibition / FederalGovernment* | AM3: "No Soldier shall, in time of peace be quartered in any house, without the consent of the Owner …" (Bill of Rights) |
| 5 | UnreasonableSearchSeizure | Prohibition / FederalGovernment* | AM4: "… against unreasonable searches and seizures, shall not be violated …" (Bill of Rights) |
| 6 | IssueWarrantWithoutProbableCause | Prohibition / FederalGovernment* | AM4: "no Warrants shall issue, but upon probable cause …" (Bill of Rights) |
| 7 | SubjectToDoubleJeopardy | Prohibition / FederalGovernment* | AM5: "nor shall any person be subject for the same offence to be twice put in jeopardy …" (Bill of Rights) |
| 8 | DepriveLifeLibertyPropertyWithoutDueProcess | Prohibition / FederalGovernment* | AM5: "nor be deprived of life, liberty, or property, without due process of law." (Bill of Rights) |
| 9 | TakePropertyWithoutJustCompensation | Prohibition / FederalGovernment* | AM5: "nor shall private property be taken for public use, without just compensation." (Bill of Rights) |
| 10 | RequireExcessiveBailOrFines | Prohibition / FederalGovernment* | AM8: "Excessive bail shall not be required, nor excessive fines imposed." (Bill of Rights) |
| 11 | InflictCruelUnusualPunishment | Prohibition / FederalGovernment* | AM8: "nor cruel and unusual punishments inflicted." (Bill of Rights) |
| 12 | EnslaveExceptAsPunishmentForCrime | Prohibition / Anyone | AM13S1: "Neither slavery nor involuntary servitude, except as a punishment for crime … shall exist …" (Amendments 11–27) |
| 13 | DenyDueProcessOrEqualProtection | Prohibition / StateGovernments | AM14S1: "nor shall any State deprive any person of life, liberty, or property, without due process of law; nor deny … the equal protection of the laws." (Amendments 11–27) |
| 14 | AbridgePrivilegesOrImmunities | Prohibition / StateGovernments | AM14S1: "No State shall make or enforce any law which shall abridge the privileges or immunities of citizens of the United States." (Amendments 11–27) |
| 15 | DenyVoteOnAccountOfRace | Prohibition / Anyone† | AM15S1: "… shall not be denied or abridged by the United States or by any State on account of race, color, or previous condition of servitude." (Amendments 11–27) |
| 16 | DenyVoteOnAccountOfSex | Prohibition / Anyone† | AM19: same formula "… on account of sex." (Amendments 11–27) |
| 17 | ImposePollTax | Prohibition / Anyone† | AM24S1: "… by reason of failure to pay any poll tax or other tax." (Amendments 11–27) |
| 18 | DenyVoteOnAccountOfAge | Prohibition / Anyone† | AM26S1: "… shall not be denied or abridged by the United States or by any State on account of age." (Amendments 11–27) |
| 19 | ElectedPresidentMoreThanTwice | Prohibition / Anyone | AM22S1: "No person shall be elected to the office of the President more than twice" (Amendments 11–27) |
| 20 | ManufactureSellTransportLiquor | Prohibition / Anyone | AM18S1: "the manufacture, sale, or transportation of intoxicating liquors … is hereby prohibited." (Amendments 11–27) — tagged but inoperative (repealed) |
| 21 | TransportLiquorInViolationOfStateLaw | Prohibition / Anyone | AM21S2: "The transportation or importation into any State … of intoxicating liquors, in violation of the laws thereof, is hereby prohibited." (Amendments 11–27) |
| 22 | LayExportTax | Prohibition / Congress | A1S9: "No Tax or Duty shall be laid on Articles exported from any State." (Constitution) |
| 23 | PassAttainderOrExPostFacto | Prohibition / Congress | A1S9: "No Bill of Attainder or ex post facto Law shall be passed." (Constitution) |
| 24 | ProhibitMigrationImportation | Prohibition / Congress | A1S9: "… shall not be prohibited by the Congress prior to the Year one thousand eight hundred and eight." (Constitution) — tagged but expired at 2026 |
| 25 | GrantNobility | Prohibition / FederalGovernment | A1S9: "No Title of Nobility shall be granted by the United States" (Constitution) |
| 26 | SuspendHabeasOutsideRebellionInvasion | Prohibition / FederalGovernment* | A1S9: "The Privilege of the Writ of Habeas Corpus shall not be suspended, unless when in Cases of Rebellion or Invasion …" (Constitution) |
| 27 | DrawMoneyWithoutAppropriation | Prohibition / FederalGovernment* | A1S9: "No Money shall be drawn from the Treasury, but in Consequence of Appropriations made by Law" (Constitution) |
| 28 | LayDirectTaxWithoutApportionment | Prohibition / Congress | A1S9: "No Capitation, or other direct, Tax shall be laid, unless in Proportion to the Census …" (Constitution) |
| 29 | ServeInCongressWhileHoldingFederalOffice | Prohibition / Anyone | A1S6: "no Person holding any Office under the United States, shall be a Member of either House during his Continuance in Office." (Constitution) |
| 30 | QuestionMemberForSpeechDebate | Prohibition / Anyone | A1S6: "for any Speech or Debate in either House, they shall not be questioned in any other Place." (Constitution) |
| 31 | ArrestMemberExceptTreasonFelonyBreach | Prohibition / Anyone | A1S6: "They shall in all Cases, except Treason, Felony and Breach of the Peace, be privileged from Arrest …" (Constitution) |
| 32 | QuestionPublicDebtValidity | Prohibition / Anyone‡ | AM14S4: "The validity of the public debt of the United States … shall not be questioned." (Amendments 11–27) |
| 33 | EnterTreatyAllianceConfederation | Prohibition / StateGovernments | A1S10: "No State shall enter into any Treaty, Alliance, or Confederation" (Constitution) |
| 34 | CoinMoneyEmitBillsNonSpecieTender | Prohibition / StateGovernments | A1S10: "No State shall … coin Money; emit Bills of Credit; make any Thing but gold and silver Coin a Tender in Payment of Debts" (Constitution) |
| 35 | LayImpostsWithoutCongressionalConsent | Prohibition / StateGovernments | A1S10: "No State shall, without the Consent of the Congress, lay any Imposts or Duties on Imports or Exports …" (Constitution) |
| 36 | GuaranteeRepublicanForm | Duty / FederalGovernment | A4S4: "The United States shall guarantee to every State in this Union a Republican Form of Government." (Constitution) |
| 37 | ProtectStatesFromInvasionAndDomesticViolence | Duty / FederalGovernment | A4S4: "and shall protect each of them against Invasion; and on Application of the Legislature … against domestic Violence." (Constitution) |
| 38 | DeliverUpFugitiveFromJustice | Duty / StateGovernments | A4S2: "… shall on Demand of the executive Authority of the State from which he fled, be delivered up …" (Constitution) |
| 39 | AssembleAtLeastAnnually | Duty / Congress | A1S4: "The Congress shall assemble at least once in every Year" (Constitution) |
| 40 | TakeOathToSupportConstitution | Duty / Anyone† | A6: "… shall be bound by Oath or Affirmation, to support this Constitution." (Constitution) |
| 41 | EnsureSpeedyPublicTrial | Duty / FederalGovernment‡ | AM6: "the accused shall enjoy the right to a speedy and public trial …" (Bill of Rights) |
| 42 | EnsureAssistanceOfCounsel | Duty / FederalGovernment‡ | AM6: "… and to have the Assistance of Counsel for his defence." (Bill of Rights) |
| 43 | PreserveCivilJuryTrial | Duty / FederalGovernment‡ | AM7: "… the right of trial by jury shall be preserved." (Bill of Rights) |
| 44 | LayCollectIncomeTax | Permission / Congress | AM16: "The Congress shall have power to lay and collect taxes on incomes …" (Amendments 11–27) |

\* passive-voice convention · † Anyone-coarsening · ‡ rights-as-duty / universal-passive judgment call.

## Tempting but untagged

Deliberately left `Untagged{}` because the minimal bar is not met (each reason
is also noted at the `clause_deontic` wildcard in `laws.bend`):

- **CL_A4S2_FugitiveLabor** — "shall … be delivered up" reads as a duty, but
  its trigger ("Person held to Service or Labour") overlaps AM13's abolition
  in a way that requires interpreting "Service or Labour" against "slavery
  nor involuntary servitude". Tagging it would prejudge that scope question.
- **CL_AM5_GrandJury** — the military exception class makes the prohibitory
  force conditional on a status the flat tag cannot express.
- **CL_A1S10_StateWar** — multi-condition structure ("unless actually invaded,
  or in such imminent Danger"), not a flat prohibition.
- **CL_A3S3_PunishmentLimits** — the bound actor (the sentencing court) is not
  textually named; assigning one would be interpretive.
- **CL_A2S3_TakeCare** — subject "the President" is not in the subject
  vocabulary; coarsening to `FederalGovernment` would misattribute.
- **CL_AM9_RetainedRights** — a meta-interpretive rule about construing the
  enumeration, not a force on conduct.
- **CL_AM10_ReservedPowers** — structural allocation of residual power.
- **CL_A6_Supremacy** — structural supremacy of federal law.
- **CL_AM14S2_Reduction** — a conditional apportionment consequence.
- **CL_AM14S3_DisabilityRemoved** — models the removal power, not the
  disability itself.
- **CL_AM20S4_SuccessionStatute** ("Congress may by law provide …") and all
  **A1S8 "shall have Power" grants** — permissions are tagged only where they
  sit opposite a prohibition on a cognate action (cf. AM16 vs A1S9 direct tax);
  bare power grants are untagged by rule.
- Repeal is never read as permission: **AM21**'s repeal of AM18 does not tag
  any permission to manufacture/sell alcohol (pinned by law
  `deontic_no_conflict_am18_am21_2026`).

## The consistency check

- **Reference year:** 2026. Operative status uses the existing temporal layer:
  `clause_operative_at_2026(c) = clause_in_force(c) ∧ clause_commenced(c, 2026)
  ∧ clause_unexpired(c, 2026)`. Two tagged clauses are inoperative at 2026
  and excluded from the operative set: `CL_AM18S1_Prohibition` (repealed;
  `clause_in_force = False`) and `CL_A1S9_MigrationRestriction` (expired 1808;
  `clause_unexpired(_, 2026) = False`).
- **Route:** `python3 tools/deontic/check.py` — independent of both the
  hand-written `laws.bend` table and the generated Bend pair code. It reuses
  the differential model's own tagging table and temporal functions, enumerates
  all 133 clauses, and checks all **8,778 unordered pairs** (133 choose 2).
  Fails nonzero on any conflict.
- **Result:** 44 tagged / 89 untagged; 42 tagged operative at 2026;
  8,778 pairs checked; **0 conflicts** — in the full pair set and in the
  operative subset.
- **Bend side:** `corpus_pairs_consistent_2026()` (generated by
  `tools/deontic/gen_pairs.py` as a balanced `Bool.and` tree over the 861
  operative-set pairs) is pinned by the law
  `corpus_deontically_consistent_2026`. The generator mechanically verifies its
  exclusion list against `clause_in_force` / `clause_unexpired` and fails
  loudly if either changes.
- **In Bend:** 482 laws total (450 baseline + 32 deontic), all passing
  `bend PROOF.bend` and the Python differential model.

### What the result establishes — and does not

Establishes: relative to the minimal tag table, the subject-overlap rule, and
the declared 44-action vocabulary, no two clauses operative at 2026 impose
opposing deontic forces on the same action for overlapping subjects.

Does **not** establish:

- Untagged clauses (89 of 133) are outside the theorem entirely.
- "Same action" is checked only over the declared vocabulary; two actions
  with different codes never conflict even if a lawyer would see tension.
- It says nothing about doctrinal or semantic consistency — only about the
  recorded tags.
- It says nothing about other years (the tag table is timeless; operative
  status is a 2026 snapshot).

## Reachability hook (design only)

A future amendment transition in the reachability model could introduce a
clause whose tag conflicts with an existing operative tag; the natural
guard is to re-run `tools/deontic/check.py` (or the Bend law) over the
post-transition clause set. This task does not expand the reachability model.
