# Individual vulnerability to industrial robot adoption increases support for the radical right — Summary

> [!NOTE]
> **Source:** [anelli-colantone-stanig-robot-radical-right.pdf](../../sources/ai-futures/anelli-colantone-stanig-robot-radical-right.pdf) · Massimo Anelli, Italo Colantone & Piero Stanig (Bocconi University; CESifo), 2021 · *PNAS* 118(47), e2111611118 · https://doi.org/10.1073/pnas.2111611118 (open access via PMC8617521). Published 19 November 2021; all three authors contributed equally.
> Study-guide summary of a peer-reviewed political-science paper. **Scope caveat — read before citing:** this study is about *past* automation (industrial-robot adoption in manufacturing, 1999–2015) and *actual voting* in western Europe. It is **not** about generative AI, attitudes toward AI, or knowledge work. It can support the book's AI-grievance argument only **by analogy** — as evidence of how a prior automation wave reshaped politics — never as direct evidence about AI.

## Abstract

This PNAS paper asks what industrial-robot automation did to voting in 13 western European countries between 1999 and 2015, using seven waves of the European Social Survey. Its methodological move is a new measure of **individual** (not regional) exposure to automation, built to avoid the bias in earlier work that used people's *current* occupation. The central finding: individuals more exposed to automation are more likely to vote for the **radical right** — a one-standard-deviation rise in exposure raises the probability of a radical-right vote by **2.8 percentage points**, against a baseline of ~4.8%. The effect survives controls for the usual rival explanations (nativism, status threat, cultural traditionalism, the China trade shock, offshoring). Automation exposure also raises radical-*left* support, but only about one-third as much (0.01 vs 0.028), and it *lowers* mainstream-right support (−0.037); more-exposed individuals also report lower satisfaction with government and democracy, worse economic perceptions, and less job security. The upshot: the losers of an automation wave — even when their current job looks safe — drift toward anti-system, radical-right politics.

> [!IMPORTANT]
> Main thesis: "individuals more vulnerable to negative consequences of automation tend to display more support for the radical right." The distributional losers of automation, identified individually rather than by region, turn toward anti-establishment and radical-right parties.

## Introduction — the question

- The rise of populist and radical-right parties is a defining feature of advanced-democracy politics. Prior work explains it via two families of drivers: **cultural** (status threat, nativism, xenophobia) and **structural-economic** (globalization, technological change producing winners and losers).
- Earlier economic work focused on **globalization** (the "China shock", offshoring), both of which peaked before the 2008 crisis. The authors argue **automation** — robotization of manufacturing, intensifying after 2010 — is the underexamined recent economic transformation with well-documented distributional effects.
- Public opinion already fears automation: a 2018 Pew survey found 85% (Canada), 83% (Italy), 90% (Japan) expected robots/computers to do much human work; large majorities expected fewer jobs and a wider wealth gap. Two U.S. Pew surveys (2018–19): 50% said workplace automation has mostly hurt workers; 75% said it contributed to inequality.

## Two methodological challenges (why individual-level analysis)

1. **Regional analysis masks the effect.** Regions that adopt more robots may also be more economically dynamic, so aggregate welfare gains hide the distributional pain. Fig. 1 shows wide *within-region* heterogeneity in individual vulnerability — the distributions across low/medium/high regional-shock terciles largely overlap. Fig. 2 shows individual exposure is significantly associated with worse outcomes (less likely to hold a permanent contract, worse economic perceptions and well-being, lower satisfaction with government and democracy), whereas *regional* exposure mostly is not statistically discernible.
2. **Current occupation is contaminated.** Measuring exposure by someone's *current* job misclassifies automation losers: a worker displaced from manufacturing into low-wage services now looks "low exposure"; the unemployed have no occupation at all. This is **direct displacement**; automation also causes **indirect displacement** by shrinking good-job opportunities for new labour-market entrants and on-the-job searchers.

## The new measure of individual exposure

A three-part construct (their Eq. 3), designed to be uncontaminated by automation's own effects:

| Component | What it is | Source |
|---|---|---|
| 1. Occupational probabilities | Predicted probability each individual works in each occupation, from a model of occupation on age, gender, education, region — estimated on **early-1990s (pre-automation)** labour markets | EU Labour Force Survey (EU-LFS) |
| 2. Automatability score (θⱼ) | Each occupation's computerisation probability | Frey & Osborne (2017) |
| 3. Pace of robot adoption (ΔRct) | National % change in operational robots, years t−1 vs t−3 | International Federation of Robotics (IFR) |

- **Individual vulnerability** = (occupation probabilities) · (automatability scores). **Individual exposure** = vulnerability × pace of robot adoption.
- Intuition: for a given national robotization pace, the measure assigns higher exposure to people who — based on the historical labour market — *would have been* likely to hold highly automatable jobs, regardless of what they do now (or whether they are employed).
- The same machinery is reused to build an individual **offshoring** exposure measure as a robustness/comparison exercise.

## Theory — why automation losers pick the *radical right* specifically

Four non-mutually-exclusive channels:

1. **Anti-establishment appeal.** Economic discontent breeds disaffection with mainstream parties; radical-right parties credibly pose as the anti-establishment alternative (also available to the radical left).
2. **Economic nationalism / "taking back control."** Radical-right platforms promise generic protection from impersonal global/technological forces. People often *misattribute* automation-driven distress to immigration and trade, and demand trade protection even when layoffs are explicitly framed as automation-caused.
3. **Nostalgia and traditionalism.** "Turn back the clock" rhetoric — a mythologised past with stable, well-paid (male-breadwinner) jobs — appeals to those whose relative standing is declining.
4. **Authoritarian/nativist shift.** Economic vulnerability is linked to rising authoritarianism and nativism; experiments show automation-motivated layoffs increase anti-immigrant sentiment. These attitudes map onto radical-right platforms, not the libertarian/solidaristic radical left.

## Data and empirical strategy

- **Data:** first seven waves of the European Social Survey (ESS); vote is the party chosen at the last election before interview; elections span **1999–2015**; **13 western European countries** (Austria, Belgium, Finland, France, Germany, Italy, Netherlands, Norway, Portugal, Spain, Sweden, Switzerland, United Kingdom).
- **Model:** linear probability model with **region fixed effects** and **country-year (election) fixed effects**, controlling for age, gender, education; SEs clustered at region-year. Coefficients are per one-SD change in standardized exposure.
- **Endogeneity:** robot adoption is procyclical and may correlate with labour laws/unionization, so they **instrument** domestic robot adoption with robot adoption in *other* countries (shared technological trajectories, plausibly exogenous to domestic politics). Robust to alternative instruments (non-European economies; robot unit prices; computer-price index; single-thread performance; transistor counts).

## Main results

- **Radical right:** OLS and IV coefficients on individual exposure are positive and significant; IV > OLS (consistent with procyclicality). A one-SD rise in exposure → **+2.8 percentage points** probability of voting radical-right, against a **~4.8%** sample baseline — a substantively large effect.
- **Robust to rival drivers.** Adding controls (and interactions) for cultural traditionalism, nativism, status threat, China shock, and offshoring leaves the automation coefficient stable and precisely estimated. Cultural factors are also significant — the two explanations are complementary, not exclusive. Interaction terms hint at mild *substitution* (automation matters more for those not already drawn to the radical right for cultural reasons).
- **Channels (Fig. 4).** Automation exposure significantly *raises* cultural traditionalism, nativism, and perceived status threat — suggesting cultural attitudes are partly downstream of (post-treatment to) the economic shock.

## Other party families and polarization

| Party family | Effect of a one-SD rise in automation exposure |
|---|---|
| Radical right | **+0.028** (baseline) |
| Radical left | +0.01 (≈ one-third of the radical-right effect; significantly smaller) |
| Mainstream right | −0.037 (significant) |
| Mainstream left | negative, not statistically significant |

- Net picture: automation **increases political polarization** — support flows to the extremes (right more than left) and away from mainstream parties. The radical-right advantage over the radical left is attributed to the former combining protectionism *and* authoritarian nationalism, whereas the radical left offers protectionism/redistribution but not nationalism (and evidence on automation raising redistribution demand is mixed).

## Conclusion

Higher exposure to automation increases support for radical-right parties in western Europe. An **individual-level** analysis is essential because automation's distributional effects unfold *within* regions and because current-occupation measures are contaminated by displacement. The paper adds automation to the material drivers of the radical right while showing it interacts with — and partly operates through — cultural factors. Replication data are on the Harvard Dataverse (10.7910/DVN/ITFA7O). Funded by EU Horizon 2020 grant 822390.

## Relation to the book

This paper is the strongest available empirical anchor — used **by analogy only** — for §6.5's hedged claim that people who bear AI's costs without sharing in its benefits may turn against it. It shows that a *previous* automation wave did exactly this: the individually-identified losers of industrial robotization did not merely report dissatisfaction (lower satisfaction with government and democracy, worse economic perceptions) but changed their **votes**, shifting toward anti-system radical-right parties by a substantively large 2.8 points per standard deviation — and did so even when their *current* job looked safe, which is precisely the population the naïve occupation-based measure misses.

The caveat must travel with the citation. The study concerns **industrial robots and manufacturing**, not generative AI, and **actual voting behaviour**, not attitudes toward AI. So it cannot be presented as evidence about AI's political fallout; it is a historical precedent that makes the book's conditional ("*may* turn against it") plausible rather than proven. It pairs naturally with the Quinnipiac 2025 poll cited alongside it: Quinnipiac shows today's AI grievance is still diffuse and second-hand (a majority expects job cuts, yet 78% of workers feel personally safe; optimism rises with income), while Anelli–Colantone–Stanig shows what happened politically once an earlier automation shock became *individually* felt. Together they support §6.5's warning about who captures AI's gains and what can follow if the losers are left to bear the costs — the analogy sharpens the hedge without overstating the evidence.
