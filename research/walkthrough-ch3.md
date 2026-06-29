# Chapter 3 — Detailed Source Summaries

One block per source; ★ = cited inline. Deep papers = full dossiers in `research/papers/`.

## Modern Stack — `sources/03-stack`

### decoding-config ★ → `2511.09268`

- 328 CLAUDE.md, top-100 repos; architecture in 72.6% (most-specified), dev guidelines 44.8%, overview 39%, testing 35.4%; top pattern arch+deps+overview 21.6%. Decision: Enhanced (full dossier).

### brockman-stack / harness / memory / eval

- Surface = model+harness+workflow+UI+memory+economics; harness owns value; memory persists outside window; eval = contract check. Decision: Used.

## Coding Patterns — `sources/03-coding-patterns`

### build-agents ★

- Anthropic: single call→workflow→agent; 5 patterns (chain, route, parallel, orchestrator-workers, evaluator-optimiser); multi-agent ~15× tokens. Decision: Enhanced.

### llm-as-code → `2606.15874`; runtime-decomposition → `2605.15425`

- Program owns loop, model judges: OSWorld 86.8%/15 vs 80.4%/100; selective retry −51.7%. Decision: dossiers.

## Spec vs Vibe — `sources/03-spec-vibe`

### spec-kit / idd-vs-sdd ★; spec-growth → `2606.27045`

- Spec-kit 4 phases; collapse = intent/spec/impl jammed; spec-growth anchors spec, scopes Spine, blocks drift. Decision: Enhanced.

## ICE & Quality & Channel

- ICE: intent/expectations/implementation separate, never pre-lock architecture. Quality: mergeability≠pass-rate. Channel: agent identity, govern-repo `2606.28235` ICC 0.30 vs 0.16. Decision: Enhanced.

## Revised Analysis — Ch3

- Enhanced patterns (LLM-as-code, runtime-decomp), spec (growth-engine), channel (govern-repo). Refs → dossiers.
