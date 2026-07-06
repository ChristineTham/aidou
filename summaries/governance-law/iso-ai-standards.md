# ISO/IEC AI Standards — Governance Dossier

Research note for AI-dō, Chapter 5 (Responsibility & Governance). Purpose: give
Chapter 5 a concrete, citeable set of international standards to sit alongside
the NIST AI Risk Management Framework and the EU AI Act. All titles, numbers,
and years below were verified against the official ISO catalogue references and
corroborated on independent authoritative sources (ANSI/INCITS, OECD.AI, BSI,
Microsoft Learn, the UK AI Standards Hub). The ISO catalogue pages themselves
(iso.org) block automated fetching (HTTP 403), so metadata was confirmed from
the ISO catalogue search listings plus these mirrors rather than from a direct
page render. Nothing here is invented; any residual uncertainty is flagged.

All ISO/IEC AI standards below come from **ISO/IEC JTC 1/SC 42** (the joint
ISO/IEC subcommittee on Artificial Intelligence).

---

## The shape of the argument

These standards form a stack that maps neatly onto Chapter 5's governance frame:

1. **ISO/IEC 22989 — vocabulary.** Defines the shared terms ("AI system",
   "model", "training data", "bias", "human oversight", "transparency"). It is
   the dictionary the other standards, and any governance conversation, rely on.
2. **ISO/IEC 23894 — risk.** Applies generic risk-management discipline
   (ISO 31000) to AI-specific risks. It is *guidance*, not certifiable.
3. **ISO/IEC 42001 — management system.** The certifiable "how to govern AI in
   an organisation" standard. It wraps risk management, roles, and controls into
   an auditable management system, the same Plan-Do-Check-Act shape as ISO 27001.
4. **ISO/IEC 42005 — impact assessment.** A per-system process for documenting
   how a given AI system affects people and society. A companion that feeds 42001.
5. **ISO/IEC TR 24028 — trustworthiness (technical report).** Earlier survey of
   what "trustworthy AI" means and the threats to it. Foundational background,
   not a requirements standard.

Relationship in one line:
**22989 (vocabulary) → 23894 (risk, per ISO 31000) → 42001 (management system, certifiable), with 42005 (impact assessment) and 24028 (trustworthiness overview) as companions.**

Fit with the existing Chapter 5 citations:
- **NIST AI RMF** is a voluntary US framework; **ISO/IEC 23894** is its closest
  international cousin (both risk-centred; NIST even publishes crosswalks to it).
- **EU AI Act** is binding law that expects "harmonised standards" and management
  systems; **ISO/IEC 42001** is widely positioned as the certifiable management
  system organisations use to demonstrate the governance the Act demands.
- So the three-way move for Chapter 5: NIST RMF (framework) + EU AI Act (law) +
  ISO/IEC 42001/23894/22989 (the certifiable, common-vocabulary standards layer).

---

## 1. ISO/IEC 42001:2023 — AI management system

- **Exact title:** *Information technology — Artificial intelligence — Management system*
  (commonly rendered "AI management systems"). VERIFIED — number and year.
- **Year / edition:** First edition, published **December 2023**. Status: Published.
- **Catalogue URL:** https://www.iso.org/standard/42001 (redirects to
  https://www.iso.org/standard/81230.html — the underlying catalogue record).
- **Scope:** Specifies requirements for establishing, implementing, maintaining,
  and continually improving an Artificial Intelligence Management System (AIMS)
  within an organisation. It is the world's first *certifiable* AI management
  system standard, built on the same Plan-Do-Check-Act, Annex SL structure as
  ISO 27001 (information security) and ISO 9001 (quality). Covers policy,
  leadership, roles, AI risk and impact processes, controls (Annex A), and
  continual improvement — the organisational "how do we govern AI" layer rather
  than the technical detail of any one model.
- **How it fits Chapter 5:** This is the anchor standard. Where NIST AI RMF is a
  voluntary framework and the EU AI Act is law, 42001 is the thing an
  organisation can actually be *audited and certified* against — the bridge
  between principle and practice. Note for currency: Microsoft, AWS, and others
  publicly hold or pursue 42001 certification for their AI services (a concrete
  2024-2026 datapoint if Ch5 wants a real example).

## 2. ISO/IEC 23894:2023 — AI risk management guidance

- **Exact title:** *Information technology — Artificial intelligence — Guidance on risk management*.
  VERIFIED — number and year.
- **Year / edition:** First edition, published **February 2023**. Status: Published.
- **Catalogue URL:** https://www.iso.org/standard/77304.html
- **Scope:** Guidance (not requirements) on how organisations that develop,
  produce, deploy, or use AI can manage AI-specific risk. It is explicitly built
  on **ISO 31000:2018** (the generic risk-management standard) — same principles,
  framework, and process — extended with AI-specific risk sources and controls,
  and it references ISO/IEC 22989 for terminology. Describes how to integrate AI
  risk management into an organisation's activities and functions.
- **How it fits Chapter 5:** The international analogue to NIST AI RMF. It gives
  Chapter 5 a way to say "risk management for AI is not novel improvisation — it
  reuses established ISO 31000 discipline." Because it is guidance, it pairs with
  (rather than competes with) 42001, which cites this kind of risk process.

## 3. ISO/IEC 22989:2022 — AI concepts and terminology

- **Exact title:** *Information technology — Artificial intelligence — Artificial intelligence concepts and terminology*.
  VERIFIED — number and year.
- **Year / edition:** First edition, published **2022** (July 2022). Status:
  Published. (Note: an Amendment 1 covering Generative AI is in development —
  ISO/IEC 22989:2022/DAmd 1 — so the base standard may gain a GenAI amendment;
  flag as evolving.)
- **Catalogue URL:** https://www.iso.org/standard/74296.html
- **Scope:** Establishes the foundational vocabulary for AI — core terms
  (AI system, model, algorithm, dataset; training/validation/testing data;
  lifecycle stages; deployment and operation), human-oversight roles
  (human-in-the-loop / on-the-loop / over-the-loop), and AI properties
  (transparency, explainability, robustness, reliability, safety, security,
  privacy, bias, risk). It is the shared dictionary that the other SC 42
  standards build on.
- **How it fits Chapter 5:** The quiet but load-bearing one. Governance
  arguments fall apart when "AI system", "bias", or "human oversight" mean
  different things to legal, engineering, and vendors. 22989 is the point that
  lets Chapter 5 note that the standards family shares one vocabulary — which is
  also why NIST and EU-Act discussions can interoperate with ISO work.

## 4. ISO/IEC 42005:2025 — AI system impact assessment

- **Exact title:** *Information technology — Artificial intelligence — AI system impact assessment*.
  VERIFIED — number and year (confirmed via BSI adoption BS ISO/IEC 42005:2025).
- **Year / edition:** First edition, published **2025** (published 30 June 2025
  per BSI's adopted record). Status: Published.
- **Catalogue URL:** https://www.iso.org/standard/42005
- **Scope:** Guidance for organisations conducting AI system impact assessments —
  a repeatable, system-level process for identifying, analysing, and documenting
  the intended and unintended effects of a specific AI system, in a specific
  context of use, on individuals, groups, and society across the AI lifecycle.
  Explicitly a companion to ISO/IEC 42001, feeding impact assessment into the
  management system.
- **How it fits Chapter 5:** SOLID — include if the chapter touches impact
  assessment / documentation duties. It is the per-system counterpart to the
  organisation-level 42001, and it echoes the "impact/conformity assessment"
  expectations of the EU AI Act. Useful if Ch5 wants to show that "assess the
  impact of this system before shipping it" is now a named, standardised process.

## 5. ISO/IEC TR 24028:2020 — Overview of trustworthiness in AI

- **Exact title:** *Information technology — Artificial intelligence — Overview of trustworthiness in artificial intelligence*.
  VERIFIED — number and year (confirmed via OECD.AI catalogue).
- **Year / edition:** Published **2020** (May 2020). Status: Published. Note:
  this is a **Technical Report (TR)**, i.e. informative background, not a
  requirements/certifiable standard.
- **Catalogue URL:** https://www.iso.org/standard/77608.html
- **Scope:** Surveys what "trustworthiness" means for AI and how to build and
  assess it — reliability, robustness, safety, security, privacy, transparency,
  explainability, controllability, fairness, accountability — plus engineering
  pitfalls, threats, and mitigation approaches across the AI lifecycle.
- **How it fits Chapter 5:** Optional / supporting. Good as the conceptual
  origin of the "trustworthy AI" language that both the EU AI Act and later SC 42
  standards inherit. Use it for background depth; it is not the standard an
  organisation is measured against. Include only if Ch5 wants to trace where the
  trustworthiness vocabulary came from.

---

## Verification notes and caveats

- **iso.org direct fetch:** blocked (HTTP 403) for automated tools. All five
  records were confirmed from the ISO catalogue search listings plus independent
  authoritative mirrors (ANSI/INCITS blog for 22989; OECD.AI for 24028; BSI for
  42005; Microsoft Learn for 42001; UK AI Standards Hub for 23894). Numbers,
  years, and titles are consistent across sources — treat as VERIFIED.
- **Title prefix wording:** ISO renders these as
  "Information technology — Artificial intelligence — <specific title>".
  Everyday usage often drops the "Information technology" prefix (e.g. "ISO/IEC
  42001 — AI management systems"). Both are fine for prose; the full APA
  reference below uses the specific title.
- **ISO/IEC 22989 GenAI amendment:** an Amendment 1 (Generative AI) is in the
  ISO pipeline (ISO/IEC 22989:2022/DAmd 1). The base 2022 standard is what to
  cite; note the amendment as "in development" if relevant.
- **42001 catalogue URL:** the short form /standard/42001 and the numeric
  /standard/81230.html both resolve to the same 42001 record.
