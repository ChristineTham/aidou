# AI-dō (AI 道)

AI-dō is a practical, opinionated guide to using artificial intelligence effectively.

It combines:

- **AI** (Artificial Intelligence)
- **愛 (ai)** — the Japanese word for *love*
- **道 (dō)** — *the way, path, or disciplined practice*

Together, **AI道** represents:

> **A disciplined way of working with AI, guided by human-centred principles.**

## The Way of AI, grounded in practice

Anyone can open a chat window and get a fluent answer in seconds. Far fewer can turn that fluency into work worth standing behind. We all draw on the same frontier models, so the model was never the edge — **method is**. *AI道* is that method: a structured, human-centred way of working with AI, earned task by task and checked at every step.

- AI is not just a tool
- It is something to be used **thoughtfully, ethically, and deliberately**

**Read it online:** <https://christham.net/aidou/> — or download the [PDF](https://christham.net/aidou/ai-do.pdf) or [ePub](https://christham.net/aidou/ai-do.epub). The website, PDF, and ePub are all built from the Markdown in `book/` by one Quarto pipeline.

---

## 📖 Start here

Begin with the preface, then follow the six-chapter climb — personal productivity, to software, to the disciplines that keep the work sound, to responsibility, to mastery.

- **[Preface — Why This Book Exists](book/00-preface.md)** — how a committed AI sceptic changed his mind, and where he still keeps AI at arm's length.
- **[1 · Foundations](book/01-foundations.md)** — what a language model actually is beneath the fluent surface: why it is brilliant and brittle at once, and how to tell which you're getting.
- **[2 · Personal Productivity](book/02-productivity.md)** — turn a chat assistant into an ambient teammate: from a single prompt, to a self-checking loop, to a memory that compounds.
- **[3 · Software Development](book/03-software.md)** — how a non-programmer shipped three real projects by describing *what* he wanted, and why over-specifying backfires.
- **[4 · Human and Agent Disciplines](book/04-disciplines.md)** — the disciplines of humans and agents working together: what the human brings, how agents are engineered, and how you direct a fleet without losing the thread.
- **[5 · Responsibility & Governance](book/05-governance.md)** — securing agents, owning what they say, and the bills that come due later — care expressed as guardrails.
- **[6 · Mastery & Forward Practice](book/06-mastery.md)** — what stays human when the tools are this good, and the one question worth asking again and again.

> Prefer one file? Download the **[PDF](https://christham.net/aidou/ai-do.pdf)** or **[ePub](https://christham.net/aidou/ai-do.epub)**.

---

## Why read it

Some AI guides and online articles focus on tools, prompts, and techniques. Those go stale in the next release.

*AI道* is a practical, opinionated guide to using artificial intelligence effectively.

- **Method over model** — results come from how you specify intent, gather context, and verify the outcome, not from which model you pick.
- **Discipline over vibe** — principles that transfer across tools and survive model releases, not one-off prompts.
- **Augmentation, not replacement** — AI transforms and amplifies human judgement and creativity rather than replacing them.

Each chapter states the concept, then shows how it works with real examples.

**Who it's for** — thoughtful professionals (leaders, consultants, analysts, designers and builders). You can read a chart, a code snippet, or a research paper, and you have critical thinking skills.

Read it as a **practice guide, not a reference manual or a textbook**: once in order to see how the ideas rest on one another, then back for the parts you need.

---

## ✍️ Status

**Current edition: 1.2** — released 24 July 2026 (see the [Changelog](https://christham.net/aidou/changelog.html) for what changed).

A work in progress. The preface and Chapters 1–3 are complete; Chapters 4–6 are earlier work in progress. The whole book uses numbered sections and APA 7 citations with per-chapter reference lists.

| Section | State |
| --- | --- |
| Preface | Completed |
| Chapters 1–3 | Completed |
| Chapters 4–6 | Work in progress |

<details>
<summary>For contributors — layout, editing, &amp; build</summary>

**Everything you edit lives outside `quarto/`.** `quarto/` is the publishing
pipeline only (Quarto config, Typst/SCSS/CSS templates, fonts). The build
generates the rest into it — all git-ignored.

| Edit this | For |
| --- | --- |
| `book/*.md` | chapter text (`00-preface` … `06-mastery`) |
| `book/blurb.md` | the back-cover / "why read it" blurb (frontmatter `description:` + lead, `- **Label** — text.` bullets, close) |
| `book/epigraph.md` | the landing-page teaser |
| `theme.yml` (repo root) | **all design tokens** — palette, colour roles, type sizes, fonts, per-chapter accents |
| `images/cover.svg` | the cover art |
| `images/chapter-art/` | the chapter banners (generated; see below) |

**Common edits**

- **Change copy** → edit `book/*.md`, `book/blurb.md`, or `book/epigraph.md`.
- **Restyle (colours, fonts, sizes)** → edit `theme.yml`. Change a value there and
  it flows to the website, PDF, and ePub — nowhere else to touch.
- **Change the cover** → edit `images/cover.svg` (the "AI-dō" title is **Raleway
  Black**, the decorative "AI" is **Rubik Glitch Pop**, the 道/愛 are KokuryuSou),
  then re-rasterise:
  ```bash
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless \
    --screenshot=images/cover.png --window-size=1600,2400 \
    --force-device-scale-factor=1 --hide-scrollbars "file://$PWD/images/cover.svg"
  ```
  The social-share image (`images/ogimage.{svg,png,jpg}`, 1200×630, wired into the
  site as `og:image`) is derived from the cover — regenerate it after any cover
  change:
  ```bash
  python3 .agents/skills/book-build/scripts/gen_ogimage.py --render
  ```
- **Regenerate chapter art / cover kanji** → the 道/愛/… kanji use **KokuryuSou**,
  an Adobe Fonts brush face. It's licensed (not in the repo): **activate it in
  Creative Cloud** (Creative Cloud app → Fonts → search *Kokuryu* → Activate; or
  toggle it on at <https://fonts.adobe.com/fonts/kokuryu>). Find its file with
  `system_profiler SPFontsDataType | grep -B2 -i kokuryu`, then (needs
  `fonttools`; run `gen_theme.py` first so accents are current):
  ```bash
  python3 .agents/skills/book-build/scripts/gen_chapter_art.py \
    --font "$KOKURYU_OTF" --out images/chapter-art --png
  ```
  The committed SVG/PNG art is distributable; the font file is not. Body and
  heading text use the open-licensed Noto Serif / Raleway (in `quarto/fonts/`).

**Build & deploy** — one Quarto pipeline → website + PDF + ePub. Locally:
`cd quarto && ./build.sh` (or `./build.sh preview`). It runs, in order,
`gen_theme.py` (tokens from `theme.yml`) → `build_site.py` (chapters from
`book/`, copies art in from `images/`, injects the Rosely Mermaid theme) →
`gen_blurb.py` (blurb, epigraph, and the SEO/Open-Graph `<head>` tags) →
`quarto render`. On push to `main`, `.github/workflows/deploy.yml` does the same
and deploys to GitHub Pages. Full detail is in the `book-build` skill.

**Authoring conventions** (also in `AGENTS.md`):

- **Prose style** — modelled on Kernighan & Pike's *The Unix Programming Environment*: plain short sentences, mechanism over metaphor, understatement, worked examples (a copy is at `sources/software-engineering/unix-programming-environment.md`).
- **Numbered headings** — H2 sections `N.M`, H3 subsections `N.M.K`; chapter titles and References stay unnumbered.
- **Citations (APA 7)** — hyperlinked to the original source (URL, DOI, arXiv); first mention in a chapter names author and *title*, later mentions are plain `(Author, Year)`. Source metadata lives in `summaries/`, downloaded sources in `sources/`, and the citation↔source map in `references.json` (repo root); the reference lists regenerate via the `apa-citations` skill.
- **Skills** — one canonical set under **`.agents/skills/`** (the vendor-neutral [Agent Skills](https://agentskills.io) `SKILL.md` standard). GitHub Copilot and Google Antigravity read `.agents/skills/` directly; Claude Code only scans `.claude/skills/`, so that path is a **symlink** to `../.agents/skills`. Edit skills in `.agents/skills/` only — there is no second copy to keep in sync. Subagent definitions stay tool-specific (`.claude/agents/*.md`, `.github/agents/*.agent.md`), as their formats differ per tool — four exist: `critical-thinking`, `mermaid-editor`, **`book-style-checker`** (the fresh-eyes pass of the [[book-style]] loop, which also checks prose against the cited source), and **`quote-verifier`** (tries to *disconfirm* a quotation before it enters the book, and reports honestly when no primary exists).
- **Hooks** — `.claude/settings.json` wires two guards, with the scripts in `.claude/hooks/`. `guard_generated.py` refuses edits to the generated files under `quarto/` (everything except the hand-authored few, which the build would silently overwrite); `check_references_json.py` verifies after every edit that `references.json` still parses, has no duplicate URLs, and changed by an append rather than a whole-file reflow.

**Skill catalogue** — reusable capabilities that help write, research, and build the book. Invoke one by **describing the task** (it triggers from its description in Claude Code, Copilot, or Antigravity) or, in Claude Code / Copilot, with **`/<name>`**. Two skills (`book-build`, `draw-io-diagram-generator`) are agent-triggered only — they fire when relevant rather than as slash-commands.

| Skill | What it does |
| --- | --- |
| `research-topic` | Orchestrator: topic → find → download → summarise → cite into the book |
| `search-topic` | Deep-research a topic; return a ranked shortlist of sources |
| `download-source` | Fetch a source into `sources/` (arXiv → PDF, web page → Markdown) |
| `summarise-source` | Write a study-guide summary (Abstract + body) into `summaries/` |
| `enhance-book` | Cite a summarised source into the book, in the house style |
| `book-style` | Rewrite prose into the house style, self-checking until it stops sounding like AI |
| `apa-citations` | Apply/audit APA-7 citations; regenerate per-chapter reference lists |
| `heading-numbering` | Number section headings `N.M` / `N.M.K` (idempotent) |
| `book-build` | Build the website + PDF + ePub from `book/` via Quarto |
| `python-scripts` | Write and run Python for analysis, scraping, or automation |
| `mermaid-diagrams` | General Mermaid diagrams (flowchart, sequence, class, ER, …) |
| `c4-architecture` | C4 architecture views in Mermaid |
| `draw-io` | Create/edit `.drawio` diagrams; export PNG/SVG |
| `draw-io-diagram-generator` | Low-level mxGraph XML authoring for draw.io |
| `mermaid-to-drawio` | Convert Mermaid source into editable draw.io XML |

</details>
