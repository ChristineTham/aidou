# AAAI 2025 Presidential Panel on the Future of AI Research

> [!NOTE]
> Source: [aaai-2025-future-of-ai-research.pdf](../../sources/ai-futures/aaai-2025-future-of-ai-research.pdf) — Francesca Rossi (chair) and the AAAI 2025 Presidential Panel, *AAAI 2025 Presidential Panel on the Future of AI Research*, Association for the Advancement of Artificial Intelligence, March 2025.
> This is a professional-society expert-panel report — institutional and non-vendor. It was written by 24 senior AI researchers (chaired by Francesca Rossi, then AAAI President and an IBM Research fellow) and includes a community survey of ~475 AAAI-community respondents. The panel explicitly notes its findings are "opinions of the panel members and do not represent the opinion of their institutions or companies." A useful counterweight to lab-leader/CEO AGI visions: it is a scholarly-community view, not a product roadmap.

## Abstract

The report is an expert-society survey of the state and trajectory of AI research, organised into 17 themed chapters (AI reasoning, factuality and trustworthiness, agents, evaluation, ethics and safety, embodied AI, cognitive science, hardware, social good, sustainability, scientific discovery, AGI, AI perception vs. reality, diversity of approaches, academia, geopolitics, and more). Each chapter sketches history, current trends and open challenges, and reports a community-opinion summary drawn from a survey of 475 respondents (about 20% students; 67% academia, 19% corporate research; 53% North America, 20% Asia, 19% Europe). Its central, most-citable finding is that the surveyed research community is broadly sceptical of the dominant "just scale it up" path to AGI: **76% of respondents assert that "scaling up current AI approaches" to yield AGI is "unlikely" or "very unlikely" to succeed.** Verbatim: *"The majority of respondents (76%) assert that 'scaling up current AI approaches' to yield AGI is 'unlikely' or 'very unlikely' to succeed, suggesting doubts about whether current machine learning paradigms are sufficient for achieving general intelligence."* This matters for a chapter on AI's future because it documents, from inside the professional research community, a large gap between AGI hype and researcher expectation.

## The document and its method

Chaired by Francesca Rossi (AAAI President 2022–2025, IBM Research), the panel of 24 experienced researchers — including Rodney Brooks, Eric Horvitz, Stuart Russell, Thomas Dietterich, Oren Etzioni, Peter Stone, Virginia Dignum, Michael Wooldridge and others — worked from summer 2024 to spring 2025 via monthly calls, per-chapter teams and a full-day in-person meeting in January 2025. The report is deliberately written in a "non-technical way" to reach policymakers, funding agencies, media and the general public. The community survey was prepared and delivered by the AAAI office; 475 people responded. 95% of respondents expressed interest in multi-disciplinary research.

## AGI chapter (chaired by Eric Horvitz and Stuart Russell)

The chapter frames AGI as a long-standing ambition of the field (traced to the 1955 Dartmouth proposal and Herb Simon's 1957 prediction), not a new goal, while noting the term "AGI" itself emerged in the early 2000s as a call for ambition against a field then seen as narrowly applied. It stresses that **AGI is not a formally defined concept, nor is there any agreed test for its achievement**, and reports genuine disagreement over whether it is even a desirable research goal — some argue its short-term monetary value lies mainly in replacing humans in economic roles, and that many purported benefits can be reached with narrower tools such as AlphaFold2.

On current trends, the panel notes the clear decade-long trajectory of AI reaching human-level or superhuman performance on "one task after another," and singles out 2024 advances in reasoning, including success on the ARC-AGI abstract reasoning challenge, "on which AI systems had utterly failed before 2024." It attributes recent gains to run-time / "test-time" deliberation mechanisms (chains of thought), analogising the shift from "system 1" to "system 2" cognition, and flags that these greatly increase run-time energy and monetary cost. It cautions that leading models still show "elementary failures" (e.g. on word-plus-image maths problems humans find easy, on spatial/geometric reasoning, and on long-horizon planning). Research challenges listed include: architectures beyond transformers; long-term planning and reasoning; generalisation beyond training data; continual/lifelong learning; structured episodic memory; causal and counterfactual reasoning; embodiment; and alignment, interpretability and safety.

### AGI community-opinion survey findings (verbatim numbers)

- **76%** assert that "scaling up current AI approaches" to yield AGI is "unlikely" or "very unlikely" to succeed.
- **77%** prioritise designing AI systems with an acceptable risk–benefit profile over the direct pursuit of AGI (vs 23% who prioritise pursuing AGI directly).
- **82%** believe that systems with AGI should be publicly owned if developed by private entities.
- **70%** oppose halting research aimed at AGI until full safety and control mechanisms are established.

The panel reads these together as "a cautious yet forward-moving approach": researchers prioritise safety, ethical governance, benefit-sharing and gradual innovation over "a race toward AGI."

## AI Perception vs. Reality chapter (chaired by Rodney Brooks)

This chapter is the report's most direct statement on hype. It argues AI has gone through repeated hype cycles since 1956, that "all hype bubbles eventually burst," and that the current Generative AI hype is many people's first exposure to AI, leaving them without tools to gauge claims. It cites Gartner's November 2024 estimate that Generative AI hype had "just passed its peak," and quotes historian Thomas Haigh ("From engines of logic to engines of bullshit?") and Narayanan and Kapoor's *AI Snake Oil* (2024). Survey findings (36% of respondents self-selected to answer this theme, so a selection bias is noted):

- **79%** disagreed (47%) or strongly disagreed (32%) that "the current perception of AI capabilities matches the reality of AI research and development."
- **90%** agreed the mismatch is hindering AI research — **74%** specifically saying research directions are driven by the hype.
- **78%** supported a community initiative to counter hype by fact-checking AI claims; **87%** supported educating the public (including press and VCs) about the diversity of AI techniques.

## Other notable survey findings

**AI Reasoning** (chaired by area experts; ~55% of respondents answered): 79% said reasoning is relevant to their research (44.7% "very relevant"). Tellingly, when asked what properties define "reasoning," only **37.4%** marked "guaranteed correctness of inference results/outcomes" and only **23.7%** "a formal system and solver is used" — the panel reads this as a shift toward "informal, plausible reasoning" in the generative-AI era, and warns that the importance of formal, sound reasoning may need better communication. **76.9%** rated integrating learning and reasoning as very important; **71.7%** said the same for explainability and verifiability.

**Factuality & Trustworthiness**: over **75%** of the community said factuality and trustworthiness were relevant or very relevant to their research. The greatest demand for improving factuality was for new neural-net architectures (73% important/very important), then external fact-checking tools (70%). For trustworthiness, new architectures again ranked highest (77%), then models describing their reasoning (70%). Notably, **~60% disagreed that either factuality or trustworthiness would soon be solved**, and **59%** agreed that "trustworthiness as currently formulated is ill-defined." The community favoured framing the work as "risk and mitigation" rather than "solving" these problems.

## Overall stance and limitations

The report's throughline is that the professional research community is measured and sceptical where public and vendor discourse is exuberant: it doubts that scaling alone reaches AGI, sees a large and research-hindering gap between AI's perceived and actual capabilities, and does not expect factuality or trustworthiness to be "solved" soon — while still supporting continued, safeguarded research. Stated limitations: survey respondents are self-selected (and per-theme response rates vary, e.g. only 36% answered the Perception vs. Reality questions and ~55% the Reasoning questions), skewing toward academia (67%) and North America (53%); and the panel is explicit that its conclusions are members' opinions, not institutional positions.
