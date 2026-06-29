Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Prompt_engineering&oldid=1360274188 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Prompt_engineering&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Prompt_engineering&id=1360274188&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FPrompt_engineering)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Prompt_engineering&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Structuring text as input to generative artificial intelligence
During the 2020s [AI boom](/wiki/AI_boom "AI boom"), prompt engineering became regarded as a business capability across corporations and industries. Employees with the title **prompt engineer** were hired to create prompts that would increase productivity and efficacy, although the individual title has since lost traction amid AI models that produce better prompts than humans and corporate training in prompting for general employees.
Common prompting techniques include multi-shot, chain-of-thought, and tree-of-thought prompting, as well as assigning roles to the model. Automated prompt generation methods, such as [retrieval-augmented generation](/wiki/Retrieval-augmented_generation "Retrieval-augmented generation") (RAG), provide for greater accuracy and a wider scope of functions for prompt engineers. [Prompt injection](/wiki/Prompt_injection "Prompt injection") is a type of [cybersecurity](/wiki/Computer_security "Computer security") attack that targets [machine learning](/wiki/Machine_learning "Machine learning") models through malicious prompts.
## Terminology
### Prompt
### Techniques
### Context engineering
## Rationale
### In-context learning
### Prompting to estimate model sensitivity
## Prompting techniques
### Multi-shot
### Chain-of-thought
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
#### Self-consistency
### Tree-of-thought
### Text-to-image prompting
<style data-mw-deduplicate="TemplateStyles:r1349637415/mw-parser-output/.tmulti">.mw-parser-output .tmulti .multiimageinner{display:flex;flex-direction:column}.mw-parser-output .tmulti .trow{display:flex;flex-direction:row;clear:left;flex-wrap:wrap;width:100%;box-sizing:border-box}.mw-parser-output .tmulti .tsingle{margin:1px;float:left}.mw-parser-output .tmulti .theader{clear:both;font-weight:bold;text-align:center;align-self:center;background-color:transparent;width:100%}.mw-parser-output .tmulti .thumbcaption{background-color:transparent}.mw-parser-output .tmulti .text-align-left{text-align:left}.mw-parser-output .tmulti .text-align-right{text-align:right}.mw-parser-output .tmulti .text-align-center{text-align:center}@media all and (max-width:720px){.mw-parser-output .tmulti .thumbinner{width:100%!important;box-sizing:border-box;max-width:none!important;align-items:center}.mw-parser-output .tmulti .trow{justify-content:center}.mw-parser-output .tmulti .tsingle{float:none!important;max-width:100%!important;box-sizing:border-box;text-align:center}.mw-parser-output .tmulti .tsingle .thumbcaption{text-align:left}.mw-parser-output .tmulti .trow>.thumbcaption{text-align:center}}@media screen{.mw-parser-output .tmulti .multiimageinner .thumbimage{background-color:inherit}html.skin-theme-clientpref-night .mw-parser-output .tmulti .multiimageinner .thumbimage:not([style*="background-color"]) span:not(.skin-invert-image):not(.skin-invert):not(.bg-transparent) img,html.skin-theme-clientpref-day .mw-parser-output .tmulti .multiimageinner .thumbimage:not([style*="background-color"]) span:not(.bg-transparent) img{background-color:white}}@media screen and (prefers-color-scheme:dark){html.skin-theme-clientpref-os .mw-parser-output .tmulti .multiimageinner .thumbimage:not([style*="background-color"]) span:not(.skin-invert-image):not(.skin-invert):not(.bg-transparent) img{background-color:white}}</style>
Demonstration of the effect of negative prompts on images generated with [Stable Diffusion](/wiki/Stable_Diffusion "Stable Diffusion")\
**Top**: no negative prompt\
**Centre**: "green trees"\
**Bottom**: "round stones, round rocks"
#### Artist styles
#### Textual inversion and embeddings
### Image prompting
### Limitations
## Automated prompt generation
### <span id="Retrieval-augmented_generation_.28RAG.29"></span>Retrieval-augmented generation (RAG)
### <span id="Graph_retrieval-augmented_generation_.28GraphRAG.29"></span>Graph retrieval-augmented generation (GraphRAG)
<figcaption>GraphRAG with a knowledge graph combining access patterns for unstructured, structured, and mixed data</figcaption>
</figure>
### Using language models to generate prompts
- There are two LLMs. One is the target LLM, and another is the prompting LLM.
- Prompting LLM is presented with example input-output pairs, and asked to generate instructions that could have caused a model following the instructions to generate the outputs, given the inputs.
- Each of the generated instructions is used to prompt the target LLM, followed by each of the inputs. The log-probabilities of the outputs are computed and added. This is the score of the instruction.
- The highest-scored instructions are given to the prompting LLM for further variations.
- Repeat until some stopping criteria is reached, then output the highest-scored instructions.
### Automatic prompt optimization
Automatic prompt optimization techniques refine prompts for large language models by automatically searching over alternative prompt strings using evaluation datasets and task-specific metrics:
### Using gradient descent to search for prompts
## History
## Prompt injection
Main article: [Prompt injection](/wiki/Prompt_injection "Prompt injection")
See also: [SQL injection](/wiki/SQL_injection "SQL injection"), [Cross-site scripting](/wiki/Cross-site_scripting "Cross-site scripting"), and [Social engineering (security)](/wiki/Social_engineering_(security) "Social engineering (security)")
## References
<style data-mw-deduplicate="TemplateStyles:r1314755338">.mw-parser-output .side-box{margin:4px 0;box-sizing:border-box;border:1px solid #aaa;font-size:88%;line-height:1.25em;background-color:var(--background-color-interactive-subtle,#f8f9fa);color:inherit;display:flow-root}.mw-parser-output .infobox .side-box{font-size:100%}.mw-parser-output .side-box-abovebelow,.mw-parser-output .side-box-text{padding:0.25em 0.9em}.mw-parser-output .side-box-image{padding:2px 0 2px 0.9em;text-align:center}.mw-parser-output .side-box-imageright{padding:2px 0.9em 2px 0;text-align:center}@media(min-width:500px){.mw-parser-output .side-box-flex{display:flex;align-items:center}.mw-parser-output .side-box-text{flex:1;min-width:0}}@media(min-width:640px){.mw-parser-output .side-box{width:238px}.mw-parser-output .side-box-right{clear:right;float:right;margin-left:1em}.mw-parser-output .side-box-left{margin-right:1em}}</style>
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
</ul>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
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
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
datasets and corpora</th>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
standards</th>
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
and data capture</a></th>
<ul>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
<tr>
reviewing</a></th>
<ul>
</ul>
</tr>
<tr>
user interface</a></th>
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
[Categories](/wiki/Help:Category "Help:Category"):
- [Deep learning](/wiki/Category:Deep_learning "Category:Deep learning")
- [Machine learning](/wiki/Category:Machine_learning "Category:Machine learning")
- [Natural language processing](/wiki/Category:Natural_language_processing "Category:Natural language processing")
- [Unsupervised learning](/wiki/Category:Unsupervised_learning "Category:Unsupervised learning")
- [2022 neologisms](/wiki/Category:2022_neologisms "Category:2022 neologisms")
- [Linguistics](/wiki/Category:Linguistics "Category:Linguistics")
- [Generative AI](/wiki/Category:Generative_AI "Category:Generative AI")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [Use mdy dates from January 2025](/wiki/Category:Use_mdy_dates_from_January_2025 "Category:Use mdy dates from January 2025")
- [Pages using multiple image with auto scaled images](/wiki/Category:Pages_using_multiple_image_with_auto_scaled_images "Category:Pages using multiple image with auto scaled images")
