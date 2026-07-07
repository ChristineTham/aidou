# A Field Guide to Fable: Finding Your Unknowns — Summary

> [!NOTE]
> Source: [thariq-field-guide-to-fable.md](../../sources/ai-coding/thariq-field-guide-to-fable.md) — Thariq Shihipar (@trq212), *A Field Guide to Fable: Finding Your Unknowns*, X (formerly Twitter) long-form article, 3 July 2026. https://x.com/trq212/status/2073100352921215386
>
> **This is a practitioner opinion piece, not established practice.** The author works on Claude Code at Anthropic, so it doubles as informal advocacy for the current Claude models (the "Fable" of the title is Claude Fable 5). It is a field guide of personal working techniques — cutting-edge craft offered as emerging intuition, with no controlled evidence behind the claims. Cite it as one experienced practitioner's method, flagged as such.

## Abstract

Thariq argues that working with the strongest current models keeps re-teaching an old lesson: *the map is not the territory*. The **map** is what you give the agent — prompts, skills, context — and the **territory** is where the work actually has to happen — the codebase, the real constraints. The gap between them he calls **unknowns**: every time the agent hits one, it must guess what you want. His central claim is that with a capable enough model, "the quality of the work is bottlenecked by my ability to clarify its unknowns" — so the scarce skill is no longer writing code but discovering and reducing your own unknowns, before, during, and after implementation. The best agentic coders, he observes, simply have fewer unknowns and plan for the rest; and this is a skill you can improve at, with the model's help.

## Knowing your unknowns

He breaks a problem into four kinds of knowledge (a Johari-window frame):

- **Known knowns** — what you put in the prompt: what you can tell the agent you want.
- **Known unknowns** — what you know you haven't figured out yet.
- **Unknown knowns** — what is so obvious you'd never write it down, but would recognise instantly if you saw it (he ties this to visual taste and "I know it when I see it" criteria).
- **Unknown unknowns** — what you haven't considered at all; knowledge you don't know you lack.

Instructing the model is "a delicate balance": too specific and it follows your instructions even when a pivot would be better; too vague and it fills gaps with generic industry best practice that may not fit. Accounting for your unknowns is what lets you avoid failing in both directions.

## The techniques (organised by stage)

The value of the piece is a toolkit of concrete moves, most of which lean on Claude producing an HTML artifact to react to. He stresses these are a collection to draw from, not a fixed recipe.

**Pre-implementation**
- **Blind spot pass** — literally ask the model to find your *unknown unknowns* and teach you them, giving it context on who you are and what you already know ("I'm adding a new auth provider but know nothing about the auth modules here — do a blindspot pass so I can prompt you better"; "teach me my unknown unknowns about colour grading").
- **Brainstorms and prototypes** — surface *unknown knowns* early, because finding them during implementation is expensive; e.g. ask for several wildly different design directions as a throwaway HTML mock before wiring anything up. He starts almost every session with an exploration phase to set scope with intent.
- **Interviews** — ask the model to interview you one question at a time about ambiguities, prioritising questions whose answers would change the architecture.
- **References** — when you can't describe what you want, point the model at source code that already does it (the richest reference), even in another language.
- **Implementation plans** — ask for a plan that leads with the decisions most likely to change (data models, type interfaces, UX flows) and buries the mechanical refactoring, so the reviewable parts are the ones you might actually alter.

**During implementation**
- **Implementation notes** — have the agent keep a temporary `implementation-notes.md` logging any deviations forced by edge cases, so the next attempt can learn from them ("hit an edge case, pick the conservative option, log it under 'Deviations', keep going").

**Post-implementation**
- **Pitches and explainers** — package the artefacts into one document for buy-in, since reviewers start with the same unknowns you did.
- **Quizzes** — after a long session, ask the model to explain the change and quiz you on it; "I only merge after I pass the quiz perfectly." A direct guard against the overreliance/comprehension gap the book warns about.

## Worked example: launching Fable

The launch video for the Fable model was edited entirely by Claude Code, in a domain (video editing, colour grading) where the author was not an expert. He worked outward from what he knew: confirmed the model could transcribe and cut with ffmpeg, prototyped a word-timed UI with Remotion to test feasibility, and — realising he didn't know what "good" colour grading looked like — asked the model to teach him rather than to guess, turning an unknown unknown into a known one.

## Takeaway

"Every explainer, brainstorm, interview, prototype, and reference is a cheap way to find out what you didn't know before it gets expensive to fix." The prescription: when a long-horizon task comes back wrong, spend more time defining unknowns or building a plan that lets the model improvise through them — and start the next project by asking the model to help find your unknowns.

**Relation to the book.** This is a practitioner's echo of two threads the book already develops with cited research: (1) Chapter 4 §4.1.1's point, grounded in Tankelevitch, that the hard part of prompting is self-knowledge — knowing what you actually want; Thariq's four-quadrant model and "interview me / blindspot pass" are concrete methods for surfacing exactly that. (2) The Chapter 4 inversion — the better the model, the more the human's clarity is the limiting factor — which Thariq states almost verbatim ("bottlenecked by my ability to clarify its unknowns"). It also touches Chapter 3's intent-driven development (the too-specific/too-vague balance) and Chapter 2's prompting loop. Best used as a practitioner sidelight next to the Tankelevitch discussion, flagged as emerging craft.
