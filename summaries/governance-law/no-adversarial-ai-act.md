# Summary — No Adversarial AI Act (and related US restrictions on Chinese AI models)

> [!NOTE]
> **Source status:** US congressional bill + press coverage. A bill is a *proposal* unless/until enacted — so the distinction matters. What is **already in force** (executive/agency and state action): DeepSeek bans on devices at the Navy, NASA, Commerce, the US Senate, and several states (NY, TX, VA). What is **proposed** (introduced, not law): the No Adversarial AI Act (H.R. 4142, June 2025) and the No DeepSeek on Government Devices Act (Feb 2025). The stated driver throughout is data-security / CCP-access — the concern that PRC-origin models route or store US data where the Chinese state can reach it.

## Abstract

In 2025 the US moved on several fronts to keep AI models built by foreign adversaries — DeepSeek being the emblematic case — out of federal systems. The centrepiece proposal is the **No Adversarial AI Act (H.R. 4142)**, introduced 25 June 2025 by Rep. John Moolenaar (R-MI) and Rep. Raja Krishnamoorthi (D-IL), the chair and ranking member of the House Select Committee on the CCP, with House cosponsors Darin LaHood (R-IL) and Ritchie Torres (D-NY) and a Senate companion from Rick Scott (R-FL) and Gary Peters (D-MI). The bill directs the Federal Acquisition Security Council to build and publish a list of AI "produced or developed by a foreign adversary" (statutorily China, Russia, Iran, North Korea) and bars executive agencies from acquiring or using listed models, subject to narrow, congressionally-notified exceptions for research, testing, counter-intelligence, or mission-critical needs. It is a proposal — referred to the Committee on Oversight and Government Reform, not yet enacted. It sits alongside an earlier proposal (the No DeepSeek on Government Devices Act) and a wave of already-enacted executive and state device bans.

## Key points

**No Adversarial AI Act (H.R. 4142, 119th Congress)**
- **Sponsors:** Moolenaar (R-MI) and Krishnamoorthi (D-IL); House cosponsors LaHood (R-IL), Torres (D-NY); Senate companion by Scott (R-FL) and Peters (D-MI). Bipartisan and bicameral.
- **Date / status:** Introduced 25 June 2025; referred to the House Committee on Oversight and Government Reform. **Proposed — not enacted.**
- **Scope / mechanism:** The Federal Acquisition Security Council develops a list of foreign-adversary AI within 60 days of enactment; OMB publishes it publicly within 180 days; updated at least every 180 days. Executive agencies must review, exclude and remove listed models (using existing authority under 41 U.S.C. §4713) within 90 days.
- **"Foreign adversary"** = the "covered nations" of 10 U.S.C. §4872(f)(2): China, Russia, Iran, North Korea. "Foreign adversary entity" reaches companies headquartered in, organised under, ≥20%-owned by, or under the direction/control of those countries — so it captures corporate structure, not just nationality.
- **Exceptions:** Permitted with written notice to OMB and the relevant congressional committees for (1) scientifically valid research, (2) evaluation/training/testing/analysis, (3) counterterrorism/counterintelligence, (4) avoiding jeopardy to mission-critical functions.
- **De-listing:** An owner can petition off the list by certifying (with evidence) the model is not foreign-adversary-developed and having the Council re-certify.

**No DeepSeek on Government Devices Act**
- Reps. Josh Gottheimer (D-NJ) and Darin LaHood (R-IL) plus 16 colleagues; introduced 7 February 2025. Narrower than H.R. 4142 — targets DeepSeek specifically on government-issued devices. Also a **proposal**, not enacted.

**Already in force (executive/agency and state bans)**
- **Navy** (memo 24 Jan 2025): DeepSeek prohibited "in any capacity." **NASA** (31 Jan 2025): barred on data and government devices/networks. **Commerce**: "broadly prohibited on all GFE." **US Senate**: banned on Senate devices.
- **States:** New York (Gov. Hochul, early Feb 2025), plus Texas, Virginia and others restricted DeepSeek on state devices.

**Stated rationale (consistent across sources)**
- Data security and CCP access: DeepSeek's privacy policy stores US user data in China, exposing it to PRC data laws and intelligence reach; the Committee's April 2025 DeepSeek investigation recommended a federal procurement prohibition on PRC-origin models. Framed as national-security "firewall" and "digital sovereignty," explicitly forward-looking to cover future adversary models.

## Relation to the book

This is the mirror-image risk to the export-control episode already in §5.2.3 (the Anthropic/"Fable"/"Mythos" suspension over export controls): there, a *Western* model is pulled from a market on national-security grounds; here, the US moves to wall *adversary* models out of its own government. Together they illustrate that model access is now a geopolitical variable in both directions — a team's choice of foundation model can be constrained not only by capability or price but by which government will let it run where. For a reader building agentic systems, the practical lesson is jurisdictional supply risk: a model that is legal, cheap and capable today may be procurement-barred tomorrow if its developer sits in (or is controlled from) a "covered nation," and the sanctioned-list mechanism (publish, review every 180 days, exclude within 90) means the goalposts move on a fixed cadence. It reinforces the book's argument for portability and vendor-neutral architecture — designing so a model can be swapped out — and for treating the provenance and corporate control of a model as a governance attribute, not just its benchmarks. Note the honest caveat when citing: H.R. 4142 is a *bill*, so the book should present it as the direction of US policy and pair it with the bans that are *actually in force* rather than describing it as settled law.
