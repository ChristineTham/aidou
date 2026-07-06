# Chapter 2 — Detailed Source Summaries (maximum detail)

One block per source; ★ = cited inline. Deep papers live as dossiers in `research/papers/`.

## Ambient Teammate — `sources/02-ambient`

### agents-willison ★

- Willison (Sep 2025): agent = LLM running tools in a loop to a goal; bounded, terminating.
- Wooldridge (1994) noted the definition problem predates LLMs; no single accepted definition.
- Anthropic settled tools-in-a-loop as the standard; OpenAI conflates Altman "work independently" / ChatGPT browser / Agents-SDK. Decision: Enhanced.

### ambient-computing

- Roy Want (Xerox PARC) Active Badge + PARCTab — first context-aware computer; Andy Hopper "teleporting"; MIT Project Oxygen; computation pervasive as air, human in supervisory role. Decision: Used (ambient framing).

### async-agents

- Hewitt Actor Model (1977): self-contained concurrent object; Sculley Knowledge Navigator (1987); attributes autonomy/persistence/reactivity. Decision: Used (async delegation).

### bottleneck-theory

- Theory of Constraints: 5 focusing steps (identify/exploit/subordinate/elevate/repeat); DBR; you are the bottleneck. Decision: Used (remove yourself).

### copilot-agent

- GitHub: agentic harness, 20+ models, token efficiency, scheduled managed agents; shift from best-model to execution control. Decision: Used.

### loopcraft

- Latent Space (Jun 2026): stack loops, down for reliability up for leverage; Karpathy maximise token throughput; ALE 1,500 tasks/55 occupations, 0% hardest tier. Decision: Enhanced.

### delegation-hbr / flow-throughput / task-mgmt

- Delegation = duties+authority+responsibility, manager retains it; throughput bottleneck = lowest link; GTD capture→clarify→organise→reflect→engage. Decision: Used.

## Knowledge Work — `sources/02-knowledge-work`

### genai-productivity-nber ★

- Brynjolfsson, Li, Raymond (NBER 31161): 5,179 support agents; +14% avg resolutions/hr, +34% novices, ~0 experts; spreads tacit expertise; better retention. Decision: Enhanced.

### copilot-study

- Peng et al. arXiv:2302.06590; Copilot devs finish ~55% faster on a task. Decision: Used.

### automation-bias

- Favour machine over own judgement; "death by GPS"; training reduces, doesn't kill it. Decision: Used (validate less).

### productivity-paradox

- 70s–80s IT spend, no measured gain; Acemoglu 2014 little speedup; e-commerce did gain. Decision: Used.

### knowledge-work-wiki

- Drucker 5 rules; exploration vs exploitation; treat worker as asset. Decision: Used.

### decision-support / synthesis-research / notebooklm / gpt-wiki

- DSS intelligence/design/choice; synthesis combines studies; NotebookLM; GPT emergent in-context learning. Decision: Background.

## LLM Wiki — `sources/02-llm-wiki`

### llm-wiki ★

- Karpathy gist: 3 layers raw sources/wiki/schema; ingest touches 10-15 pages, query cites + files back, lint finds contradictions; LLM never bored, humans curate. Decision: Enhanced.

### memex / as-we-think

- Bush 1945 Memex; associative trails not trees; "trailblazers" profession; information overload presaged. Decision: Used (compounding).

### agent-memory / context-eng / obsidian / note-taking / knowledge-base

- Claude memory tools; context rot/attention budget; Obsidian wikilinks/graph; Cornell/SQ3R; ACID KB. Decision: Used (Ch4).

## Operating Models — `sources/02-operating-models`

- Personal kit: reusable plays, preferences once, daily workflow; repeatable patterns over one-off prompts. Decision: Used.

## Revised Analysis — Ch2 changes

- Enhanced: knowledge-work (NBER 14%/34%), wiki (Karpathy), ambient (Willison). Latent: LENS 84.4% F1 / 75% useful added. Refs trace to dossiers + NBER 31161.
