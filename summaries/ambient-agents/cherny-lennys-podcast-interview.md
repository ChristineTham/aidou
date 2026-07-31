# Summary — Boris Cherny on Lenny's Podcast (19 February 2026)

> [!NOTE]
> **Source status: a recorded interview — practitioner opinion, not research.** Boris Cherny, who
> created and leads Claude Code, talking to Lenny Rachitsky, 19 February 2026, 88 minutes
> ([source](../../sources/ambient-agents/cherny-lennys-podcast-interview.md);
> [original](https://www.youtube.com/watch?v=We7BZVKbCVw)). No data, no evaluation.
>
> **Conflict of interest: strong.** He runs the product he is describing, and every tool he names
> (Claude Code, Cowork) is Anthropic's. Cite for what he does, not for whether it works.
>
> **Auto-caption caution.** The transcript is machine-generated: punctuation is unreliable and terms
> are mis-heard — "Claudes" appears as both "quads" and "clouds". Paraphrase the argument; quote only
> short phrases that are plainly correct.

> [!WARNING]
> **This is NOT the source of the viral "I write loops" quote.** The word *loop* appears **zero
> times** in the complete 20,021-word transcript. That quote is relayed on X only by third parties —
> never by [@bcherny](https://x.com/bcherny) himself — in at least six inconsistent wordings, and the
> relayers point to a 4- or 16-minute clip, not this 88-minute interview. It has no located primary
> and should not be quoted. Details are recorded in the source file.

## Abstract

A long interview covering the state of AI coding and what Cherny thinks follows it. The part useful
to this book is his description of how he actually works now. He says he has "agents running all the
time" and is "not locked into a terminal anymore" — his own coding splits roughly three ways between
terminal, desktop app, and phone. Agents in his setup run unattended for long stretches: "hours or
even days at a time", with some examples running for weeks, and he expects that to become normal, so
"you don't have to sit there and baby sit them anymore". He gives one concrete non-coding example:
his team keeps a spreadsheet with a row per engineer for weekly status, and every Monday an agent
messages on Slack whoever hasn't filled theirs in — "I don't have to do this anymore." He also
recalls predicting in May 2025 that engineers might not need an IDE by year's end, to an audible gasp
from the room.

## Key points

- **Agents running continuously, not on request.** The working pattern he reports is a standing set
  of agents rather than a chat session opened per task.
- **Long-running and unattended.** Hours to days; the shift he names is away from babysitting.
- **Not tied to one interface.** Terminal, desktop, and phone each carry about a third of his work —
  the agent runs somewhere else, so the desk stops being the bottleneck.
- **Ambient work beyond coding.** The Monday status-chaser is a small, checkable example of an agent
  doing recurring work nobody has to remember.
- **His stated caution on judging models:** don't reason from an older model — "it's not Sonnet 3.5
  anymore."

## What it does not establish

Nothing measured. There is no evidence here about productivity, quality, or whether this pattern
works for anyone other than the person who builds the tool. The claims about how long agents run are
his recollection, not instrumented figures.

## Relation to the book

The natural home is **§2.6 Loops and Ambient Teammates**, whose argument is precisely the one Cherny
embodies: a chat assistant is synchronous and paced by your attention, while an ambient teammate runs
while you are elsewhere. The section currently makes that case with Karpathy's "remove yourself from
the keystroke loop" and a Latent Space piece on loopcraft; what it lacks is a named practitioner
describing the arrangement in a recorded, checkable setting. Cherny supplies that, and the Monday
status-chaser gives the section a concrete non-coding example it does not otherwise have.

There is a second reason to prefer this source. §2.6's existing Latent Space citation is one of the
files in this repo that carries the unverified "I write loops" quote; grounding the same idea in a
recording keeps the book's version of the claim traceable.

Runner-ups noted, not used: **§4.3.2**, where Cherny's adoption-steps table already sits (adding the
interview there would crowd a section that already carries Garousi, the table, and a vendor hedge);
and **§4.2.4 Loop Engineering**, which already carries an Anthropic-sourced hedge of its own.
