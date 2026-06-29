# Computer Science \> Software Engineering
**arXiv:2605.15425** (cs)
\[Submitted on 14 May 2026\]
View a PDF of the paper titled Runtime-Structured Task Decomposition for Agentic Coding Systems, by Shubhi Asthana and 4 other authors
> We present runtime-structured task decomposition, an architectural approach in which task partitioning and execution flow are managed through executable control logic rather than prompt structure alone. LLMs are used only for focused judgment tasks, and outputs are validated against predefined schemas before downstream execution.\
> We evaluate this approach on two software engineering workloads using three configurations: monolithic execution, static decomposition with fixed subtasks and no runtime branching, and runtime-structured decomposition. Each configuration was evaluated across 10 runs.\
> Our results show that decomposition alone does not necessarily reduce retry cost. In the Kubernetes root cause analysis workload, the static decomposition baseline produced a retry cost of 1,632 +/- 145 tokens versus 904 +/- 17 tokens for the monolithic baseline because failures forced reruns of downstream subtasks. A similar pattern appeared in the multi-file debugging workload, where the static baseline consumed 933 tokens compared to 703 tokens for the monolithic system.\
> The runtime-structured approach reran only failed subtasks, reducing retry costs to 436 +/- 132 tokens for root cause analysis and 460 tokens for debugging. Overall, the approach achieved up to 51.7% lower retry cost than monolithic systems and 73.2% lower retry cost than static decomposition baselines, improving efficiency, debuggability, and operational reliability in agentic coding systems.
<table data-summary="Additional metadata">
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
</tr>
<tr>
</tr>
<tr>
</tr>
<tr>
</tr>
<tr>
</tr>
</tbody>
</table>
## Submission history
**\[v1\]** Thu, 14 May 2026 21:16:23 UTC (359 KB)\
## Access Paper:
  View a PDF of the paper titled Runtime-Structured Task Decomposition for Agentic Coding Systems, by Shubhi Asthana and 4 other authors
### Current browse context:
cs.SE
Change to browse by:
### References & Citations
export BibTeX citation
<span id="bib-cite-loading" hidden="true">Loading...</span>
## BibTeX formatted citation
×
Data provided by: <span id="bib-cite-source-api"></span>
### Bookmark
Bibliographic Tools
# Bibliographic and Citation Tools
<span id="label-for-bibex">Bibliographic Explorer</span> *([What is the Explorer?](https://info.arxiv.org/labs/showcase.html#arxiv-bibliographic-explorer))*
Code, Data, Media
# Code, Data and Media Associated with this Article
Demos
# Demos
Related Papers
# Recommenders and Search Tools
<span id="label-for-core">CORE Recommender</span> *([What is CORE?](https://core.ac.uk/services/recommender))*
About arXivLabs
# arXivLabs: experimental projects with community collaborators
arXivLabs is a framework that allows collaborators to develop and share new arXiv features directly on our website.
Both individuals and organizations that work with arXivLabs have embraced and accepted our values of openness, community, excellence, and user data privacy. arXiv is committed to these values and only works with partners that adhere to them.
Have an idea for a project that will add value for arXiv's community? [**Learn more about arXivLabs**](https://info.arxiv.org/labs/index.html).
