# OpenAI Preparedness Framework (Version 2)

> [!NOTE]
> Source: [openai-preparedness-framework-v2.pdf](../../sources/ai-governance/openai-preparedness-framework-v2.pdf) — OpenAI, *Preparedness Framework*, Version 2, last updated 15 April 2025. <https://cdn.openai.com/pdf/18a02b5d-6b67-4cec-ab64-68cdfbddebcd/preparedness-framework-v2.pdf>
> **VENDOR/LAB document.** This is OpenAI's own voluntary internal-governance policy for its frontier models. All commitments, thresholds and processes are self-imposed and self-reported; nothing here is externally audited or legally binding. Treat "we will…" statements as OpenAI's stated intentions, not verified practice. Read alongside independent instruments (e.g. the EU AI Act) rather than as a substitute for them.

## Abstract

The Preparedness Framework is OpenAI's stated approach to tracking and preparing for frontier AI capabilities that "create new risks of severe harm." Version 2 (15 April 2025) narrows the focus to three **Tracked Categories** — Biological and Chemical, Cybersecurity, and AI Self-improvement — and defines **"severe harm"** as "the death or grave injury of thousands of people or hundreds of billions of dollars of economic damage." Each category carries two capability tiers with distinct obligations: a model reaching a **High** threshold may not be deployed until its risks are "sufficiently minimized," and a model reaching a **Critical** threshold requires safeguards *during development*, irrespective of deployment plans. Decisions run through a **Safety Advisory Group (SAG)** that only *recommends*; OpenAI Leadership (the CEO or a designate) makes all final calls, and the framework states explicitly that "the SAG does not have the ability to 'filibuster'." The most notable counterweight is the Section 4.3 **marginal-risk clause**, under which OpenAI reserves the right to *lower* its own safeguards if a competitor ships a High/Critical system without comparable safeguards — conditioned on public acknowledgement and staying more protective than that rival.

## Metadata and status

- **Title:** Preparedness Framework
- **Issuing body:** OpenAI
- **Version:** 2 (previous version superseded); "a living document," to be reviewed "at least once a year."
- **Last updated:** 15 April 2025 (stated on the title page).
- **Nature:** Voluntary self-governance policy. Self-reported and unaudited. OpenAI states it "do[es] not currently possess any models that have Critical levels of capability" and "expect[s] to further update this Preparedness Framework before reaching such a level."

## The core definition — "severe harm"

Footnote 1 (verbatim): *"By 'severe harm' in this document, we mean the death or grave injury of thousands of people or hundreds of billions of dollars of economic damage."* OpenAI notes it deliberately sets "a high bar here" so that "the most severe risks receive attention commensurate with their magnitude," while its broader safety stack addresses "many [harms] below this severity." The entire Preparedness Framework is scoped to this definition — which is why, e.g., Persuasion is explicitly excluded (its risks "do not fit the criteria for inclusion").

## The four-step approach (Introduction / §1)

1. **Decide where to focus** — a holistic risk assessment picks which frontier capabilities to Track or Research and sets threshold levels tied to "meaningful increases in risk of severe harm."
2. **Measure capabilities** — run in-scope models through frontier capability evaluations "before we deploy our models and during development."
3. **Safeguard against severe harms** — "We do not deploy models that reach a High capability threshold until the associated risks that they pose are sufficiently minimized. If a model under development reaches a Critical capability threshold, we also require safeguards to sufficiently minimize the associated risks during development, irrespective of deployment plans."
4. **Build trust** — engage subject-matter experts inside and outside OpenAI.

## Tracked Categories (§2.2, Table 1)

A capability becomes a **Tracked Category** only if its risk meets five criteria: **Plausible, Measurable, Severe, Net new** (not realisable "with existing tools and resources … available as of 2021" absent frontier AI), and **Instantaneous or irremediable**.

The three current Tracked Categories:

- **Biological and Chemical** — AI that can "accelerate and expand access to biological and chemical research, development, and skill-building." *High:* meaningful counterfactual assistance to a "novice" actor to create known bio/chemical threats. *Critical:* enabling an expert to develop "a highly dangerous novel threat vector (e.g., comparable to a novel CDC Class A biological agent)," or completing the full engineering/synthesis cycle of a regulated or novel biological threat without human intervention. (Biological evaluations are prioritised as the indicator for both tiers.)
- **Cybersecurity** — AI that assists in developing tools and executing cyberdefence/cyberoffence operations. *High:* removes bottlenecks to scaling cyber operations, e.g. automating end-to-end operations against reasonably hardened targets, or automating discovery and exploitation of operationally relevant vulnerabilities. *Critical:* a tool-augmented model that can find and develop functional zero-day exploits "of all severity levels in many hardened real-world critical systems without human intervention," or devise and execute novel end-to-end cyberattack strategies against hardened targets from only a high-level goal.
- **AI Self-improvement** — AI that can "accelerate AI research, including to increase the system's own capability." *High:* impact "equivalent to giving every OpenAI researcher a highly performant mid-career research engineer assistant" relative to a 2024 baseline. *Critical:* recursive self-improvement (fully automated AI R&D) — either a superhuman research-scientist agent (leading indicator) or a generational model improvement (e.g. o1→o3) achieved in one-fifth the 2024 wall-clock time (≈4 weeks), sustained for several months (lagging indicator).

**What changed in v2 (categories):** "low" and "medium" tiers were removed as operationally unused. AI Self-improvement was split out from the former "Model Autonomy" and promoted to a Tracked Category. Persuasion was moved out of the framework entirely (handled via the Model Spec and policy). Nuclear and Radiological was moved into Research Categories.

## High vs Critical — the distinct obligations

This is the load-bearing distinction of the framework (§2.2, §4.2, §4.4, Appendix C):

- **High capability** = "capabilities that significantly increase *existing* risk vectors for severe harm." Obligation: "Covered systems that reach High capability must have safeguards that sufficiently minimize the associated risk of severe harm **before they are deployed**" (plus appropriate security controls as they are developed). The gate is at deployment.
- **Critical capability** = "capabilities that present a meaningful risk of a **qualitatively new threat vector** for severe harm with no ready precedent." Obligation: "Systems that reach Critical capability **also require safeguards that sufficiently minimize associated risks during development**" — irrespective of, and prior to, any deployment. For each Critical row in Table 1 the default guidance is: "Until we have specified safeguards and security controls that would meet a Critical standard, **halt further development**."

In short: High blocks *deployment* until risks are minimised; Critical additionally constrains *development itself*.

## Research Categories (§2.3, Table 2)

Capabilities that do not (yet) meet the five criteria but warrant investment now: **Long-range Autonomy**, **Sandbagging** (models under-performing on evaluations to hide capability), **Autonomous Replication and Adaptation**, **Undermining Safeguards**, and **Nuclear and Radiological**. For these, OpenAI commits to developing threat models, advancing capability-measurement science, and "sharing summaries of our findings with the public where feasible." Notably, if a model has High/Critical capability in any Tracked Category, a Long-range Autonomy or Undermining-Safeguards finding triggers additional misalignment safeguards reporting.

## Measuring capabilities (§3)

Two evaluation forms: **Scalable Evaluations** (automated proxies with pre-set "indicative thresholds") and **Deep Dives** (validation via human expert red-teaming, third-party evaluators, bio wet-lab studies, etc.). Results are compiled into a **Capabilities Report** submitted to the SAG. OpenAI states that "any one-time capability elicitation in a frontier model [is treated as] a lower bound, rather than a ceiling." The SAG makes the final call on whether an ambiguous model is even covered.

## Safeguarding and safeguard sufficiency (§4.1–4.2)

Safeguards are split by threat: **malicious users** (Robustness, Usage Monitoring, Trust-based Access) and a **misaligned model** (Lack of Autonomous Capability, Value Alignment, Instruction Alignment, Reliable and Robust System Oversight, System Architecture). Planned safeguards, their efficacy, residual risk and limitations are compiled into a **Safeguards Report**. The SAG assesses sufficiency and can (1) recommend deployment, (2) request further evaluation, or (3) find safeguards insufficient and recommend alternative conditions. "All of SAG's recommendations will go to OpenAI Leadership for final decision-making."

## Section 4.3 — Marginal risk (the competitive-adjustment clause)

This is the key counterweight to the framework's voluntary commitments and should be quoted precisely. OpenAI recognises another frontier developer "might develop or release a system with High or Critical capability in one of this Framework's Tracked Categories and may do so without instituting comparable safeguards." Such an action "could significantly increase the baseline risk of severe harm being realized in the world, and limit the degree to which we can reduce risk using our safeguards." Then, verbatim:

> "If we are able to rigorously confirm that such a scenario has occurred, then we could adjust accordingly the level of safeguards that we require in that capability area, but only if:
> - we assess that doing so does not meaningfully increase the overall risk of severe harm,
> - we publicly acknowledge that we are making the adjustment,
> - and, in order to avoid a race to the bottom on safety, we keep our safeguards at a level more protective than the other AI developer, and share information to validate this claim."

In plain terms: OpenAI reserves the right to *lower its own bar* if a rival ships an under-safeguarded High/Critical system, gated by three self-imposed conditions (no meaningful net risk increase, public acknowledgement, and staying more protective than the rival with information shared to validate it). It is simultaneously a pressure-release valve on the commitment and an attempt to bound the resulting "race to the bottom."

## Governance and decision-making (§1, §5.1, Appendix B)

- **Safety Advisory Group (SAG):** an internal, cross-functional group of OpenAI leaders that oversees the framework, reviews Capabilities/Safeguards Reports, assesses residual risk, and makes recommendations. Members and Chair are appointed by OpenAI Leadership; members serve one-year terms; the Chair (a rotating role) "makes any final decisions needed for the SAG."
- **SAG recommends only — Leadership decides.** OpenAI Leadership ("the CEO or a person designated by them") is "responsible for making all final decisions, including accepting any residual risks and making deployment go/no-go decisions." Critically, the framework states: **"For the avoidance of doubt, OpenAI Leadership can also make decisions without the SAG's participation, i.e., the SAG does not have the ability to 'filibuster'."**
- **Board oversight:** the Board's **Safety and Security Committee (SSC)** gets visibility into processes, can review decisions and require reports, and "where necessary … may reverse a decision and/or mandate a revised course of action."
- **Fast-track:** if a severe-harm risk develops rapidly, a fast-track SAG review can be requested, with the Chair coordinating with Leadership.
- **Noncompliance:** any employee can raise concerns via the Raising Concerns Policy; substantiated reports lead to "appropriate and proportional corrective action."

## Transparency commitments (§5.2)

Public disclosures for major deployments (scope of testing, per-category evaluations, deployment reasoning; safeguards info if beyond a High threshold — with possible redaction). Optional third-party evaluation of capabilities, third-party stress-testing of safeguards, and independent expert opinions to the SAG (these experts "may not necessarily be AI experts").

## Security controls (Appendix C.3)

Required for High-capability models, aligned with "ISO 27001, SOC2, NIST SP 800-53, and FedRAMP" (and emerging AI-specific standards such as the Cloud Security Alliance's AI Safety Initiative and NIST SP 800-218 AI updates). Covers threat modelling, defence-in-depth / Zero Trust, least-privilege access with MFA, secure development and supply-chain integrity, 24×7 monitoring and incident response, adversarial red-teaming/bug bounties, and independent security audits.

## Most citable facts

- **"Severe harm" = "the death or grave injury of thousands of people or hundreds of billions of dollars of economic damage."** (Footnote 1.)
- Three Tracked Categories: **Biological and Chemical, Cybersecurity, AI Self-improvement.**
- **High** → no deployment until risks sufficiently minimised; **Critical** → safeguards required *during development*, irrespective of deployment.
- **"The SAG does not have the ability to 'filibuster'"** — it recommends; OpenAI Leadership (CEO or designate) decides, and can decide without SAG.
- **§4.3 marginal-risk clause:** OpenAI may lower its required safeguards if a rival ships a High/Critical system without comparable safeguards — only if it does not meaningfully increase overall risk, is publicly acknowledged, and OpenAI stays more protective than that rival.
