# Artificial Intelligence Risk Management Framework: Generative Artificial Intelligence Profile

> [!NOTE]
> Source: [nist-ai-600-1-genai-profile.pdf](../../sources/ai-governance/nist-ai-600-1-genai-profile.pdf) — National Institute of Standards and Technology (NIST), U.S. Department of Commerce, *Artificial Intelligence Risk Management Framework: Generative Artificial Intelligence Profile* (NIST AI 600-1), July 2024. https://doi.org/10.6028/NIST.AI.600-1
> Primary US Government standards document (a NIST Trustworthy and Responsible AI publication). Approved by the NIST Editorial Review Board 2024-07-25. Voluntary, non-binding guidance.

## Abstract

NIST AI 600-1 is a **cross-sectoral profile of, and companion resource to, the AI Risk Management Framework (AI RMF 1.0, NIST AI 100-1)** specialised for generative AI (GAI). It was developed pursuant to Section 4.1(a)(i)(A) of President Biden's Executive Order 14110 (Safe, Secure, and Trustworthy AI), which directed the Secretary of Commerce, acting through NIST, to produce a GAI companion to the AI RMF. A "profile" is an implementation of the AI RMF's functions, categories, and subcategories for a specific setting — here, generative foundation models — that organisations can use to govern, map, measure, and manage risks common across sectors (e.g. use of large language models, cloud services, or acquisition). The document's two substantive contributions are: (1) an enumeration of **twelve risks unique to or exacerbated by GAI**, each mapped to the AI RMF's Trustworthy AI Characteristics; and (2) roughly **200+ suggested actions** (212 uniquely numbered in this profile) organised under the AI RMF's four functions — Govern, Map, Measure, Manage. It is explicitly voluntary and focuses only on risks with an existing empirical evidence base at time of writing (speculative future-capability risks are excluded). EO 14110 defines Generative AI as "the class of AI models that emulate the structure and characteristics of input data in order to generate derived synthetic content."

## Document structure

The profile has three main sections plus two appendices:

1. **Introduction** — its statutory basis and its nature as a cross-sectoral AI RMF profile.
2. **Overview of Risks Unique to or Exacerbated by GAI** — defines the twelve GAI risks and discusses each in a dedicated subsection (§2.1–§2.12).
3. **Suggested Actions to Manage GAI Risks** — ~200+ actions organised by AI RMF subcategory under the four functions.
4. **Appendix A. Primary GAI Considerations** — the four themes derived from the NIST Generative AI Public Working Group (GAI PWG): Governance, Pre-Deployment Testing, Content Provenance, and Incident Disclosure.
5. **Appendix B. References.**

It was informed by the GAI PWG (an open, multistakeholder process) and public Requests for Information. The GAI PWG's scope was limited to the four primary considerations in Appendix A, so the suggested actions primarily address those; future revisions are expected to add more AI RMF subcategories and risks.

## What a "profile" is (Introduction, §1)

- The AI RMF was released January 2023 for **voluntary use**, to help organisations build trustworthiness into the design, development, use, and evaluation of AI.
- A profile implements the RMF's functions/categories/subcategories for a specific setting based on the user's "requirements, risk tolerance, and resources."
- Because GAI risks span use cases and sectors, this is a **cross-sectoral profile**.
- The profile "defines risks that are novel to or exacerbated by the use of GAI" and then gives suggested actions to govern, map, measure, and manage them.
- **Statutory basis:** developed per EO 14110 §4.1(a)(i)(A). Footnote defines "dual-use foundation models" (per EO 14110) as models "trained on broad data; generally uses self-supervision; contains at least tens of billions of parameters; is applicable across a wide range of contexts."

## How GAI risk is framed (§2 overview)

Risk = "the composite measure of an event's probability (or likelihood) of occurring and the magnitude or degree of the consequences." GAI risks are said to vary along four dimensions:

- **Stage of the AI lifecycle** — design, development, deployment, operation, decommissioning.
- **Scope** — model/system level, application/use-case level, or ecosystem level (e.g. "algorithmic monocultures" from repeated reuse of the same model).
- **Source of risk** — model itself, inputs, outputs, or human behaviour (abuse, misuse, unsafe repurposing) and human–AI interaction.
- **Time scale** — abrupt vs. prolonged (e.g. immediate deepfake harm vs. long-term erosion of societal trust).

The profile deliberately focuses on **empirically evidenced** risks, not speculative future-system risks. A footnote offers one optional way to categorise the twelve risks (derived partly from the UK's *International Scientific Report on the Safety of Advanced AI*): technical/model (malfunction) risks, misuse-by-humans (malicious use) risks, and ecosystem/societal (systemic) risks — with several risks cross-cutting.

## The twelve GAI risks (§2, verbatim definitions)

Each risk is also mapped to AI RMF Trustworthy AI Characteristics (Safe; Valid and Reliable; Accountable and Transparent; Explainable and Interpretable; Privacy Enhanced; Secure and Resilient; Fair with Harmful Bias Managed).

1. **CBRN Information or Capabilities** — "Eased access to or synthesis of materially nefarious information or design capabilities related to chemical, biological, radiological, or nuclear (CBRN) weapons or other dangerous materials or agents." (Notes that recent research found LLM outputs on biological-threat creation "provided minimal assistance beyond traditional search engine queries," but flags chemical/biological design tools (BDTs) as a growing concern.)
2. **Confabulation** — "The production of confidently stated but erroneous or false content (known colloquially as 'hallucinations' or 'fabrications') by which users may be misled or deceived." (Described as "a natural result of the way generative models are designed"; a footnote notes "hallucination"/"fabrication" anthropomorphise GAI.)
3. **Dangerous, Violent, or Hateful Content** — "Eased production of and access to violent, inciting, radicalizing, or threatening content as well as recommendations to carry out self-harm or conduct illegal activities. Includes difficulty controlling public exposure to hateful and disparaging or stereotyping content." (Discusses "jailbreaking" — manipulating prompts to circumvent output controls.)
4. **Data Privacy** — "Impacts due to leakage and unauthorized use, disclosure, or de-anonymization of biometric, health, location, or other personally identifiable information or sensitive data." (Covers "data memorization" and models correctly inferring PII by stitching together disparate sources.)
5. **Environmental Impacts** — "Impacts due to high compute resource utilization in training or operating GAI models, and related outcomes that may adversely impact ecosystems." (Cites an estimate that training a single transformer LLM "can emit as much carbon as 300 round-trip flights between San Francisco and New York"; notes "there is no agreed upon method to estimate environmental impacts from GAI.")
6. **Harmful Bias or Homogenization** — "Amplification and exacerbation of historical, societal, and systemic biases; performance disparities between sub-groups or languages... that result in discrimination, amplification of biases, or incorrect presumptions about performance; undesired homogeneity that skews system or model outputs." (Introduces "model collapse" from over-reliance on synthetic training data, and foundation models acting as "bottlenecks" / single points of failure.)
7. **Human-AI Configuration** — "Arrangements of or interactions between a human and an AI system which can result in the human inappropriately anthropomorphizing GAI systems or experiencing algorithmic aversion, automation bias, over-reliance, or emotional entanglement with GAI systems."
8. **Information Integrity** — "Lowered barrier to entry to generate and support the exchange and consumption of content which may not distinguish fact from opinion or fiction or acknowledge uncertainties, or could be leveraged for large-scale dis- and mis-information campaigns." (Distinguishes misinformation (unintentional) from disinformation (intent to deceive); cites the viral synthetic Pentagon-blast image that "briefly caused a drop in the stock market.")
9. **Information Security** — "Lowered barriers for offensive cyber capabilities, including via automated discovery and exploitation of vulnerabilities to ease hacking, malware, phishing, offensive cyber operations, or other cyberattacks; increased attack surface for targeted cyberattacks, which may compromise a system's availability or the confidentiality or integrity of training data, code, or model weights." (Two primary risks: GAI enabling offensive capability, and GAI's own new attack surface — prompt injection (direct/indirect) and data poisoning.)
10. **Intellectual Property** — "Eased production or replication of alleged copyrighted, trademarked, or licensed content without authorization (possibly in situations which do not fall under fair use); eased exposure of trade secrets; or plagiarism or illegal replication." (Notes copyright status of GAI output "is currently being debated in legal fora.")
11. **Obscene, Degrading, and/or Abusive Content** — "Eased production of and access to obscene, degrading, and/or abusive imagery which can cause harm, including synthetic child sexual abuse material (CSAM), and nonconsensual intimate images (NCII) of adults." (Notes some commonly used training datasets "were found to contain hundreds of known images" of CSAM.)
12. **Value Chain and Component Integration** — "Non-transparent or untraceable integration of upstream third-party components, including data that has been improperly obtained or not processed and cleaned due to increased automation from GAI; improper supplier vetting across the AI lifecycle; or other issues that diminish transparency or accountability for downstream users." (Exacerbated for GAI by training-data scale too large to vet, extensive reuse of a limited number of foundation models, and deep integration into other services.)

## Suggested actions (§3) — organised by the four AI RMF functions

The profile provides suggested actions in tables keyed to AI RMF subcategories, under the four RMF functions. **Action IDs encode the function and subcategory** — the function tags are: **GV = Govern; MP = Map; MS = Measure; MG = Manage** (e.g. `GV-1.1-001` is the first suggested action for Govern 1.1). Each table row lists the Action ID, the Suggested Action, the associated GAI Risks, and pertinent AI Actor Tasks.

- The profile contains **212 uniquely numbered suggested actions** (the brief's "~200+"): Govern (GV) 58, Map (MP) 39, Measure (MS) 72, Manage (MG) 43.
- These are additive to — not a replacement for — the AI RMF 1.0 and its Playbook, which "are already applicable for managing GAI risks."
- Not every AI RMF subcategory is covered (scope was limited to the GAI PWG's four primary considerations); not every action applies to every AI Actor (e.g. developer vs. deployer).
- Example (GV-1.1-001): "Align GAI development and use with applicable laws and regulations, including those related to data privacy, copyright and intellectual property law." Example (GV-1.4-001): "Establish policies and mechanisms to prevent GAI systems from generating CSAM, NCII or content that violates the law."

## Appendix A — Primary GAI Considerations

Four overarching themes from the GAI PWG that shape the suggested actions:

- **A.1 Governance** — re-evaluating and adjusting organisational governance/risk-tiering regimes for GAI, including third-party considerations across the AI value chain.
- **A.2 Pre-Deployment Testing.**
- **A.3 Content Provenance.**
- **A.4 Incident Disclosure.**

("AI Actors" are defined per the OECD as "those who play an active role in the AI system lifecycle, including organizations and individuals that deploy or operate AI.")

## Relevance for AI governance

NIST AI 600-1 is the **US Government's authoritative GAI-specific extension of the voluntary AI RMF 1.0**. For a book chapter that already cites the AI RMF, it supplies (a) a concrete, enumerated taxonomy of twelve GAI-specific risks with verbatim definitions and Trustworthy-AI-Characteristic mappings, and (b) a large, actionable catalogue (~200+ suggested actions) structured on the RMF's Govern/Map/Measure/Manage spine — grounding claims about how the US operationalises GenAI risk management under Executive Order 14110.
