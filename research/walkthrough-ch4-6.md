# Chapters 4–6 — Detailed Source Summaries

One block per source; ★ = cited inline. Deep papers = dossiers in `research/papers/`.

## Ch4 Context — `04-context`

- **context-eng ★** — Anthropic (Rajasekaran, Dixon, Ryan, Hadfield, 2025): context rot, n² attention budget, compaction, just-in-time retrieval, sub-agents, structured notes. Enhanced.
- **context-rot** → Chroma 18-model; **static-anchoring** → `2606.26979` (+2.2pp, half variance). Dossiers.

## Ch4 Harness/Loopcraft — `04-harness`, `04-loopcraft`

- **llm-as-code** → `2606.15874`; **runtime-decomp** → `2605.15425`. Dossiers.
- **bitter-lesson** — Sutton 2019: general compute-scaling methods beat handcrafted knowledge; chess 1997, Go 2016. Used.
- **loopcraft** — stack loops, down=reliability up=leverage. Used.

## Ch5 Safety/Liability/Access

- **reflection-control** → `2512.21354`; **securing-agent** → `2605.05287`; **control-plane** → `2606.26924`; **govern-repo** → `2606.28235`. Dossiers.
- **owasp** — LLM Top-10 (injection, output, agency, disclosure, overreliance). Used.
- **gdpr** — 2016/2018; up to €20M or 4%; 72h breach; privacy-by-design. Used.
- **c2pa** — content credentials bind origin/edit history. Used.
- **nist-rmf** — Govern/Map/Measure/Manage; deloitte 69%/22%; sovereignty. Used.

## Ch6 Human Edge/Refinement

- **augmentation-dilution** → `2606.26289`: newcomer −3.7pp, review +5.3%. Dossier.
- **centaur** — advanced chess, human strategic oversight + engine. Used.
- **shuhari** — shu/ha/ri keep/break/transcend; mastery loop. Used.
- **nber 31161** — novices +34%; mckinsey redesign. Used.

## Revised Analysis — Ch4-6

- Ch4: anchoring + harness data. Ch5: multitenant 98-100% leak, control-plane 10% dup configs. Ch6: dilution. All trace to dossiers.
