# New Cloud Security Alliance Survey Reveals 82% of Enterprises Have Unknown AI Agents in Their Environments

> [!NOTE]
> Source: [csa-shadow-agents-survey.md](../../sources/ai-governance/csa-shadow-agents-survey.md) — Cloud Security Alliance (CSA), *New Cloud Security Alliance Survey Reveals 82% of Enterprises Have Unknown AI Agents in Their Environments* (press release for the report *Autonomous but Not Controlled: AI Agent Incidents Now Common in Enterprises*), CSA Official Press Release, 21 April 2026. https://cloudsecurityalliance.org/press-releases/
> Vendor-commissioned survey: the underlying report was commissioned and financed by Token Security ("identity-first AI agent security"), which co-developed the questionnaire with CSA; CSA performed the data analysis. Read self-reported survey figures accordingly. This file summarises the press release, not the full report.

## Abstract

This CSA press release (21 April 2026) announces the survey report *Autonomous but Not Controlled: AI Agent Incidents Now Common in Enterprises*, based on an online survey CSA conducted in January 2026 of 418 IT and security professionals across organisations of various sizes and locations. The headline finding: "82% have discovered previously unknown agents in the past year, with 41% of respondents saying this happened multiple times" — i.e. "shadow" AI agents are near-universal even though 68% of respondents report high confidence in their visibility into AI agents. The release also reports that 65% of organisations experienced at least one AI agent-related incident in the past 12 months (61% data exposure, 43% operational disruption, 35% financial loss, with no respondent reporting zero material business impact), and it identifies weak lifecycle/decommissioning practice as a leading risk factor — only 21% have formal decommissioning processes. It matters for AI governance because it quantifies a visibility gap between perceived and actual control over autonomous, non-human/agent identities.

## Provenance and method

- Report title: *Autonomous but Not Controlled: AI Agent Incidents Now Common in Enterprises*.
- Commissioned and financed by **Token Security**, which co-developed the questionnaire with CSA research analysts; CSA performed the data analysis and interpretation.
- Survey conducted online by CSA in **January 2026**; **418 responses** from IT and security professionals, organisations of various sizes and locations.
- Issuing date of release: **21 April 2026** (Seattle).

## Headline finding — shadow agents vs. perceived visibility

- Verbatim: "While 68% report high confidence in their visibility into AI agents, 82% have discovered previously unknown agents in the past year, with 41% of respondents saying this happened multiple times."
- The release frames the 82% against the 68% confidence figure as a contradiction — a perception-vs-reality visibility gap.
- Where shadow agents most commonly emerge: internal automation or scripting environments (51%); LLM platforms including custom tools, assistants and plugins (47%); SaaS tools with built-in automation (40%); developer-created workflows (40%).

## Incidents and business impact

- 65% reported at least one AI agent-related incident in the past 12 months.
- Impacts: data exposure 61%, operational disruption 43%, financial cost 35%. "No respondent reported experiencing zero material business impact."
- Resulting priorities: risk management 29%, monitoring 28%, permission control 19% — described as a shift "from discovery to managing agent behavior at scale."

## Lifecycle / decommissioning and "retirement debt"

- Only 21% of respondents have formal decommissioning processes in place, flagged as a leading risk factor.
- Many agents "linger long past their intended use, retaining permissions and credentials that create 'retirement debt'," which the release argues accumulates quietly into "a structural exposure."

## Autonomy and control at decision points

- Autonomy is not absolute: 53% operate agents autonomously for low-risk tasks with human review for higher-risk actions; 24% rely on human-in-the-loop for most tasks; only 13% report fully autonomous models.
- When agents exceed scope: 38% require human approval, 24% require it be logged, and only 11% will automatically block the action.

## Governance signals and future priorities

- Primary signals for governing agent behaviour: action risk (63%) and human authorization (53%).
- 79% say context-aware controls will be important/very important in the next two years.
- 66% report having clear guardrails for defining agent boundaries already in place.

## Notable quotes

- Hillary Baron, AVP of Research, CSA: "AI agent security and governance encompass an interconnected system spanning visibility, lifecycle management, policy, and monitoring. While foundational controls are in place, gaps in consistency and end-of-life management remain. As agents gain greater autonomy, governance must evolve into a more unified, operational model that can sustain control at scale."
- Itamar Apelblat, CEO and Co-Founder, Token Security: "AI agents are outpacing the identity systems meant to secure and control them, and it's already showing up in unknown agents and real incidents in the enterprise... They are a new type of identity and legacy controls don't work."
