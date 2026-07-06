Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Template_processor&oldid=1342559172 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Template_processor&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Template_processor&id=1342559172&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FTemplate_processor)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Template_processor&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Software using templates to produce documents
<figcaption>A diagram illustrating all of the basic elements and processing flow of a template engine.</figcaption>
</figure>
## Typical features
Template engines typically include features common to most [high-level programming languages](/wiki/High-level_programming_language "High-level programming language"), with an emphasis on features for processing [plain text](/wiki/Plain_text "Plain text").
Such features include:
- text replacement
- file inclusion (or [transclusion](/wiki/Transclusion "Transclusion"))
- conditional evaluation and [loops](/wiki/Control_flow#Loops "Control flow")
## Embedded template engines
While template processors are typically a separate piece of software, used as part of a system or framework, simple templating languages are commonly included in the string processing features of [general-purpose programming languages](/wiki/General-purpose_programming_language "General-purpose programming language"), and in text processing programs, notably [text editors](/wiki/Text_editor "Text editor") or [word processors](/wiki/Word_processor "Word processor"). The templating languages are generally simple substitution-only languages, in contrast to the more sophisticated facilities in full-blown template processors, but may contain some logic.
An illustrative example of the complementary nature of [parsing](/wiki/Parsing "Parsing") and templating is the `s` (substitute) command in the [sed](/wiki/Sed "Sed") text processor, originating from search-and-replace in the [ed](/wiki/Ed_(text_editor) "Ed (text editor)") text editor. Substitution commands are of the form `s/regexp/replacement/`, where `regexp` is a [regular expression](/wiki/Regular_expression "Regular expression"), for parsing input, and `replacement` is a simple template for output, either literal text, or a format string containing the characters `&` for "entire match" or the special [escape sequences](/wiki/Escape_sequence "Escape sequence") `\1` through `\9` for the *n*th sub-expression. For example, `s/(cat|dog)s?/\1s/g` replaces all occurrences of "cat" or "dog" with "cats" or "dogs", without duplicating an existing "s": `(cat|dog)` is the 1st (and only) sub-expression in the regexp, and `\1` in the format string substitutes this into the output.
## System elements
All template processing systems consist of at least these primary elements:
- an associated **data model**;
- one or more **source templates**;
- a processor or **template engine**;
- generated output in the form of **result documents**.
### Data model
### Source template
Source templates are traditionally specified:
- according to a pre-existing programming language;
- according to a specially defined template language;
- according to the features of a hosting software application; or
- according to a hybrid combination of some or all of the above.
### Template engine
The template engine is responsible for:
- connecting to the data model;
- processing the code specified in the source templates; and
- directing the output to a specific [pipeline](/wiki/Pipeline_(computing) "Pipeline (computing)"), [text file](/wiki/Text_file "Text file"), or [stream](/wiki/Stream_(computing) "Stream (computing)").
Additionally some template engines allow additional configuration options.
### Result documents
These may consist of an entire document or a document fragment.
## Uses
### Template engine
### Document generation
Document generation frameworks typically use template processing as the central model for generating documents.
### Source code generation
### Software functionality
A [web](/wiki/World_Wide_Web "World Wide Web") template engine processes web templates and source data (typically from a [relational database](/wiki/Relational_database "Relational database")) to produce one or more output [web pages](/wiki/Web_page "Web page") or page fragments. It is ordinarily included as a part of a [web template system](/wiki/Web_template_system "Web template system") or [application framework](/wiki/Application_framework "Application framework"). Currently, template processing software is most frequently used in the context of development for the [web](/wiki/World_Wide_Web "World Wide Web").
## Comparison
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
Further information: [Comparison of web template engines](/wiki/Comparison_of_web_template_engines "Comparison of web template engines")
## Benefits of using template engines
- encourages organization of source code into operationally-distinct layers (see e.g., [MVC](/wiki/Model%E2%80%93view%E2%80%93controller "Model–view–controller"))
- enhances productivity by reducing unnecessary reproduction of effort
- enhances teamwork by allowing separation of work based on skill-set (e.g., artistic vs. technical)
## See also
- [Document automation](/wiki/Document_automation "Document automation")
- [Glossary of operating systems terms § Templating](/wiki/Glossary_of_operating_systems_terms#Templating "Glossary of operating systems terms")
- [Internationalization and localization](/wiki/Internationalization_and_localization "Internationalization and localization")
  - [Common Locale Data Repository](/wiki/Common_Locale_Data_Repository "Common Locale Data Repository")
  - [gettext](/wiki/Gettext "Gettext")
- [Macro (computer science)](/wiki/Macro_(computer_science) "Macro (computer science)")
- [Web template system](/wiki/Web_template_system "Web template system")
  - [Comparison of web template engines](/wiki/Comparison_of_web_template_engines "Comparison of web template engines")
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
of concerns</a></th>
<ul>
</ul>
</tr>
<tr>
</tr>
</tbody>
</table>
[Categories](/wiki/Help:Category "Help:Category"):
- [Scripting languages](/wiki/Category:Scripting_languages "Category:Scripting languages")
- [Template engines](/wiki/Category:Template_engines "Category:Template engines")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
