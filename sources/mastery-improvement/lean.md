Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Lean_software_development&oldid=1328904097 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Lean_software_development&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Lean_software_development&id=1328904097&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FLean_software_development)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Lean_software_development&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Use of lean manufacturing principles in software development
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
Not to be confused with [Lean (proof assistant)](/wiki/Lean_(proof_assistant) "Lean (proof assistant)").
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
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
</tr>
</tbody>
</table>
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
## Origin
## Lean principles
1.  [Eliminate waste](#Eliminate_waste)
2.  [Amplify learning](#Amplify_learning)
3.  [Decide as late as possible](#Decide_as_late_as_possible)
4.  [Deliver as fast as possible](#Deliver_as_fast_as_possible)
5.  [Empower the team](#Empower_the_team)
6.  [Build integrity in](#Build_integrity_in)
7.  [Optimize the whole](#Optimize_the_whole)
### Eliminate waste
|  |  |
|----|----|
| The Seven Wastes of Manufacturing | The Seven Wastes of Software Development |
| Inventory | Partially done work |
| Extra Processing | Extra Processes |
| Overproduction | [Extra features](/wiki/Software_bloat "Software bloat") |
| Transportation | [Task switching](/wiki/Task_switching_(psychology) "Task switching (psychology)") |
| Waiting | Waiting |
| Motion | Motion (hand offs) |
| [Defects](/wiki/Software_bug "Software bug") | [Defects](/wiki/Software_bug "Software bug") |
The Seven Wastes {.wikitable}
In order to eliminate waste, one should be able to recognize it. If some activity could be bypassed or the result could be achieved without it, it is waste. Partially done coding eventually abandoned during the [development process](/wiki/Software_development_process "Software development process") is waste. Extra features like paperwork and features not often used by customers are waste. Switching people between tasks is waste (because of time spent, and often lost, by people involved in context-switching). Waiting for other activities, teams, processes is waste. Relearning requirements to complete work is waste. Defects and lower quality are waste. Managerial overhead not producing real value is waste.
### Amplify learning
Software development is a continuous learning process based on iterations when writing code. [Software design](/wiki/Software_design "Software design") is a problem-solving process involving the developers writing the code and what they have learned. Software value is measured in fitness for use and not in conformance to requirements.
Instead of adding more documentation or detailed planning, different ideas could be tried by writing code and building. The process of user requirements gathering could be simplified by presenting screens to the end-users and getting their input. The accumulation of defects should be prevented by running tests as soon as the code is written.
The learning process is sped up by usage of short iteration cycles – each one coupled with refactoring and [integration testing](/wiki/Integration_testing "Integration testing"). Increasing feedback via short feedback sessions with customers helps when determining the current phase of development and adjusting efforts for future improvements. During those short sessions, both [customer representatives](/wiki/Customer_representative "Customer representative") and the development team learn more about the domain problem and figure out possible solutions for further development. Thus the customers better understand their needs, based on the existing result of development efforts, and the developers learn how to better satisfy those needs. Another idea in the communication and learning process with a customer is set-based development – this concentrates on communicating the constraints of the future solution and not the possible solutions, thus promoting the birth of the solution via dialogue with the customer.<sup>\[*[<span title="The material near this tag may be using jargon that limits the article's accessibility. (June 2018)">jargon</span>](/wiki/Wikipedia:Manual_of_Style#Technical_language "Wikipedia:Manual of Style")*\]</sup>
### Decide as late as possible
As [software development](/wiki/Software_development "Software development") is always associated with some uncertainty, better results should be achieved with a *set-based* or *options-based* approach, delaying decisions as much as possible until they can be made based on facts and not on uncertain assumptions and predictions. The more complex a system is, the more capacity for change should be built into it, thus enabling the delay of important and crucial commitments. The iterative approach promotes this principle – the ability to adapt to changes and correct mistakes, which might be very costly if discovered after the release of the system.
With set-based development: If a new brake system is needed for a car, for example, three teams may design solutions to the same problem. Each team learns about the problem space and designs a potential solution. As a solution is deemed unreasonable, it is cut. At the end of a period, the surviving designs are compared and one is chosen, perhaps with some modifications based on learning from the others - a great example of deferring commitment until the last possible moment. Software decisions could also benefit from this practice to minimize the risk brought on by big up-front design. Additionally, there would then be multiple implementations that work correctly, yet are different (implementation-wise, internally). These could be used to implement fault-tolerant systems which check all inputs and outputs for correctness, across the multiple implementations, simultaneously.
An [agile software development](/wiki/Agile_software_development "Agile software development") approach can move the building of options earlier for customers, thus delaying certain crucial decisions until customers have realized their needs better. This also allows later adaptation to changes and the prevention of costly earlier technology-bounded decisions. This does not mean that no planning should be involved – on the contrary, planning activities should be concentrated on the different options and adapting to the current situation, as well as clarifying confusing situations by establishing patterns for rapid action. Evaluating different options is effective as soon as it is realized that they are not free, but provide the needed flexibility for late decision making.
### Deliver as fast as possible
In the era of rapid technology evolution, it is not the biggest that survives, but the fastest. The sooner the end product is delivered without major defects, the sooner feedback can be received, and incorporated into the next [iteration](/wiki/Iteration "Iteration"). The shorter the iterations, the better the learning and communication within the team. With speed, decisions can be delayed. Speed assures the fulfilling of the customer's present needs and not what they required yesterday. This gives them the opportunity to delay making up their minds about what they really require until they gain better knowledge. Customers value rapid delivery of a [quality](/wiki/Quality_(business) "Quality (business)") product.
The myth underlying this principle is *haste makes waste*. However, lean implementation has shown that it is a good practice to deliver fast in order to see and analyze the output as early as possible.
### Empower the team
### Build integrity in
The customer needs to have an overall experience of the system. This is the so-called perceived integrity: how it is being advertised, delivered, deployed, accessed, how intuitive its use is, its price and how well it solves problems.
Conceptual integrity means that the system's separate components work well together as a whole with balance between flexibility, [maintainability](/wiki/Maintainability "Maintainability"), efficiency, and responsiveness. This could be achieved by understanding the problem domain and solving it at the same time, not sequentially. The needed information is received in small batch pieces – not in one vast chunk - preferably by face-to-face communication and not any written documentation. The information flow should be constant in both directions – from customer to developers and back, thus avoiding the large stressful amount of information after long development in isolation.
### Optimize the whole
## Lean software practices
Lean software development practices, or what the Poppendiecks call "tools" are restated slightly from the original equivalents in [agile software development](/wiki/Agile_software_development "Agile software development"). Examples of such practices include:
- Seeing [waste](/wiki/Muda_(Japanese_term) "Muda (Japanese term)")
- [Set-based development](/wiki/Theory_of_constraints "Theory of constraints")
- [Queueing theory](/wiki/Queueing_theory "Queueing theory")
- [Motivation](/wiki/Motivation "Motivation")
- [Test-driven development](/wiki/Test-driven_development "Test-driven development")
## See also
- [Extreme programming](/wiki/Extreme_programming "Extreme programming")
- [DevOps](/wiki/DevOps "DevOps")
- [Kanban](/wiki/Kanban_(development) "Kanban (development)")
- [Kanban board](/wiki/Kanban_board "Kanban board")
- [Lean integration](/wiki/Lean_integration "Lean integration")
- [Lean services](/wiki/Lean_services "Lean services")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## Further reading
[Categories](/wiki/Help:Category "Help:Category"):
- [Software development philosophies](/wiki/Category:Software_development_philosophies "Category:Software development philosophies")
- [Agile software development](/wiki/Category:Agile_software_development "Category:Agile software development")
- [Lean manufacturing](/wiki/Category:Lean_manufacturing "Category:Lean manufacturing")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [Articles needing additional references from July 2014](/wiki/Category:Articles_needing_additional_references_from_July_2014 "Category:Articles needing additional references from July 2014")
- [All articles needing additional references](/wiki/Category:All_articles_needing_additional_references "Category:All articles needing additional references")
- [Wikipedia articles that are too technical from July 2025](/wiki/Category:Wikipedia_articles_that_are_too_technical_from_July_2025 "Category:Wikipedia articles that are too technical from July 2025")
- [All articles that are too technical](/wiki/Category:All_articles_that_are_too_technical "Category:All articles that are too technical")
- [Wikipedia articles that are too technical from June 2018](/wiki/Category:Wikipedia_articles_that_are_too_technical_from_June_2018 "Category:Wikipedia articles that are too technical from June 2018")
- [All articles needing expert attention](/wiki/Category:All_articles_needing_expert_attention "Category:All articles needing expert attention")
- [Articles needing expert attention from June 2018](/wiki/Category:Articles_needing_expert_attention_from_June_2018 "Category:Articles needing expert attention from June 2018")
