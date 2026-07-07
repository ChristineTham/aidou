# Canaries in the Coal Mine? Six Facts about the Recent Employment Effects of Artificial Intelligence

> [!NOTE]
> Source: [brynjolfsson-canaries-coal-mine.pdf](../../sources/ai-futures/brynjolfsson-canaries-coal-mine.pdf) — Erik Brynjolfsson, Bharat Chandar & Ruyu Chen, *Canaries in the Coal Mine? Six Facts about the Recent Employment Effects of Artificial Intelligence*, Stanford Digital Economy Lab working paper, 13 November 2025. https://digitaleconomy.stanford.edu/publications/canaries-in-the-coal-mine/
> This is an **empirical working paper / preprint — not yet peer-reviewed**. It is quantitative labour-economics research using proprietary payroll microdata from ADP (the largest US payroll processor). The authors themselves caution that the documented patterns "may in part be influenced by factors other than generative AI" and describe the evidence as *consistent with*, not proof of, a causal AI effect. Cite as **Brynjolfsson, Chandar & Chen, 2025** — this is a distinct, newer paper from the already-cited *Generative AI at Work* (Brynjolfsson et al., 2023).

## Abstract

Using high-frequency administrative payroll data from ADP covering millions of US workers through September 2025, the authors document six facts about how the labour market has shifted since the widespread adoption of generative AI. The central, most citable finding: **early-career workers (ages 22–25) in the most AI-exposed occupations experienced a ~16% relative employment decline** (controlling for firm-level shocks) since generative AI's diffusion in late 2022, while employment for experienced workers in the same occupations, and for workers of all ages in less-exposed occupations, remained stable or grew. Crucially, the adjustment shows up in **headcount, not wages** ("Adjustments occur primarily via employment rather than compensation"), and is concentrated in occupations where AI **automates** rather than **augments** labour. Results are robust to excluding technology firms and remotable occupations. The title's metaphor — "canaries in the coal mine" — frames young, exposed workers as early harbingers of potentially more widespread AI labour-market effects. It matters for a chapter on AI's future because it is among the first large-scale, near-real-time empirical measurements of realised (not projected) AI employment effects.

## Metadata (verified at source)

- **Title:** *Canaries in the Coal Mine? Six Facts about the Recent Employment Effects of Artificial Intelligence* (from PDF title page and document metadata).
- **Authors:** Erik Brynjolfsson (Stanford University and NBER), Bharat Chandar (Stanford University), Ruyu Chen (Stanford University).
- **Date:** November 13, 2025 (title-page date; PDF creation/mod date 2025-11-13). This is the revision read; the "latest version" lives at the Stanford Digital Economy Lab URL above.
- **Venue:** Stanford Digital Economy Lab working paper (unpublished, not peer-reviewed). 65 pages including appendices and references.
- **Data source acknowledgement:** ADP (data access) and the Stanford Digital Economy Lab (financial support).

## Introduction and motivation

The paper opens against the global debate over generative AI's labour-market impact — utopian productivity gains, dystopian displacement, and sceptical "minimal effect" views. The authors situate their work amid rapid capability gains and adoption:

- On the SWE-Bench software-engineering benchmark, AI systems improved from solving **4.4% of coding problems in 2023 to 71.7% in 2024** (citing Maslej et al., 2025).
- Current systems "could match or outperform up to **47 percent** of industry professionals" on a benchmark of economically valuable tasks (Patwardhan et al., 2025).
- LLM adoption at work among US respondents over 18 "reached **46% by June/July 2025**" (Hartley et al., 2025); Bick et al. (2024) found nearly 40% of US 18–64s used generative AI in late 2024, 23% weekly for work, 9% daily.

They cite the policy salience directly: in May 2025 Anthropic CEO **Dario Amodei predicted AI could wipe out roughly 50% of all entry-level white-collar jobs within five years** (Morris, 2025). The paper's stated purpose is to close the empirical gap with actual, high-frequency data rather than projections.

The authors also offer a **mechanism**: AI may disproportionately substitute for **codified knowledge** (the "book-learning" of formal education and codifiable company data), while being less able to replace the **tacit knowledge** accumulated through experience. Young workers supply relatively more codified than tacit knowledge, so they face greater task replacement in exposed occupations. Firms may also prefer to shrink junior *inflows* (reduced hiring) rather than displace incumbents, given training/retention frictions.

## Data and methods

- **Payroll data:** ADP, "the largest payroll processing firm in America," servicing firms employing **over 25 million US workers**. Monthly, individual-level records January 2021 – September 2025.
- **Sample restrictions:** positive earnings only, full-time only, under age 70, must have a recorded job title (ADP observes titles for ~70% of workers), and firms kept only if they have earnings records every month Jan 2021–Sep 2025 (balanced panel). Over 7,000 standardised job titles mapped to 2010 SOC codes by ADP's research team.
- **Resulting sample:** records on **3.5–5 million workers each month** in the main analysis sample. Between **250,000 and 350,000 employed 22–25-year-olds per month** — vastly larger than the CPS, which surveys only 44,000–51,000 employed people across *all* ages monthly (10,000–12,000 with earnings records).
- **AI-exposure measures (two):** (1) Eloundou et al. (2024) GPT-4-based *β* exposure by O*NET task, aggregated to SOC codes; (2) the **Anthropic Economic Index** (Handa et al., 2025), which uses several million Claude conversations to estimate the share of queries per O*NET task and, for each task, the share that is **"automative," "augmentative,"** or neither.
- **Other data:** Dingel and Neiman (2020) teleworkability; BLS PCE index for real earnings (indexed to Oct 2017); CPS as a comparison benchmark.
- **Key regression (Fact 4):** a Poisson event-study regression with **firm-quintile fixed effects** and **firm-time fixed effects**, run separately by age group, with October 2022 as the reference period (*t* = −1). Firm-time effects absorb aggregate firm shocks hitting all exposure quintiles equally; standard errors clustered by firm.

## The Six Facts

**Fact 1 — Employment for young workers has declined in AI-exposed occupations.** For software developers and customer-service representatives (frequently cited as highly exposed), employment for the youngest workers (22–25) fell considerably after 2022 while other age groups kept growing. **Software developers aged 22–25 declined nearly 20% by September 2025 from their late-2022 peak.** By contrast, in less-exposed occupations the age pattern does not appear — e.g. health aides (nursing, psychiatric, home health aides) show young-worker employment *growing faster* than older workers. Across all occupations, the youngest workers show a clear divergence: more-exposed occupations decline, less-exposed grow; older age groups show much weaker differences by exposure.

**Fact 2 — Overall employment keeps growing, but young-worker employment growth has been stagnant since late 2022.** For the lowest three AI-exposure quintiles, employment grew **5–13%** from late 2022 to September 2025 across all age groups, with no clear age ordering. But in the highest two exposure quintiles, employment for **22–25-year-olds declined ~6%** while employment for **35–49-year-olds grew over 8%** (the intro states older workers saw a 6–9% increase). Declining employment in AI-exposed jobs is what drives the tepid overall growth for young workers.

**Fact 3 — Declines concentrate in AI that *automates*, not AI that *augments*.** Using the Anthropic Economic Index automation/augmentation classification: occupations with the highest **automation** shares show declining young-worker employment; occupations with the highest **augmentation** shares do *not* — the top augmentation quintile is among the fastest-growing. Consistent with automative AI substituting for labour while augmentative AI does not.

**Fact 4 — The decline survives firm-time controls (the headline number).** After conditioning on firm-time and firm-quintile fixed effects in the Poisson event study, workers aged 22–25 show a **15 log-point decline in relative employment** for the most-exposed versus least-exposed quintile — large and statistically significant. (The abstract and conclusion state this as a **~16% relative employment decline** — 15 log points ≈ 16%.) Estimates for other age groups are much smaller and not statistically significant. This rules out the confounder that AI-exposed young workers simply sort into firms hit by common shocks (e.g. interest-rate sensitivity).

**Fact 5 — The adjustment is in employment, not compensation.** Using annual base compensation (deflated to 2017 dollars via PCE), the authors find **little difference in salary trends by age or exposure quintile** — far less divergence than in employment. This suggests possible **wage stickiness** in the short run, and that AI may (at least initially) affect employment more than wages — "or even that AI may boost wages for as many workers as it hurts." (They cite Autor and Thompson, 2025, on offsetting expert/inexpert wage effects.)

**Fact 6 — Findings are robust across alternative sample constructions.** Results hold when: excluding computer occupations (SOC 15-1) and IT/computer-systems-design firms (NAICS 51, 5415); splitting teleworkable vs non-teleworkable occupations (so not merely outsourcing/WFH); extending the balanced sample back to 2018 (the exposure-based divergence appears only in the post-GPT era, not before — and for the Anthropic measures pre-2022 trends are comparable across exposure); splitting high- vs low-college-share occupations (so not merely COVID-era education decline — and for low-college occupations the exposure divergence extends up to age 40, i.e. experience buffers non-college workers less); controlling for occupational interest-rate exposure (which is *negatively* correlated with AI exposure); and splitting by sex. CPS comparisons are noisy given small fine age-occupation cells.

## Conclusion and stated limitations

The paper's conclusion restates the six facts and, notably, gives the headline as: "**After conditioning on firm-time effects, young workers experienced a 16% relative employment decline in the most exposed occupations.**" The authors are careful: "While our main estimates may be influenced by factors other than generative AI, our results are consistent with the hypothesis that generative AI has begun to affect entry-level employment significantly." They draw an analogy to prior general-purpose-technology transitions (the IT revolution) that ultimately produced robust employment and wage growth after adjustment, and commit to **ongoing monitoring** to see whether the trends accelerate. They call for better firm-level AI-adoption data to sharpen causal identification.

**Self-stated limitations / caveats to preserve when citing:**
- Not peer-reviewed; a working paper subject to revision.
- ADP's firm composition does not exactly match the US economy (over-represents Northeast, manufacturing/services; ADP firms grow faster than average).
- Correlational, not a clean causal identification; authors explicitly do not claim proof of causation.
- Contemporaneous studies disagree — e.g. Humlum and Vestergaard (2025) found minimal entry-level effects in Denmark — and reconciling these is flagged as future work.

## Note on the headline figure (for accurate citation)

The paper reports two related but distinct numbers, which should not be conflated:
- **~6% absolute employment decline** for 22–25-year-olds in the most-exposed occupations from late 2022 to September 2025 (raw, Fact 2); software developers specifically fell ~20% from peak (Fact 1).
- **~16% relative employment decline** (15 log points) for 22–25-year-olds in the most- vs least-exposed occupations *after* controlling for firm-time shocks (Fact 4, abstract, conclusion). This is the paper's stated headline number.
