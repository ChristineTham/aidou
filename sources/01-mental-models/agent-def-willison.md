# [Simon Willison’s Weblog](/)
## I think “agent” may finally have a widely enough agreed upon definition to be useful jargon now
18th September 2025
I’ve noticed something interesting over the past few weeks: I’ve started using the term “agent” in conversations where I don’t feel the need to then define it, roll my eyes or wrap it in scare quotes.
This is a big piece of personal character development for me!
Moving forward, when I talk about agents I’m going to use this:
**An LLM agent runs tools in a loop to achieve a goal.**
I’ve been *very* hesitant to use the term “agent” for meaningful communication over the last couple of years. It felt to me like the ultimate in buzzword bingo—everyone was talking about agents, but if you quizzed them everyone seemed to hold a different mental model of what they actually were.
I even started collecting definitions in my [agent-definitions tag](https://simonwillison.net/tags/agent-definitions/), including crowdsourcing 211 definitions on Twitter and attempting to summarize and group them with Gemini (I got [13 groups](https://gist.github.com/simonw/beaa5f90133b30724c5cc1c4008d0654#response), here’s the [tool-using LLMS](https://gist.github.com/simonw/beaa5f90133b30724c5cc1c4008d0654#2-tool-using-llms) one.)
Jargon terms are only useful if you can be confident that the people you are talking to share the same definition! If they don’t then communication becomes *less* effective—you can waste time passionately discussing entirely different concepts.
It turns out this is not a new problem. In 1994’s *Intelligent Agents: Theory and Practice* [Michael Wooldridge wrote](https://www.cs.ox.ac.uk/people/michael.wooldridge/pubs/ker95/subsection3_1_1.html):
> Carl Hewitt recently remarked that the question *what is an agent?* is embarrassing for the agent-based computing community in just the same way that the question *what is intelligence?* is embarrassing for the mainstream AI community. The problem is that although the term is widely used, by many people working in closely related areas, it defies attempts to produce a single universally accepted definition.
So long as agents lack a commonly shared definition, using the term reduces rather than increases the clarity of a conversation.
In the AI engineering space I think we may finally have settled on a widely enough accepted definition that we can now have productive conversations about them.
#### Tools in a loop to achieve a goal
An LLM agent *runs tools in a loop to achieve a goal*. Let’s break that down.
The “tools in a loop” definition has been popular for a while—Anthropic in particular have [settled on that one](https://simonwillison.net/2025/May/22/tools-in-a-loop/). This is the pattern baked into many LLM APIs as tools or function calls—the LLM is given the ability to request actions to be executed by its harness, and the outcome of those tools is fed back into the model so it can continue to reason through and solve the given problem.
“To achieve a goal” reflects that these are not infinite loops—there is a stopping condition.
I debated whether to specify “... a goal set by a user”. I decided that’s not a necessary part of this definition: we already have sub-agent patterns where another LLM sets the goal (see [Claude Code](https://simonwillison.net/2025/Jun/2/claude-trace/) and [Claude Research](https://simonwillison.net/2025/Jun/14/multi-agent-research-system/)).
There remains an almost unlimited set of alternative definitions: if you talk to people outside of the technical field of building with LLMs you’re still likely to encounter travel agent analogies or employee replacements or excitable use of the word “autonomous”. In those contexts it’s important to clarify the definition they are using in order to have a productive conversation.
But from now on, if a technical implementer tells me they are building an “agent” I’m going to assume they mean they are wiring up tools to an LLM in order to achieve goals using those tools in a bounded loop.
Some people might insist that agents have a memory. The “tools in a loop” model has a fundamental form of memory baked in: those tool calls are constructed as part of a conversation with the model, and the previous steps in that conversation provide short-term memory that’s essential for achieving the current specified goal.
If you want long-term memory the most promising way to implement it is [with an extra set of tools](https://simonwillison.net/2025/Sep/12/claude-memory/)!
#### Agents as human replacements is my least favorite definition
If you talk to non-technical business folk you may encounter a depressingly common alternative definition: agents as replacements for human staff. This often takes the form of “customer support agents”, but you’ll also see cases where people assume that there should be marketing agents, sales agents, accounting agents and more.
If someone surveys Fortune 500s about their “agent strategy” there’s a good chance that’s what is being implied. Good luck getting a clear, distinct answer from them to the question “what is an agent?” though!
This category of agent remains science fiction. If your agent strategy is to replace your human staff with some fuzzily defined AI system (most likely a system prompt and a collection of tools under the hood) you’re going to end up sorely disappointed.
That’s because there’s one key feature that remains unique to human staff: **accountability**. A human can take responsibility for their actions and learn from their mistakes. Putting an AI agent on a [performance improvement plan](https://en.m.wikipedia.org/wiki/Performance_improvement#Performance_improvement_plans) makes no sense at all!
Amusingly enough, humans also have **agency**. They can form their own goals and intentions and act autonomously to achieve them—while taking accountability for those decisions. Despite the name, AI agents can do nothing of the sort.
This [legendary 1979 IBM training slide](https://simonwillison.net/2025/Feb/3/a-computer-can-never-be-held-accountable/) says everything we need to know:
#### OpenAI need to get their story straight
The single biggest source of agent definition confusion I’m aware of is OpenAI themselves.
OpenAI CEO Sam Altman is fond of [calling agents](https://simonwillison.net/2025/Jan/23/introducing-operator/) “AI systems that can do work for you independently”.
Back in July OpenAI [launched a product feature](https://openai.com/index/introducing-chatgpt-agent/) called “ChatGPT agent” which is actually a browser automation system—toggle that option on in ChatGPT and it can launch a real web browser and use it to interact with web pages directly.
And in March OpenAI [launched an Agents SDK](https://openai.com/index/new-tools-for-building-agents/) with libraries in Python ([openai-agents](https://pypi.org/project/openai-agents/)) and JavaScript ([@openai/agents](https://www.npmjs.com/package/@openai/agents)). This one is a much closer fit to the “tools in a loop” idea.
It may be too late for OpenAI to unify their definitions at this point. I’m going to ignore their various other definitions and stick with tools in a loop!
#### There’s already a meme for this
Josh Bickett [tweeted this](https://twitter.com/josh_bickett/status/1725556267014595032) in November 2023:
> What is an AI agent?
>
I guess I’ve climbed my way from the left side of that curve to the right.
Posted [18th September 2025](/2025/Sep/18/) at 7:12 pm · Follow me on [Mastodon](https://fedi.simonwillison.net/@simon), [Bluesky](https://bsky.app/profile/simonwillison.net), [Twitter](https://twitter.com/simonw) or [subscribe to my newsletter](https://simonwillison.net/about/#subscribe)
## More recent articles
- [Porting the Moebius 0.2B image inpainting model to run in the browser with Claude Code](/2026/Jun/22/porting-moebius/) - 22nd June 2026
- [sqlite-utils 4.0rc1 adds migrations and nested transactions](/2026/Jun/21/sqlite-utils-40rc1/) - 21st June 2026
- [Datasette Apps: Host custom HTML applications inside Datasette](/2026/Jun/18/datasette-apps/) - 18th June 2026
This is **I think “agent” may finally have a widely enough agreed upon definition to be useful jargon now** by Simon Willison, posted on [18th September 2025](/2025/Sep/18/).
**Next:** [Claude Sonnet 4.5 is probably the "best coding model in the world" (at least for now)](/2025/Sep/29/claude-sonnet-4-5/)
**Previous:** [My review of Claude's new Code Interpreter, released under a very confusing name](/2025/Sep/9/claude-code-interpreter/)
    /* .promo */
    border-radius: 8px;
    margin: 1.5rem 0;
    padding: 1rem 1.25rem;
    /* .variant-a */
    border: 2px solid #6c3eb9;
  ">
### Monthly briefing
Sponsor me for **\$10/month** and get a curated email digest of the month's most important LLM developments.
Pay me to send you less!
      /* a.button */
      display: inline-block;
      padding: 0.5rem 1rem;
      background: #6c3eb9;
      color: #fff;
      text-decoration: none;
      border-radius: 4px;
      font-weight: 600;
    ">Sponsor &amp; subscribe</a>
- [Disclosures](/about/#disclosures)
- [Colophon](/about/#about-site)
- ©
- [2002](/2002/)
- [2003](/2003/)
- [2004](/2004/)
- [2005](/2005/)
- [2006](/2006/)
- [2007](/2007/)
- [2008](/2008/)
- [2009](/2009/)
- [2010](/2010/)
- [2011](/2011/)
- [2012](/2012/)
- [2013](/2013/)
- [2014](/2014/)
- [2015](/2015/)
- [2016](/2016/)
- [2017](/2017/)
- [2018](/2018/)
- [2019](/2019/)
- [2020](/2020/)
- [2021](/2021/)
- [2022](/2022/)
- [2023](/2023/)
- [2024](/2024/)
- [2025](/2025/)
- [2026](/2026/)
<style>image-gallery:not(:defined) img {max-height: 150px;} captioned-image-gallery:not(:defined) > figure {max-height: 240px; overflow: hidden;}</style>
