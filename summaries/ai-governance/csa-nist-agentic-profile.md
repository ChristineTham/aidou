# NIST AI Risk Management Framework: Agentic Profile

> [!NOTE]
> Source: [csa-nist-agentic-profile.md](../../sources/ai-governance/csa-nist-agentic-profile.md) — Cloud Security Alliance (CSA AI Safety Initiative), *NIST AI Risk Management Framework: Agentic Profile*, white paper (status: draft), 27 March 2026. (Published on a CSA "Lab Space" page; primary URL not captured in the extraction — CSA companion sources cited within: cloudsecurityalliance.org.)
> This is a CSA-authored draft white paper, NOT an official NIST publication. It *proposes* extensions to the NIST AI RMF; NIST has not adopted them. It is also a partly promotional document — it repeatedly steers organisations toward CSA's own AAGATE reference architecture and AI Controls Matrix (AICM) as the recommended implementation path. Treat the tier taxonomy, control identifiers ("AG-*"), and mappings as CSA proposals, not NIST-endorsed standards. Self-reported/proposed obligations are attributed as such below.

## Abstract

This is a Cloud Security Alliance draft white paper (dated 2026-03-27) that proposes an "Agentic Profile" extending the NIST AI Risk Management Framework (AI RMF 1.0, NIST AI 100-1, published 26 January 2023) to autonomous AI agents. Its thesis is that agentic systems pose *structurally different* risks from conversational or generative models — they can initiate irreversible real-world actions, amplify errors across delegation chains before humans can intervene, and exhibit behavioural drift that accumulates undetected — and that neither RMF 1.0 nor the Generative AI Profile (NIST AI 600-1, 26 July 2024) contemplated tool-using, autonomously-executing agents. The paper organises proposed extensions under the RMF's four functions (GOVERN, MAP, MEASURE, MANAGE), the most citable being a **four-tier autonomy classification** (Tier 1 fully supervised → Tier 4 full autonomy) with escalating oversight obligations. It explicitly positions itself as a "practitioner-oriented complement" to NIST's own emerging AI Agent Standards Initiative (announced by NIST CAISI, February 2026; an AI Agent Interoperability Profile planned for Q4 2026), and aligns its extensions with CSA's own AICM v1.0 (a 243-control, 18-domain framework, July 2025) and AAGATE reference architecture (CSA, 22 December 2025). It grounds the point that the standards machinery is being actively extended to agents — though here by an industry body proposing to, rather than by NIST itself.

## The agentic governance gap (Introduction, §1)

The paper accepts the RMF's four-function architecture — GOVERN (policies/accountability), MAP (contextualise risk per system/use case), MEASURE (assess and monitor risk), MANAGE (implement responses) — and its seven trustworthiness characteristics (validity and reliability; safety; security and resilience; accountability and transparency; explainability and interpretability; privacy-enhancement; fair bias management). It argues the framework was built for discriminative classifiers and conversational LLMs, and that AI 600-1 extended it only to *content-generation* risks (confabulation, IP, harmful content).

The claimed new risk dimensions of agents: (a) the **temporal gap** between an agent initiating a cascade of irreversible actions and any human observing the misbehaviour; (b) **distributed accountability** when an orchestrating agent spawns sub-agents; (c) attack vectors with "no equivalent" in AI 600-1's threat model — prompt injection through tool outputs, cross-session memory persistence, and tool-chain poisoning. The paper cites the Model Context Protocol (Anthropic, late 2024) and multi-agent frameworks (LangGraph, AutoGen, CrewAI) as what drove agents into production. It notes NIST's own acknowledgement of the gap via the **AI Agent Standards Initiative** launched through the Center for AI Standards and Innovation (CAISI) in February 2026, covering identity/authorisation, security/risk management, and monitoring/logging, with an AI Agent Interoperability Profile planned for Q4 2026.

## Assessment of RMF 1.0 for "agentic fitness" (§2)

Four claimed structural gaps:
- **2.1 No autonomy-tier concept** — GOVERN treats a text-recommender and an agent executing multi-day workflows with external effects identically; gives no guidance on when human-in-the-loop should become mandatory.
- **2.2 No tool-use risk model** — MAP maps intrinsic model properties, not the extrinsic risk of the tools an agent controls; "risk contextualization machinery stops at the model boundary."
- **2.3 Insufficient runtime monitoring** — MEASURE is a pre-deployment/periodic-review activity; agents need continuous telemetry against behavioural baselines because drift is undetectable through periodic audits.
- **2.4 No delegation/oversight-boundary framework** — RMF has "no concept of delegation boundary" for multi-agent chains.

## Assessment of NIST AI 600-1 for agentic fitness (§3)

AI 600-1 (Generative AI Profile, July 2024) identifies **twelve risk areas**: CBRN Information or Capabilities; Confabulation; Dangerous, Violent, or Hateful Content; Data Privacy; Environmental Impacts; Harmful Bias and Homogenization; Human-AI Configuration; Information Integrity; Information Security; Intellectual Property; Obscene or Degrading Content; and Value Chain and Component Integration — with "more than 200 suggested actions." The paper says it is **scoped to content generation** ("what they say" not "what they do"), has **no action-consequence modelling**, **no multi-step planning risk assessment**, and **no control-plane security framework** (prompt injection via tool outputs, agent impersonation in multi-agent channels, malicious tool registration are unrepresented).

## Proposed agentic extensions by RMF function (§4)

Extensions supplement (not replace) RMF 1.0; proposed identifiers use the prefix **"AG"** (Agentic).

### GOVERN extensions (§4.1)
- **AG-GV.1 Autonomy Tier Classification** — a proposed **four-tier taxonomy**:
  - **Tier 1** — fully supervised; outputs require human approval before any action.
  - **Tier 2** — constrained autonomy; executes pre-approved action types within a predefined scope, escalates for out-of-scope actions.
  - **Tier 3** — broad autonomy within a defined boundary; acts autonomously but under continuous monitoring and hard constraints on resource access, action scope, time horizon.
  - **Tier 4** — full autonomy within a constrained environment; can spawn sub-agents, acquire new tool capabilities, execute long-horizon plans with minimal human interaction.
  - Obligations escalate by tier: Tier 1 = equivalent to non-agentic generative AI; Tier 2 = action-scope documentation, approval-authority delegation policies, escalation triggers; Tier 3 = continuous behavioural monitoring, anomaly response playbooks, documented fail-safe conditions; Tier 4 = all the above plus oversight-board review at defined intervals, documented decommissioning procedures, and independent adversarial security testing.
- **AG-GV.2 Delegation Accountability / Oversight Boundary Framework** — document, per agent: scope of actions allowed without human approval; escalation conditions; delegation authority (when it may spawn/task sub-agents and with what authorities); and an **accountability lineage** connecting every agent action to a responsible human officer. Maintain an **agent accountability register** (business owner, technical owner, delegation-authority lineage, review conditions).
- **AG-GV.3 Agent Inventory and Lifecycle** — extends existing **GV.1.6** (AI system inventory). Inventories must be dynamic (capture ephemeral sub-agents); organisations at **Tier 3 or Tier 4 should maintain real-time agent registries integrated with IAM**.

### MAP extensions (§4.2)
- **AG-MP.1 Agent Tool Risk Classification** — a **tool risk inventory** per deployment across four dimensions: consequence scope (read-only → destructive), reversibility, authentication requirements, and compositional risk. Distinguishes read / write / **execute** tools (execute = code/command execution, side-effecting API calls = highest inherent risk).
- **AG-MP.2 Action-Consequence Analysis** — required for **Tier 2 and above**; produces a **consequence graph** (directed graph: nodes = agent states, edges = tool invocations with consequence probability and severity).
- **AG-MP.3 Multi-Agent Topology Risk** — map inter-agent interaction patterns, trust boundaries, and compromise-propagation risk; required for any deployment where an agent can receive inputs from other agents rather than only from humans.

### MEASURE extensions (§4.3)
- **AG-MS.1 Agentic Behavioural Telemetry** — required at **Tier 2+**; minimum telemetry set: **action velocity**, **permission escalation rate**, **cross-boundary invocations**, **delegation depth**, and **exception rates**, evaluated against baselines from controlled deployment testing.
- **AG-MS.2 Autonomy Calibration Assessment** — compares an agent's track record against its tier's risk-tolerance thresholds; supports tier promotion/demotion. Cadence: **at minimum annually for Tier 2, quarterly for Tier 3, monthly for Tier 4**, plus incident-triggered assessments. Provides a feedback loop from MEASURE back to GOVERN.
- **AG-MS.3 Delegation Chain Integrity** — monitor actual vs planned delegation depth/breadth, out-of-scope sub-agent capability use, deviant cross-agent communication, and authority-claim consistency against the delegation-time registry.

### MANAGE extensions (§4.4)
- **AG-MG.1 Agentic Incident Classification and Response** — playbooks for incident types unique to agents: **agent compromise** (adversarial control), **behavioural hijack** (following injected instructions), **runaway agent** (exceeded authorisation via error/manipulation), **delegation chain compromise** (malicious agent introduced into a network). Each playbook: detection criteria from telemetry thresholds; containment (suspension/termination conditions); forensic procedures accounting for ephemeral/distributed actions; remediation. Recommends **pre-authorised automatic containment / kill-switch** for the highest-severity patterns because the human-in-the-loop window is often too short.
- **AG-MG.2 Drift Detection and Remediation** — distinguishes acceptable variation from problematic drift; remediation path = drift characterisation → root-cause analysis → remediation selection (re-anchoring via fine-tuning or prompt adjustment, scope reduction, autonomy tier demotion, or redeployment from a known-good state).
- **AG-MG.3 Principled Agent Retirement (Decommissioning)** — disposition of persistent memory/learned state; revocation of all credentials/API keys/tool access; notification of external systems holding trust relationships; preservation of complete action-history audit logs per retention obligations; assessment of downstream dependent agents/systems.

## Alignment with AAGATE (§5) — CSA's own architecture

AAGATE ("Agentic AI Governance Assurance and Trust Engine"), a CSA reference architecture published **22 December 2025**, is presented as a Kubernetes-native runtime instantiation of the extensions. Key components (all CSA constructs):
- **Governing-Orchestrator Agent (GOA)** — decision centre; classifies incidents using Carnegie Mellon SEI **SSVC** (Stakeholder-Specific Vulnerability Categorization) logic; activates a **"millisecond kill-switch"** (implements AG-MG.1; enforces AG-GV.1 tier policies).
- **Janus Shadow-Monitor Agent (SMA)** — embedded red-team pre-execution evaluator (implements AG-MG.2 drift detection and AG-MS.3 delegation-chain integrity).
- **Tool-Gateway Chokepoint** — single audited control point for all external interactions (implements AG-MP.1); enforces authorisation at the infrastructure level rather than in the (potentially compromised) agent.
- **Agent Name Service (ANS)** — verifiable agent registry using **Decentralized Identifiers (DIDs)** and **SPIFFE** credentials; a zero-trust identity model (implements AG-GV.3 and AG-MS.3).

## Mapping table (§6) — RMF subcategory → AG extension → AICM domain → AAGATE component

Cross-references existing RMF subcategories to proposed AG extensions, CSA **AICM v1.0** control domains, and AAGATE components. Selected rows:
- GV.1.3 (Risk tolerance) → AG-GV.1 Autonomy Tier Classification → GRC → AAGATE GOA Tier Policy Engine
- GV.2.1 (Accountability structures) → AG-GV.2 Delegation Accountability Register → Accountability and Transparency → AAGATE ANS
- GV.1.6 (AI system inventory) → AG-GV.3 Agent Lifecycle Registry → Supply Chain Transparency → AAGATE ANS
- MP.2.1 (Impact assessment) → AG-MP.1 Tool Risk Classification → Application and Interface Security → Tool-Gateway Chokepoint
- MP.3.1 (System context) → AG-MP.3 Multi-Agent Topology Risk → App/Interface Security → AAGATE eBPF Mesh
- MS.1.1 (Risk metrics) → AG-MS.1 Behavioural Telemetry → Security Monitoring and Incident Response → AAGATE UEBA/Kafka Pipeline
- MG.2.2 (Risk response) → AG-MG.1 Incident Response Playbooks → Sec Monitoring/IR → GOA + Kill-Switch
- MG.4.1 (Residual risk) → AG-MG.3 Decommissioning → GRC → ANS Credential Revocation

## Implementation guidance & relationship to NIST guidance (§7–8)

- Phased path for mature-RMF organisations: Phase 1 GOVERN (tier policy, oversight boundary, extend inventory) → Phase 2 MAP (tool risk inventories, action-consequence maps) → Phase 3 MEASURE (telemetry, calibration, delegation monitoring for Tier 2+) → Phase 4 MANAGE (playbooks, drift correction, decommissioning; tabletop exercises, and live drills for Tier 3/4). Recommends adopting AAGATE rather than building custom tooling.
- Emphasises treating **agents as non-human identities** subject to the same lifecycle management, privilege minimisation, and monitoring as service accounts, managed within existing IAM/PAM infrastructure.
- **§8 explicitly frames the paper as a companion, not a replacement**, to NIST AI 100-1 and AI 600-1, and defers to NIST's forthcoming AI Agent Standards Initiative (which "may supersede, refine, or formalize the extensions proposed here"). Cites a March 2026 NIST report on AI monitoring stating monitoring for agentic systems must span functionality, operations, security, compliance, and human factors. CSA states the CSA AI Safety Initiative will update the document as official NIST guidance matures.

## Notes on limitations / what to flag when citing

- **Provenance:** CSA draft white paper, not a NIST document. The "AG-*" identifiers, four-tier taxonomy, and AAGATE mappings are CSA proposals.
- **Promotional angle:** the paper recommends CSA's own AAGATE and AICM products as the implementation path; treat those endorsements as self-interested.
- **Unconfirmed future items:** the NIST AI Agent Interoperability Profile (Q4 2026), CAISI initiative details, and the "March 2026 NIST report on AI monitoring" are described as of the paper's authorship and may not have materialised as stated. Given the document date (2026-03-27) some cited items are near-contemporaneous or forward-looking.
- The extraction is complete (full white paper text through the reference list); no obvious truncation.
