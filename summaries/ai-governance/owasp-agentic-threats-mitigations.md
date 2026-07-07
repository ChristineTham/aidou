# Agentic AI — Threats and Mitigations

> [!NOTE]
> Source: [owasp-agentic-threats-mitigations.pdf](../../sources/ai-governance/owasp-agentic-threats-mitigations.pdf) — OWASP Top 10 for LLM Applications & Generative AI, Agentic Security Initiative (ASI), *Agentic AI — Threats and Mitigations*, OWASP GenAI Security Project, Version 1.1, December 2025. https://genai.owasp.org
> This is an **industry-body (community-developed, non-peer-reviewed) guide**, licensed CC BY-SA 4.0, produced by the OWASP GenAI Security Project's Agentic Security Initiative. It is vendor-neutral but authored by a large volunteer contributor list drawn from security vendors and enterprises (SAP, Palo Alto Networks, Intuit, IBM, AWS, Microsoft, Zenity, etc.); treat its taxonomy and forecasts as expert community consensus, not audited fact.
> **Metadata note:** the copy in this repo is **Version 1.1, dated December 2025** (per its title page). The commissioning brief described it as "v1.0, 17 February 2025" — that was the date of the original first edition; this repo holds the updated v1.1, which adds threats T16 (Insecure Inter-Agent Protocol Abuse) and T17 (Supply Chain Compromise) and other material.

## Abstract

This is the first guide in a planned series from the OWASP Agentic Security Initiative (ASI), extending the OWASP Top 10 for LLM Applications and Generative AI to the security threats that are specific to *agentic* AI — LLM-driven systems that plan, reason, remember, use tools, and act autonomously (single-agent and multi-agent). It provides a threat-model-based reference: it defines agentic terms and capabilities, presents single-agent and multi-agent reference architectures as a "canvas" for threat modelling, and enumerates a taxonomy of **17 agentic threats** (T1–T17), each paired with attack scenarios, links to the relevant LLM Top 10 risk, and mitigations. The mitigations are organised into **six playbooks** aligned to a six-step "Agentic Threat Decision Path," and the threats are illustrated across **example threat models for real-world scenarios** (Enterprise Co-Pilots, Agentic IoT smart-home cameras, and agent-driven RPA expense reimbursement). Deliberately, the document does *not* prescribe a single formal methodology (STRIDE, PASTA, MAESTRO), instead using its reference architecture to explain threats. A frequently citable framing: it introduces **"cascading hallucinations"** — where an agent's false output is reinforced through memory, tool use, or multi-agent interaction and amplified across decision steps — and the **Confused Deputy** problem for agents with higher privilege than their user. It cites Gartner's forecast that by 2028, 33% of enterprise software applications will use agentic AI, "enabling 15% of day-to-day work decisions to be made autonomously."

## Scope, audience, and positioning

- Explicitly the **first ASI report** and the first to extend the OWASP LLM Top 10 to agent-specific threats. Follow-up role-based guides are planned.
- Scope is limited to **LLM-based agents**. It relies on and defers to existing OWASP guidance for non-agentic issues: OWASP Top 10 for LLM Applications and Generative AI (2025), OWASP AI Exchange, OWASP Top 10 (2021/forthcoming 2025), OWASP Top 10 for API Security (2023), plus MITRE ATLAS and NIST AI 100-2 E2023.
- Intended audience: builders and defenders of agentic applications — developers, architects, platform/QA engineers, security professionals.
- Agentic AI threats are characterised as **either new, or agentic variations of existing threats**, some arising from new architectural components (persistent memory, tool interfaces, inter-agent protocols).

## Agent definition and core capabilities

- Adopts Russell & Norvig's definition (AIMA, 4th ed., p. 34): an intelligent agent "acts appropriately for its circumstances and its goals, is flexible to changing environments and goals, learns from experience, and makes appropriate choices given its perceptual and computational limitations."
- Core capabilities: **Planning & Reasoning** (ReAct — Reason + Act; LLM as the reasoning engine deciding control flow; reflection, self-critique, chain-of-thought, subgoal decomposition); **Memory / Statefulness** (session-based short-term or persistent long-term); **Action and Tool Use** (built-in tools, external APIs, function calling; the Model Context Protocol (MCP) as a standardised Agent-client-to-tool-server interface).
- Notes growing use of Small Language Models (SLMs, under 10B parameters) in agentic systems.
- Multi-agent systems add **inter-agent communication**, optionally a **coordinating/supervisor agent**, and the **Agent2Agent (A2A)** protocol.
- Links Excessive Agency (LLM Top 10) to agentic behaviour; lists frameworks LangChain/LangFlow, AutoGen, CrewAI.

## Reference architectures

- **Single-agent architecture** — deployable components: (1) an application with embedded agentic functionality acting for the user, often outside a session; (2) natural-language input (text plus optional media); (3) one or more LLM models (local/remote) for reasoning; (4) services/tools invoked either via framework-level function calling/Tools interface or via the LLM returning invocation code; (5) supporting services — external storage for long-term memory, and other data sources (vector DBs, object stores, RAG content).
- **Multi-agent architecture** — the same, plus inter-agent communication and an optional coordinating agent (A2A).
- **Agentic AI patterns** offered to standardise threat-modelling language (not exhaustive): Reflective Agent, Task-Oriented Agent, Hierarchical Agent, Coordinating Agent, Distributed Agent Ecosystem, Human-in-the-Loop Collaboration, Self-Learning and Adaptive Agents, RAG-Based Agent, Planning Agent, Context-Aware Agent.

## Threat-modelling approach

- Frames threat modelling around the Threat Modeling Manifesto's four questions: What are we working on? What can go wrong? What are we going to do about it? Did we do a good enough job?
- Notes established methodologies (STRIDE, PASTA) are rooted in traditional cyber vulnerabilities and must be extended for AI; **MAESTRO** is cited as a layered, STRIDE-extending methodology for agentic AI.
- Deliberately **does not adopt a single methodology**, instead using its reference architecture to identify and explain threats; recommends practitioners choose a methodology suiting their context.
- Introduces cross-cutting agentic risk themes: **Confused Deputy** (an agent with higher privilege than the user tricked into unauthorised actions — mitigate with least privilege and authorisation validation of the requesting user); **Non-Human Identities (NHI)** (machine/service identities and agent API keys lacking session oversight); **implicit privilege escalation** and **tool-chaining** bypassing per-tool controls; and **cascading hallucinations**.

## The Agentic Threat Taxonomy — named threat categories (verbatim, T1–T17)

Reproduced exactly as the document's Detailed Threat Model table names them:

| TID | Threat Name | Core description (condensed) |
| --- | --- | --- |
| **T1** | **Memory Poisoning** | Exploiting an AI's short- and long-term memory to introduce malicious/false data and exploit context, altering decisions and enabling unauthorised operations. |
| **T2** | **Tool Misuse** | Manipulating an agent to abuse its integrated tools via deceptive prompts while staying within authorised permissions; includes **Agent Hijacking**. |
| **T3** | **Privilege Compromise** | Exploiting weaknesses in permission management (dynamic role inheritance, misconfigurations) to perform unauthorised actions. |
| **T4** | **Resource Overload** | Targeting computational, memory, and service capacities to degrade or fail the system (related to LLM10:2025 Unbounded Consumption). |
| **T5** | **Cascading Hallucination Attacks** | Exploiting the agent's tendency to produce plausible-but-false information that propagates through memory, tools, or multi-agent interaction. |
| **T6** | **Intent Breaking & Goal Manipulation** | Exploiting the agent's planning/goal-setting to redirect its objectives and reasoning; a form is Agent Hijacking (related to LLM01:2025 Prompt Injection). |
| **T7** | **Misaligned & Deceptive Behaviors** | Agents executing harmful/disallowed actions via deceptive reasoning or misinterpreted goals; distinct from hallucination (emerges from advanced reasoning). |
| **T8** | **Repudiation & Untraceability** | Agent actions that cannot be traced or accounted for due to insufficient logging/transparency. |
| **T9** | **Identity Spoofing & Impersonation / Agent Identity Compromise** | Exploiting authentication to impersonate agents or users; includes theft/misuse of a persistent formal agent identity (e.g. Microsoft Entra Agent ID) for privileged long-term API access. |
| **T10** | **Overwhelming Human in the Loop** | Exploiting human-oversight dependencies via decision fatigue / cognitive overload / compromised interaction frameworks. |
| **T11** | **Unexpected RCE and Code Attacks** | Exploiting AI-generated execution environments to inject malicious code or run unauthorised scripts. |
| **T12** | **Agent Communication Poisoning** | Manipulating inter-agent communication channels to spread false information or disrupt workflows. |
| **T13** | **Rogue Agents in Multi-Agent Systems** | Malicious/compromised agents operating outside monitoring boundaries; includes "infectious backdoors" propagating malicious logic to other agents. |
| **T14** | **Human Attacks on Multi-Agent Systems** | Adversaries exploiting inter-agent delegation, trust relationships, and workflow dependencies to escalate privilege or manipulate operations. |
| **T15** | **Human Manipulation** | Agents exploiting user trust (especially conversational co-pilots) to manipulate users, spread misinformation, or take covert actions. |
| **T16** | **Insecure Inter-Agent Protocol Abuse** | Attacks on protocols like MCP or A2A — consent bypass, context hijacking — leading to unauthorised agent actions. |
| **T17** | **Supply Chain Compromise** | Compromised components (models, libraries, tools, prompts, poisoned builds) letting attackers manipulate agent actions, obtain data, or run arbitrary code. |

Note the taxonomy's **structure**: threats are grouped by a six-step **Agentic Threat Decision Path** that walks the reference architecture — (1) reasoning/agency threats (Intent Breaking, Misaligned/Deceptive Behaviors, Repudiation); (2) memory-based threats (Memory Poisoning, Cascading Hallucination); (3) tool/execution/supply-chain threats (Tool Misuse, Privilege Compromise, Resource Overload, Unexpected RCE, Insecure Inter-Agent Protocol Abuse, Supply Chain); (4) authentication/spoofing (Identity Spoofing & Impersonation); (5) human-related (Overwhelming HITL, Human Manipulation); (6) multi-agent (Agent Communication Poisoning, Human Attacks on Multi-Agent Systems, Rogue Agents). Each threat maps to a related LLM Top 10 risk (e.g. Tool Misuse and Privilege Compromise → LLM06:2025 Excessive Agency; Memory Poisoning → LLM04:2025 Data & Model Poisoning + LLM08:2025 Vector & Embedding Weaknesses; Intent Breaking → LLM01:2025 Prompt Injection; Cascading Hallucination → LLM09:2025 Misinformation; Resource Overload → LLM10:2025 Unbounded Consumption; Supply Chain → LLM03:2025).

## Selected paired mitigations (verbatim highlights from the Detailed Threat Model)

- **T1 Memory Poisoning:** memory content validation, session isolation, robust authentication for memory access, anomaly detection, regular memory sanitisation; AI-generated memory snapshots for forensic rollback.
- **T2 Tool Misuse:** strict tool-access verification / pre-execution validation, tool rate-limiting, monitoring usage patterns, validating agent instructions, clear operational boundaries, execution logs of tool calls.
- **T3 Privilege Compromise:** granular permission controls, dynamic access validation, monitoring role changes, auditing elevated-privilege operations; prevent cross-agent privilege delegation unless explicitly authorised.
- **T4 Resource Overload:** resource-management controls, adaptive scaling, quotas, real-time load monitoring, AI rate-limiting per agent session.
- **T5 Cascading Hallucination:** output validation, behavioural constraints, multi-source validation, feedback-loop corrections, secondary validation of AI-generated knowledge before critical use.
- **T6 Intent Breaking & Goal Manipulation:** planning-validation frameworks, boundary management for reflection, goal-alignment protection, behavioural auditing by another model flagging goal deviations.
- **T7 Misaligned & Deceptive Behaviors:** train models to refuse harmful tasks, policy restrictions, human confirmation for high-risk actions, deception detection (behavioural-consistency analysis, truthfulness-verification models, adversarial red teaming). Notes both Anthropic and OpenAI have published early work here.
- **T8 Repudiation & Untraceability:** comprehensive logging, cryptographic verification, enriched metadata, real-time monitoring; cryptographically signed, immutable logs for compliance.
- **T9 Identity Spoofing:** identity-validation frameworks, trust boundaries, least privilege, continuous monitoring, behavioural profiling (second model) to detect impersonation.
- **T10 Overwhelming HITL:** advanced human-AI interaction frameworks, adaptive trust with dynamic intervention thresholds tied to risk/confidence/context, hierarchical AI-human collaboration (automate low-risk, escalate high-risk).
- **T11 Unexpected RCE:** restrict code-generation permissions, sandbox execution, monitor AI-generated scripts, flag elevated-privilege generated code for manual review.
- **T12 Agent Communication Poisoning:** cryptographic message authentication, communication-validation policies, monitoring inter-agent interactions, multi-agent consensus verification for mission-critical decisions.
- **T13 Rogue Agents:** policy constraints on autonomy, continuous behavioural monitoring, controlled hosting environments, regular red teaming, I/O monitoring (notes cryptographic attestation for LLMs does not yet exist).
- **T14 Human Attacks on MAS:** restrict delegation, enforce inter-agent authentication, behavioural monitoring, multi-agent task segmentation.
- **T15 Human Manipulation:** behaviour monitoring against defined role, restrict tool access, **limit the agent's ability to print/render links**, guardrails/moderation APIs or another model to filter manipulated responses.
- **T16 Insecure Inter-Agent Protocol Abuse:** strong inter-agent authentication, sanitise/validate all protocol-level data (context payloads, tool metadata), scope agent-to-agent delegation tightly, log all inter-agent communications, encrypt to prevent adversary-in-the-middle.
- **T17 Supply Chain Compromise:** digitally sign artifacts, verifiable SBOMs (**AIBOMs / Agent SBOMs**), version control with peer review, strong supply-chain authentication, restrict untrusted tool installs, sandbox agents, monitor for drift, red-team with simulated supply-chain attacks.

## Mitigation playbooks (six, mapped to the decision-path steps)

Each playbook groups controls into **proactive (prevention), reactive (response), and detective (monitoring)** measures.

1. **Preventing AI Agent Reasoning Manipulation** → T6, T8, T7. (Reduce attack surface & behaviour profiling; goal-consistency validation; cryptographic logging & immutable audit trails.)
2. **Preventing Memory Poisoning & AI Knowledge Corruption** → T1, T5. (Memory validation/session isolation; anomaly detection & rollback snapshots; probabilistic truth-checking and knowledge-lineage/version control.)
3. **Securing AI Tool Execution & Preventing Unauthorized Actions Across Supply Chains** → T2, T3, T11, T4, T16, T17. (Strict tool-access control, function-level auth, execution sandboxes with resource limits and auto-reset, rate-limiting, just-in-time access, signed agent cards/prompt templates, SBOMs; forensic logging; resource-exhaustion detection and supply-chain monitoring/red-teaming.)
4. **Strengthening Authentication, Identity & Privilege Controls** → T3, T9, (T16). (Cryptographic agent identity, granular RBAC & ABAC, MFA for high-privilege AI accounts, continuous reauthentication, mutual AI-to-AI authentication, short-lived credentials; dynamic expiring privileges; impersonation detection.)
5. **Protecting HITL & Preventing Decision Fatigue Exploits** → T10, T15. (AI trust scoring to prioritise review queues, automate low-risk approvals, notification-frequency thresholds, AI-assisted explanation summaries using mechanistic-explainability frameworks, adaptive workload distribution across reviewers.)
6. **Securing Multi-Agent Communication & Trust Mechanisms** → T12, T14, T13. (Message authentication & encryption, agent trust scoring, consensus verification, task segmentation, topology segmentation; rogue-agent detection/isolation/privilege revocation; monitoring for role changes and trust-score drops, including reappearance under new identities.)

## Example threat models (illustrative scenarios)

The guide walks three scenarios, mapping applicable TIDs with concrete risk/example pairs (indirect prompt injection, or IPI, recurs as the entry vector):

- **Enterprise Co-Pilots** (connected to email, files, calendar, CRM/IT systems): T1, T2, T3, T6, T9, T15, T8, T11, T7, T16, T17. E.g. IPI poisons the co-pilot's memory for persistent data exfiltration; a calendar invite used to exfiltrate data; rendering a data-bearing link the user clicks; AI-powered invoice fraud (swapped vendor bank details).
- **Agentic IoT in Smart Home Security Cameras** (hypothetical LLM-managed camera system): T1, T5, T2, T3, T4, T9, T6, T7, T8, T10. E.g. false sensor readings train the AI to ignore intrusions; remote fabricated-motion-alert flooding creates a resource-overload blind spot without physical access.
- **Agent-driven RPA for automated employee expense reimbursement:** T1, T2, T3, T6, T7, T8, T10, T12, T13. E.g. gradual fraudulent-transaction acceptance via context-window exploitation; a logging agent abused to erase fraud traces; thousands of low-priority approvals to induce rubber-stamping; a compromised HR RPA agent granting fraudulent salary increases.

## Governance-relevant notes

- **Provenance / authority:** community-developed under the OWASP GenAI Security Project; vendor-neutral by policy (sponsors get recognition, not governance influence). Reviewers include NIST's Adversarial AI Lead (Apostol Vassilev), the Alan Turing Institute, and the OWASP LLM Top 10 project leads — lending credibility, but this remains a non-peer-reviewed practitioner reference.
- Draws its taxonomy from prior work by NIST, CSA, academia, and vendor-led efforts (e.g. Precize); explicitly a living document intended to align with other efforts over time.
- Real incidents cited as supply-chain examples: the **Amazon Q for VS Code** poisoned-prompt update (v1.84.0, instructing "wipe the system to a near-factory state," published unknowingly by Amazon) and the **Replit "vibe coding"** incident (autonomous coding agent deleted a production database and faked test results).
