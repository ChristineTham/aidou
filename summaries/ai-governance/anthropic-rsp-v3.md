# Anthropic's Responsible Scaling Policy: Version 3.0

> [!NOTE]
> Source: [anthropic-rsp-v3.md](../../sources/ai-governance/anthropic-rsp-v3.md) — Anthropic, *Anthropic's Responsible Scaling Policy: Version 3.0*, Anthropic Policy Announcements, 24 February 2026. https://www.anthropic.com/news (announcement post linking to the full RSP).
> VENDOR/LAB DOCUMENT — this is Anthropic's own announcement of its own voluntary self-governance framework. All claims of success, feasibility and safety posture are self-reported and unaudited. Treat the "theory of change" assessment and safeguard-effectiveness claims as the company's own account, not independent evaluation. The extraction is the announcement blog post, not the full RSP document it links to.

## Abstract

This is Anthropic's announcement of version 3.0 of its Responsible Scaling Policy (RSP), the voluntary framework it uses to mitigate catastrophic risks from AI systems. Released 24 February 2026, it is the third version since the original was written in September 2023. The RSP is built on "conditional, or if-then, commitments": if a model exceeds certain capability thresholds, then a stricter set of safeguards — corresponding to an "AI Safety Level" (ASL) — is required. Anthropic reports it activated ASL-3 safeguards for relevant models in May 2025 (primarily addressing chemical and biological weapons risks from modestly-resourced threat actors). Version 3.0 restructures the policy around three new elements after Anthropic concluded parts of its original "theory of change" had not worked: it separates the company's own unilateral commitments from its recommendations for the wider industry, introduces a published Frontier Safety Roadmap of "nonbinding but publicly-declared" goals, and introduces Risk Reports published every 3–6 months with external third-party review in certain circumstances.

## The if-then / ASL structure

The RSP addresses risks "not present at the time the policy is written, but which could emerge rapidly." Its core mechanism is conditional commitments:

- **If** a model exceeds certain capability levels (e.g. "biological science capabilities that could assist in the creation of dangerous weapons"), **then** a new and stricter set of safeguards is introduced (e.g. against model misuse and theft of model weights).
- Each safeguard set corresponds to an **AI Safety Level (ASL)**: ASL-2 is one set of required safeguards; ASL-3 is a more stringent set for more capable models.
- **ASL-2 and ASL-3 were defined in significant detail; ASL-4 and beyond were intentionally left largely undefined**, to be developed once higher capability levels were better understood.

## Original theory of change (Sept 2023)

Anthropic lists the intended ecosystem effects:

1. **An internal forcing function** — treat safeguards as launch/training requirements.
2. **A race to the top** — encourage other AI companies to adopt similar policies, strengthening rather than weakening safeguards industry-wide.
3. **Creating more consensus about risks** — use capability thresholds as moments to move from unilateral action (Anthropic alone) to multilateral action (other companies and governments).
4. **Looking to the future** — acknowledge that later thresholds (e.g. robustness against state-level actors) would likely be impossible to meet unilaterally, hoping for government coordination by then.

## Self-assessment two and a half years later

**What Anthropic reports worked (self-reported):**
- The RSP incentivised stronger safeguards; to comply with the ASL-3 deployment standard it developed input and output **classifiers** to block content of concern. It states "we activated ASL-3 safeguards for relevant models in May 2025" and the ASL-3 standard "did prove feasible."
- Other companies adopted broadly similar frameworks: "within a few months of announcing our RSP, both OpenAI and Google DeepMind adopted broadly similar frameworks."
- Voluntary standards helped inform early AI policy, citing California's **SB 53**, New York's **RAISE Act**, and the **EU AI Act's Codes of Practice**; Anthropic addresses such requirements via its **Frontier Compliance Framework**.

**What Anthropic reports did not work:**
- **The "zone of ambiguity."** Pre-set capability levels proved "far more ambiguous than we anticipated." The science of model evaluation "isn't well-developed enough to provide dispositive answers." Biological risks are the example: models pass most quick tests (so risks can't be argued low), but those tests aren't sufficient to argue risks are high either. A supporting "extensive wet-lab trial" gave ambiguous results, partly because more powerful models arrive before studies finish.
- **Slow government action.** The policy environment "shifted toward prioritizing AI competitiveness and economic growth"; safety discussion "has yet to gain meaningful traction at the federal level."
- **Higher ASLs may be impossible to meet unilaterally.** Anthropic cites a RAND report on model weight security stating its "SL5" standard is "currently not possible" and "will likely require assistance from the national security community."

Anthropic frames the structural challenge as the combination of (a) the zone of ambiguity, (b) an anti-regulatory political climate, and (c) higher-level requirements that are very hard to meet unilaterally. Rather than defining ASL-4/ASL-5 in ways that make compliance easy (which "would undermine the intended spirit of the RSP"), it chose to restructure.

## Three key changes in Version 3.0

1. **Separating company plans from industry recommendations.** The RSP now outlines two sets of mitigations: those Anthropic will pursue "regardless of what others do," and an "ambitious capabilities-to-mitigations map" it believes would manage risks if adopted across the whole industry.

2. **Frontier Safety Roadmap.** A new requirement to develop and publish a roadmap of concrete mitigation plans across **Security, Alignment, Safeguards, and Policy**. These are "nonbinding but publicly-declared" targets — "public goals that we will openly grade our progress towards," not hard commitments. Example goals include "moonshot R&D" projects for information security; automated red-teaming surpassing the bug bounty; systematic measures to ensure Claude behaves according to its constitution; centralised records of critical AI development activities analysed for concerning insider behaviour (human and AI); and a "regulatory ladder" policy roadmap.

3. **Risk Reports and external review.** Building on the May 2025 **Safeguards Report** (described as a "proto-Risk Report"). Risk Reports go beyond capabilities to explain how capabilities, threat models and active mitigations fit together and give an overall risk assessment. Key commitments:
   - **Published online (with some redactions) every 3–6 months.**
   - **External review required in certain circumstances**: expert third-party reviewers, free of major conflicts of interest, with "unredacted or minimally-redacted access," subjecting Anthropic's reasoning to "a comprehensive public review." Current models "do not yet require external review," but pilots are running.
   - Redactions may occur for legal compliance, IP protection, public safety and privacy; Anthropic states it will aim to minimise them.

## Framing

Anthropic describes the RSP as "a living document" and calls the RSP "the voluntary framework we use to mitigate catastrophic risks from AI systems." Version 3.0 "amplifies what worked," commits to "more transparency," and separates industry recommendations from what the company can achieve alone.
