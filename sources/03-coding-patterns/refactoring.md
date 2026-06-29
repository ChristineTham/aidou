Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Code_refactoring&oldid=1354363287 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Code_refactoring&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Code_refactoring&id=1354363287&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FCode_refactoring)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Code_refactoring&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Restructuring existing computer code without changing its external behavior
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
"Refactoring" redirects here. For its use on Wikipedia, see [Wikipedia:Refactoring talk pages](/wiki/Wikipedia:Refactoring_talk_pages "Wikipedia:Refactoring talk pages").
This article is about a behaviour-preserving change; not to be confused with [Rewrite (programming)](/wiki/Rewrite_(programming) "Rewrite (programming)").
<style data-mw-deduplicate="TemplateStyles:r1244412712">.mw-parser-output .templatequote{overflow:hidden;margin:1em 0;padding:0 32px}.mw-parser-output .templatequotecite{line-height:1.5em;text-align:left;margin-top:0}@media(min-width:500px){.mw-parser-output .templatequotecite{padding-left:1.6em}}</style>
> By continuously improving the design of code, we make it easier and easier to work with. This is in sharp contrast to what typically happens: little refactoring and a great deal of attention paid to expediently add new features. If you get into the hygienic habit of refactoring continuously, you'll find that it is easier to extend and maintain code.
## Motivation
## Benefits
There are two general categories of benefits to the activity of refactoring.
## Timing and responsibility
There are two possible times for refactoring.
## Challenges
## Testing
## Techniques
### Static analysis
[Static program analysis](/wiki/Static_program_analysis "Static program analysis") (called "linting" when performed on less strict interpreted languages) detects problems in a valid but substandard program.
- [Software intelligence](/wiki/Software_intelligence "Software intelligence") - reverse engineers the initial state to understand existing intra-application dependencies
### Transformations
Transformations modify the syntactic representation of a program. Some modifications alter the semantics or structure of the program in a way that improves its flexibility or robustness. Such modifications require knowledge of the problem domain and intended logic, and thus are infeasible to automate. Modifications exist that make the program easier to read and modify, but which do not alter the underlying logic of the program; these transformations can be automated.
- Techniques that allow for more [abstraction](/wiki/Abstraction_(computer_science) "Abstraction (computer science)")
  - [Encapsulate field](/wiki/Field_encapsulation "Field encapsulation") – force code to access the field with getter and setter methods
  - [Generalize type](/wiki/Type_generalization "Type generalization") – create more general types to allow for more code sharing
- Techniques for breaking code apart into more logical pieces
  - Componentization breaks code down into reusable semantic units that present clear, well-defined, simple-to-use interfaces.
- Techniques for improving names and location of code
  - Move method or move field – move to a more appropriate [class](/wiki/Class_(programming) "Class (programming)") or source file
  - Rename method or rename field – changing the name into a new one that better reveals its purpose
## Hardware refactoring
## History
[Martin Fowler](/wiki/Martin_Fowler_(software_engineer) "Martin Fowler (software engineer)")'s book *Refactoring: Improving the Design of Existing Code* is the canonical reference. <sup>\[*[<span title="The material near this tag may use weasel words or too-vague attribution. (July 2018)">according to whom?</span>](/wiki/Wikipedia:Manual_of_Style/Words_to_watch#Unsupported_attributions "Wikipedia:Manual of Style/Words to watch")*\]</sup>
## Tools
<style data-mw-deduplicate="TemplateStyles:r1360160623">.mw-parser-output .ambox{border:1px solid #a2a9b1;border-left:10px solid #36c;background-color:#fbfbfb;box-sizing:border-box}.mw-parser-output .ambox+link+.ambox,.mw-parser-output .ambox+link+style+.ambox,.mw-parser-output .ambox+link+link+.ambox,.mw-parser-output .ambox+.mw-empty-elt+link+.ambox,.mw-parser-output .ambox+.mw-empty-elt+link+style+.ambox,.mw-parser-output .ambox+.mw-empty-elt+link+link+.ambox,.mw-parser-output .ambox+.mw-empty-elt+.ambox,.mw-parser-output .ambox+.mw-empty-elt+.mw-empty-elt+.ambox,.mw-parser-output .ambox+.mw-empty-elt+.mw-empty-elt+.mw-empty-elt+.ambox{margin-top:-1px}html body.mediawiki .mw-parser-output .ambox.mbox-small-left{margin:4px 1em 4px 0;overflow:hidden;width:238px;border-collapse:collapse;font-size:88%;line-height:1.25em}.mw-parser-output .ambox-speedy{border-left:10px solid #b32424;background-color:#fee7e6}.mw-parser-output .ambox-delete{border-left:10px solid #b32424}.mw-parser-output .ambox-content{border-left:10px solid #f28500}.mw-parser-output .ambox-style{border-left:10px solid #fc3}.mw-parser-output .ambox-move{border-left:10px solid #9932cc}.mw-parser-output .ambox-protection{border-left:10px solid #a2a9b1}.mw-parser-output .ambox .mbox-text{border:none;padding:0.25em 0.5em;width:100%}.mw-parser-output .ambox .mbox-image{border:none;padding:2px 0 2px 0.5em;text-align:center}.mw-parser-output .ambox .mbox-imageright{border:none;padding:2px 0.5em 2px 0;text-align:center}.mw-parser-output .ambox .mbox-empty-cell{border:none;padding:0;width:1px}.mw-parser-output .ambox .mbox-image-div{width:52px}@media(min-width:720px){.mw-parser-output .ambox{margin:0 10%}}@media print{body.ns-0 .mw-parser-output .ambox{display:none!important}}</style>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
</tr>
</tbody>
</table>
[Android Studio](/wiki/Android_Studio "Android Studio")  
Supports refactoring Java and C++.
Supports refactoring [Objective-C](/wiki/Objective-C "Objective-C"), C and C++.
[Delphi](/wiki/Delphi_(software) "Delphi (software)")  
Supports refactoring [Object Pascal](/wiki/Object_Pascal "Object Pascal").
[DMS Software Reengineering Toolkit](/wiki/DMS_Software_Reengineering_Toolkit "DMS Software Reengineering Toolkit")  
Supports large-scale refactoring for [C](/wiki/C_(programming_language) "C (programming language)"), [C++](/wiki/C%2B%2B "C++"), [C#](/wiki/C_Sharp_(programming_language) "C Sharp (programming language)"), [COBOL](/wiki/COBOL "COBOL"), [Java](/wiki/Java_(programming_language) "Java (programming language)"), [PHP](/wiki/PHP "PHP") and other languages.
[Eclipse](/wiki/Eclipse_(software) "Eclipse (software)")  
Via plugins, supports refactoring Java and to a lesser extent C++, PHP, [Ruby](/wiki/Ruby_(programming_language) "Ruby (programming language)") and [JavaScript](/wiki/JavaScript "JavaScript")
[IntelliJ IDEA](/wiki/IntelliJ_IDEA "IntelliJ IDEA")  
Supports refactoring Java.
[JDeveloper](/wiki/JDeveloper "JDeveloper")  
Supports refactoring Java.
[NetBeans](/wiki/NetBeans "NetBeans")  
Supports refactoring Java.
Supports refactoring PHP.
[PyCharm](/wiki/PyCharm "PyCharm")  
Supports refactoring Python.
[PyDev](/wiki/PyDev "PyDev")  
Supports refactoring [Python](/wiki/Python_(programming_language) "Python (programming language)").
[Smalltalk](/wiki/Smalltalk "Smalltalk")  
Most dialects include powerful refactoring tools. Many use the original refactoring browser produced in the early '90s by [Ralph Johnson](/wiki/Ralph_Johnson_(computer_scientist) "Ralph Johnson (computer scientist)").
[Visual Assist](/wiki/Visual_Assist "Visual Assist")  
Supports refactoring C# and C++.
[Visual Studio](/wiki/Visual_Studio "Visual Studio")  
Supports refactoring [.NET](/wiki/.NET ".NET") and C++.
[Visual Studio Code](/wiki/Visual_Studio_Code "Visual Studio Code")  
Supports refactoring many languages via plugins
Supports refactoring JavaScript.
[Wing IDE](/wiki/Wing_IDE "Wing IDE")  
Supports refactoring Python.
[Xcode](/wiki/Xcode "Xcode")  
[Qt Creator](/wiki/Qt_Creator "Qt Creator")  
## See also
- [Code review](/wiki/Code_review "Code review")
- [Database refactoring](/wiki/Database_refactoring "Database refactoring")
- [Decomposition (computer science)](/wiki/Decomposition_(computer_science) "Decomposition (computer science)")
- [Modular programming](/wiki/Modular_programming "Modular programming")
- [Prefactoring](/wiki/Prefactoring "Prefactoring")
- [Rewrite (programming)](/wiki/Rewrite_(programming) "Rewrite (programming)")
- [Separation of concerns](/wiki/Separation_of_concerns "Separation of concerns")
- [Software peer review](/wiki/Software_peer_review "Software peer review")
- [Test-driven development](/wiki/Test-driven_development "Test-driven development")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## Further reading
## External links
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
</tr>
&#10;<tr>
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
- [Code refactoring](/wiki/Category:Code_refactoring "Category:Code refactoring")
- [Extreme programming](/wiki/Category:Extreme_programming "Category:Extreme programming")
- [Technology neologisms](/wiki/Category:Technology_neologisms "Category:Technology neologisms")
Hidden categories:
- [Webarchive template wayback links](/wiki/Category:Webarchive_template_wayback_links "Category:Webarchive template wayback links")
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [Wikipedia articles needing page number citations from July 2018](/wiki/Category:Wikipedia_articles_needing_page_number_citations_from_July_2018 "Category:Wikipedia articles needing page number citations from July 2018")
- [All articles with specifically marked weasel-worded phrases](/wiki/Category:All_articles_with_specifically_marked_weasel-worded_phrases "Category:All articles with specifically marked weasel-worded phrases")
- [Articles with specifically marked weasel-worded phrases from July 2018](/wiki/Category:Articles_with_specifically_marked_weasel-worded_phrases_from_July_2018 "Category:Articles with specifically marked weasel-worded phrases from July 2018")
- [Articles needing additional references from July 2018](/wiki/Category:Articles_needing_additional_references_from_July_2018 "Category:Articles needing additional references from July 2018")
- [All articles needing additional references](/wiki/Category:All_articles_needing_additional_references "Category:All articles needing additional references")
