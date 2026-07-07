# everything is a ralph loop — Summary

> [!NOTE]
> Source: [ghuntley-ralph-loop.md](../../sources/ai-coding/ghuntley-ralph-loop.md) — Geoffrey Huntley, *everything is a ralph loop*, ghuntley.com, 17 January 2026. https://ghuntley.com/loop/
>
> **This is a deliberately provocative opinion/manifesto, not research or established practice.** Huntley is an independent engineer promoting his own technique ("ralph") and tooling ("Loom", "gastown"), and the post is written to provoke — "software development is dead — I killed it", software "cheaper than the wage of a burger flipper". There is no evidence behind the claims; treat the strong ones as rhetoric and cite only the underlying craft idea, flagged as one practitioner's contrarian view.

## Abstract

Huntley describes how his way of building software has shifted from stacking code "brick by brick" to treating everything as a *loop*. The "ralph loop" is a single agent, working autonomously in one repository as one process, doing **one task per loop** against a goal you set and then repeat. His central, contrarian claim is that the multi-agent machinery everyone in San Francisco is chasing — agent-to-agent communication, multiplexing — "is not needed", and is in fact a "red hot mess" because it is microservices whose services are non-deterministic. The opposite of microservices is a monolith, and "Ralph is monolithic." The engineer's job, he says, is no longer writing the bricks but *programming the loop*.

## Key points

- **One agent, one task, looped.** "Ralph works autonomously in a single repository as a single process that performs one task per loop." Software becomes "clay on the pottery wheel" — if something is wrong, throw it back on the wheel.
- **Against multi-agent complexity (for now).** Multi-agent, agent-to-agent, multiplexing: "at this stage, it's not needed." Non-deterministic services make microservice-style agent architectures worse, not better.
- **Watch the loop; that is where your learning is.** "When you see a failure domain — put on your engineering hat and resolve the problem so it never happens again." Ralph can be run manually (prompt, `CTRL+C`, next task) or automated; either way the discipline is getting the most out of the model through *context engineering*, a pattern he calls generic and usable for all tasks.
- **The engineer still matters — but the skill has changed.** "Software development/programming is now dead", yet "we deeply need software engineers with these skills who understand that LLMs are a new form of programmable computer." His advice: build your own coding agent.
- **The software factory as the endpoint.** His "Loom" project is "infrastructure for evolutionary software", aiming at a "level 9" where "autonomous loops evolve products and optimise automatically for revenue generation. Evolutionary software — also known as a software factory."
- **The wager.** "What if the models don't stop getting good?" — the argument that today's fringe technique is where everyone ends up.

## Relation to the book

The ralph loop's sharpest claim maps directly onto **Chapter 4 §4.2.3 (Orchestration)**, where the book already cites the Tran multi-agent survey for the finding that "a team of agents with poorly designed channels loses to a single agent with a strong harness." Huntley is the vivid practitioner extreme of that point: an engineer who rejects multi-agent architectures outright in favour of one monolithic, looping agent — a useful contrarian voice to set against the research, flagged as opinion. Two runners-up, not used, to keep it to one citation: **§4.2.4 (Loop Engineering)** — "an agent is a loop… watch the trajectory… fix failures" is Huntley's "program the loop / watch the loop / resolve the failure domain" almost verbatim; and **§4.2 intro (the software factory)** — his "evolutionary software / level 9 / software factory" is the aspirational top rung already discussed there via Factory.ai, Osmani, and BCG, though that passage is already dense and adding another booster would pile on rather than add.
