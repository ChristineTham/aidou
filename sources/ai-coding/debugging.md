Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Debugging&oldid=1361586305 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Debugging&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Debugging&id=1361586305&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FDebugging)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Debugging&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Fixing defects in an engineered system
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
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
## Etymology
See also: [Bug (engineering) § History](/wiki/Bug_(engineering)#History "Bug (engineering)")
<figcaption>A computer log entry from the Mark II, with a moth taped to the page</figcaption>
</figure>
The term *bug*, in the sense of defect, dates back at least to 1878 when [Thomas Edison](/wiki/Thomas_Edison "Thomas Edison") wrote "little faults and difficulties" in his inventions as "Bugs".
## Scope
## Tools
Main article: [Debugger](/wiki/Debugger "Debugger")
</figure>
Debugging ranges in complexity from fixing simple errors to performing lengthy and tiresome tasks of data collection, analysis, and scheduling updates. The debugging skill of the programmer can be a major factor in the ability to debug a problem, but the difficulty of software debugging varies greatly with the complexity of the system, and also depends, to some extent, on the [programming language](/wiki/Programming_language "Programming language")(s) used and the available tools, such as *[debuggers](/wiki/Debugger "Debugger")*. Debuggers are software tools which enable the [programmer](/wiki/Programmer "Programmer") to monitor the [execution](/wiki/Execution_(computing) "Execution (computing)") of a program, stop it, restart it, set [breakpoints](/wiki/Breakpoint "Breakpoint"), and change values in memory. The term *debugger* can also refer to the person who is doing the debugging.
In certain situations, general purpose software tools that are language specific in nature can be very useful. These take the form of *[static code analysis tools](/wiki/List_of_tools_for_static_code_analysis "List of tools for static code analysis")*. These tools look for a very specific set of known problems, some common and some rare, within the source code, concentrating more on the semantics (e.g. data flow) rather than the syntax, as compilers and interpreters do.
Both commercial and free tools exist for various languages; some claim to be able to detect hundreds of different problems. These tools can be extremely useful when checking very large source trees, where it is impractical to do code walk-throughs. A typical example of a problem detected would be a variable dereference that occurs *before* the variable is assigned a value. As another example, some such tools perform strong type checking when the language does not require it. Thus, they are better at locating likely errors in code that is syntactically correct. But these tools have a reputation of false positives, where correct code is flagged as dubious. The old Unix *[lint](/wiki/Lint_(software) "Lint (software)")* program is an early example.
## Debugging process
After the bug is reproduced, the input of the program may need to be simplified to make it easier to debug. For example, a bug in a compiler can make it [crash](/wiki/Crash_(computing) "Crash (computing)") when parsing a large source file. However, after simplification of the test case, only few lines from the original source file can be sufficient to reproduce the same crash. Simplification may be done manually using a [divide-and-conquer](/wiki/Divide-and-conquer_algorithm "Divide-and-conquer algorithm") approach, in which the programmer attempts to remove some parts of original test case then checks if the problem still occurs. When debugging in a [GUI](/wiki/Graphical_user_interface "Graphical user interface"), the programmer can try skipping some user interaction from the original problem description to check if the remaining actions are sufficient for causing the bug to occur.
## Techniques
- *Interactive debugging* uses debugger tools which allow a program's execution to be processed one step at a time and to be paused to inspect or alter its state. Subroutines or function calls may typically be executed at full speed and paused again upon return to their caller, or themselves single stepped, or any mixture of these options. Breakpoints may be installed which permit full speed execution of code that is not suspected to be faulty, and then stop at a point that is. Putting a breakpoint immediately after the end of a program loop is a convenient way to evaluate repeating code. Watchpoints are commonly available, where execution can proceed until a particular variable changes, and catchpoints which cause the debugger to stop for certain kinds of program events, such as exceptions or the loading of a shared library.
- *Activity tracing* is like tracing (above), but rather than following program execution one instruction or function at a time, follows program activity based on the overall amount of time spent by the processor/CPU executing particular segments of code. This is typically presented as a fraction of the program's execution time spent processing instructions within defined memory addresses (machine code programs) or certain program modules (high level language or compiled programs). If the program being debugged is shown to be spending an inordinate fraction of its execution time within traced areas, this could indicate misallocation of processor time caused by faulty program logic, or at least inefficient allocation of processor time that could benefit from optimization efforts.
- *[Record and replay debugging](/wiki/Record_and_replay_debugging "Record and replay debugging")* is the technique of creating a program execution recording (e.g. using Mozilla's free [rr](/wiki/Rr_(debugging) "Rr (debugging)") debugging tool; enabling reversible debugging/execution), which can be replayed and interactively debugged. Useful for remote debugging and debugging intermittent, non-deterministic, and other hard-to-reproduce defects.
- *[Time travel debugging](/wiki/Time_travel_debugging "Time travel debugging")* is the process of stepping back in time through source code (e.g. using [Undo LiveRecorder](/wiki/Undo_(company) "Undo (company)")) to understand what is happening during execution of a computer program; to allow users to interact with the program; to change the history if desired and to watch how the program responds.
### Automatic bug fixing
## Debugging for embedded systems
In contrast to the general purpose computer software design environment, a primary characteristic of embedded environments is the sheer number of different platforms available to the developers (CPU architectures, vendors, operating systems, and their variants). Embedded systems are, by definition, not general-purpose designs: they are typically developed for a single task (or small range of tasks), and the platform is chosen specifically to optimize that application. Not only does this fact make life tough for embedded system developers, it also makes debugging and testing of these systems harder as well, since different debugging tools are needed for different platforms.
In addition to the typical task of identifying bugs in the system, embedded system debugging also seeks to collect information about the operating states of the system that may then be used to analyze the system: to find ways to boost its performance or to optimize other important characteristics (e.g. energy consumption, reliability, real-time response, etc.).
## Anti-debugging
- API-based: check for the existence of a debugger using system information
- Exception-based: check to see if exceptions are interfered with
- Process and thread blocks: check whether process and thread blocks have been manipulated
- Modified code: check for code modifications made by a debugger handling software breakpoints
- Hardware- and register-based: check for hardware breakpoints and CPU registers
- Timing and latency: check the time taken for the execution of instructions
## See also
<style data-mw-deduplicate="TemplateStyles:r1184024115">.mw-parser-output .div-col{margin-top:0.3em;column-width:30em}.mw-parser-output .div-col-small{font-size:90%}.mw-parser-output .div-col-rules{column-rule:1px solid #aaa}.mw-parser-output .div-col dl,.mw-parser-output .div-col ol,.mw-parser-output .div-col ul{margin-top:0}.mw-parser-output .div-col li,.mw-parser-output .div-col dd{page-break-inside:avoid;break-inside:avoid-column}</style>
- [Assertion (software development)](/wiki/Assertion_(software_development) "Assertion (software development)")
- [Debugging pattern](/wiki/Debugging_pattern "Debugging pattern")
- [Magic debug values](/wiki/Magic_number_(programming)#Magic_debug_values "Magic number (programming)")
- [Software bug](/wiki/Software_bug "Software bug")
- [Software testing](/wiki/Software_testing "Software testing")
- [Time travel debugging](/wiki/Time_travel_debugging "Time travel debugging")
- [Trace table](/wiki/Trace_table "Trace table")
- [Troubleshooting](/wiki/Troubleshooting "Troubleshooting")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## Further reading
## External links
<style data-mw-deduplicate="TemplateStyles:r1314755338">.mw-parser-output .side-box{margin:4px 0;box-sizing:border-box;border:1px solid #aaa;font-size:88%;line-height:1.25em;background-color:var(--background-color-interactive-subtle,#f8f9fa);color:inherit;display:flow-root}.mw-parser-output .infobox .side-box{font-size:100%}.mw-parser-output .side-box-abovebelow,.mw-parser-output .side-box-text{padding:0.25em 0.9em}.mw-parser-output .side-box-image{padding:2px 0 2px 0.9em;text-align:center}.mw-parser-output .side-box-imageright{padding:2px 0.9em 2px 0;text-align:center}@media(min-width:500px){.mw-parser-output .side-box-flex{display:flex;align-items:center}.mw-parser-output .side-box-text{flex:1;min-width:0}}@media(min-width:640px){.mw-parser-output .side-box{width:238px}.mw-parser-output .side-box-right{clear:right;float:right;margin-left:1em}.mw-parser-output .side-box-left{margin-right:1em}}</style><style data-mw-deduplicate="TemplateStyles:r1311551236">@media print{body.ns-0 .mw-parser-output .sistersitebox{display:none!important}}@media screen{html.skin-theme-clientpref-night .mw-parser-output .sistersitebox img[src*="Wiktionary-logo-en-v2.svg"]{filter:invert(1)brightness(55%)contrast(250%)hue-rotate(180deg)}}@media screen and (prefers-color-scheme:dark){html.skin-theme-clientpref-os .mw-parser-output .sistersitebox img[src*="Wiktionary-logo-en-v2.svg"]{filter:invert(1)brightness(55%)contrast(250%)hue-rotate(180deg)}}</style>
<style data-mw-deduplicate="TemplateStyles:r1353707246">.mw-parser-output .navbox{box-sizing:border-box;border:1px solid #a2a9b1;width:100%;clear:both;font-size:88%;text-align:center;padding:1px;margin:1em auto 0}.mw-parser-output .navbox .navbox{margin-top:0}.mw-parser-output .navbox+.navbox-styles+.navbox,.mw-parser-output .navbox+span.mw-empty-elt+.navbox-styles+.navbox{margin-top:-1px}.mw-parser-output .navbox-inner,.mw-parser-output .navbox-subgroup{width:100%}.mw-parser-output .navbox-group,.mw-parser-output .navbox-title,.mw-parser-output .navbox-abovebelow{padding:0.25em 1em;line-height:1.5em;text-align:center}.mw-parser-output .navbox-group{white-space:nowrap;text-align:right}.mw-parser-output .navbox,.mw-parser-output .navbox-subgroup{background-color:#fdfdfd;color:inherit}.mw-parser-output .navbox-list{line-height:1.5em;border-color:#fdfdfd}.mw-parser-output .navbox-list-with-group{text-align:left;border-left-width:2px;border-left-style:solid}.mw-parser-output tr+tr>.navbox-abovebelow,.mw-parser-output tr+tr>.navbox-group,.mw-parser-output tr+tr>.navbox-image,.mw-parser-output tr+tr>.navbox-list{border-top:2px solid #fdfdfd}.mw-parser-output .navbox-title{background-color:#ccf;color:inherit}.mw-parser-output .navbox-abovebelow,.mw-parser-output .navbox-group,.mw-parser-output .navbox-subgroup .navbox-title{background-color:#ddf;color:inherit}.mw-parser-output .navbox-subgroup .navbox-group,.mw-parser-output .navbox-subgroup .navbox-abovebelow{background-color:#e6e6ff;color:inherit}.mw-parser-output .navbox-even{background-color:#f7f7f7;color:inherit}.mw-parser-output .navbox-odd{background-color:transparent;color:inherit}.mw-parser-output .navbox .hlist td dl,.mw-parser-output .navbox .hlist td ol,.mw-parser-output .navbox .hlist td ul,.mw-parser-output .navbox td.hlist dl,.mw-parser-output .navbox td.hlist ol,.mw-parser-output .navbox td.hlist ul{padding:0.125em 0}.mw-parser-output .navbox .navbar{display:block;font-size:100%}.mw-parser-output .navbox-title .navbar{float:left;text-align:left;margin-right:0.5em}body.skin--responsive .mw-parser-output .navbox-image img{max-width:none!important}@media print{body.ns-0 .mw-parser-output .navbox{display:none!important}}</style><style data-mw-deduplicate="TemplateStyles:r1038841319">.mw-parser-output .tooltip-dotted{border-bottom:1px dotted;cursor:help}</style>
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
- [Debugging](/wiki/Category:Debugging "Category:Debugging")
Hidden categories:
- [Webarchive template wayback links](/wiki/Category:Webarchive_template_wayback_links "Category:Webarchive template wayback links")
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [Articles with excerpts](/wiki/Category:Articles_with_excerpts "Category:Articles with excerpts")
