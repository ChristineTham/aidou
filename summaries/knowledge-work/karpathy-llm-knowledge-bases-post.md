# Summary — Karpathy, "LLM Knowledge Bases" (2 April 2026)

> [!NOTE]
> **Source status: a practitioner's workflow description posted on X, not research.** 610 words from
> Andrej Karpathy, 2 April 2026
> ([source](../../sources/knowledge-work/karpathy-llm-knowledge-bases-post.md);
> [original](https://x.com/karpathy/status/2039805659525644595)). No data, no evaluation — one
> person reporting a habit he finds useful.
>
> **Conflict of interest: mild.** Karpathy's standing rises with enthusiasm for AI tooling, and the
> post ends by suggesting "there is room here for an incredible new product". He is not selling one.
>
> **Already covered in the book.** This is the *origin post* for the workflow the book cites as
> Karpathy 2026a (the *LLM wiki* gist). §2.5 already explains the method in the author's own voice
> and diagrams it. Treat this as a companion citation, not a new argument.

## Abstract

Karpathy describes using an LLM to build and maintain a personal knowledge base, noting that much of
his token spend has shifted "less into manipulating code, and more into manipulating knowledge". The
loop has five parts. Source documents go into a read-only `raw/` directory. An LLM incrementally
"compiles" them into a wiki of Markdown files — summaries, backlinks, concept articles, all
cross-linked — which the model, not the human, writes and maintains: "I rarely touch it directly."
Once the wiki is large enough he queries it conversationally, and the outputs (Markdown, slides,
plots) are often "filed" back into the wiki, so that "my own explorations and queries always 'add up'
in the knowledge base". Periodic LLM "health checks" hunt inconsistencies, impute missing data, and
propose new article candidates. He views the whole thing in Obsidian.

## The two genuinely additive facts

Everything structural in this post is already in §2.5, including the diagram. Two details are not:

1. **The scale at which it starts paying off.** His research wiki runs to "~100 articles and ~400K
   words" — a concrete number for a section that otherwise describes the method abstractly.
2. **The retrieval admission.** "I thought I had to reach for fancy RAG, but the LLM has been pretty
   good about auto-maintaining index files and brief summaries of all the documents." This is a
   practitioner arriving at exactly the contrast §2.5 is built on — accumulation ahead of time
   beating retrieval at query time — and being surprised by it.

## What it does not establish

Nothing measured. There is no comparison against a retrieval baseline, no evaluation of answer
quality, and the scale figure is one person's single wiki. The post is a description of a habit.

## Relation to the book

**Already cited, in §2.5 Context and Memory**, as Karpathy 2026a (the gist). The book's prose there
explains the accumulate-versus-retrieve contrast, and the Mermaid diagram encodes this post's exact
structure — ingest, LLM-owned wiki, Q&A, outputs filed back, lint for drift and contradictions, and
the `AGENTS.md` schema.

The right treatment is therefore a **companion reference on the existing mention** (as [[inject-article]]
prescribes for an author already cited for the same argument), carrying only the two additive facts
above. Quoting the post in full in §2.5 would restate, for a third time, what the section already
gives in prose and in a diagram — and roughly half its words are tool specifics (Obsidian, Obsidian
Web Clipper, Marp) that will date faster than anything else in the chapter. The complete text is
preserved in `sources/` for the record.

Runner-ups noted, not used: **§2.10** (personal operating models — the "explorations add up" idea
fits, but §2.5 owns the wiki) and **§4.2.2 Context and Memory** (agent-side memory, already served by
the Zhang survey).
