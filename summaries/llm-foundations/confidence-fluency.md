# Dossier — Confidence, Fluency & Convergence

Sources cited by "AI is a jester: How AI makes you confident and wrong" (Johnson Spink, 2026, [LinkedIn](https://www.linkedin.com/pulse/ai-jester-how-makes-you-confident-wrong-johnson-spink-gg3df/)). The article is the connecting essay; the underlying studies are the primary evidence.

> [!NOTE]
> **Verification status (2026-06-30).** All six DOI-bearing citations below (Fernandes, McGlone, Reber, Fazio, Li, Jakesch) had their year, venue, and title confirmed against CrossRef. Open full text was obtained for the arXiv items (Casper, Huschens, Jakesch, Li) and the Anthropic page. The two **HBR** articles (Parra-Moyano 2025; Romasanta 2026) carry no DOI and sit behind a paywall — their internal figures (e.g. "differentiate 96%", the Nvidia forecast shifts) are taken from the jester article and could not be independently verified.

## The two reliable effects

1. **Confidence inflation regardless of performance.**
2. **Convergence on similar outputs regardless of domain.**
No tested remedy (awareness, expertise, careful prompting, team review, disclosure) reliably counters them short of real-time ground-truth feedback.

## Underlying sources

- **Parra-Moyano, Reinmoeller & Schmedders (2025), HBR** (paywalled) — executives who consulted gen AI on a Nvidia price forecast became more optimistic, more confident, and *less* accurate than peers who discussed it together. [link](https://hbr.org/2025/07/research-executives-who-used-gen-ai-made-worse-predictions)
- **Romasanta, Thomas & Levina (2026), HBR** (paywalled) — "trendslop": frontier models asked for strategy converge; chose "differentiate" 96% of the time; context shifts the answer ~11%, better prompting ~2%. [link](https://hbr.org/2026/03/researchers-asked-llms-for-strategic-advice-they-got-trendslop-in-return)
- **Li et al. (2025), CHI** — "As confidence aligns": user self-confidence drifts to match the AI's displayed confidence, persists after the AI is removed, degrades calibration; real-time correctness feedback reduces it. Open arXiv:2501.12868; see [dossier](../papers/2501.12868-confidence-aligns.md). DOI [10.1145/3706598.3713336](https://doi.org/10.1145/3706598.3713336)
- **Jakesch et al. (2023), CHI** — a covertly opinionated writing assistant shifted both what people wrote and the views they later reported (N=1,506). Open arXiv:2302.00560; see [dossier](../papers/2302.00560-co-writing-opinions.md). DOI [10.1145/3544548.3581196](https://doi.org/10.1145/3544548.3581196)
- **Fernandes et al. (2026), Computers in Human Behavior** (paywalled) — "AI makes you smarter but none the wiser": AI raises task performance but flattens metacognition; Dunning-Kruger self-assessment signal is destroyed; more AI knowledge → worse self-assessment. DOI [10.1016/j.chb.2025.108779](https://doi.org/10.1016/j.chb.2025.108779)
- **Casper et al. (2023), TMLR** — RLHF rewards confident/fluent over correct. See [2307.15217 dossier](../papers/2307.15217-rlhf-limitations.md).
- **Huschens et al. (2023), arXiv** — AI text rated clearer/more engaging at equal credibility. See [2309.02524 dossier](../papers/2309.02524-ai-credibility.md).
- **Sofroniew et al. (2026), Anthropic** — emotion vectors organised by valence; positive-valence steering increases sycophancy. See [emotions dossier](../papers/2026-emotions-anthropic.md).

### Processing-fluency psychology (older, paywalled)
- **McGlone & Tofighbakhsh (2000), Psychological Science** — rhyming aphorisms judged more accurate than identical non-rhyming ones (rhyme-as-reason). DOI [10.1111/1467-9280.00282](https://doi.org/10.1111/1467-9280.00282)
- **Reber & Schwarz (1999), Consciousness and Cognition** — higher perceptual fluency (e.g. contrast) raises judged truth. DOI [10.1006/ccog.1999.0386](https://doi.org/10.1006/ccog.1999.0386)
- **Fazio et al. (2015), JEP: General** — illusory-truth effect; repetition raises perceived truth even against known facts. DOI [10.1037/xge0000098](https://doi.org/10.1037/xge0000098)

## Three mechanisms behind confidence + convergence (per the article)

1. **Emotional valence** in training data ("differentiation" sits among positive words; "cost-cutting" among negative) — corroborated mechanistically by the Anthropic emotions paper.
2. **RLHF** rewards confident/fluent answers over correct ones (Casper et al.).
3. **Autoregressive generation** amplifies an initial framing token-by-token.

## Use in book

- Ch1: three mechanisms; processing fluency.
- Ch2 "The Confidence Trap": Nvidia study, fluency, contagion, metacognition, verification scale.
- Ch5 "Overreliance & Convergence": trendslop, deadly interaction.
- Preface: jester metaphor.
