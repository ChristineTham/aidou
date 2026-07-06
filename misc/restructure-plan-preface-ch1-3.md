# Implementation Plan — Rebalance Preface + Chapters 1–3

Goal: the preface and Chapter 1 are too heavy; a reader may lose interest before
reaching the meat (Chapters 2–3). Redistribute and rebalance the existing content
into a new structure. **Discard nothing** — every paragraph, table, note, and
diagram lands somewhere.

## Decisions locked (from review)

- **Cost-of-getting-it-wrong** (AI psychosis, companion apps, bosses over-relying) →
  **Chapter 1 §1.5** (the sceptic→practitioner arc). Only a brief slop/hallucination
  line stays in the preface.
- **"Why now" / "Won't this be out of date?"** → **kept in the preface** (condensed
  in a later phase, not now).
- **Ch2's Confidence Trap, Knowledge Work, Personal Operating Models** → **stay in Ch2**.
- **Mental Models** → **its own section, second-last in Ch1 (1.6)**, before Principles.
- **Cooking anecdote** → merged into **§1.5 From Sceptic to Practitioner** (not the
  chapter opener).
- Open items accepted: **nondeterminism** paragraph → §1.4 Limits; **Play-Doh** pun →
  §1.7 Principles.
- **Preface: move content only now; do NOT condense yet.** Condensation is a separate
  later phase, run after the move is reviewed.

## Phases

1. **Scaffold** — lay the new heading skeletons in all four files.
2. **Move** — relocate existing prose blocks into the scaffold, faithfully (verbatim
   where possible). Citations/notes/numbers may be temporarily broken. The preface is
   **moved but NOT condensed**. Placement ambiguities were resolved pre-move (see
   Decisions); any residual is flagged inline while moving.
3. **Move-fidelity review (GATE)** — compare the originals to the moved versions and
   prove nothing substantial was left behind. **No rewriting happens until this passes.**
   Method:
   - Snapshot the originals as a baseline from git (the pre-move commit).
   - Automated coverage checks across the four new files vs the baseline:
     - **Citations** — every citation URL in the originals still appears somewhere in
       the new set (none dropped).
     - **Diagrams** — every ```mermaid block is present.
     - **Tables** — every table (by header row) is present.
     - **Callouts** — every `> [!NOTE]` / `> [!TIP]` / `> [!IMPORTANT]` is present.
     - **Prose** — sentence-level coverage: flag any original sentence/paragraph with no
       match in the new set (the "possibly dropped" list).
     - **Word-count sanity** — total words across the four files ≈ the original total
       (small deltas only, from intentional dedup at seams).
   - Produce a short reconciliation report: for every item flagged as missing, either
     locate it in the new files or record a deliberate reason (e.g., duplicate merged).
   - **Exit criterion:** zero substantial content unaccounted for.
4. **Flow-rewrite / refactor / reflow (chapters)** — only after Phase 3 passes: smooth
   seams, write the genuinely new connective material and the new §1.1 history, apply
   house style. **Preface condensation is NOT part of this phase.**
5. **Mechanics** — renumber headings; fix first-use definitions; rebuild citations +
   References; audit; prose-lint; build all three formats; commit, push, deploy.
6. **(Deferred, user-triggered) Preface condensation** — shorten the preface once the
   move is reviewed.

---

## Target structure

### Preface (move only; still full-length until Phase 6)
1. Opening + **The name** (愛/道) + TIP box
2. **Why I wrote it** (background: AI strategy just delivered + Torrens teaching)
3. **Who it is for**
4. **The approach, and how to read it** (structure + climb diagram + chapter table)
5. **Why now**
6. **Won't this be out of date?**

### Chapter 1 — Foundations (The Way) — 7 sections
- 1.1 **What AI Is, and How It Got Here** (definition + 1950s → neural nets → ML → LLM)
- 1.2 **How a Language Model Works** (next-token predictor; world model; chain of thought)
- 1.3 **From Chatbot to Agent** (tool evolution + timeline + coding agents + dev stack +
  personal agents + 2026 landscape)
- 1.4 **The Limits That Remain** (all the research papers; nondeterminism lives here)
- 1.5 **From Sceptic to Practitioner** (cooking anecdote + sceptic story +
  cost-of-getting-it-wrong)
- 1.6 **Mental Models for AI** (loop-not-oracle; the loop diagram) — second last
- 1.7 **Principles to Carry Forward** (key takeaways; Play-Doh; **no Unix philosophy yet**) — last

### Chapter 2 — Personal Productivity (愛 in practice) — reordered
- 2.1 **From a Prompt to a Teammate** (summarisation tutorial: simple prompt → elaborate
  → loop → skill → MCP; do **not** name "prompt engineering" yet)
- 2.2 **The Unix Philosophy, Re-run** (moved from Ch1 §1.2)
- 2.3 **Prompt Engineering** (the theory, named now)
- 2.4 **Everything Becomes Markdown**
- 2.5 **Context & Memory** (LLM wiki + memory patterns)
- 2.6 **Loops and Ambient Teammates** (loopcraft / async delegation)
- 2.7 **Composability: Skills, Loops, and MCP** (the "programs work together" thread, deepened)
- 2.8 **Knowledge Work, Not Just Code** (kept)
- 2.9 **The Confidence Trap** (kept)
- 2.10 **Personal Operating Models** (kept)

### Chapter 3 — Software Development (the craft) — light touch
- Reframe intro: (a) extends Ch2's skill-orchestration into deterministic software
  products; (b) "not for the engineer, for the professional who reads some code";
  (c) lead with the over-specify → iterative-intent / "happy path" anecdote (already in
  the current intro, just surfaced).
- §3.1–3.9 unchanged in content.

---

## Block-level move mapping (source → destination)

### → Preface (remove moved blocks; keep the rest full-length)
| Preface section | Source blocks |
| --- | --- |
| The name (愛/道) + TIP | current "The problem this book solves" (name paras) + TIP box |
| Why I wrote it | current "A word about me" |
| Who it is for | current "Who it is for" |
| The approach + how to read it | current "How to read it" + climb mermaid + chapter table |
| Why now | current "Why now" |
| Won't this be out of date? | current "Won't this be out of date?" |

**Moves OUT of preface:** sceptic story (Zitron/Marcus/Doctorow) → Ch1 §1.5; "where I
landed / deliberate boundary" → Ch1 §1.5; full "cost of getting it wrong" → Ch1 §1.5;
AI/frontier/foundation defs + NOTE box → Ch1 §1.1; "From chatbot to agent" + timeline →
Ch1 §1.3. A brief slop/hallucination line stays in the preface "why this book" prose.

### → Chapter 1
| Ch1 section | Source blocks |
| --- | --- |
| 1.1 What AI is + history | preface "A short bearing…" defs + NOTE box (LLM/foundation/frontier/loopcraft) + **NEW** 1950s→NN→ML→LLM history |
| 1.2 How an LLM works | current §1.4 first half: next-token prediction, token NOTE, Wolfram, Othello world model, chain of thought, emergent abilities, reasoning-by-chaining + its mermaid |
| 1.3 From chatbot to agent | preface "From chatbot to agent" + timeline mermaid + current §1.6 (Tabnine→Copilot→Cursor→Claude Code→multi-agent, dev-stack table, OpenClaw/Hermes/Gemini/Cowork) + current §1.5 "2026 Landscape" (signals table) + **agent-definition NOTE** (first use lands here) |
| 1.4 The limits that remain | current §1.4 second half: nondeterminism, hallucination, jagged competence, Olympiad/clock, knowledge-boundary survey, Prato, Gu, Bogomolov, lost-in-middle, study table, sound-right/RLHF/emotion vectors, transformer/RLHF NOTE, reliable/brittle table + its mermaids |
| 1.5 From sceptic to practitioner | **cooking anecdote** + preface sceptic story + "where I landed" + full "cost of getting it wrong" (psychosis, companion apps, bosses) |
| 1.6 Mental models | current §1.3 (oracle→loop framing, loop mermaid, "goal/context/check", fluency-as-truth) — agent-definition NOTE relocated to 1.3 |
| 1.7 Principles | current §1.7 Key Takeaways (**Unix bullet reworded to not name Unix**) + Play-Doh / "philosophy outlives tools" from current §1.1 |

**Moves OUT of Ch1 → Ch2:** §1.2 "The Unix Philosophy, Re-run" (whole section + table).

### → Chapter 2 (reordered)
| Ch2 section | Source blocks |
| --- | --- |
| 2.1 From a prompt to a teammate | summarisation anecdote (intro) + elaborated prompt example from §2.1 (unnamed) + §2.2 skill→loop→MCP + mermaids |
| 2.2 The Unix philosophy, re-run | **moved from Ch1 §1.2** (+ table) |
| 2.3 Prompt engineering | current §2.1 (four elements, techniques ladder, zero/few/CoT tables) |
| 2.4 Everything becomes Markdown | current §2.7 |
| 2.5 Context & memory | current §2.8 (wiki) + §2.9 (memory patterns) |
| 2.6 Loops & ambient teammates | current §2.3 |
| 2.7 Composability (skills/loops/MCP) | composition thread from §2.2 tail, deepened |
| 2.8 Knowledge work, not just code | current §2.4 |
| 2.9 The confidence trap | current §2.5 |
| 2.10 Personal operating models | current §2.6 |

### → Chapter 3 (light)
- Rework intro paragraphs: frame as extending Ch2 (orchestrating skills into deterministic
  software products); restate audience; lead with the over-specify → intent / happy-path
  anecdote (currently intro paras 4–5), in the author's "path of least resistance" framing.
- §3.1–3.9 content unchanged.

---

## Phase 5 mechanics detail
1. `number_headings.py book/00-preface.md book/0[1-3]*.md` — note the preface stays
   unnumbered; number Ch1–3.
2. First-use definitions after the move: *agent* (now first in Ch1 §1.3), *token* (§1.2),
   *frontier/foundation model* (§1.1), *skill* / *MCP* / *harness* (Ch2), *ICE* (Ch3).
   Relocate/duplicate NOTE boxes to first use per chapter.
3. `apply_citations.py --refs research/references.json …` — first mention resets per
   chapter, so moved citations re-title correctly.
4. `audit_citations.py …` — clear orphans.
5. `prose_lint.py …` — advisory on new/seamed prose.
6. **New references** for §1.1 history (verify before use): Vaswani et al. 2017
   (*Attention Is All You Need*, arXiv:1706.03762); Wikipedia *History of artificial
   intelligence*, *Deep learning*, *Perceptron*.
7. Build all three formats; verify diagrams + cover; commit, push, watch deploy.

## Expected net effect
- Preface: content moved out (defs, chatbot→agent, sceptic, cost-of-wrong); still
  full-length until Phase 6 condensation.
- Chapter 1: clean arc — define → how → evolve → limits → my-turn → mental models →
  principles; Unix removed.
- Chapter 2: opens with a concrete build-it-up tutorial before theory; Unix introduced here.
- Chapter 3: same content, gentler on-ramp.
