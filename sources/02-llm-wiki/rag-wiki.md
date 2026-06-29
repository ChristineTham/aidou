Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Retrieval-augmented_generation&oldid=1361250981 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Retrieval-augmented_generation&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Retrieval-augmented_generation&id=1361250981&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FRetrieval-augmented_generation)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Retrieval-augmented_generation&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Type of information retrieval using LLMs
## RAG and LLM limitations
## Process
### RAG key stages
<figcaption>Overview of RAG process, combining external documents and user input into an LLM prompt to get tailored output</figcaption>
</figure>
## Applications
Retrieval-augmented generation is used in applications where generated responses need to be grounded in external or frequently updated information.<sup>\[*[<span title="This claim needs references to reliable sources. (June 2026)">citation needed</span>](/wiki/Wikipedia:Citation_needed "Wikipedia:Citation needed")*\]</sup>
## Improvements
Improvements to the basic process above can be applied at different stages in the RAG flow.
### Encoder
### Retriever-centric methods
These methods aim to enhance the quality of document retrieval in vector databases:
### Language model
Retro language model for RAG. Each Retro block consists of Attention, Chunked Cross Attention, and Feed Forward layers. Black-lettered boxes show data being changed, and blue lettering shows the algorithm performing the changes.
### Chunking
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
See also: [Chunking (computing)](/wiki/Chunking_(computing) "Chunking (computing)")
Chunking involves various strategies for breaking up the data into vectors so the retriever can find details in it.
Different data styles have patterns that correct chunking can take advantage of.
Three types of chunking strategies are:<sup>\[*[<span title="This claim needs references to reliable sources. (August 2025)">citation needed</span>](/wiki/Wikipedia:Citation_needed "Wikipedia:Citation needed")*\]</sup>
- Fixed length with overlap. This is fast and easy. Overlapping consecutive chunks helps to maintain semantic context across chunks.
- Syntax-based chunks can break the document up into sentences. Libraries such as [spaCy](/wiki/SpaCy "SpaCy") or [NLTK](/wiki/Natural_Language_Toolkit "Natural Language Toolkit") can also help.
### Hybrid search
## Challenges
### RAG poisoning
## References
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
<ul>
</ul>
</tr>
&#10;<tr>
<ul>
</ul>
</tr>
<tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
</tbody>
</table>
</tr>
<tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
<ul>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
</tbody>
</table>
</tr>
<tr>
<ul>
<ul>
</ul></li>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
<ul>
<ul>
</ul></li>
</ul></li>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
</tbody>
</table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
<ul>
</ul>
</tr>
&#10;<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<li>Hypothetical
<ul>
</ul></li>
</ul>
</tr>
<tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
<ul>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
</tbody>
</table>
</tr>
<tr>
<ul>
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
</tbody>
</table>
[Categories](/wiki/Help:Category "Help:Category"):
- [Large language models](/wiki/Category:Large_language_models "Category:Large language models")
- [Natural language processing](/wiki/Category:Natural_language_processing "Category:Natural language processing")
- [Information retrieval systems](/wiki/Category:Information_retrieval_systems "Category:Information retrieval systems")
- [Generative AI](/wiki/Category:Generative_AI "Category:Generative AI")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [Articles containing potentially dated statements from 2023](/wiki/Category:Articles_containing_potentially_dated_statements_from_2023 "Category:Articles containing potentially dated statements from 2023")
- [All articles containing potentially dated statements](/wiki/Category:All_articles_containing_potentially_dated_statements "Category:All articles containing potentially dated statements")
- [All articles with unsourced statements](/wiki/Category:All_articles_with_unsourced_statements "Category:All articles with unsourced statements")
- [Articles with unsourced statements from June 2026](/wiki/Category:Articles_with_unsourced_statements_from_June_2026 "Category:Articles with unsourced statements from June 2026")
- [Articles with unsourced statements from August 2025](/wiki/Category:Articles_with_unsourced_statements_from_August_2025 "Category:Articles with unsourced statements from August 2025")
