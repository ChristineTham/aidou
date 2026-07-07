# AI Hallucination Cases

> [!NOTE]
> Source: [charlotin-hallucination-cases-db.md](../../sources/ai-governance/charlotin-hallucination-cases-db.md) — Damien Charlotin, *AI Hallucination Cases* (database), damiencharlotin.com/hallucinations, last updated 5 July 2026.
> This is a primary tracker maintained by a legal scholar (Damien Charlotin), not a vendor or advocacy document. The captured file is a web extraction of the live database's front page; it includes filter counts and the first screenful of case rows, not the full dataset. A downloadable CSV and per-case detail pages exist behind the site.

## Abstract

*AI Hallucination Cases* is a continuously updated database, maintained by legal scholar Damien Charlotin, that tracks court and tribunal decisions worldwide in which "generative AI produced hallucinated content – typically fake citations, but also other types of AI-generated arguments." The tracker records **1,725 cases identified so far** (as of the page's last-updated date of **5 July 2026**), and explicitly describes itself as "a work in progress" that "will expand as new examples emerge." Its inclusion standard is narrow: it covers only cases where a court "has explicitly found (or implied) that a party relied on hallucinated content or material," not the wider universe of all fake citations or all AI use in filings. For each case it records structured fields — jurisdiction/court, date, the party that used AI, the AI tool (if named), the nature of the hallucination, the outcome/sanction, and any monetary penalty. The single most citable fact: **1,725 court decisions across dozens of jurisdictions have identified AI-hallucinated content in legal filings**, grounding the scale of the reliability-and-verification problem for AI in professional practice.

## What the database is and what it counts

Charlotin describes the scope precisely (verbatim): the database tracks "legal decisions ... in cases where generative AI produced hallucinated content – typically fake citations, but also other types of AI-generated arguments. It does not track the (necessarily wider) universe of all fake citations or use of AI in court filings."

Inclusion is judgment-gated:
- It covers documents where AI use "is addressed in more than a passing reference by the court or tribunal."
- It does "not cover mere allegations of hallucinations, but only cases where the court or tribunal has explicitly found (or implied) that a party relied on hallucinated content or material."
- As "an exception," it also covers "some judicial decisions where AI use was alleged but not confirmed" — described as "a judgment call on my part."

Total: **1,725 cases identified so far**; **last updated: 5 July 2026**. The author notes the database "has been featured in news media, and indeed in several decisions dealing with hallucinated material" — i.e., courts themselves cite it.

## Fields tracked (per case)

Each row records:
- **Case** (party names / citation)
- **Court / Jurisdiction**
- **Date** (of decision)
- **Party Using AI** (who relied on the hallucinated material)
- **AI Tool** — with the caveat: "The mention of a specific tool does not necessarily mean that tool was responsible for the hallucinations in question."
- **Nature of Hallucination** (category and subcategory)
- **Outcome / Sanction**
- **Monetary Penalty**
- **Details** (a narrative of what the court found)
- **Report(s)** (supporting documents; PelAIkan checker reports)

## Breakdown by facet (counts on the captured page)

### By jurisdiction (State)
The USA dominates. Selected counts: **USA (1,187)**, **Canada (190)**, **Australia (96)**, **UK (59)**, **Israel (54)**, India (12), France (11), Brazil (10), Italy (9), Argentina (8), Belgium (8), Germany (8), New Zealand (7), Singapore (7), Spain (7), Ireland (6), Netherlands (6), South Africa (5), South Korea (4), Chile (3), Colombia (3), plus ~15 more jurisdictions with 1–2 cases each (Austria, Czech Republic, Denmark, Hong Kong, Kenya, Poland, Portugal, Qatar, Russian Federation, Tanzania, Uganda, UAE, Zimbabwe, Costa Rica, the Bahamas, Trinidad & Tobago, Papua New Guinea, Northern Cyprus, International Arbitration, etc.).

### By party using AI
- **Pro Se Litigant (1,016)** — the largest group
- **Lawyer (667)**
- Judge (24), Expert (13), Prosecutor (5), Paralegal (2), Arbitrator (1), Federal Defender (1)

### Nature of hallucination — category (cases can carry more than one)
- **Fabricated (1,447)**
- **Misrepresented (710)**
- **False Quotes (466)**
- **Outdated Advice (33)**

### Nature — subcategory
- **Case Law (1,544)** — overwhelmingly the target
- Legal Norm (194), Exhibits & Submissions (120), Doctrinal Work (39), Other (37), Overturned Case Law (17), Repealed Law (16)

### By legal field
Contract (419), Administrative (236), Civil rights (179), Employment (156), Tort (145), Other (111), Family (108), Criminal (51), Bankruptcy (45), Immigration (29), Tax (21), IP (16), Habeas (8), Landlord-tenant (4).

The tracker begins with the period **Q2 2023**.

## Sanctions and penalties (illustrative from captured rows)

Outcomes range from no sanction to admonishments, warnings, orders to show cause, struck briefs, bar/disciplinary referrals, and monetary penalties. The facet filters include "Monetary sanction" and "Disciplinary Referral." Sample penalties from the captured rows:
- **Landberg v City of New York** (CA NY 2d, USA, 23 June 2026, Lawyer): fabricated and misrepresented case law; **$10,500 USD** monetary sanction.
- **Patterson v. Nuvision Credit Union** (CA California 4d, USA, 2 July 2026, Pro Se): fabricated citations, false quotes; **$500 USD** plus a bar referral for unauthorised practice of law.
- **Nady v. Al Sadi** (Ontario SCJ, Canada, 26 June 2026): AI misuse increasing an adverse costs award; nominal **$1 CAD**.

A notable high-court entry in the captured set: **Pooja Ramesh Singh v. Jammu and Kashmir Bank Ltd.** (Supreme Court of India, 2 July 2026) — the Court found the NCLT/NCLAT had relied on AI-generated, non-existent case law and misattributed paragraphs, held that such reliance "amounts to a subversion of the rule of law," declared "zero tolerance for citing unverified AI-generated precedents," set aside the impugned orders, and directed the Bar Council of India to formulate guidance and disciplinary measures.

## Related tooling and provenance

- Charlotin has built **PelAIkan**, "an automated reference checker that also detects hallucinations," derived from the database.
- A companion newsletter, *Artificial Authority*, covers case commentary.
- Media coverage cited on the page includes the *LA Times* (M. Hiltzik, 22 May 2025), the Volokh Conspiracy (E. Volokh, 18 May 2025), *Next* (J.-M. Manach, 1 July 2025), and *404 Media* (J. Koebler & J. Roscoe, 30 September 2025).
- A downloadable CSV and a FAQ are provided; new-case submissions are crowdsourced (several captured rows credit contributors such as "Jesse Schaefer").

## Caveats for citing this source

- The database is self-described as non-exhaustive and a work in progress; the 1,725 figure is a snapshot as of 5 July 2026 and will rise. Cite the count with its date.
- Counts across facets overlap (a case can be both "Fabricated" and "False Quotes"), so category subtotals do not sum to the case total.
- The AI-tool field is explicitly not an attribution of causation.
