# The Simple Macroeconomics of AI

> [!NOTE]
> Source: [acemoglu-macroeconomics-of-ai.pdf](../../sources/ai-futures/acemoglu-macroeconomics-of-ai.pdf) — Daron Acemoglu, *The Simple Macroeconomics of AI*, NBER Working Paper No. 32487, May 2024 (prepared for and subsequently published in *Economic Policy*, 2025). https://www.nber.org/papers/w32487
> This is an academic working paper by an MIT economist (later Nobel laureate), written as a deliberate macroeconomic *counterweight* to the more dramatic AI-productivity forecasts of Goldman Sachs, McKinsey, and AGI-focused authors. It is not vendor data or advocacy; it is a task-based economic analysis with explicit, self-flagged speculative assumptions.

## Abstract

The paper evaluates claims of large macroeconomic gains from recent AI advances using a task-based model. Its central discipline is a version of Hulten's theorem: so long as AI's microeconomic effects come from cost savings/productivity improvements at the task level, economy-wide productivity gains equal the fraction of tasks impacted × average task-level cost savings. Applying existing estimates, Acemoglu finds effects that are "nontrivial but modest": total factor productivity (TFP) rises by no more than about 0.66% over 10 years (and, once the harder-to-automate tasks are recognised, less than 0.53%), with GDP up roughly 0.9–1.1% over the decade. His single most citable line, verbatim: "if we take this framework and existing estimates seriously, it is difficult to arrive at very large macroeconomic gains." He also argues AI will not reduce inequality, will widen the capital–labour gap, and that GDP figures can overstate welfare because some AI-created tasks (deepfakes, manipulation, IT attacks) have negative social value. This matters for a chapter on AI's future as the grounded, arithmetic-first case against transformative near-term macro effects.

## Introduction: framing against the hype

Acemoglu opens by contrasting his estimates with the prevailing forecasts. Goldman Sachs (2023) predicts a 7% increase in global GDP (≈ $7 trillion) and a 1.5% per annum rise in US productivity growth over 10 years. McKinsey Global Institute (2023) suggests generative AI could add $17.1–25.6 trillion to the global economy, and that AI plus other automation could raise average annual GDP growth in advanced economies by 1.5–3.4 percentage points over the decade. Korinek and Suh (2024) entertain a "baseline" 100% GDP growth over 10 years and "aggressive" AGI scenarios of 300%. ChatGPT (released 30 November 2022) reached ~100 million monthly users within two months.

He scopes his analysis: the ~10-year (medium-term) horizon; the US economy (where the microeconomic evidence exists); "AI" broadly (not just generative AI); and he distinguishes throughout between aggregate TFP and GDP (per capita/worker) effects, treating task-level productivity improvement as synonymous with cost savings. He focuses on two channels — extensive-margin automation and task complementarities — and sets aside deepening of automation and revolutionary science effects (e.g. protein folding) as unlikely to matter materially within 10 years.

## The task-based method and Hulten's theorem

Production of a final good combines a continuum of tasks (measure N) with elasticity of substitution σ between tasks; he takes σ ≃ 0.5 (from Humlum 2021), so tasks are gross complements. Each task can be done by capital or labour. AI automation expands the set of tasks done by capital (raising threshold I); task complementarities raise labour's productivity in tasks it still performs.

Because the economy is competitive with constant returns, Hulten's theorem applies and "disciplines" the productivity effect. The key equation (his eq. 14):

> d ln TFP = π̄ × (GDP share of tasks impacted by AI)

where π̄ is economy-wide average cost savings. The GDP effect adds the investment response: d ln Y = d ln TFP + s_K · d ln K (eq. 13). He repeatedly stresses the equation is simple but hard to apply, because there is "huge uncertainty" about which tasks are affected and by how much — and that all numbers should be read as "suggestive."

## The two ingredients: exposed tasks and cost savings

**GDP share of tasks impacted.** From Eloundou et al. (2023), who classify all 19,265 O*NET tasks (via GPT-4), Acemoglu takes their granular "automation index," keeping only tasks with >50% of activities impacted ("AI exposed tasks," 4,089 of them). Aggregated to occupations and weighted by wage-bill share (BLS data, 2019–2022), **20% of US labour tasks are exposed to AI.** From Svanberg et al. (2024) on computer vision, only **23% of exposed tasks can be profitably (cost-effectively) automated within 10 years** — for the rest, costs exceed benefits. Extrapolating that fraction to all exposed tasks gives the GDP share impacted within 10 years: 0.23 × 0.20 = **4.6%** of tasks/occupations.

**Cost savings (π̄).** From three "proof-of-concept" experimental studies:
- Peng et al. (2023): GitHub Copilot programmers completed a JavaScript HTTP-server task **55.8% faster**.
- Noy and Zhang (2023): ChatGPT gave **40% faster** completion of white-collar writing tasks and an **18% quality** improvement.
- Brynjolfsson et al. (2023): a real customer-service deployment gave a **~14%** speed improvement; top-quintile associates saw no gain; a slight, insignificant quality decline.

All three concentrate gains among lower-performing/less-expert workers. As a baseline he averages Noy–Zhang and Brynjolfsson et al. (excluding Peng et al. as too narrow), giving average labour cost savings of **27%**. Multiplying by the AI-exposure-adjusted labour share (0.535) converts this to average **overall cost savings of 14.4%** (0.27 × 0.535 ≈ 0.144). Including Peng et al. raises labour cost savings to 36% and overall to 19.3%.

## Headline estimate: the first-pass TFP number

Combining the two ingredients:

> TFP gains over 10 years = 0.046 × 0.144 ≃ **0.0066 (0.66%)**

That is, TFP higher by ~0.66 percentage points in 10 years, or **~0.064% extra annual TFP growth** — "a nontrivial, but modest effect, and certainly much less than both the revolutionary changes some are predicting and the less hyperbolic but still substantial improvements forecast by Goldman Sachs and the McKinsey Global Institute." Using the larger Peng-inclusive cost savings raises it to **0.89%**. Even aggressive assumptions (10%/year computer-vision cost declines → 30% of exposed tasks feasibly automated → ~6% GDP share) still yield only ~0.9%.

He further argues **0.66% is itself an upper bound**, because it ignores three drags: (1) very low actual AI investment — Acemoglu et al. (2022) find <1.5% of US businesses had any AI investment in 2019, especially outside large firms, so the 4.6% share "may be a big overestimate"; (2) J-curve adjustment costs, where digital-technology productivity gains historically stay flat for ~20 years (Greenwood–Yorukoglu 1997; Brynjolfsson et al. 2021); and (3) the presence of hard-to-learn tasks.

## Easy tasks vs hard tasks — the key downward refinement

Easy-to-learn tasks have (i) a reliable, observable outcome metric and (ii) a simple, low-dimensional mapping from action to outcome (e.g. boiling an egg, verifying identity, writing well-known subroutines). Hard-to-learn tasks lack these — outcomes depend on many context-dependent factors, there is no clean success metric, and models can only learn from average human behaviour, so "there will be a tendency for the performance of AI models to be similar to the average performance of human decision-makers, limiting the potential for large productivity improvements." (His example of a hard task: diagnosing a persistent cough.) Crucially, easy/hard is *not* the routine/non-routine distinction (Autor et al. 2003), and "easy" tasks need not be easy for humans.

Since the experimental evidence is all from easy tasks, extrapolating it overstates future gains. Using a GPT-4-assisted classification (verbs, IWAs, and LDA topic clusters fed to a gradient-boosted classifier trained on manual labels), he finds **72.6% (about three-quarters) of wage-bill-weighted exposed tasks are easy** — comprising 3.3% of GDP, with the hard remainder 1.3% of GDP. He assumes hard-task cost savings are **~7%** (about a quarter of the 27% easy-task figure; half of Brynjolfsson et al.'s 14%). The refined estimate (eq. 15):

> TFP gains = 0.033 × 0.144 + (0.046 − 0.033) × 0.037 ≃ **0.0053 (0.53%)**

He views this ~25%-lower figure as "more reasonable." Either way, "the TFP gains within the next 10 years appear quite modest."

## From TFP to GDP

Using the private-business-sector capital share of 0.43, GDP gains ≈ TFP × 1/(1−0.43) = TFP × 1.75. So the 0.66% TFP gives **~1.16% GDP** over 10 years; the hard-task-adjusted 0.53% gives **~0.93%**. The concluding summary states the GDP boost should be **0.93%–1.16%** if the investment increase is modest, or **1.4%–1.56%** if there is a large investment boom (from the fuller Acemoglu–Restrepo 2022 substitution model). He warns that if the capital-output ratio rises, GDP overstates welfare, because the extra investment (and possibly extra energy use) comes out of consumption — consumer welfare tracks TFP/(1−s_K), so **TFP, not GDP, is the welfare-relevant number.**

## "So-so automation," new bad tasks, and what GDP misses

New *good* tasks could raise productivity more than automation and would raise wages and the labour share — but Acemoglu argues these are not the industry's current focus, so few will be created quickly.

New *bad* tasks (deepfakes, misleading digital ads, addictive social media, AI-powered IT attacks) can raise revenue while reducing welfare. Drawing on Bursztyn et al. (2023) on social media: users are willing to pay ~$53/user-month to keep using TikTok/Instagram, yet would pay ~$19/user-month to get everyone (including themselves) off — implying a net negative welfare effect of −19/53 ≈ **−0.36 per dollar of revenue**. Combining with ~2% of US GDP in relevant revenues (social-media/digital-ad revenue ~1.64% of GDP + IT security/attack spending), such activity could **appear to add 2% to GDP while actually reducing welfare by about −0.72%** (consumption-equivalent). The lesson: not all AI-driven GDP increases are welfare gains.

## Wage and inequality effects

Because σ ≈ 0.5 < the capital share (~0.4), productivity gains from AI are "unlikely to lead to sizable wage rises," and automation/complementarities both tend to reduce the labour share. He proves theoretically (§2.10) that even AI improvements that disproportionately help low-skill workers can *increase* inequality, via ripple effects that reallocate workers across tasks.

Empirically, adapting Acemoglu–Restrepo (2022) across 500 demographic groups: **AI exposure is much more evenly distributed across demographic groups than earlier (robotics-era) automation**, so AI is unlikely to raise inequality as sharply as past technologies. But there is **no evidence AI will reduce inequality**: between-group standard deviation of log wages rises slightly (0.35 → 0.36), workers with less than high school see ~1.3% wage growth over 10 years, and **low-education women — especially white, native-born low-education women — are predicted to see real-wage declines.** GDP rises more than average wages, so the **capital share rises ~0.31 percentage points and the capital–labour gap widens.**

## Conclusion

Acemoglu lists four possible macro effect types — singularity (no evidence; not addressed), modest productivity gains, wage/inequality effects, and welfare-reducing "bads" — and analyses the middle two plus the last. His bottom line: TFP up ~0.53–0.66% and GDP up ~0.9–1.6% over 10 years; inequality not reduced; capital–labour gap widened; welfare possibly overstated by GDP. He is careful that this is "modest but still far from trivial," and that much larger gains are *possible* — but would require reorienting AI away from human-like conversation toward reliable, productivity-enhancing information for workers (electricians, nurses, teachers, plumbers), plus new institutions and regulation. He closes: "it remains an open question whether we need foundation models … that can engage in human-like conversations and write Shakespearean sonnets if what we want is reliable information useful for educators, healthcare professionals, electricians, plumbers and other craft workers."

*Self-flagged limitations:* nearly every quantitative input is described as speculative or suggestive; the 23% feasibility figure is extrapolated from computer vision to all AI; productivity evidence is only from easy tasks; new-good-task gains are deliberately excluded; and the propagation-matrix/ripple-effect estimates are borrowed from a 1980–2016 automation context that may not transfer to AI.
