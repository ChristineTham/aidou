Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Observability_(software)&oldid=1355101350 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Observability_(software)&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Observability_%28software%29&id=1355101350&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FObservability_%28software%29)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Observability_%28software%29&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Ability to collect data about software execution
## <span id="Etymology.2C_terminology_and_definition"></span>Etymology, terminology and definition
The term is borrowed from control theory, where the "[observability](/wiki/Observability "Observability")" of a system measures how well its state can be determined from its outputs. Similarly, software observability measures how well a system's state can be understood from the obtained telemetry (metrics, logs, traces, profiling).
The definition of observability varies by vendor:
<style data-mw-deduplicate="TemplateStyles:r1244412712">.mw-parser-output .templatequote{overflow:hidden;margin:1em 0;padding:0 32px}.mw-parser-output .templatequotecite{line-height:1.5em;text-align:left;margin-top:0}@media(min-width:500px){.mw-parser-output .templatequotecite{padding-left:1.6em}}</style>
> Observability is the process of making a system’s internal state more transparent. Systems are made observable by the data they produce, which in turn helps you to determine if your infrastructure or application is healthy and functioning normally.
> a measure of how well you can understand and explain any state your system can get into, no matter how novel or bizarre \[...\] without needing to ship new code
> software tools and practices for aggregating, correlating and analyzing a steady stream of performance data from a distributed application along with the hardware and network it runs on
> observability starts by shipping all your raw data to central service before you begin analysis
> the ability to measure a system’s current state based on the data it generates, such as logs, metrics, and traces
> Observability is tooling or a technical solution that allows teams to actively debug their system. Observability is based on exploring properties and patterns not defined in advance.
> proactively collecting, visualizing, and applying intelligence to all of your metrics, events, logs, and traces—so you can understand the behavior of your complex digital system
### Observability vs. monitoring
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
## Telemetry types
### Metrics
Main article: [Software metric](/wiki/Software_metric "Software metric")
- number of HTTP requests per second;
- total number of query failures;
- database size in bytes;
- time in seconds since last [garbage collection](/wiki/Garbage_collection_(computer_science) "Garbage collection (computer science)").
Monitoring tools are typically configured to emit alerts when certain metric values exceed set thresholds. Thresholds are set based on knowledge about normal operating conditions and experience.
Metrics are typically tagged to facilitate grouping and searchability.
Application developers choose what kind of metrics to instrument their software with, before it is released. As a result, when a previously unknown issue is encountered, it is impossible to add new metrics without shipping new code. Furthermore, their [cardinality](/wiki/Cardinality_(data_modeling) "Cardinality (data modeling)") can quickly make the storage size of telemetry data prohibitively expensive. Since metrics are cardinality-limited, they are often used to represent aggregate values (for example: average page load time, or 5-second average of the request rate). Without external context, it is impossible to correlate between events (such as user requests) and distinct metric values.
### Logs
Main article: [Logging (computing)](/wiki/Logging_(computing) "Logging (computing)")
Logs typically include a timestamp and severity level. An event (such as a user request) may be fragmented across multiple log lines and interweave with logs from concurrent events.
### Traces
Main article: [Tracing (software)](/wiki/Tracing_(software) "Tracing (software)")
#### Distributed traces
### Continuous profiling
Main article: [Profiling (computer programming)](/wiki/Profiling_(computer_programming) "Profiling (computer programming)")
### Instrumentation
Instrumentation can be automatic, or custom. Automatic instrumentation offers blanket coverage and immediate value; custom instrumentation brings higher value but requires more intimate involvement with the instrumented application.
Instrumentation can be native - done in-code (modifying the code of the instrumented application) - or out-of-code (e.g. sidecar, [eBPF](/wiki/EBPF "EBPF")).
## <span id=".22Pillars_of_observability.22"></span>"Pillars of observability"
## Self monitoring
Self monitoring is a practice where observability stacks monitor each other, in order to reduce the risk of inconspicuous outages. Self monitoring may be put in place in addition to high availability and redundancy to further avoid correlated failures.
## See also
- [Application performance management](/wiki/Application_performance_management "Application performance management") (APM)
- [Real user monitoring](/wiki/Real_user_monitoring "Real user monitoring") (RUM)
- [Synthetic monitoring](/wiki/Synthetic_monitoring "Synthetic monitoring")
- [DevOps](/wiki/DevOps "DevOps")
- [Site reliability engineering](/wiki/Site_reliability_engineering "Site reliability engineering") (SRE)
- [Sociotechnical system](/wiki/Sociotechnical_system "Sociotechnical system")
## External links
## Bibliography
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
[Categories](/wiki/Help:Category "Help:Category"):
- [Distributed computing](/wiki/Category:Distributed_computing "Category:Distributed computing")
- [Software engineering](/wiki/Category:Software_engineering "Category:Software engineering")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [Wikipedia articles needing clarification from February 2024](/wiki/Category:Wikipedia_articles_needing_clarification_from_February_2024 "Category:Wikipedia articles needing clarification from February 2024")
