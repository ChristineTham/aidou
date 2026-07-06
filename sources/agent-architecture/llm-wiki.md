Instantly share code, notes, and snippets.
Created April 4, 2026 16:25
Show Gist options
  # Select an option
  ## No results found
  Clone this repository at \&lt;script src=\&quot;https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f.js\&quot;\&gt;\&lt;/script\&gt;
  Save karpathy/442a6bf555914893e9891c11519de94f to your computer and use it in GitHub Desktop.
# Select an option
## No results found
Clone this repository at \&lt;script src=\&quot;https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f.js\&quot;\&gt;\&lt;/script\&gt;
Save karpathy/442a6bf555914893e9891c11519de94f to your computer and use it in GitHub Desktop.
llm-wiki
# LLM Wiki
A pattern for building personal knowledge bases using LLMs.
This is an idea file, it is designed to be copy pasted to your own LLM Agent (e.g. OpenAI Codex, Claude Code, OpenCode / Pi, or etc.). Its goal is to communicate the high level idea, but your agent will build out the specifics in collaboration with you.
## The core idea
Most people's experience with LLMs and documents looks like RAG: you upload a collection of files, the LLM retrieves relevant chunks at query time, and generates an answer. This works, but the LLM is rediscovering knowledge from scratch on every question. There's no accumulation. Ask a subtle question that requires synthesizing five documents, and the LLM has to find and piece together the relevant fragments every time. Nothing is built up. NotebookLM, ChatGPT file uploads, and most RAG systems work this way.
The idea here is different. Instead of just retrieving from raw documents at query time, the LLM **incrementally builds and maintains a persistent wiki** — a structured, interlinked collection of markdown files that sits between you and the raw sources. When you add a new source, the LLM doesn't just index it for later retrieval. It reads it, extracts the key information, and integrates it into the existing wiki — updating entity pages, revising topic summaries, noting where new data contradicts old claims, strengthening or challenging the evolving synthesis. The knowledge is compiled once and then *kept current*, not re-derived on every query.
This is the key difference: **the wiki is a persistent, compounding artifact.** The cross-references are already there. The contradictions have already been flagged. The synthesis already reflects everything you've read. The wiki keeps getting richer with every source you add and every question you ask.
You never (or rarely) write the wiki yourself — the LLM writes and maintains all of it. You're in charge of sourcing, exploration, and asking the right questions. The LLM does all the grunt work — the summarizing, cross-referencing, filing, and bookkeeping that makes a knowledge base actually useful over time. In practice, I have the LLM agent open on one side and Obsidian open on the other. The LLM makes edits based on our conversation, and I browse the results in real time — following links, checking the graph view, reading the updated pages. Obsidian is the IDE; the LLM is the programmer; the wiki is the codebase.
This can apply to a lot of different contexts. A few examples:
- **Personal**: tracking your own goals, health, psychology, self-improvement — filing journal entries, articles, podcast notes, and building up a structured picture of yourself over time.
- **Research**: going deep on a topic over weeks or months — reading papers, articles, reports, and incrementally building a comprehensive wiki with an evolving thesis.
- **Business/team**: an internal wiki maintained by LLMs, fed by Slack threads, meeting transcripts, project documents, customer calls. Possibly with humans in the loop reviewing updates. The wiki stays current because the LLM does the maintenance that no one on the team wants to do.
- **Competitive analysis, due diligence, trip planning, course notes, hobby deep-dives** — anything where you're accumulating knowledge over time and want it organized rather than scattered.
## Architecture
There are three layers:
**Raw sources** — your curated collection of source documents. Articles, papers, images, data files. These are immutable — the LLM reads from them but never modifies them. This is your source of truth.
**The wiki** — a directory of LLM-generated markdown files. Summaries, entity pages, concept pages, comparisons, an overview, a synthesis. The LLM owns this layer entirely. It creates pages, updates them when new sources arrive, maintains cross-references, and keeps everything consistent. You read it; the LLM writes it.
**The schema** — a document (e.g. CLAUDE.md for Claude Code or AGENTS.md for Codex) that tells the LLM how the wiki is structured, what the conventions are, and what workflows to follow when ingesting sources, answering questions, or maintaining the wiki. This is the key configuration file — it's what makes the LLM a disciplined wiki maintainer rather than a generic chatbot. You and the LLM co-evolve this over time as you figure out what works for your domain.
## Operations
**Ingest.** You drop a new source into the raw collection and tell the LLM to process it. An example flow: the LLM reads the source, discusses key takeaways with you, writes a summary page in the wiki, updates the index, updates relevant entity and concept pages across the wiki, and appends an entry to the log. A single source might touch 10-15 wiki pages. Personally I prefer to ingest sources one at a time and stay involved — I read the summaries, check the updates, and guide the LLM on what to emphasize. But you could also batch-ingest many sources at once with less supervision. It's up to you to develop the workflow that fits your style and document it in the schema for future sessions.
**Query.** You ask questions against the wiki. The LLM searches for relevant pages, reads them, and synthesizes an answer with citations. Answers can take different forms depending on the question — a markdown page, a comparison table, a slide deck (Marp), a chart (matplotlib), a canvas. The important insight: **good answers can be filed back into the wiki as new pages.** A comparison you asked for, an analysis, a connection you discovered — these are valuable and shouldn't disappear into chat history. This way your explorations compound in the knowledge base just like ingested sources do.
**Lint.** Periodically, ask the LLM to health-check the wiki. Look for: contradictions between pages, stale claims that newer sources have superseded, orphan pages with no inbound links, important concepts mentioned but lacking their own page, missing cross-references, data gaps that could be filled with a web search. The LLM is good at suggesting new questions to investigate and new sources to look for. This keeps the wiki healthy as it grows.
## Indexing and logging
Two special files help the LLM (and you) navigate the wiki as it grows. They serve different purposes:
**index.md** is content-oriented. It's a catalog of everything in the wiki — each page listed with a link, a one-line summary, and optionally metadata like date or source count. Organized by category (entities, concepts, sources, etc.). The LLM updates it on every ingest. When answering a query, the LLM reads the index first to find relevant pages, then drills into them. This works surprisingly well at moderate scale (~100 sources, ~hundreds of pages) and avoids the need for embedding-based RAG infrastructure.
**log.md** is chronological. It's an append-only record of what happened and when — ingests, queries, lint passes. A useful tip: if each entry starts with a consistent prefix (e.g. `## [2026-04-02] ingest | Article Title`), the log becomes parseable with simple unix tools — `grep "^## \[" log.md | tail -5` gives you the last 5 entries. The log gives you a timeline of the wiki's evolution and helps the LLM understand what's been done recently.
## Optional: CLI tools
At some point you may want to build small tools that help the LLM operate on the wiki more efficiently. A search engine over the wiki pages is the most obvious one — at small scale the index file is enough, but as the wiki grows you want proper search. [qmd](https://github.com/tobi/qmd) is a good option: it's a local search engine for markdown files with hybrid BM25/vector search and LLM re-ranking, all on-device. It has both a CLI (so the LLM can shell out to it) and an MCP server (so the LLM can use it as a native tool). You could also build something simpler yourself — the LLM can help you vibe-code a naive search script as the need arises.
## Tips and tricks
- **Obsidian Web Clipper** is a browser extension that converts web articles to markdown. Very useful for quickly getting sources into your raw collection.
- **Download images locally.** In Obsidian Settings → Files and links, set "Attachment folder path" to a fixed directory (e.g. `raw/assets/`). Then in Settings → Hotkeys, search for "Download" to find "Download attachments for current file" and bind it to a hotkey (e.g. Ctrl+Shift+D). After clipping an article, hit the hotkey and all images get downloaded to local disk. This is optional but useful — it lets the LLM view and reference images directly instead of relying on URLs that may break. Note that LLMs can't natively read markdown with inline images in one pass — the workaround is to have the LLM read the text first, then view some or all of the referenced images separately to gain additional context. It's a bit clunky but works well enough.
- **Obsidian's graph view** is the best way to see the shape of your wiki — what's connected to what, which pages are hubs, which are orphans.
- **Marp** is a markdown-based slide deck format. Obsidian has a plugin for it. Useful for generating presentations directly from wiki content.
- **Dataview** is an Obsidian plugin that runs queries over page frontmatter. If your LLM adds YAML frontmatter to wiki pages (tags, dates, source counts), Dataview can generate dynamic tables and lists.
- The wiki is just a git repo of markdown files. You get version history, branching, and collaboration for free.
## Why this works
The tedious part of maintaining a knowledge base is not the reading or the thinking — it's the bookkeeping. Updating cross-references, keeping summaries current, noting when new data contradicts old claims, maintaining consistency across dozens of pages. Humans abandon wikis because the maintenance burden grows faster than the value. LLMs don't get bored, don't forget to update a cross-reference, and can touch 15 files in one pass. The wiki stays maintained because the cost of maintenance is near zero.
The human's job is to curate sources, direct the analysis, ask good questions, and think about what it all means. The LLM's job is everything else.
The idea is related in spirit to Vannevar Bush's Memex (1945) — a personal, curated knowledge store with associative trails between documents. Bush's vision was closer to this than to what the web became: private, actively curated, with the connections between documents as valuable as the documents themselves. The part he couldn't solve was who does the maintenance. The LLM handles that.
## Note
This document is intentionally abstract. It describes the idea, not a specific implementation. The exact directory structure, the schema conventions, the page formats, the tooling — all of that will depend on your domain, your preferences, and your LLM of choice. Everything mentioned above is optional and modular — pick what's useful, ignore what isn't. For example: your sources might be text-only, so you don't need image handling at all. Your wiki might be small enough that the index file is all you need, no search engine required. You might not care about slide decks and just want markdown pages. You might want a completely different set of output formats. The right way to use this is to share it with your LLM agent and work together to instantiate a version that fits your needs. The document's only job is to communicate the pattern. Your LLM can figure out the rest.
<span id="comments"></span>
Load earlier comments...
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
One pattern I've noticed across many of the projects in this thread is that they focus heavily on *what* the agent remembers.
Smriti-MCP started from a slightly different question:
**How does the agent remember consistently across sessions, tools, models, and runtimes?**
Instead of treating memory as a feature inside a specific agent framework, Smriti exposes memory as an MCP-native service that any compatible agent can use.
A few design principles that shaped it:
- Memory is externalised from the agent lifecycle.
- Context should survive model changes.
- Knowledge should be reusable across multiple agents.
- Memory must be queryable, governed, and inspectable.
- The memory layer should remain useful even when the orchestration layer changes.
What interests me most is that we're gradually moving from "prompt engineering" toward **memory architecture**.
The next generation of agent systems will not be differentiated by model choice alone.
They will be differentiated by:
- what they know,
- how they remember,
- how they evolve knowledge over time,
- and how reliably they can retrieve the right context at the right moment.
Smriti-MCP is my attempt to explore that direction as a portable memory layer for agent ecosystems.
Project:
[Smriti MCP](https://github.com/deepak-bhardwaj-ps/smriti-mcp)
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
Hello Andrei and the community.\
I’m building a Markdown/Obsidian-style knowledge wiki for teaching a health informatics course, using Codex to help ingest sources, maintain links, and later query the wiki for presentations and curriculum design.
I ran into a token-efficiency problem that may be interesting: the token burn was not mainly from reasoning or output, but from repeated context loading. Codex kept re-reading files like AGENTS.md, wiki/index.md, manifests, handoffs, raw sources, and tool scripts across short sessions. Even small source-ingest tasks became expensive.
I’ve started moving toward a split workflow: deterministic Python scripts handle source intake, route indexes, validation, and compact handoffs; Codex is reserved for higher-value graph curation, synthesis, and judgment. I’m also using compact routing files instead of asking the model to scan the whole wiki.
I would be grateful for any advice on the right architecture for this kind of “wiki as working memory” setup. Specifically, how would you structure retrieval, summaries, graph edges, and agent instructions so Codex can reason over a rich knowledge base without repeatedly consuming the entire context?
Even a few pointers or design principles would be very helpful.
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
One thing I think the LLM-wiki pattern needs as it grows past toy scale is a\
hard boundary between:
1.  canonical human-readable Markdown
2.  derived recall/projection state
3.  agent write authority
The failure mode I kept running into was not "can the agent write a wiki page?"\
It was:
- stale synthesis pages that still looked authoritative
- duplicate pages for the same concept
- retrieval results with no stable citation contract
- agents silently turning generated summaries into truth
I have been building OpenClerk around that boundary:
- Markdown remains canonical
- SQLite/FTS/graph state is derived and auditable
- every retrieval result carries `doc_id`, `chunk_id`, and citation path
- duplicate/stale/freshness checks are explicit reports
- writes go through planned/approved runner actions
- semantic search/OCR are optional modules, not hidden defaults
Repo: <https://github.com/yazanabuashour/openclerk>
I would especially love criticism on the runner boundary: should freshness and\
duplicate signals be advisory reports, hard write gates, or retrieval-time\
ranking inputs?
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
> Hello Andrei and the community. I’m building a Markdown/Obsidian-style knowledge wiki for teaching a health informatics course, using Codex to help ingest sources, maintain links, and later query the wiki for presentations and curriculum design.
>
> I ran into a token-efficiency problem that may be interesting: the token burn was not mainly from reasoning or output, but from repeated context loading. Codex kept re-reading files like AGENTS.md, wiki/index.md, manifests, handoffs, raw sources, and tool scripts across short sessions. Even small source-ingest tasks became expensive.
>
> I’ve started moving toward a split workflow: deterministic Python scripts handle source intake, route indexes, validation, and compact handoffs; Codex is reserved for higher-value graph curation, synthesis, and judgment. I’m also using compact routing files instead of asking the model to scan the whole wiki.
>
> I would be grateful for any advice on the right architecture for this kind of “wiki as working memory” setup. Specifically, how would you structure retrieval, summaries, graph edges, and agent instructions so Codex can reason over a rich knowledge base without repeatedly consuming the entire context?
>
> Even a few pointers or design principles would be very helpful.
You can try Smriti MCP I dhared above on the thread. Out of the box agents struggle to use wiki efficiently. I have built it for that purpose and you can configure same MCP with multiple agents to collaborate and share wiki.
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
Implemented this end-to-end as **Eidetic** (memory for Claude Code): <https://github.com/LARIkoz/eidetic> — compounding pages (a good answer files back; a re-touch appends to a History/Update section instead of duplicating), an explicit schema as the maintenance contract, typed pages, and an op-log.
Two additions from running it on an ~1.8k-file / 16k-chunk store: (1) **auto-extraction** at session end so the wiki grows without manual ingest, and (2) **drift detection** — your "note where new data contradicts old", automated as stale-age / broken-link / confidence-escalation penalties; past ~day 60 the real failure mode is confident-but-stale memory making the agent *worse*, not better. The "LLMs don't get bored" framing nails the thesis — thanks for writing it up.
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
Thank you Andrej for this write-up. I ended up exploring one specific piece of the pattern: how to make an LLM Wiki portable and agent-maintainable without turning it into a new app.
I built OKF Harness around that idea: <https://github.com/pumblus/okf-harness>
It uses local folders, immutable raw sources, OKF-compatible markdown, an `okfh --json` CLI for Claude Code or Codex, bounded reads, validation, citations, and a local graph report. The goal is to keep the wiki as ordinary files while giving agents a stable contract for maintaining it.
Would be interested to hear how others are handling portability, provenance, and validation across agent clients.
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
Thank you Andrej for the write-up and making this pattern so popular!\
Also everybody else in this comment section is coming up with fantastic idea.\
That is truly inspiring in the truest sense of the word.
------------------------------------------------------------------------
So, I've been collecting well-formated data in an Obsidian Vault for roughly 3 years (a tabletop RPG campaign), and I asked myself: How can you automate the re-occuring tasks that come with TTRPG campaign management?
How to effectively cross-reference several wikilinked markdown files and several (image-only) PDF documents to generate the next session without contradicting the established campaign canon?
Here's my solution to that.\
I just shipped your new favorite TTRPG Worldbuilding companion [Loremaester](https://github.com/mm-weber/loremaester):
## TL;DR
[Loremaester](https://github.com/mm-weber/loremaester) is a close cousin to Andrej's pattern that solves the problem of making the content of (image-only) PDF documents available to Claude-Code as a second source to reason over, at scale. Ingest your PDFs into your locally hosted pgvector + PostgreSQL DB.
Cross-reference hundreds of linked markdown files ("the canon") with dozens of PDF documents ("the corpus") to generate the next session without contradicting the established campaign lore.
It is fllipping the usual RAG architecture:\
Instead of retrieval at the center with reasoning attached to it, Claude Code sits at the center as planner, reasoner, and writer.
# Loremaester
*A worldbuilding assistant for Claude Code*
This project turns:
- scanned PDFs,
- Obsidian vaults,
- wikilink graphs,
- hybrid retrieval,
- and agent workflows
into a persistent, self-compounding knowledge system.
Key ideas:
- Claude Code sits above the retrieval layer as planner, reasoner, and writer.
- Navigating Obsidian's structured wikilink graph surface the most important contextual connections between notes.
- Human-reviewed synthesis compounds the knowledge base over time.
Under the hood:
- Claude-Code as the agentic orchestrator
  - 3 MCP servers, 14 skills
  - hosted inside a hardened devcontainer with restricted egress
- R2R (pgvector + PostgreSQL) for hybrid semantic + keyword retrieval
- Ollama + mxbai-embed-large for embedding
- OCR pipeline (CUDA, CPU) for image-only PDF
- Obsidian for viewing and manual editing
## Architecture:
### Request flow
Would especially love feedback from people working on:
- agents
- memory systems
- retrieval infra
- knowledge graphs
- other shapes of the LLM-wiki pattern
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
Strongest framing of this in the thread, I think. The policy/representation split is the right cut, and I agree the policy is the load-bearing half. Let me push on the other half then, the representation.\
The thing I keep coming back to: is a contradiction an edge or a node? Typed edges (A contradicts B) make it a property of a relation between two pages, which is fine as far as it goes. But I'd make the tension itself a first-class object: its own page, with frontmatter for status, the poles it's holding, resolution attempts, provenance. Edges work while a contradiction is binary and stable. The moment it isn't, they run thin. Think of a tension among three or more claims, or one that's already real before either side is a proper page yet, or the cases where the content of the contradiction (why it won't resolve) is the whole point. There's nowhere on an edge to hang that. A node gives you somewhere.\
It's also, I think, where the node form quietly handles the vocabulary-governance worry you raised at the end. You're not policing extends vs supersedes vs was a response to on every ingest, because the edges stay dumb (claims just participate in a tension) and the semantics all live on the node: its status (open / held / resolved-with-proof / dissolved) and the provenance of whatever closed it. The ontology work stays in one place instead of leaking into every link.\
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
I really love the Linting. I start using it more and more as an agent.
it built it out pretty nicely, I really love the index and the linter agent!
### Uh oh!
### 
### Uh oh!
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
谢谢你分享的智慧，我在AI的帮助下构建了一个简单的LLM-Wiki项目。
欢迎伙伴们点评。
<https://github.com/arrrr110/Nemsy>\
奈姆希（Nemsy）：一个自我构建的私人知识助理
> 名字取自炉石传说中的 Nemsy Necrofizzle —— 聪明、好奇、充满能量。
本项目基于 Karpathy 的 LLM Wiki 理念，由 DeepSeek 超长上下文模型驱动，以 Obsidian Vault 为知识源，为唯一用户提供持续积累、自主归纳的个人知识服务。
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
1.  Synthesis Decay & Knowledge Drift\
    When the LLM constantly rewrites entity pages as new data flows in, how do you prevent the original nuance from getting compressed out? Or worse, hallucinations slowly becoming the "ground truth" over multiple update cycles? Are you sticking strictly to append-only, or maybe forcing the LLM to anchor its claims with hard quotes from the immutable raw/ files?
2.  Scaling the "Lint" Step\
    Triggering a full health-check across the entire wiki for contradictions is going to nuke the context window and get expensive fast. Have any of you tried a "local subgraph" approach to linting? For example, if a new source updates a specific concept, you only trigger a lint on that node and its 1st or 2nd-degree connections rather than checking the whole repo?
Curious to hear how you guys are optimizing the backend logic and maintenance loops in your forks!
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
Contradiction checking does not need to be a monolithic full-repo LLM pass.
It can be implemented as several smaller steps:
1.  Per-source contradiction detection (at ingest time)\
    This is the high-frequency activity: it runs on every source ingest. The schema says to compare the incoming claim against what the touched pages already say. A source touches ~8–15 pages, so the model only loads those pages, not the whole repo. My schema classifies a detected contradiction into one of three severities — soft, scope-mismatch, or hard (and "none" when there is no conflict). Soft and scope-mismatch are non-blocking: they get flagged, referenced, compared and explained, and I permit them since they can be useful in setting the subject matter's peripheral context. I also have a mechanism to keep an eye on soft/scope contradictions so they do not quietly accumulate over time without any review. Hard contradictions are not acceptable — they stop the ingestion run, hold the commit, send me a notification, and block continuation of ingestion until I manually resolve them (with an explanation of the resolution) inside the MD files. Each flagged contradiction carries a machine-readable severity token plus a status line, e.g.:
``` notranslate
Contradiction severity: hard
Status: Unresolved — flagged for user review
```
2.  The commit gate - it is deterministic and carries zero context cost.\
    This is what holds a commit for hard contradictions on every source. The commit gate is not an LLM pass at all — it is a Python os.walk over the "wiki/" folder that greps each page for "Status: Unresolved" and reads the severity token. Yes, it touches every file, but only via cheap disk I/O + regex; it never reaches into the context window. So this "scan the whole repo on every commit" costs ~nothing and scales to any size.
3.  The periodic lint backstop — the only genuinely broad pass, and the one to watch.\
    This is where the concern about nuking the context window has real merit. In my lint workflow, the deterministic checks still sweep the whole wiki, but most of that is shell, not LLM: orphan detection, missing-page detection, and unreferenced-image checks are comm/grep passes (comm to diff sorted page-lists against sorted wikilink targets). Only the reasoning-heavy checks — the contradiction backstop, causal-chain gaps, thin-page judgment, and missing cross-references — need the model. This way I avoid a naive "load every page, cross-check all pairs" approach with O(n²) that would get painful fast as the wiki scales.
The reasoning-heavy backstop therefore runs over nodes changed since the last lint plus their graph neighbors only, not the full repo. This keeps cost bounded as the wiki grows and still catches newly-introduced cross-page conflicts.
One gap this leaves intentionally: a contradiction between two old, unchanged pages that have never landed in the same lint neighborhood. That is real, and I am not pretending it isn't. The mitigation is periodic full sweeps — currently after large ingestion rounds and on explicit request, not on an automated schedule. This trades recall for cost, and I think that is the right tradeoff: the per-source check and the commit gate already filter the cases that would actually corrupt the wiki. The full sweep is a cleanup pass, not a primary defense.
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
**OKF — a production instance of this pattern, with the index + graph internals**
Running this for a self-hosted infra fleet (a mail server, ~30 Tailscale hosts, Proxmox, CI runners).\
~7,500 `type`-tagged notes; the vault is the *operational* source of truth, not just reading notes.\
A few internals that made it hold up past the "index.md is enough" scale:
  S[Raw sources&lt;br/&gt;repos · live configs · API specs · kanban · fleet] --&gt;|exporters on timers| V[Vault&lt;br/&gt;~7,500 md + YAML frontmatter]
  V --&gt;|okf sync /10min| F[(notes&lt;br/&gt;FTS5 trigram)]
  V --&gt;|okf sync /10min| E[(emb&lt;br/&gt;1024-d vectors)]
  V --&gt;|okf-crosslink| M[per-area MOC Map hubs]
  F --&gt; Q[okf search / semantic / record / run]
  E --&gt; Q
  Q --&gt; A[agent &amp;amp; human]
" dir="auto">
``` notranslate
flowchart LR
  S[Raw sources<br/>repos · live configs · API specs · kanban · fleet] -->|exporters on timers| V[Vault<br/>~7,500 md + YAML frontmatter]
  V -->|okf sync /10min| F[(notes<br/>FTS5 trigram)]
  V -->|okf sync /10min| E[(emb<br/>1024-d vectors)]
  V -->|okf-crosslink| M[per-area MOC Map hubs]
  F --> Q[okf search / semantic / record / run]
  E --> Q
  Q --> A[agent &amp; human]
```
**Ingest is scripted, not one-source-at-a-time.** Exporters walk the live systems on timers — network\
inventory, Google/OpenAPI discovery (→ ~1,880 `api-method` notes), kanban→notes, commits, model &\
provider registries. The wiki re-derives itself as the infra changes under you.
**The index is a derived dual index** (`okf-index.db`, ~53 MB, throwaway/rebuildable):
- `notes` = FTS5 **trigram** (so `MATCH` behaves like substring); `emb` = 1024-d float32 unit vectors\
  (`mxbai-embed-large` via local Ollama, 4 KB/note); `meta`/`config` for bookkeeping.
- **Latency:** keyword **~0.07 s** (vs 0.5–1.2 s full scan); semantic **~1.1 s cold** — dominated by\
  process + numpy import + the query-embed, *not* the matrix (loading ~19 MB is ~50 ms).
- **Integrity guards** (why it never drifts): content-hash authority (git/exporters churn `mtime`; a\
  sha1 decides real change, so no spurious ~5-min re-embeds); embedder-identity guard (model swap →\
  full re-embed, never mixes vector spaces); **independent commit** (FTS advances even if Ollama is\
  down mid-sync — the embedding is deferred + retried, never marked done with a stale vector);\
  deletion reconciliation + zero-candidate full-walk fallback (true mirror, never misses an add).\
  Vault = truth; index = throwaway.
It's plain SQLite — `okf` shells out, no ORM:
``` notranslate
-- derived schema (rebuildable; the vault is the source of truth)
CREATE VIRTUAL TABLE notes USING fts5(rel UNINDEXED, hay, tokenize='trigram');
CREATE TABLE meta  (rel TEXT PRIMARY KEY, mtime REAL, rid INTEGER, hash TEXT);
CREATE TABLE emb   (rel TEXT PRIMARY KEY, mtime REAL, vec BLOB, hash TEXT);   -- 4096-byte float32 blob
CREATE TABLE config(k TEXT PRIMARY KEY, v TEXT);                              -- emb_model, emb_dim, schema_version
-- keyword: trigram tokenizer makes MATCH behave like substring; narrows ~7,500 -> a few
SELECT rel FROM notes WHERE notes MATCH '"gitea"';        -- then exact `ql in hay` re-check per candidate
-- filtered (frontmatter is folded into `hay`, lowercased): type + a field
SELECT rel FROM notes WHERE notes MATCH '"type:bill"' AND notes MATCH '"billable:true"';
-- incremental upsert: skip unchanged, delete+reinsert changed by FTS rowid
SELECT rel, mtime, rid, hash FROM meta WHERE rel = :rel;       -- mtime fast-path, hash authority
DELETE FROM notes WHERE rowid = :rid;                          -- then INSERT the new hay
INSERT INTO notes(rowid, rel, hay) VALUES (:rid, :rel, :hay);
-- semantic: pull unit vectors, cosine = dot product in numpy (no SQL vector op)
SELECT rel, vec FROM emb;
```
**Indexing notes:** `rel` is the PK everywhere (O(1) upsert / delete-reinsert); `meta.rid` maps a\
note to its FTS rowid so a change is `DELETE`+`INSERT` by rowid (no full reindex); the **trigram**\
tokenizer *is* the index — substring `MATCH` with no `LIKE` table-scan — and FTS5 maintains its own\
shadow tables (`notes_data/_idx/_content/_docsize`). There's deliberately no B-tree on `hay`; FTS5\
owns that, and the exact re-check per candidate keeps results identical to a full scan.
**The graph is maintained *and* linted.** `okf lint` reports: orphans (no inbound `[[links]]`), stubs\
(broken links = not-yet-written knowledge, informational), near-duplicate / contradiction candidates\
by embedding cosine, and **conformance** (frontmatter + non-empty `type`). A cross-link pass maintains\
per-area **MOC "Map" hubs** — it writes *only* the hubs, never the member notes, so there's no churn —\
and took orphans from **~31% → ~19%** in one run.
**Convergence:** we'd independently named it "OKF," then found Google's **Open Knowledge Format** spec\
describing almost exactly the design (md + YAML frontmatter, `type` required, links = untyped edges,\
broken links tolerated). Aligning to v0.1 means external OKF tooling could consume the vault unchanged.
The "maintenance ≈ 0" claim is the crux: timers + the agent keep the ingest, the dual index, and the\
graph all current, so unlike every wiki I've abandoned, this one stays connected and in-sync without\
me touching it.
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
### What about "Reinforcement Learning (RLHF) for PKMs"?
Right now, our graphs are "flat". Every block or bullet has a static weight of 1.0. Search relies on text matching, but human memory doesn't work like that. Some ideas are core pillars, others are just fleeting notes.
I’m releasing an architectural RFC to the open-source community: Applying Reinforcement Learning from Human Feedback (RLHF) to Personal Knowledge Graphs.
Instead of forcing users to manually rate notes (flashcards/spaced repetition), the database should passively learn from our UI interactions:
- **Rewards (+ weight):** When you transclude a block ((uuid)) or zoom into it (Focus Mode), the database learns this is a foundational node.
- **Penalties (- weight):** When a block is ignored in search results (scroll-past) or hasn't been touched in months (temporal decay), its semantic weight drops.
I wrote a detailed Gist outlining the architecture, the pseudo-code for the dynamic weights, and how it alters global search ranking. I've released the concept under the Apache 2.0 license so anyone can experiment with it or build plugins.
You can take a look and contribute here:\
<https://gist.github.com/MarcoPorcellato/9e5226408c56048b16957771f9056e28>
I'm building this into the core of Matryca Brain (next step from Matryca Plumber), but I’d love to hear the thoughts of the Logseq community. Is anyone else exploring dynamic node weighting based on implicit UI feedback? Let's discuss the architecture!
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
The comment section is unreadable...
I'm just wondering about his idea of sources. For articles/research this makes sense, just add the paper. But one of the example use cases was reading a book. So how would one add a source for a book? Its either copyright protected or will be in the order of MBs per book.
Adding books do seem a bit redundant since surely the LLM was already trained on every printed book at the time. In my experience however getting a LLM to work with me on a certain chapter is a bit difficult without pulling in future chapters (since it knows about it) or random ideas from other wikis/reddit. It would be nice to truly work with the LLM and discover knowledge in tandem when it comes to books.
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
lol
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
That's basically what we built trip2g for. You sync the markdown vault from Obsidian, and it's served two ways: as a normal site and over MCP. So everyone's agent (Claude, Cursor, Codex, whatever) points at one endpoint. It runs search to find the section, then expand to walk the note's TOC one level at a time, so it only pulls the part it needs instead of the whole note. You can also stitch a few separate bases together with federation behind the same endpoint.
### Uh oh!
### 
### Uh oh!
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
Letting an AI silently maintain a markdown-based knowledge base is incredibly powerful. But as your graph grows, taxonomy drift becomes a nightmare. An unconstrained LLM will generate company, Company, Business, and Organization across different runs, making it impossible to build reliable app UI dashboards on top of your data.\
To solve this, we are brainstorming a Per-Entity Seeded Ontology architecture for our @equationalapplications/core-llm-wiki memory engine.\
As shown in the infographic, this pattern gives developers 3 configurable modes to control how the LLM extracts knowledge graph edges:\
1️⃣ Strict (Seeded): Supply a starter pack of allowed edges (e.g., \['client', 'employed_by'\]) using a package like @equationalapplications/wiki-ontologies. The LLM is forced to stick to this schema, guaranteeing predictable data structures for hard-coded dashboards. 2️⃣ Emergent (Autogenerated): Give the LLM total freedom to invent relationships dynamically, tracking its own inventions in an ontology_manifest fact. Perfect for flexible "Second Brain" apps where the domain is unknown. 3️⃣ Off (Disabled): Stick to standard, isolated semantic fact extraction when relationship traversal is overkill.\
This perfectly balances rigid app data requirements with the "minimally opinionated" philosophy of the Open Knowledge Format (OKF) v0.1
I would love to get feedback from other developers building agentic memory! Which mode would you use for your app?\
🔗 Links & Resources:\
Core LLM Wiki Engine: <https://github.com/equationalapplications/expo-llm-wiki/tree/main/packages/core>\
Open Knowledge Format (OKF) Spec: <https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md>\
Karpathy's LLM Wiki Gist: <https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f>\
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
An introduction to the Equational Applications LLC collection of LLM Wiki inspired, open-source Typescript packages.\
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
We are excited to announce that Open Knowledge Format (OKF) Import is officially coming to the @equationalapplications/core-llm-wiki memory engine!\
OKF v0.1 is a vendor-neutral standard that represents knowledge as a directory of markdown files with YAML frontmatter, where the file path serves as the concept's identity. While our ecosystem already supports exporting episodic memory into compliant OKF bundles, this upcoming update introduces the parseOkfBundle adapter to seamlessly read foreign or modified OKF bundles back into your local SQLite database.\
But we aren't just importing flat facts—this update lays the foundational database schema for our upcoming Per-Entity Seeded Ontology roadmap. We are introducing:\
A new okf_type column to preserve the exact YAML frontmatter type strings.\
A lightweight llm_wiki_edges table to extract and persist typed graph relationships directly from markdown cross-links.\
Zero-dependency parsing primitives in our new @equationalapplications/core-okf package.\
Soon, your AI agents will be able to ingest, maintain, and share rich, interconnected knowledge graphs with complete data portability!
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
fwiw the read path is what decides this in practice, and it stays cheap without a typed graph. trip2g serves the vault over MCP as agent memory: search, expand the TOC one level, then read only the section you need. Links are plain `[[wikilinks]]` resolved lazily, so a dangling link is just a "write this later" marker and I've never had to seed an ontology to keep drift under control.
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
This has held up really well for me — keeping the raw sources read-only and letting the model own the markdown made a real difference.
The thing that kept biting me: an agent would re-try a dead end an earlier session had already ruled out. It happened so many times that I ended up building a small open-source Python tool for it (Qiju) — it keeps a plain record of the decisions and the approaches I'd dropped, so the next run doesn't repeat them. Honestly it's been working great.
Have you hit the agent-repeats-a-dead-end problem too? Curious whether you'd keep that history inside the wiki, or in a separate log next to it.
For anyone interested to try: [QiJu](https://github.com/jasonshrepo/qiju)
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
Spot on. The shift from raw RAG to compounding LLM-curated synthesis is the next paradigm shift.
It structures project context as Markdown + YAML frontmatter + cross-referenced \[\[wiki-links\]\] inside a /brain directory. Downstream agents (Cursor, Claude Code, Codex) ingest curated context; humans review Brain Diffs alongside code PRs.
Your write-up is a brilliant crystallization. Seeing this convergence after a month of building on it is incredibly validating.
### Uh oh!
### 
<span data-view-component="true"> Copy link </span>
<span data-view-component="true"> Copy Markdown </span>
I tried creating a codebase wiki based on the existing idea (llm-wiki). You can copy this gist into a CLAUDE.md file, then ask Claude to initialize the wiki and see how it behaves:
