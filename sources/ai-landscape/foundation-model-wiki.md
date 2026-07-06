Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Foundation_model&oldid=1361502319 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Foundation_model&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Foundation_model&id=1361502319&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFoundation_model)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Foundation_model&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Artificial intelligence model paradigm
## Definitions
As governments regulate foundation models, new legal definitions have emerged.
- In the European Union, the [European Parliament](/wiki/European_Parliament "European Parliament")'s negotiated position on the [E.U. AI Act](/wiki/Artificial_Intelligence_Act "Artificial Intelligence Act") defines a foundation model as an "AI model that is trained on broad data at scale, is designed for generality of output, and can be adapted to a wide range of distinctive tasks".
The United States's definitions are the only ones to make reference to the size of a foundation model, and differ on magnitude. Beyer and Eshoo's definition also specifies that foundation models must achieve a level of performance as to be a potential danger. In contrast, the E.U. definition requires the model to be designed for generality of output. All definitions agree that foundation models must be trained on a broad range of data with potential applications in many domains.
## History
## Related concepts
### Frontier models
Since the concept of dangerous capabilities is inherently subjective, there is no strict designation for what foundation models qualify as frontier models. However, some generally held ideas for sufficiently dangerous capabilities include:
### General-purpose AI
Government agencies like EU Parliament have identified regulation of general-purpose AI, such as foundation models, to be a high priority. General-purpose AI systems are often characterized by large size, opacity, and potential for emergence, all of which can create unintended harms. Such systems also heavily influence downstream applications, which further exacerbates the need for regulation. In regards to prominent legislation, a number of stakeholders have pushed for the [EU AI Act](/wiki/Artificial_Intelligence_Act "Artificial Intelligence Act") to include restrictions on general-purpose AI systems, all of which would also apply to foundation models.
### World models
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
Main article: [World model (artificial intelligence)](/wiki/World_model_(artificial_intelligence) "World model (artificial intelligence)")
See also: [Digital twin](/wiki/Digital_twin "Digital twin")
#### History
#### Training
#### Examples
#### Applications
#### Concerns
## Technical details
### Model architecture
### Training
With the rise of foundation models and the larger datasets that power them, a training objective must be able to parse through internet-scale data for meaningful data points. Additionally, since foundation models are designed to solve a general range of tasks, training objectives ought to be *domain complete*, or able to solve a broad set of downstream capabilities within the given domain. Lastly, foundation model training objectives should seek to scale well and be computationally efficient. With model size and compute power both being relevant constraints, a training objective must be able to overcome such bottlenecks.
### Data
### Systems
GPUs are the most common choice of compute hardware for machine learning, due to high memory storage and strong power. Typical foundation model training requires many GPUs in a [distributed computing](/wiki/Distributed_computing "Distributed computing") setup, connected in parallel with fast interconnects. Acquiring a sufficient amount of GPUs of requisite compute efficiency is a challenge for many foundation model developers, one that has led to an increasing dilemma in the field. Larger models require greater compute power, but often at the cost of improved compute efficiency. Since training remains time-consuming and expensive, the tradeoff between compute power and compute efficiency has led only a few select companies to afford the production costs for large, state of the art foundation models. Some techniques like compression and distillation can make inference more affordable, but they fail to completely shore up this weakness.
### Scaling
The accuracy and capabilities of foundation models often scale predictably with the size of the model and the amount of the training data. Specifically, scaling laws have been discovered, which are data-based empirical trends that relate resources (data, model size, compute usage) to model capabilities. Particularly, a model's scale is defined by compute, dataset size, and the number of parameters, all of which exhibit a power-law relationship with end performance.
### Adaptation
Foundation models are inherently multi-purpose: to use these model for a specific use case requires some form of adaptation. At a minimum, models need to be adapted to perform the task of interest (task specification), but often better performance can be achieved by more extensive adaptation to the domain of interest (domain specialization).
### Evaluation
## Supply chain
</figure>
The foundation model will then be hosted online either via the developer or via an external organization. Once released, other parties can create applications based on the foundation model, whether through fine-tuning or wholly new purposes. People can then access these applications to serve their various means, allowing one foundation model to power and reach a wide audience.
## Release strategies
When a model is released via an [API](/wiki/API "API"), users can query the model and receive responses, but cannot directly access the model itself. Comparatively, the model could be directly downloadable for users to access and modify. Both release strategies are often classified as an open release. The exact definition of an open release is disputed, but widely accepted requirements are provided by the [Open Source Initiative](/wiki/Open_Source_Initiative "Open Source Initiative").
During a closed release, the foundation model cannot be accessed by the public, but is used internally by an organization. Such releases are considered safer, but offer no additional value to the research community or the public at large.
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
</tbody>
</table>
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
[Categories](/wiki/Help:Category "Help:Category"):
- [Natural language processing](/wiki/Category:Natural_language_processing "Category:Natural language processing")
- [Computational linguistics](/wiki/Category:Computational_linguistics "Category:Computational linguistics")
- [Computational fields of study](/wiki/Category:Computational_fields_of_study "Category:Computational fields of study")
- [Language modeling](/wiki/Category:Language_modeling "Category:Language modeling")
- [Unsupervised learning](/wiki/Category:Unsupervised_learning "Category:Unsupervised learning")
- [Deep learning](/wiki/Category:Deep_learning "Category:Deep learning")
Hidden categories:
- [CS1 maint: deprecated archival service](/wiki/Category:CS1_maint:_deprecated_archival_service "Category:CS1 maint: deprecated archival service")
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description matches Wikidata](/wiki/Category:Short_description_matches_Wikidata "Category:Short description matches Wikidata")
- [Use dmy dates from May 2023](/wiki/Category:Use_dmy_dates_from_May_2023 "Category:Use dmy dates from May 2023")
- [All articles with unsourced statements](/wiki/Category:All_articles_with_unsourced_statements "Category:All articles with unsourced statements")
- [Articles with unsourced statements from July 2025](/wiki/Category:Articles_with_unsourced_statements_from_July_2025 "Category:Articles with unsourced statements from July 2025")
