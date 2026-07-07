# Frontier Safety Framework, Version 3.0

> [!NOTE]
> Source: [deepmind-frontier-safety-framework-v3.pdf](../../sources/ai-governance/deepmind-frontier-safety-framework-v3.pdf) — Google DeepMind, *Frontier Safety Framework, Version 3.0*, published 22 September 2025. (Google DeepMind publication; PDF has no in-document URL.)
> VENDOR/LAB DOCUMENT. This is a first-party safety-governance policy authored by a frontier AI developer (Google DeepMind / Google) describing its own voluntary protocols. Its claims about thresholds, mitigations and review are self-reported and unaudited; treat commitments and risk-acceptance criteria as the lab's own policy, not independently verified assurance.

## Abstract

The *Frontier Safety Framework* (FSF) is Google DeepMind's set of voluntary protocols for anticipating and addressing "severe risks that may arise from the high-impact capabilities of frontier AI models." Version 3.0 was published on 22 September 2025 (succeeding v2.0 of 4 February 2025 and v1.0 of 17 May 2024). Its central construct is the **Critical Capability Level (CCL)**, defined as a capability level "at which, absent mitigation measures, frontier AI models or systems may pose heightened risk of severe harm." The Framework defines three sets of CCLs — **misuse** (CBRN, cyber, harmful manipulation), **machine-learning R&D**, and **misalignment** (an exploratory, illustration-only set) — and pairs each with security and/or deployment mitigations. It relies on **"early warning evaluations"** with **"alert thresholds"** to flag when a CCL may be approaching, and requires that **external deployment of a model take place only after "the appropriate governance function determines the safety case regarding each CCL the model has reached to be adequate."** The single most citable definition: CCLs are "capability levels at which, absent mitigation measures, frontier AI models or systems may pose heightened risk of severe harm."

## Overview and core components

The FSF "complements Google's suite of AI responsibility and safety practices" and is "informed by the broader conversation on Frontier AI Safety and Security Frameworks" (citing UK government processes, METR, Anthropic's Responsible Scaling Policy, OpenAI's Preparedness Framework, and the Frontier Model Forum). It states the core components of such frameworks are to:

- Identify capability levels at which frontier models, without additional mitigations, could pose severe risk.
- Implement protocols to detect the attainment of such levels throughout the model lifecycle.
- Prepare and articulate proactive mitigation plans.
- Where required or appropriate, involve external parties.

The Framework "addresses misuse risk, risks from machine learning research and development (ML R&D), and misalignment risk." Risk assessment "will necessarily involve evaluating cross-cutting capabilities such as agency, tool use, reasoning, and scientific understanding." The document stresses that many mitigations are "most effective when adopted by industry as a whole" — Google's own adoption "would result in effective risk mitigation for society only if all relevant organisations provide similar levels of protection." It repeatedly flags the Framework as "based on early and evolving research" that it expects "to evolve substantially."

## Section 1: Framework

### 1.1 Scope
Focuses on "possible severe risks stemming from high-impact capabilities of frontier AI models." The approaches and mitigations are not exclusive to models where a severe risk could arise; they are part of Google's broader AI responsibility and safety practices.

### 1.2 Critical Capability Levels (CCLs)
**Definition (verbatim):** CCLs "are capability levels at which, absent mitigation measures, frontier AI models or systems may pose heightened risk of severe harm." They are "determined by identifying and analyzing the main foreseeable paths through which a model could result in severe harm," then defined "as the minimal set of capabilities a model must possess to do so."

Three sets of CCLs are described:

- **Misuse CCLs** across three risk domains:
  - **CBRN** — "Risks of models assisting in the development, preparation, and/or execution of a chemical, biological, radiological, or nuclear ('CBRN') threat."
  - **Cyber** — "Risks of models assisting in the development, preparation, and/or execution of a cyber attack."
  - **Harmful Manipulation** — "Risks of models with high manipulative capabilities potentially being misused in ways that could reasonably result in large scale harm."
- **Machine-learning R&D CCLs** — identify when ML R&D capabilities "may, if not properly managed, reduce society's overall ability to manage AI risks," serving as "a substantial cross-cutting risk factor."
- **Misalignment CCLs** — an "exploratory approach" focused on detecting when models "might develop a baseline instrumental reasoning ability at which they have the potential to undermine human control, assuming no additional mitigations were applied."

Most CCLs "define one important component of our risk acceptance criteria." Because the misalignment CCLs are "exploratory and intended for illustration only," they carry no explicit risk-acceptance criteria.

### 1.3 Risk assessment process
Risk assessment is conducted at various moments before and after deployment. A risk assessment is done "for the first external deployment of a new frontier AI model," and repeated for subsequent versions "if the model has meaningful new capabilities or a material increase in performance," until the model is retired or superseded. Model capability evaluations (including automated benchmarks) indicate whether a full risk assessment is needed; they may be triggered on completion of a pre-training or post-training run.

The high-level steps:
- **Identification** — risk domains where severe risks are judged most likely: CBRN, cyber, harmful manipulation, and ML R&D. (Misalignment is excluded from this list "because of its exploratory nature.")
- **Analysis** — central to model evaluations are **"early warning evaluations,"** which "assess the proximity of the model to a CCL." The lab defines **"alert thresholds"** for these evaluations, "designed to flag when a CCL may be reached before a risk assessment is conducted again." Evaluations aim to equip the model with "appropriate scaffolding and other augmentations." Early warning evaluations may be run more frequently, or the alert threshold adjusted, "if the rate of progress suggests our safety buffer is no longer adequate."
- **Acceptance determination and mitigations** — determine whether the model has met (or will meet) a CCL and whether further mitigations are needed to reduce risk to an acceptable level.

A note on ML R&D CCLs states that because other actors may put more effort into eliciting capabilities than DeepMind puts into assessing risk, conservatism is required — but "as a frontier AI company, we do not expect other groups to put significantly more effort into ML R&D than we do ourselves," so ML R&D CCLs may be assessed using information about DeepMind's own progress in accelerating ML R&D, and the alert threshold "may be defined based on these sources of information, rather than on evaluation scores."

### 1.4 Response plans and mitigations
Two categories of mitigations: **security mitigations** (e.g. preventing exfiltration of model weights) and **deployment mitigations** (e.g. safety fine-tuning, monitoring and response). When a model reaches an alert threshold for a CCL, DeepMind assesses proximity, analyses the risk (with internal/external experts as needed), and formulates a response plan.

### 1.5 Evaluating mitigations
Security mitigations are subject to penetration testing and other assessments. Deployment mitigations use threat modelling, empirical testing and other information; these "form the basis of a **safety case** for models reaching CCLs, that will be reviewed before deployment." A safety case is defined (footnote 5) as "an assessable argument showing how severe risks associated with a model's CCLs have been reduced to an appropriate level" (referencing arXiv:2505.01420).

### 1.6 Summary of risk acceptance criteria
- **No CCL reached** → the model "will be deemed to pose an acceptable level of severe risk for further development and deployment."
- **Misuse CCL reached** → acceptable "if, for example" (a) deployment mitigations have brought the risk of severe harm to an appropriate level proportionate to the risk (considering mitigation efficacy, deployment scope, capabilities/mitigations on other publicly available models, and historical incidence/severity) — required only for external deployment, not further development; and (b) security mitigations have reached the recommended security level (or are otherwise assessed adequate, e.g. matching other similarly capable models, or open-release benefits outweigh risks).
- **ML R&D CCL reached** → analogous criteria, but the deployment-mitigation criterion is "required only for external deployment and large scale internal deployment, not further development."
- **Misalignment CCLs** — no explicit risk-acceptance criteria (exploratory/illustrative).

"Proportionality is central" to determining whether a mitigation has sufficiently reduced risk; assessments "will often involve some level of subjective analysis."

## Section 2: Misuse

### 2.1 Mitigation approach
Two categories: **security mitigations** (prevent exfiltration of model weights, with several calibrated levels) and **deployment mitigations** (a standard process to apply, assess and review, calibrated to CCLs). Security levels are indexed to the corresponding level in the **RAND framework** (RRA2849-1); "security level N" indicates controls "generally aligned with RAND SL N" (referencing the RAND report's security goals/principles, not its benchmarks).

### 2.1.2 Deployment mitigations (three-step process)
1. **Development and assessment of mitigations** — iterate on a suite of safeguards (e.g. safety post-training, monitoring and analysis, account moderation, jailbreak detection and patching, user verification, bug bounties) and assess robustness via testing (automated evaluations, red teaming) and threat modelling. The assessment "takes the form of a safety case" considering: how much risk has been reduced (refusal rate, jailbreak robustness); likelihood/consequences of misuse and of mitigations being circumvented; scope of deployment (small/private vs large/public); capabilities and mitigations on other publicly available models (marginal-risk framing); and historical incidence/severity of related events.
2. **Pre-deployment review of safety case** — "external deployments of a model take place only after the appropriate governance function determines the safety case regarding each CCL the model has reached to be adequate." Mitigations are deemed adequate "if the evidence suggests that for the CCLs the model has reached, the increase in likelihood of severe harm has been reduced to an acceptable level."
3. **Post-deployment processes** — safety cases and mitigations may be updated based on post-market monitoring; "material updates to a safety case will be submitted to the appropriate governance function for review."

### 2.2 Misuse Critical Capability Levels
A recommended security level is stated for each CCL as "the minimum appropriate level of security the field of frontier AI should apply." These recommendations "will only be effective if the entire frontier AI field applies them."

- **CBRN uplift level 1** — "Provides low to medium resourced actors uplift in reference scenarios resulting in additional expected harm at severe scale." Recommended: **Security level 2**. (Additional harm is defined relative to a baseline without generative AI.)
- **Cyber uplift level 1** — "Provides sufficient uplift with high impact cyber attacks for additional expected harm at severe scale." Recommended: **Security level 2**.
- **Harmful manipulation level 1 (exploratory)** — "Possesses manipulative capabilities sufficient to enable it to systematically and substantially change beliefs and behavior in identified high stakes contexts over the course of interactions with the model, reasonably resulting in additional expected harm at severe scale." Recommended: **Security level 2**. The document notes research into harmful manipulation "is nascent" and the CCL is exploratory.

## Section 3: Machine Learning R&D

### 3.1 Mitigation approach
As with misuse, both security and deployment mitigations apply, but deployment mitigations "also include measures for large scale internal deployments." Security mitigations against exfiltration matter because exfiltration of highly capable models increases the likelihood they are misused to reach other critical capabilities or deployed without adequate control; security also protects against "the risk of the model exfiltrating itself." The deployment process mirrors the misuse three-step process, with an added focus on large-scale internal deployment, and step 2 requiring governance-function sign-off on the safety case "for external deployments and large scale internal deployments."

### 3.2 ML R&D Critical Capability Levels
Focus on models capable of accelerating the rate of AI progress (which may undermine human control, incentivise higher-risk deployment, or enable unsafe attainment/proliferation of other powerful models).

- **ML R&D acceleration level 1** — "Has been used to accelerate AI development, resulting in AI progress substantially accelerating from historical rates." Recommended: **Security level 3** (may include SL 2 mitigations plus measures to prevent unilateral access, harden infrastructure, and prevent data exfiltration). Rationale notes acceleration is expected to stem from "systems of models integrated with workflows, rather than the model alone," which counts against the highest security levels.
- **ML R&D automation level 1** — "Can fully automate the work of any team of researchers at Google focused on improving AI capabilities, with approximately comparable all-inclusive costs." Recommended: **Security level 4** ("but emphasize that this must be taken on by the frontier AI field as a whole"). Rationale: unrestricted access could let an actor (or AI systems) reach "much more powerful" capabilities in a short time — "catastrophic if there is no effective way of defending against rapidly improving and potentially superhuman AI systems." SL 4 may add mitigations to isolate model weights, enhance data-centre security, harden infrastructure and minimise attack surface.

## Section 4: Misalignment (Exploratory Approach)

Addresses "specific scenarios where general-purpose AI agents are potentially misaligned and can become difficult to control." Focus is on when models "may develop a baseline instrumental reasoning ability at which, without additional mitigations, they may have the potential to undermine human control." One possible mitigation is "an automated monitor to the model's explicit reasoning (e.g. chain-of-thought output)." Once a model can perform effective instrumental reasoning "in ways that cannot be monitored, additional mitigations may be warranted" — an area of active research. This section is "illustrative only"; no security mitigations are indicated.

Table 4.a — exploratory misalignment CCLs:
- **Instrumental Reasoning Level 1** — instrumental reasoning enables enough situational awareness ("ability to work out and use relevant details of its deployment setting") and stealth ("ability to circumvent basic oversight mechanisms") that, absent additional mitigations, "we cannot rule out the model significantly undermining human control." Illustrative mitigation: **automated monitoring** of chain-of-thought "in high-stakes internal deployments."
- **Instrumental Reasoning Level 2** — situational awareness and stealth such that "even when relevant model outputs (including, e.g. scratchpads) are being monitored, we cannot detect or rule out the risk of a model significantly undermining human control." Illustrative mitigation: "Future work — We are actively researching approaches to addressing models that reach this CCL."

## Section 5: Updates and Disclosures

- **5.1 Updates** — the Framework "will be updated at least once a year — more frequently if we have reasonable grounds to believe the adequacy of the Framework or our adherence to it has been materially undermined." The process involves an assessment of appropriateness for systemic-risk management and an assessment of adherence; updated versions are "reviewed by the appropriate corporate governance bodies."
- **5.2 Disclosures** — if a model reaches "a CCL that poses an unmitigated and material risk to overall public safety," DeepMind aims to share relevant information with "appropriate government authorities." Disclosable information may include model information, evaluation results, and mitigation plans.
- **5.3 Past updates** — Version 2.0 (4 February 2025); Version 1.0 (17 May 2024).

## Notes for citation

- Most citable definition (CCL): "capability levels at which, absent mitigation measures, frontier AI models or systems may pose heightened risk of severe harm" (§1.2).
- Pre-deployment governance gate (verbatim, §2.1.2 / §3.1.2): external deployment takes place "only after the appropriate governance function determines the safety case regarding each CCL the model has reached to be adequate."
- "Early warning evaluations" and "alert thresholds" are defined in §1.3 (Analysis).
- Recommended security levels are indexed to the RAND framework (RRA2849-1) and are self-described as the *minimum* the field should apply; DeepMind's "overall security posture may commonly exceed" them.
- All commitments are voluntary, self-reported, and explicitly "based on early and evolving research."
