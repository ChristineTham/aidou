# [Simon Willison’s Weblog](/)
12th September 2025 - Link Blog
**[Claude Memory: A Different Philosophy](https://www.shloked.com/writing/claude-memory)** ([via](https://news.ycombinator.com/item?id=45214908 "Hacker News")) Shlok Khemani has been doing excellent work reverse-engineering LLM systems and documenting his discoveries.
Last week he [wrote about ChatGPT memory](https://www.shloked.com/writing/chatgpt-memory-bitter-lesson). This week it's Claude.
> Claude's memory system has two fundamental characteristics. First, it starts every conversation with a blank slate, without any preloaded user profiles or conversation history. Memory only activates when you explicitly invoke it. Second, Claude recalls by only referring to your raw conversation history. There are no AI-generated summaries or compressed profiles—just real-time searches through your actual past chats.
Claude's memory is implemented as two new function tools that are made available for a Claude to call. I [confirmed this myself](https://claude.ai/share/18754235-198d-446b-afc6-26191ea62d27) with the prompt "`Show me a list of tools that you have available to you, duplicating their original names and descriptions`" which gave me back these:
> **conversation_search**: Search through past user conversations to find relevant context and information
>
> **recent_chats**: Retrieve recent chat conversations with customizable sort order (chronological or reverse chronological), optional pagination using 'before' and 'after' datetime filters, and project filtering
The good news here is *transparency* - Claude's memory feature is implemented as visible tool calls, which means you can see exactly when and how it is accessing previous context.
This helps address my big complaint about ChatGPT memory (see [I really don’t like ChatGPT’s new memory dossier](https://simonwillison.net/2025/May/21/chatgpt-new-memory/) back in May) - I like to understand as much as possible about what's going into my context so I can better anticipate how it is likely to affect the model.
The OpenAI system is [*very* different](https://simonwillison.net/2025/May/21/chatgpt-new-memory/#how-this-actually-works): rather than letting the model decide when to access memory via tools, OpenAI instead automatically include details of previous conversations at the start of every conversation.
[Shlok's notes on ChatGPT's memory](https://www.shloked.com/writing/chatgpt-memory-bitter-lesson) did include one detail that I had previously missed that I find reassuring:
> Recent Conversation Content is a history of your latest conversations with ChatGPT, each timestamped with topic and selected messages. \[...\] Interestingly, only the user's messages are surfaced, not the assistant's responses.
One of my big worries about memory was that it could harm my "clean slate" approach to chats: if I'm working on code and the model starts going down the wrong path (getting stuck in a bug loop for example) I'll start a fresh chat to wipe that rotten context away. I had worried that ChatGPT memory would bring that bad context along to the next chat, but omitting the LLM responses makes that much less of a risk than I had anticipated.
**Update**: Here's a slightly confusing twist: yesterday in [Bringing memory to teams at work](https://www.anthropic.com/news/memory) Anthropic revealed an *additional* memory feature, currently only available to Team and Enterprise accounts, with a feature checkbox labeled "Generate memory of chat history" that looks much more similar to the OpenAI implementation:
> With memory, Claude focuses on learning your professional context and work patterns to maximize productivity. It remembers your team’s processes, client needs, project details, and priorities. \[...\]
>
> Claude uses a memory summary to capture all its memories in one place for you to view and edit. In your settings, you can see exactly what Claude remembers from your conversations, and update the summary at any time by chatting with Claude.
I haven't experienced this feature myself yet as it isn't part of my Claude subscription. I'm glad to hear it's fully transparent and can be edited by the user, resolving another of my complaints about the ChatGPT implementation.
This version of Claude memory also takes Claude Projects into account:
> If you use projects, **Claude creates a separate memory for each project**. This ensures that your product launch planning stays separate from client work, and confidential discussions remain separate from general operations.
I [praised OpenAI for adding this](https://simonwillison.net/2025/Aug/22/project-memory/) a few weeks ago.
Posted [12th September 2025](/2025/Sep/12/) at 7:34 am
## Recent articles
- [Porting the Moebius 0.2B image inpainting model to run in the browser with Claude Code](/2026/Jun/22/porting-moebius/) - 22nd June 2026
- [sqlite-utils 4.0rc1 adds migrations and nested transactions](/2026/Jun/21/sqlite-utils-40rc1/) - 21st June 2026
- [Datasette Apps: Host custom HTML applications inside Datasette](/2026/Jun/18/datasette-apps/) - 18th June 2026
This is a **link post** by Simon Willison, posted on [12th September 2025](/2025/Sep/12/).
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
