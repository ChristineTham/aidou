# AI-dō (AI 道)

**The Way of AI, grounded in practice (道).**

Anyone can open a chat window and get a fluent answer in seconds. Far fewer can turn that fluency into work worth standing behind. We all draw on the same frontier models, so the model was never the edge — **method is**. *AI-dō* is that method: a structured, human-centred way of working with AI, earned task by task and checked at every step.

It's a short book, written first-person by a former sceptic, and grounded in primary sources throughout. If you have ten minutes, start reading.

**Read it online:** <https://christinetham.github.io/aidou/> — or download the [PDF](https://christinetham.github.io/aidou/ai-do.pdf) or [ePub](https://christinetham.github.io/aidou/ai-do.epub). The website, PDF, and ePub are all built from the Markdown in `book/` by one Quarto pipeline.

---

## 📖 Start here

Begin with the preface, then follow the six-chapter climb — personal productivity, to software, to the disciplines that keep the work sound, to responsibility, to mastery.

- **[Preface — Why This Book Exists](book/00-preface.md)** — how a committed AI sceptic changed his mind, and where he still keeps AI at arm's length.
- **[1 · Foundations](book/01-foundations.md)** — what a language model actually is beneath the fluent surface: why it is brilliant and brittle at once, and how to tell which you're getting.
- **[2 · Personal Productivity](book/02-productivity.md)** — turn a chat assistant into an ambient teammate: from a single prompt, to a self-checking loop, to a memory that compounds.
- **[3 · Software Development](book/03-software-development.md)** — how a non-programmer shipped three real projects by describing *what* he wanted, and why over-specifying backfires.
- **[4 · Engineering Disciplines](book/04-engineering-disciplines.md)** — the craft above prompting: context, harnesses, loops, and the systems that run agents at scale.
- **[5 · Responsibility & Governance](book/05-governance.md)** — securing agents, owning what they say, and the bills that come due later — care expressed as guardrails.
- **[6 · Mastery & Forward Practice](book/06-mastery.md)** — what stays human when the tools are this good, and the one question worth asking again and again.

> Prefer one file? Download the **[PDF](https://christinetham.github.io/aidou/ai-do.pdf)** or **[ePub](https://christinetham.github.io/aidou/ai-do.epub)**.

---

## Why read it

Most AI writing sells tools, prompts, and features. Those go stale in a release. *AI-dō* is about what lasts underneath — how you frame a problem, gather context, and verify a result:

- **Method over model** — the advantage is the scaffolding you build, not the model you pick.
- **Discipline over hacks** — repeatable patterns, not one-off prompts.
- **Augmentation, not replacement** — AI to extend human judgement, never to outsource it.

Every claim is cited inline to a primary source, and each chapter reads like a good textbook: state the idea, show why it holds, then prove it with a real example.

**The name** says it in miniature. **愛 (ai)** — *love*: care for the people the work touches. **道 (dō)** — *the way*: a craft refined over time, the suffix in jūdō and kendō. **AI-dō** joins the two: human care and a practised craft.

**Who it's for** — thoughtful professionals (leaders, consultants, analysts, builders) and engineers who want a durable practice, not a bag of prompts. You can read a chart, a code snippet, or a paper when it helps; you don't live in a terminal.

Read it as a **practice guide, not a reference manual**: once in order to see how the ideas rest on one another, then back for the parts you need.

---

## ✍️ Status

A work in progress. The preface and Chapter 1 have had a full research-and-style pass; the later chapters are drafted and being revised. The whole book uses numbered sections and APA 7 citations with per-chapter reference lists.

| Phase | Chapters | State |
| --- | --- | --- |
| 1 | Preface, 1–2 | Preface + Ch 1 revised; Ch 2 in progress |
| 2 | 3–4 | Drafted |
| 3 | 5–6 | Drafted |

<details>
<summary>For contributors — conventions &amp; tooling</summary>

Authoring conventions live in `AGENTS.md`; the highlights:

- **Prose style** — modelled on Kernighan & Pike's *The Unix Programming Environment*: plain short sentences, mechanism over metaphor, understatement, worked examples (a copy is at `research/the-unix-programming-environment-kernighan-pike.md`).
- **Numbered headings** — H2 sections `N.M`, H3 subsections `N.M.K`; chapter titles and References stay unnumbered.
- **Citations (APA 7)** — hyperlinked to the original source (URL, DOI, arXiv); first mention in a chapter names author and *title*, later mentions are plain `(Author, Year)`. Source metadata lives in `research/papers/`.
- **Skills & agents** — kept in both Copilot (`.github/`) and Claude (`.claude/`) formats and maintained in sync.
- **Build & publish** — one Quarto pipeline turns `book/*.md` into the website + PDF + ePub. Locally: `cd quarto && ./build.sh` (or `./build.sh preview`); it regenerates the chapters via `.claude/skills/book-build/scripts/build_site.py`, then `quarto render`. On push to `main`, `.github/workflows/deploy.yml` builds and deploys to GitHub Pages. See the `book-build` skill for details.

</details>
