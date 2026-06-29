- <span id="ca-view">[Read](/wiki/Separation_of_concerns)</span>
Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Separation_of_concerns&oldid=1359922329 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Separation_of_concerns&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Separation_of_concerns&id=1359922329&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSeparation_of_concerns)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Separation_of_concerns&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Design principle for computer programming
Modularity is a specific application of concerns to system components (separation by size). In modular systems, each module encapsulates a single concern, and modules are designed, implemented, and understood in isolation before being composed into a larger system. While modularity is the most common and recognizable embodiment of SoC in code structure, the principle of Separation of concerns is broader. For example, separating requirements analysis from implementation in a project timeline, or separating functional from non-functional requirements in a specification, are valid forms of separation of concerns that do not necessarily require a modular design.
According to [Carlo Ghezzi](/wiki/Carlo_Ghezzi "Carlo Ghezzi"), the main benefit of software [modularity](/wiki/Modular_programming "Modular programming") is that it allows the application of the separation of concerns principle to system components, or "modules." Module details can be addressed in isolation; furthermore, module integration is treated as a separate concern that deals with the overall characteristics of software modules and their relationships.
## Origin
<style data-mw-deduplicate="TemplateStyles:r1244412712">.mw-parser-output .templatequote{overflow:hidden;margin:1em 0;padding:0 32px}.mw-parser-output .templatequotecite{line-height:1.5em;text-align:left;margin-top:0}@media(min-width:500px){.mw-parser-output .templatequotecite{padding-left:1.6em}}</style>
> Let me try to explain to you, what to my taste is characteristic for all intelligent thinking. It is, that one is willing to study in depth an aspect of one's subject matter in isolation for the sake of its own consistency, all the time knowing that one is occupying oneself only with one of the aspects. We know that a program must be correct and we can study it from that viewpoint only; we also know that it should be efficient and we can study its efficiency on another day, so to speak. In another mood we may ask ourselves whether, and if so: why, the program is desirable. But nothing is gained—on the contrary!—by tackling these various aspects simultaneously. It is what I sometimes have called "the separation of concerns", which, even if not perfectly possible, is yet the only available technique for effective ordering of one's thoughts, that I know of. This is what I mean by "focusing one's attention upon some aspect": it does not mean ignoring the other aspects, it is just doing justice to the fact that from this aspect's point of view, the other is irrelevant. It is being one- and multiple-track minded simultaneously.
> The programmer is having to do several things at the same time, namely,
>
> 1.  describe what is to be computed;
> 2.  organise the computation sequencing into small steps;
> 3.  organise memory management during the computation.
Reade continues to say,
> Ideally, the programmer should be able to concentrate on the first of the three tasks (describing what is to be computed) without being distracted by the other two, more administrative, tasks. Clearly, administration is important, but by separating it from the main task we are likely to get more reliable results and we can ease the programming problem by automating much of the administration.
>
> SoC has other advantages. For example, program proving becomes much more feasible when details of sequencing and memory management are absent from the program. Furthermore, descriptions of what is to be computed should be free of such detailed step-by-step descriptions of how to do it, if they are to be evaluated with different machine architectures. Sequences of small changes to a data object held in a store may be an inappropriate description of how to compute something when a highly parallel machine is being used with thousands of processors distributed throughout the machine and local rather than global storage facilities.
>
> Automating the administrative aspects means that the language implementor has to deal with them, but he/she has far more opportunity to make use of very different computation mechanisms with different machine architectures.
## Examples
### Internet protocol stack
SoC is crucial to the design of the Internet. In the [Internet protocol suite](/wiki/Internet_protocol_suite "Internet protocol suite"), great efforts have been made to separate concerns into well-defined [layers](/wiki/OSI_model "OSI model"). This allows protocol designers to focus on the concerns in one layer, and ignore the other layers. The Application Layer protocol [SMTP](/wiki/Simple_Mail_Transfer_Protocol "Simple Mail Transfer Protocol"), for example, is concerned about all the details of conducting an email session over a reliable transport service (usually [TCP](/wiki/Transmission_Control_Protocol "Transmission Control Protocol")), but not in the least concerned about how the transport service makes that service reliable. Similarly, TCP is not concerned about the routing of data packets, which is handled at the [Internet layer](/wiki/Internet_layer "Internet layer").
### <span id="HTML.2C_CSS.2C_JavaScript"></span>HTML, CSS, JavaScript
[HTML](/wiki/HTML "HTML"), [CSS](/wiki/CSS "CSS"), and [JavaScript](/wiki/JavaScript "JavaScript") are complementary languages used in the development of web pages and websites. HTML is mainly used for organization of webpage content, CSS is used for definition of content presentation style, and JavaScript defines how the content interacts and behaves with the user. Historically, this was not the case: prior to the introduction of CSS, HTML performed both duties of defining semantics and style.
### Subject-oriented programming
[Subject-oriented programming](/wiki/Subject-oriented_programming "Subject-oriented programming") allows separate concerns to be addressed as separate software constructs, each on an equal footing with the others. Each concern provides its own class-structure into which the objects in common are organized, and contributes state and methods to the composite result where they cut across one another. Correspondence rules describe how the classes and methods in the various concerns are related to each other at points where they interact, allowing composite behavior for a method to be derived from several concerns. [Multi-dimensional SoC](/wiki/Subject-oriented_programming#Multi-dimensional_separation_of_concerns "Subject-oriented programming") allows the analysis and composition of concerns to be manipulated as a multi-dimensional "matrix" in which each concern provides a dimension in which different points of choice are enumerated, with the cells of the matrix occupied by the appropriate software artifacts.
### Aspect-oriented programming
### Levels of analysis in artificial intelligence
## See also
<style data-mw-deduplicate="TemplateStyles:r1184024115">.mw-parser-output .div-col{margin-top:0.3em;column-width:30em}.mw-parser-output .div-col-small{font-size:90%}.mw-parser-output .div-col-rules{column-rule:1px solid #aaa}.mw-parser-output .div-col dl,.mw-parser-output .div-col ol,.mw-parser-output .div-col ul{margin-top:0}.mw-parser-output .div-col li,.mw-parser-output .div-col dd{page-break-inside:avoid;break-inside:avoid-column}</style>
- [Concern (computer science)](/wiki/Concern_(computer_science) "Concern (computer science)")
- [Holism](/wiki/Holism "Holism")
- [Modular design](/wiki/Modular_design "Modular design")
- [Modular programming](/wiki/Modular_programming "Modular programming")
- [Orthogonality § Computer science](/wiki/Orthogonality#Computer_science "Orthogonality")
- [Single-responsibility principle](/wiki/Single-responsibility_principle "Single-responsibility principle")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## External links
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
<tr>
<ul>
</ul>
</tr>
<tr>
specific<br />
language</a><br />
(DSL)</th>
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
of concerns</span></th>
<ul>
</ul>
</tr>
<tr>
</tr>
</tbody>
</table>
[Categories](/wiki/Help:Category "Help:Category"):
- [Programming principles](/wiki/Category:Programming_principles "Category:Programming principles")
- [Reductionism](/wiki/Category:Reductionism "Category:Reductionism")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [Webarchive template wayback links](/wiki/Category:Webarchive_template_wayback_links "Category:Webarchive template wayback links")
