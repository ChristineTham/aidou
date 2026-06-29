Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Software_architecture&oldid=1361524825 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Software_architecture&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Software_architecture&id=1361524825&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSoftware_architecture)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Software_architecture&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
High level structures of a software system
<figcaption>Linux architecture diagram</figcaption>
</figure>
<style data-mw-deduplicate="TemplateStyles:r1333133064">.mw-parser-output .hlist dl,.mw-parser-output .hlist ol,.mw-parser-output .hlist ul{margin:0;padding:0}.mw-parser-output .hlist dd,.mw-parser-output .hlist dt,.mw-parser-output .hlist li{margin:0;display:inline}.mw-parser-output .hlist.inline,.mw-parser-output .hlist.inline dl,.mw-parser-output .hlist.inline ol,.mw-parser-output .hlist.inline ul,.mw-parser-output .hlist dl dl,.mw-parser-output .hlist dl ol,.mw-parser-output .hlist dl ul,.mw-parser-output .hlist ol dl,.mw-parser-output .hlist ol ol,.mw-parser-output .hlist ol ul,.mw-parser-output .hlist ul dl,.mw-parser-output .hlist ul ol,.mw-parser-output .hlist ul ul{display:inline}.mw-parser-output .hlist .mw-empty-li{display:none}.mw-parser-output .hlist dt::after{content:": "}.mw-parser-output .hlist dd::after,.mw-parser-output .hlist li::after{content:"\a0 · ";font-weight:bold}.mw-parser-output .hlist dd:last-child::after,.mw-parser-output .hlist dt:last-child::after,.mw-parser-output .hlist li:last-child::after{content:none}.mw-parser-output .hlist dd dd:first-child::before,.mw-parser-output .hlist dd dt:first-child::before,.mw-parser-output .hlist dd li:first-child::before,.mw-parser-output .hlist dt dd:first-child::before,.mw-parser-output .hlist dt dt:first-child::before,.mw-parser-output .hlist dt li:first-child::before,.mw-parser-output .hlist li dd:first-child::before,.mw-parser-output .hlist li dt:first-child::before,.mw-parser-output .hlist li li:first-child::before{content:" (";font-weight:normal}.mw-parser-output .hlist dd dd:last-child::after,.mw-parser-output .hlist dd dt:last-child::after,.mw-parser-output .hlist dd li:last-child::after,.mw-parser-output .hlist dt dd:last-child::after,.mw-parser-output .hlist dt dt:last-child::after,.mw-parser-output .hlist dt li:last-child::after,.mw-parser-output .hlist li dd:last-child::after,.mw-parser-output .hlist li dt:last-child::after,.mw-parser-output .hlist li li:last-child::after{content:")";font-weight:normal}.mw-parser-output .hlist ol{counter-reset:listitem}.mw-parser-output .hlist ol>li{counter-increment:listitem}.mw-parser-output .hlist ol>li::before{content:" "counter(listitem)"\a0 "}.mw-parser-output .hlist dd ol>li:first-child::before,.mw-parser-output .hlist dt ol>li:first-child::before,.mw-parser-output .hlist li ol>li:first-child::before{content:" ("counter(listitem)"\a0 "}</style><style data-mw-deduplicate="TemplateStyles:r1246091330">.mw-parser-output .sidebar{width:22em;float:right;clear:right;margin:0.5em 0 1em 1em;background:var(--background-color-neutral-subtle,#f8f9fa);border:1px solid var(--border-color-base,#a2a9b1);padding:0.2em;text-align:center;line-height:1.4em;font-size:88%;border-collapse:collapse;display:table}body.skin-minerva .mw-parser-output .sidebar{display:table!important;float:right!important;margin:0.5em 0 1em 1em!important}.mw-parser-output .sidebar-subgroup{width:100%;margin:0;border-spacing:0}.mw-parser-output .sidebar-left{float:left;clear:left;margin:0.5em 1em 1em 0}.mw-parser-output .sidebar-none{float:none;clear:both;margin:0.5em 1em 1em 0}.mw-parser-output .sidebar-outer-title{padding:0 0.4em 0.2em;font-size:125%;line-height:1.2em;font-weight:bold}.mw-parser-output .sidebar-top-image{padding:0.4em}.mw-parser-output .sidebar-top-caption,.mw-parser-output .sidebar-pretitle-with-top-image,.mw-parser-output .sidebar-caption{padding:0.2em 0.4em 0;line-height:1.2em}.mw-parser-output .sidebar-pretitle{padding:0.4em 0.4em 0;line-height:1.2em}.mw-parser-output .sidebar-title,.mw-parser-output .sidebar-title-with-pretitle{padding:0.2em 0.8em;font-size:145%;line-height:1.2em}.mw-parser-output .sidebar-title-with-pretitle{padding:0.1em 0.4em}.mw-parser-output .sidebar-image{padding:0.2em 0.4em 0.4em}.mw-parser-output .sidebar-heading{padding:0.1em 0.4em}.mw-parser-output .sidebar-content{padding:0 0.5em 0.4em}.mw-parser-output .sidebar-content-with-subgroup{padding:0.1em 0.4em 0.2em}.mw-parser-output .sidebar-above,.mw-parser-output .sidebar-below{padding:0.3em 0.8em;font-weight:bold}.mw-parser-output .sidebar-collapse .sidebar-above,.mw-parser-output .sidebar-collapse .sidebar-below{border-top:1px solid #aaa;border-bottom:1px solid #aaa}.mw-parser-output .sidebar-navbar{text-align:right;font-size:115%;padding:0 0.4em 0.4em}.mw-parser-output .sidebar-list-title{padding:0 0.4em;text-align:left;font-weight:bold;line-height:1.6em;font-size:105%}.mw-parser-output .sidebar-list-title-c{padding:0 0.4em;text-align:center;margin:0 3.3em}@media(max-width:640px){body.mediawiki .mw-parser-output .sidebar{width:100%!important;clear:both;float:none!important;margin-left:0!important;margin-right:0!important}}body.skin--responsive .mw-parser-output .sidebar a>img{max-width:none!important}@media screen{html.skin-theme-clientpref-night .mw-parser-output .sidebar:not(.notheme) .sidebar-list-title,html.skin-theme-clientpref-night .mw-parser-output .sidebar:not(.notheme) .sidebar-title-with-pretitle{background:transparent!important}html.skin-theme-clientpref-night .mw-parser-output .sidebar:not(.notheme) .sidebar-title-with-pretitle a{color:var(--color-progressive)!important}}@media screen and (prefers-color-scheme:dark){html.skin-theme-clientpref-os .mw-parser-output .sidebar:not(.notheme) .sidebar-list-title,html.skin-theme-clientpref-os .mw-parser-output .sidebar:not(.notheme) .sidebar-title-with-pretitle{background:transparent!important}html.skin-theme-clientpref-os .mw-parser-output .sidebar:not(.notheme) .sidebar-title-with-pretitle a{color:var(--color-progressive)!important}}@media print{body.ns-0 .mw-parser-output .sidebar{display:none!important}}</style>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr>
</tr>
<tr>
</tr>
<tr>
Core activities
<ul>
</ul>
</tr>
<tr>
Paradigms, models
<ul>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
<tr>
Supporting disciplines
<ul>
</ul>
</tr>
<tr>
Practices
<ul>
</ul>
</tr>
<tr>
<ul>
</ul>
</tr>
<tr>
Standards, bodies of knowledge
<ul>
</ul>
</tr>
<tr>
Glossaries
<ul>
</ul>
</tr>
<tr>
Outlines
<ul>
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
1.  Everything is a trade-off
2.  "Why is more important than how"
<figcaption>Software architecture activities</figcaption>
</figure>
## Scope
## Patterns and styles
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
Main listing: [List of software architecture styles and patterns](/wiki/List_of_software_architecture_styles_and_patterns "List of software architecture styles and patterns")
"Architectural pattern" redirects here; not to be confused with [Pattern (architecture)](/wiki/Pattern_(architecture) "Pattern (architecture)").
<figcaption>Model-View-Controller Pattern</figcaption>
</figure>
## Anti-patterns
## Characteristics
Software architecture exhibits the following:
## Motivation
## History
While in IEEE 1471, software architecture was about the architecture of "software-intensive systems", defined as "any system where software contributes essential influences to the design, construction, deployment, and evolution of the system as a whole", the 2011 edition goes a step further by including the [ISO/IEC 15288](/wiki/ISO/IEC_15288 "ISO/IEC 15288") and [ISO/IEC 12207](/wiki/ISO/IEC_12207 "ISO/IEC 12207") definitions of a system, which embrace not only hardware and software, but also "humans, processes, procedures, facilities, materials and naturally occurring entities". This reflects the relationship between software architecture, [enterprise architecture](/wiki/Enterprise_architecture "Enterprise architecture") and [solution architecture](/wiki/Solution_architecture "Solution architecture").
## Architecture activities
- Having a high [customer satisfactions](/wiki/Customer_satisfaction "Customer satisfaction") requires availability, fault tolerance, security, testability, recoverability, agility and performance in the system.
- Doing [mergers and acquisitions](/wiki/Mergers_and_acquisitions "Mergers and acquisitions") (M&A) requires extensibility, scalability, adaptability, and interoperability
- Constrained budget and time requires feasibility and simplicity
- Faster [time-to-market](/wiki/Time_to_market "Time to market") requires maintainability, testability and deployability.
**Architectural analysis** is the process of understanding the environment in which a proposed system will operate and determining the requirements for the system. The input or requirements to the analysis activity can come from any number of stakeholders and include items such as:
- what the system will do when operational (the functional requirements)
**Architecture evolution** is the process of maintaining and adapting an existing software architecture to meet changes in requirements and environment. As software architecture provides a fundamental structure of a software system, its evolution and maintenance would necessarily impact its fundamental structure. As such, architecture evolution is concerned with adding new functionality as well as maintaining existing functionality and system behavior.
Architecture requires critical supporting activities. These supporting activities take place throughout the core software architecture process. They include knowledge management and communication, design reasoning and decision-making, and documentation.
### Architecture supporting activities
Software architecture supporting activities are carried out during core software architecture activities. These supporting activities assist a software architect to carry out analysis, synthesis, evaluation, and evolution. For instance, an architect has to gather knowledge, make decisions, and document during the analysis phase.
## Software Architecture Design Strategies
- A high-level partitioning strategy is established, often categorized as technical or domain-based. Guidelines for the smallest meaningful deployable unit, referred to as "quanta," are defined. While these foundational decisions are made early, they may be revisited later in the cycle if necessary.
- Initial components are identified based on the established strategy.
- Requirements are assigned to the identified components.
- The roles and responsibilities of each component are analyzed to ensure clarity and minimize overlap.
- Architectural characteristics, such as scalability, fault tolerance, and maintainability, are evaluated.
- Components may be restructured based on feedback from development teams.
This cycle serves as a general framework and can be adapted to different domains.
## Software architecture topics
### Software architecture and agile development
### Software architecture erosion
### Software architecture recovery
Main article: [Software architecture recovery](/wiki/Software_architecture_recovery "Software architecture recovery")
## Related fields
### Design
Main article: [Software design](/wiki/Software_design "Software design")
### Requirements engineering
Main article: [Requirements engineering](/wiki/Requirements_engineering "Requirements engineering")
### <span id="Other_types_of_.27architecture.27"></span>Other types of 'architecture'
Main articles: [Computer architecture](/wiki/Computer_architecture "Computer architecture"), [Systems architecture](/wiki/Systems_architecture "Systems architecture"), and [Enterprise architecture](/wiki/Enterprise_architecture "Enterprise architecture")
Computer architecture  
[Computer architecture](/wiki/Computer_architecture "Computer architecture") targets the internal structure of a computer system, in terms of collaborating hardware components such as the [CPU](/wiki/Central_processing_unit "Central processing unit") – or processor – the [bus](/wiki/Bus_(computing) "Bus (computing)") and the [memory](/wiki/Computer_memory "Computer memory").
<!-- -->
Serverless architecture  
<!-- -->
Systems architecture  
The term [systems architecture](/wiki/Systems_architecture "Systems architecture") has originally been applied to the architecture of [systems](/wiki/System "System") that consist of both hardware and [software](/wiki/Software "Software"). The main concern addressed by the systems architecture is then the integration of software and hardware in a complete, correctly working device. In another common – much broader – meaning, the term applies to the architecture of any complex system which may be of a technical, [sociotechnical](/wiki/Sociotechnical_system "Sociotechnical system") or social nature.
<!-- -->
Enterprise architecture  
The goal of [enterprise architecture](/wiki/Enterprise_architecture "Enterprise architecture") is to "translate business vision and strategy into effective enterprise". Enterprise architecture [frameworks](/wiki/Architecture_framework "Architecture framework"), such as [TOGAF](/wiki/TOGAF "TOGAF") and the [Zachman Framework](/wiki/Zachman_Framework "Zachman Framework"), usually distinguish between different enterprise architecture layers. Although terminology differs from framework to framework, many include at least a distinction between a *[business](/wiki/Business "Business") layer*, an *[application](/wiki/Application_software "Application software")* (or *[information](/wiki/Information "Information")*) *layer*, and a *[technology](/wiki/Technology "Technology") layer*. Enterprise architecture addresses among others the alignment between these layers, usually in a top-down approach.
## See also
<style data-mw-deduplicate="TemplateStyles:r1184024115">.mw-parser-output .div-col{margin-top:0.3em;column-width:30em}.mw-parser-output .div-col-small{font-size:90%}.mw-parser-output .div-col-rules{column-rule:1px solid #aaa}.mw-parser-output .div-col dl,.mw-parser-output .div-col ol,.mw-parser-output .div-col ul{margin-top:0}.mw-parser-output .div-col li,.mw-parser-output .div-col dd{page-break-inside:avoid;break-inside:avoid-column}</style>
- [ArchiMate](/wiki/ArchiMate "ArchiMate")
- [Architecture description language](/wiki/Architecture_description_language "Architecture description language")
- [Architecture framework](/wiki/Architecture_framework "Architecture framework")
- [Architectural style](/wiki/Architectural_style "Architectural style")
- [Anti-pattern](/wiki/Anti-pattern "Anti-pattern")
- [Attribute-driven design](/wiki/Attribute-driven_design "Attribute-driven design")
- [Computer architecture](/wiki/Computer_architecture "Computer architecture")
- [Distributed Data Management Architecture](/wiki/Distributed_Data_Management_Architecture "Distributed Data Management Architecture")
- [Distributed Relational Database Architecture](/wiki/DRDA "DRDA")
- [Systems architecture](/wiki/Systems_architecture "Systems architecture")
- [Systems design](/wiki/Systems_design "Systems design")
- [List of software architecture styles and patterns](/wiki/List_of_software_architecture_styles_and_patterns "List of software architecture styles and patterns")
- [Software architecture description](/wiki/Software_architecture_description "Software architecture description")
- [View model](/wiki/View_model "View model")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## Further reading
- Magee, J., Dulay, N., Eisenbach, S., & [Kramer, J.](/wiki/Jeff_Kramer_(academic) "Jeff Kramer (academic)") (1995, September). Specifying distributed software architectures. In European software engineering conference (pp. 137-153). Berlin, Heidelberg: Springer Berlin Heidelberg.
## External links
<style data-mw-deduplicate="TemplateStyles:r1314755338">.mw-parser-output .side-box{margin:4px 0;box-sizing:border-box;border:1px solid #aaa;font-size:88%;line-height:1.25em;background-color:var(--background-color-interactive-subtle,#f8f9fa);color:inherit;display:flow-root}.mw-parser-output .infobox .side-box{font-size:100%}.mw-parser-output .side-box-abovebelow,.mw-parser-output .side-box-text{padding:0.25em 0.9em}.mw-parser-output .side-box-image{padding:2px 0 2px 0.9em;text-align:center}.mw-parser-output .side-box-imageright{padding:2px 0.9em 2px 0;text-align:center}@media(min-width:500px){.mw-parser-output .side-box-flex{display:flex;align-items:center}.mw-parser-output .side-box-text{flex:1;min-width:0}}@media(min-width:640px){.mw-parser-output .side-box{width:238px}.mw-parser-output .side-box-right{clear:right;float:right;margin-left:1em}.mw-parser-output .side-box-left{margin-right:1em}}</style><style data-mw-deduplicate="TemplateStyles:r1311551236">@media print{body.ns-0 .mw-parser-output .sistersitebox{display:none!important}}@media screen{html.skin-theme-clientpref-night .mw-parser-output .sistersitebox img[src*="Wiktionary-logo-en-v2.svg"]{filter:invert(1)brightness(55%)contrast(250%)hue-rotate(180deg)}}@media screen and (prefers-color-scheme:dark){html.skin-theme-clientpref-os .mw-parser-output .sistersitebox img[src*="Wiktionary-logo-en-v2.svg"]{filter:invert(1)brightness(55%)contrast(250%)hue-rotate(180deg)}}</style>
<style data-mw-deduplicate="TemplateStyles:r1353707246">.mw-parser-output .navbox{box-sizing:border-box;border:1px solid #a2a9b1;width:100%;clear:both;font-size:88%;text-align:center;padding:1px;margin:1em auto 0}.mw-parser-output .navbox .navbox{margin-top:0}.mw-parser-output .navbox+.navbox-styles+.navbox,.mw-parser-output .navbox+span.mw-empty-elt+.navbox-styles+.navbox{margin-top:-1px}.mw-parser-output .navbox-inner,.mw-parser-output .navbox-subgroup{width:100%}.mw-parser-output .navbox-group,.mw-parser-output .navbox-title,.mw-parser-output .navbox-abovebelow{padding:0.25em 1em;line-height:1.5em;text-align:center}.mw-parser-output .navbox-group{white-space:nowrap;text-align:right}.mw-parser-output .navbox,.mw-parser-output .navbox-subgroup{background-color:#fdfdfd;color:inherit}.mw-parser-output .navbox-list{line-height:1.5em;border-color:#fdfdfd}.mw-parser-output .navbox-list-with-group{text-align:left;border-left-width:2px;border-left-style:solid}.mw-parser-output tr+tr>.navbox-abovebelow,.mw-parser-output tr+tr>.navbox-group,.mw-parser-output tr+tr>.navbox-image,.mw-parser-output tr+tr>.navbox-list{border-top:2px solid #fdfdfd}.mw-parser-output .navbox-title{background-color:#ccf;color:inherit}.mw-parser-output .navbox-abovebelow,.mw-parser-output .navbox-group,.mw-parser-output .navbox-subgroup .navbox-title{background-color:#ddf;color:inherit}.mw-parser-output .navbox-subgroup .navbox-group,.mw-parser-output .navbox-subgroup .navbox-abovebelow{background-color:#e6e6ff;color:inherit}.mw-parser-output .navbox-even{background-color:#f7f7f7;color:inherit}.mw-parser-output .navbox-odd{background-color:transparent;color:inherit}.mw-parser-output .navbox .hlist td dl,.mw-parser-output .navbox .hlist td ol,.mw-parser-output .navbox .hlist td ul,.mw-parser-output .navbox td.hlist dl,.mw-parser-output .navbox td.hlist ol,.mw-parser-output .navbox td.hlist ul{padding:0.125em 0}.mw-parser-output .navbox .navbar{display:block;font-size:100%}.mw-parser-output .navbox-title .navbar{float:left;text-align:left;margin-right:0.5em}body.skin--responsive .mw-parser-output .navbox-image img{max-width:none!important}@media print{body.ns-0 .mw-parser-output .navbox{display:none!important}}</style>
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
[Category](/wiki/Help:Category "Help:Category"):
- [Software architecture](/wiki/Category:Software_architecture "Category:Software architecture")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [All articles lacking reliable references](/wiki/Category:All_articles_lacking_reliable_references "Category:All articles lacking reliable references")
- [Articles lacking reliable references from November 2023](/wiki/Category:Articles_lacking_reliable_references_from_November_2023 "Category:Articles lacking reliable references from November 2023")
- [All articles with dead external links](/wiki/Category:All_articles_with_dead_external_links "Category:All articles with dead external links")
- [Articles with dead external links from May 2026](/wiki/Category:Articles_with_dead_external_links_from_May_2026 "Category:Articles with dead external links from May 2026")
- [Commons category link from Wikidata](/wiki/Category:Commons_category_link_from_Wikidata "Category:Commons category link from Wikidata")
- [Webarchive template wayback links](/wiki/Category:Webarchive_template_wayback_links "Category:Webarchive template wayback links")
