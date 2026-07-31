# LLM Knowledge Bases

- Source URL: https://x.com/karpathy/status/2039805659525644595
- Author: Andrej Karpathy (@karpathy) — founding member of OpenAI, former Director of AI at Tesla;
  now an independent researcher/educator (Eureka Labs).
- Date: 2 April 2026 (Thu 02 Apr 2026 20:42:21 UTC)
- Length: 610 words. A plain X post (not a long-form X article), opening with its own title line
  "LLM Knowledge Bases".
- Type: **Practitioner opinion / workflow description — not research.** No data, no evaluation.
  Conflict of interest: mild — Karpathy's standing rises with enthusiasm for AI tooling, and the
  post closes by suggesting "there is room here for an incredible new product". No product of his
  own is being sold.
- Relationship to the gist already cited in the book: this post (2 April 2026) is the **origin
  announcement** of the workflow that the book cites as Karpathy 2026a, the *LLM wiki* gist
  (https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f).
- Retrieved via the fxtwitter JSON mirror (api.fxtwitter.com), 2026-07-24. Text below is verbatim.

## Full text (verbatim)

> LLM Knowledge Bases
>
> Something I'm finding very useful recently: using LLMs to build personal knowledge bases for
> various topics of research interest. In this way, a large fraction of my recent token throughput is
> going less into manipulating code, and more into manipulating knowledge (stored as markdown and
> images). The latest LLMs are quite good at it. So:
>
> Data ingest:
> I index source documents (articles, papers, repos, datasets, images, etc.) into a raw/ directory,
> then I use an LLM to incrementally "compile" a wiki, which is just a collection of .md files in a
> directory structure. The wiki includes summaries of all the data in raw/, backlinks, and then it
> categorizes data into concepts, writes articles for them, and links them all. To convert web
> articles into .md files I like to use the Obsidian Web Clipper extension, and then I also use a
> hotkey to download all the related images to local so that my LLM can easily reference them.
>
> IDE:
> I use Obsidian as the IDE "frontend" where I can view the raw data, the the compiled wiki, and the
> derived visualizations. Important to note that the LLM writes and maintains all of the data of the
> wiki, I rarely touch it directly. I've played with a few Obsidian plugins to render and view data
> in other ways (e.g. Marp for slides).
>
> Q&A:
> Where things get interesting is that once your wiki is big enough (e.g. mine on some recent
> research is ~100 articles and ~400K words), you can ask your LLM agent all kinds of complex
> questions against the wiki, and it will go off, research the answers, etc. I thought I had to reach
> for fancy RAG, but the LLM has been pretty good about auto-maintaining index files and brief
> summaries of all the documents and it reads all the important related data fairly easily at this
> ~small scale.
>
> Output:
> Instead of getting answers in text/terminal, I like to have it render markdown files for me, or
> slide shows (Marp format), or matplotlib images, all of which I then view again in Obsidian. You
> can imagine many other visual output formats depending on the query. Often, I end up "filing" the
> outputs back into the wiki to enhance it for further queries. So my own explorations and queries
> always "add up" in the knowledge base.
>
> Linting:
> I've run some LLM "health checks" over the wiki to e.g. find inconsistent data, impute missing data
> (with web searchers), find interesting connections for new article candidates, etc., to
> incrementally clean up the wiki and enhance its overall data integrity. The LLMs are quite good at
> suggesting further questions to ask and look into.
>
> Extra tools:
> I find myself developing additional tools to process the data, e.g. I vibe coded a small and naive
> search engine over the wiki, which I both use directly (in a web ui), but more often I want to hand
> it off to an LLM via CLI as a tool for larger queries.
>
> Further explorations:
> As the repo grows, the natural desire is to also think about synthetic data generation + finetuning
> to have your LLM "know" the data in its weights instead of just context windows.
>
> TLDR: raw data from a given number of sources is collected, then compiled by an LLM into a .md
> wiki, then operated on by various CLIs by the LLM to do Q&A and to incrementally enhance the wiki,
> and all of it viewable in Obsidian. You rarely ever write or edit the wiki manually, it's the
> domain of the LLM. I think there is room here for an incredible new product instead of a hacky
> collection of scripts.

## Notes on the text

- Typos are as posted ("the the compiled wiki").
- The scale figure is the most concretely citable fact: "~100 articles and ~400K words".
- The most striking line for a book arguing accumulation over retrieval: "I thought I had to reach
  for fancy RAG, but the LLM has been pretty good about auto-maintaining index files and brief
  summaries."
- Much of the post is tool-specific (Obsidian, Obsidian Web Clipper, Marp, matplotlib) and will date
  quickly; the durable content is the shape of the loop, not the tool list.
