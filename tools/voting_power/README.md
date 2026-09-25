# Voting power: Banzhaf indices

Computes normalized Banzhaf power indices for the voting bodies in the
formalization, via dynamic programming over vote counts (never 2^n
enumeration).

## Run

```
python3 tools/voting_power/banzhaf.py      # indices + results.json + report
python3 tools/voting_power/test_banzhaf.py # DP vs brute force (exit 1 on mismatch)
```

## Games and quotas (from the constitutional text)

| game | voters | quota | textual basis |
|---|---|---|---|
| senate_51 | 100 equal | 51 | ordinary legislation, A1S7 |
| senate_67 | 100 equal | 67 | impeachment / treaties, 2/3 present |
| house_218 | 435 equal | 218 | ordinary legislation |
| house_290 | 435 equal | 290 | veto override, 2/3 |
| ec_270 | 51 weighted jurisdictions | 270 | AM12, majority of appointed electors |
| contingent_26 | 50 equal state blocs | 26 | AM12 contingent election, majority of states |

Electoral votes: 2024/2028 apportionment (2020 census), cross-checked across
three published distributions; sum verified = 538.

## Headline results

- Equal-weight bodies: every voter holds exactly 1/n (Senate 0.01, House
  ~0.002299, contingent 0.02), confirmed by the DP.
- Electoral College (quota 270): California 0.110796, Texas 0.076365,
  Wyoming 0.005457.
- Per-electoral-vote power is slightly *higher* for large states
  (CA/WY per-EV ratio 1.13x). The small-state advantage lives in
  apportionment (EVs per capita), not in the index.
- Per-capita (2020 census pops ~39.5M / ~576,850): a Wyoming voter holds
  ~3.4x the presidential-election power of a California voter.

## Machine-checked part

`LAWS.bend` pins a tiny 3-voter weighted game (weights [3,2,1], quota 4)
with hand-computed swing counts A=3, B=1, C=1, implemented as brute-force
defs in `laws.bend` (`banzhaf3_*`) and proven in `PROOF.bend`. The
differential model independently recomputes the same game. This pins the
*logic* of the algorithm (criticality = in a winning coalition whose
removal loses) inside the proof gate.

## Honest boundaries

1. **Banzhaf assumes all coalitions equiprobable.** Real voting has parties,
   ideology, and correlated blocs; the index measures a priori voting
   power under the random-coalition model, not predictive influence.
   Shapley-Shubik (random *orderings*) would give slightly different
   numbers; neither is "the" power.
2. **The Python numbers are analysis, not proof-gate claims.** Only the
   tiny [3,2,1] game is machine-checked. The EC/Senate/House figures are
   computed, tested against brute force on small games, and sanity-checked
   (normalization, monotonicity, per-capita direction) -- but they are not
   proven in Bend.
3. **Equal-weight results are trivially 1/n** and included as regression
   anchors, not discoveries.
4. **Per-capita figures use rounded census populations** (~39.5M, ~576,850)
   and are approximate by construction.
5. Quotas model the *textual* rule (e.g. 2/3 of those present at full
   attendance); absentee effects on the denominator are modeled in
   `laws.bend`'s denominator layer, not here.
