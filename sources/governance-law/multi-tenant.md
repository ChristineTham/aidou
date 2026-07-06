# Computer Science \> Cryptography and Security
**arXiv:2605.05287** (cs)
\[Submitted on 6 May 2026\]
View a PDF of the paper titled Securing the Agent: Vendor-Neutral, Multitenant Enterprise Retrieval and Tool Use, by Francisco Javier Arceo and 1 other authors
> A fundamental problem underlies existing RAG architectures in these settings: retrieval systems rank documents by relevance--whether through semantic similarity, keyword matching, or hybrid approaches--not by authorization, so a query from one tenant can surface another tenant's confidential data simply because it scores highest. We formalize this gap and analyze additional shortcomings--including tool-mediated disclosure, context accumulation across turns, and client-side orchestration bypass--that arise when agentic systems conflate relevance with authorization. To address these challenges, we introduce a layered isolation architecture combining policy-aware ingestion, retrieval-time gating, and shared inference, enforced through server-side agentic orchestration. This approach centralizes security-critical operations--tool execution authorization, state isolation, and policy enforcement--on the server, creating natural enforcement points for multitenant isolation while allowing client-side frameworks to retain control over agent composition and latency-sensitive operations.\
> We validate the proposed architecture through an open-source implementation in OGX, a vendor-neutral framework that implements an OpenAI-compatible, open-source Responses API with server-side multi-turn orchestration. We evaluate it empirically and show that ABAC gating eliminates cross-tenant leakage while introducing negligible overhead.
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
<tr>
</tr>
<tr>
</tr>
<tr>
</tr>
</tbody>
</table>
## Submission history
**\[v1\]** Wed, 6 May 2026 17:59:21 UTC (62 KB)\
## Access Paper:
  View a PDF of the paper titled Securing the Agent: Vendor-Neutral, Multitenant Enterprise Retrieval and Tool Use, by Francisco Javier Arceo and 1 other authors
### Current browse context:
cs.CR
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
