Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Sandbox_(computer_security)&oldid=1360521576 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Sandbox_(computer_security)&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Sandbox_%28computer_security%29&id=1360521576&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSandbox_%28computer_security%29)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Sandbox_%28computer_security%29&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Software security mechanism
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
This article is about the computer security mechanism. For the software testing environment, see [Sandbox (software development)](/wiki/Sandbox_(software_development) "Sandbox (software development)").
## Implementations
Examples of sandbox implementations include the following:
- [Linux](/wiki/Linux "Linux") application sandboxing, built on the [Linux kernel](/wiki/Linux_kernel "Linux kernel") [seccomp](/wiki/Seccomp "Seccomp"), [cgroups](/wiki/Cgroups "Cgroups") and [namespaces](/wiki/Linux_namespaces "Linux namespaces") features. Notably used by [Systemd](/wiki/Systemd "Systemd"), [Google Chrome](/wiki/Google_Chrome "Google Chrome"), [Firefox](/wiki/Firefox "Firefox") and [Firejail](/wiki/Firejail "Firejail").
- [Virtual machines](/wiki/Virtual_machine "Virtual machine") [emulate](/wiki/Emulator "Emulator") a complete host computer, on which a conventional operating system may boot and run as on actual hardware. The guest operating system runs sandboxed in the sense that it does not function natively on the host and can only access host resources through the emulator.
- [Capability](/wiki/Capability-based_security "Capability-based security") systems can be thought of as a fine-grained sandboxing mechanism, in which programs are given opaque tokens when spawned and have the ability to do specific things based on what tokens they hold. Capability-based implementations can work at various levels, from kernel to user-space. An example of capability-based user-level sandboxing involves HTML rendering in a [web browser](/wiki/Web_browser "Web browser"), whether [Chromium](/wiki/Chromium_(web_browser) "Chromium (web browser)") or [WebKit](/wiki/WebKit "WebKit").
- [Secure Computing Mode (seccomp)](/wiki/Seccomp "Seccomp") strict mode, seccomp only allows the `write()`, `read()`, `exit()`, and `sigreturn()` system calls.
- [Java virtual machines](/wiki/Java_virtual_machine "Java virtual machine") include a sandbox to restrict the actions of untrusted code, such as a [Java applet](/wiki/Java_applet "Java applet").
- The .NET [Common Language Runtime](/wiki/Common_Language_Runtime "Common Language Runtime") provides [Code Access Security](/wiki/Code_Access_Security "Code Access Security") to enforce restrictions on untrusted code.
Some of the use cases for sandboxes include the following:
## See also
- [FreeBSD jail](/wiki/FreeBSD_jail "FreeBSD jail")
- [Sandboxie](/wiki/Sandboxie "Sandboxie")
- [seccomp](/wiki/Seccomp "Seccomp")
- [Test bench](/wiki/Test_bench "Test bench")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## External links
[Categories](/wiki/Help:Category "Help:Category"):
- [Operating system security](/wiki/Category:Operating_system_security "Category:Operating system security")
- [Virtualization](/wiki/Category:Virtualization "Category:Virtualization")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description matches Wikidata](/wiki/Category:Short_description_matches_Wikidata "Category:Short description matches Wikidata")
- [Webarchive template wayback links](/wiki/Category:Webarchive_template_wayback_links "Category:Webarchive template wayback links")
