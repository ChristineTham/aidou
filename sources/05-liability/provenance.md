Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Data_lineage&oldid=1356903271 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Data_lineage&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Data_lineage&id=1356903271&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FData_lineage%23Data_provenance)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Data_lineage&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Origins and events of data
<style data-mw-deduplicate="TemplateStyles:r1360160623">.mw-parser-output .ambox{border:1px solid #a2a9b1;border-left:10px solid #36c;background-color:#fbfbfb;box-sizing:border-box}.mw-parser-output .ambox+link+.ambox,.mw-parser-output .ambox+link+style+.ambox,.mw-parser-output .ambox+link+link+.ambox,.mw-parser-output .ambox+.mw-empty-elt+link+.ambox,.mw-parser-output .ambox+.mw-empty-elt+link+style+.ambox,.mw-parser-output .ambox+.mw-empty-elt+link+link+.ambox,.mw-parser-output .ambox+.mw-empty-elt+.ambox,.mw-parser-output .ambox+.mw-empty-elt+.mw-empty-elt+.ambox,.mw-parser-output .ambox+.mw-empty-elt+.mw-empty-elt+.mw-empty-elt+.ambox{margin-top:-1px}html body.mediawiki .mw-parser-output .ambox.mbox-small-left{margin:4px 1em 4px 0;overflow:hidden;width:238px;border-collapse:collapse;font-size:88%;line-height:1.25em}.mw-parser-output .ambox-speedy{border-left:10px solid #b32424;background-color:#fee7e6}.mw-parser-output .ambox-delete{border-left:10px solid #b32424}.mw-parser-output .ambox-content{border-left:10px solid #f28500}.mw-parser-output .ambox-style{border-left:10px solid #fc3}.mw-parser-output .ambox-move{border-left:10px solid #9932cc}.mw-parser-output .ambox-protection{border-left:10px solid #a2a9b1}.mw-parser-output .ambox .mbox-text{border:none;padding:0.25em 0.5em;width:100%}.mw-parser-output .ambox .mbox-image{border:none;padding:2px 0 2px 0.5em;text-align:center}.mw-parser-output .ambox .mbox-imageright{border:none;padding:2px 0.5em 2px 0;text-align:center}.mw-parser-output .ambox .mbox-empty-cell{border:none;padding:0;width:1px}.mw-parser-output .ambox .mbox-image-div{width:52px}@media(min-width:720px){.mw-parser-output .ambox{margin:0 10%}}@media print{body.ns-0 .mw-parser-output .ambox{display:none!important}}</style><style data-mw-deduplicate="TemplateStyles:r1248332772">.mw-parser-output .multiple-issues-text{width:95%;margin:0.2em 0}.mw-parser-output .multiple-issues-text>.mw-collapsible-content{margin-top:0.3em}.mw-parser-output .compact-ambox .ambox{border:none;border-collapse:collapse;background-color:transparent;margin:0 0 0 1.6em!important;padding:0!important;width:auto;display:block}body.mediawiki .mw-parser-output .compact-ambox .ambox.mbox-small-left{font-size:100%;width:auto;margin:0}.mw-parser-output .compact-ambox .ambox .mbox-text{padding:0!important;margin:0!important}.mw-parser-output .compact-ambox .ambox .mbox-text-span{display:list-item;line-height:1.5em;list-style-type:disc}body.skin-minerva .mw-parser-output .multiple-issues-text>.mw-collapsible-toggle,.mw-parser-output .compact-ambox .ambox .mbox-image,.mw-parser-output .compact-ambox .ambox .mbox-imageright,.mw-parser-output .compact-ambox .ambox .mbox-empty-cell,.mw-parser-output .compact-ambox .hide-when-compact{display:none}</style>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
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
</tr>
</tbody>
</table>
**[Data governance](/wiki/Data_governance "Data governance")** plays a critical role in managing metadata by establishing guidelines, strategies and policies. Enhancing data lineage with [data quality](/wiki/Data_quality "Data quality") measures and [master data management](/wiki/Master_data_management "Master data management") adds business value. Although data lineage is typically represented through a [graphical user interface](/wiki/Graphical_user_interface "Graphical user interface") (GUI), the methods for gathering and exposing [metadata](/wiki/Metadata "Metadata") to this interface can vary. Based on the metadata collection approach, data lineage can be categorized into three types: Those involving software packages for structured data, [programming languages](/wiki/Programming_language "Programming language") and [Big data](/wiki/Big_data "Big data") systems.
## Representation of data lineage
Data lineage can be visualized at various levels based on the granularity of the view. At a very high-level, data lineage is visualized as systems that the data interacts with before it reaches its destination. At its most granular, visualizations at the data point level can provide the details of the data point and its historical behavior, attribute properties and trends and [data quality](/wiki/Data_quality "Data quality") of the data passed through that specific data point in the data lineage.
The scope of the data lineage determines the volume of metadata required to represent its data lineage. Usually, [data governance](/wiki/Data_governance "Data governance") and [data management](/wiki/Data_management "Data management") of an organization determine the scope of the data lineage based on their [regulations](/wiki/Regulation "Regulation"), enterprise data management strategy, data impact, reporting attributes and critical [data elements](/wiki/Data_element "Data element") of the organization.
## Rationale
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
</tr>
</tbody>
</table>
### Big data debugging
Big data analytics is the process of examining large data sets to uncover hidden patterns, unknown [correlations](/wiki/Correlation "Correlation"), [market trends](/wiki/Marketing_research "Marketing research"), customer preferences and other useful business information. [Machine learning](/wiki/Machine_learning "Machine learning"), among other algorithms, is used to transform and analyze the data. Due to the large size of the data, there could be unknown features in the data.
The massive scale and [unstructured](/wiki/Unstructured_data "Unstructured data") nature of data, the complexity of these analytics pipelines, and long runtimes pose significant manageability and debugging challenges. Even a single error in these analytics can be extremely difficult to identify and remove. While one may debug them by re-running the entire analytics through a debugger for stepwise debugging, this can be expensive due to the amount of time and resources needed.
### Challenges in Big Data debugging
#### Massive scale
#### Unstructured data
#### Proposed solution
Data provenance or data lineage can be used to make the debugging of [Big Data](/wiki/Big_data "Big data") pipeline easier. This necessitates the collection of data about data transformations. The below section will explain data provenance in more detail.
## Data provenance
### PROV Data Model
*Provenance is information about entities, activities and people involved in producing a piece of data or thing, which can be used to form assessments about its quality, reliability or trustworthiness. The PROV Family of Documents defines a model, corresponding serializations and other supporting definitions to enable the inter-operable interchange of provenance information in heterogeneous environments such as the Web*.\
<figcaption>PROV Core Structures</figcaption>
</figure>
***Provenance** is defined as a record that describes the people, institutions, entities and activities involved in producing, influencing, or delivering a piece of data or something. In particular, the provenance of information is crucial in deciding whether information is to be trusted, how it should be integrated with other diverse information sources, and how to give credit to its originators when reusing it. In an open and inclusive environment such as the Web, where users find information that is often contradictory or questionable, provenance can help those users to make trust judgements.*\
## Lineage capture
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
</figure>
<figcaption>Containment Hierarchy</figcaption>
</figure>
## Eager versus lazy lineage
Eager collection systems capture the entire lineage of the data flow at run time. The kind of lineage they capture may be coarse-grain or fine-grain, but they do not require any further computations on the data flow after its execution.
Lazy lineage collection typically captures only coarse-grain lineage at run time. These systems incur low capture overheads due to the small amount of lineage they capture. However, to answer fine-grain tracing queries, they must replay the data flow on all (or a large part) of its input and collect fine-grain lineage during the replay. This approach is suitable for forensic systems, where a user wants to debug an observed bad output.
## Actors
## Associations
## Architecture
[Big data](/wiki/Big_data "Big data") systems increase capacity by adding new hardware or software entities into the distributed system. This process is called *horizontal scaling*. The distributed system acts as a single entity at the logical level even though it comprises multiple hardware and software entities. The system should continue to maintain this property after horizontal scaling. An important advantage of horizontal scalability is that it can provide the ability to increase capacity on the fly. The biggest plus point is that horizontal scaling can be done using commodity hardware.
<figcaption>Architecture of lineage systems</figcaption>
</figure>
## Data flow reconstruction
The information stored in terms of associations needs to be combined by some means to get the data flow of a particular job. In a distributed system a job is broken down into multiple tasks. One or more instances run a particular task. The results produced on these individual machines are later combined to finish the job. Tasks running on different machines perform multiple transformations on the data in the machine. All the transformations applied to the data on a machine is stored in the local lineage store of that machines. This information needs to be combined to get the lineage of the entire job. The lineage of the entire job should help the data scientist understand the data flow of the job and he/she can use the data flow to debug the [Big Data](/wiki/Big_data "Big data") pipeline. The data flow is reconstructed in 3 stages.
### Association tables
The first stage of the data flow reconstruction is the computation of the association tables. The association tables exist for each actor in each local lineage store. The entire association table for an actor can be computed by combining these individual association tables. This is generally done using a series of equality joins based on the actors themselves. In few scenarios the tables might also be joined using inputs as the key. Indexes can also be used to improve the efficiency of a join. The joined tables need to be stored on a single instance or a machine to further continue processing. There are multiple schemes that are used to pick a machine where a join would be computed. The easiest one being the one with minimum CPU load. Space constraints should also be kept in mind while picking the instance where join would happen.
### Association graph
The second step in data flow reconstruction is computing an association graph from the lineage information. The graph represents the steps in the data flow. The actors act as vertices and the associations act as edges. Each actor T is linked to its upstream and downstream actors in the data flow. An upstream actor of T is one that produced the input of T, while a downstream actor is one that consumes the output of T. Containment relationships are always considered while creating the links. The graph consists of three types of links or edges.
#### Explicitly specified links
#### Logically inferred links
#### Implicit links through data set sharing
### Topological sorting
The final step in the data flow reconstruction is the [topological sorting](/wiki/Topological_sorting "Topological sorting") of the association graph. The directed graph created in the previous step is topologically sorted to obtain the order in which the actors have modified the data. This record of modifications by the different actors involved is used to track the data flow of the [Big Data](/wiki/Big_data "Big data") pipeline or task.
## Tracing and replay
This is the most crucial step in [Big Data](/wiki/Big_data "Big data") debugging. The captured lineage is combined and processed to obtain the data flow of the pipeline. The data flow helps the data scientist or a developer to look deeply into the actors and their transformations. This step allows the data scientist to figure out the part of the algorithm that is generating the unexpected output. A [Big Data](/wiki/Big_data "Big data") pipeline can go wrong in two broad ways. The first is a presence of a suspicious actor in the dataflow. The second is the existence of outliers in the data.
<figcaption>Tracing anomalous actors</figcaption>
</figure>
The second problem i.e. the existence of outliers can also be identified by running the dataflow step wise and looking at the transformed outputs. The data scientist finds a subset of outputs that are not in accordance with the rest of outputs. The inputs which are causing these bad outputs are outliers in the data. This problem can be solved by removing the set of outliers from the data and replaying the entire dataflow. It can also be solved by modifying the machine learning algorithm by adding, removing or moving actors in the dataflow. The changes in the dataflow are successful if the replayed dataflow does not produce bad outputs.
<figcaption>Tracing outliers in the data</figcaption>
</figure>
## Challenges
Although the utilization of data lineage methodologies represents a novel approach to the debugging of [Big Data](/wiki/Big_data "Big data") pipelines, the process is not straightforward. A number of challenges must be addressed, including the scalability of the lineage store, the fault tolerance of the lineage store, the accurate capture of lineage for black box operators, and numerous other considerations. These challenges must be carefully evaluated in order to develop a realistic design for data lineage capture, taking into account the inherent trade-offs between them.
### Scalability
[DISC](/wiki/Data-intensive_computing "Data-intensive computing") systems are primarily batch processing systems designed for high throughput. They execute several jobs per analytics, with several tasks per job. The overall number of operators executing at any time in a cluster can range from hundreds to thousands depending on the cluster size. Lineage capture for these systems must be able scale to both large volumes of data and numerous operators to avoid being a bottleneck for the DISC analytics.
### Fault tolerance
Lineage capture systems must also be fault tolerant to avoid rerunning data flows to capture lineage. At the same time, they must also accommodate failures in the DISC system. To do so, they must be able to identify a failed DISC task and avoid storing duplicate copies of lineage between the partial lineage generated by the failed task and duplicate lineage produced by the restarted task. A lineage system should also be able to gracefully handle multiple instances of local lineage systems going down. This can be achieved by storing replicas of lineage associations in multiple machines. The replica can act like a backup in the event of the real copy being lost.
### Black-box operators
### Efficient tracing
### Sophisticated replay
### Anomaly detection
One of the primary debugging concerns in DISC systems is identifying faulty operators. In long dataflows with several hundreds of operators or tasks, manual inspection can be tedious and prohibitive. Even if lineage is used to narrow the subset of operators to examine, the lineage of a single output can still span several operators. There is a need for an inexpensive automated debugging system, which can substantially narrow the set of potentially faulty operators, with reasonable accuracy, to minimize the amount of manual examination required.
## See also
- [Directed acyclic graph](/wiki/Directed_acyclic_graph "Directed acyclic graph")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## Further reading
<style data-mw-deduplicate="TemplateStyles:r1239549316">.mw-parser-output .refbegin{margin-bottom:0.5em}.mw-parser-output .refbegin-hanging-indents>ul{margin-left:0}.mw-parser-output .refbegin-hanging-indents>ul>li{margin-left:0;padding-left:3.2em;text-indent:-3.2em}.mw-parser-output .refbegin-hanging-indents ul,.mw-parser-output .refbegin-hanging-indents ul li{list-style:none}@media(max-width:720px){.mw-parser-output .refbegin-hanging-indents>ul>li{padding-left:1.6em;text-indent:-1.6em}}.mw-parser-output .refbegin-columns{margin-top:0.3em}.mw-parser-output .refbegin-columns ul{margin-top:0}.mw-parser-output .refbegin-columns li{page-break-inside:avoid;break-inside:avoid-column}@media screen{.mw-parser-output .refbegin{font-size:90%}}</style>
[Categories](/wiki/Help:Category "Help:Category"):
- [Data management](/wiki/Category:Data_management "Category:Data management")
- [Distributed computing problems](/wiki/Category:Distributed_computing_problems "Category:Distributed computing problems")
- [Big data](/wiki/Category:Big_data "Category:Big data")
Hidden categories:
- [Webarchive template wayback links](/wiki/Category:Webarchive_template_wayback_links "Category:Webarchive template wayback links")
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description matches Wikidata](/wiki/Category:Short_description_matches_Wikidata "Category:Short description matches Wikidata")
- [Wikipedia references cleanup from October 2024](/wiki/Category:Wikipedia_references_cleanup_from_October_2024 "Category:Wikipedia references cleanup from October 2024")
- [All articles needing references cleanup](/wiki/Category:All_articles_needing_references_cleanup "Category:All articles needing references cleanup")
- [Articles covered by WikiProject Wikify from October 2024](/wiki/Category:Articles_covered_by_WikiProject_Wikify_from_October_2024 "Category:Articles covered by WikiProject Wikify from October 2024")
- [All articles covered by WikiProject Wikify](/wiki/Category:All_articles_covered_by_WikiProject_Wikify "Category:All articles covered by WikiProject Wikify")
- [Wikipedia articles that are too technical from November 2025](/wiki/Category:Wikipedia_articles_that_are_too_technical_from_November_2025 "Category:Wikipedia articles that are too technical from November 2025")
- [All articles that are too technical](/wiki/Category:All_articles_that_are_too_technical "Category:All articles that are too technical")
- [Articles with multiple maintenance issues](/wiki/Category:Articles_with_multiple_maintenance_issues "Category:Articles with multiple maintenance issues")
- [Wikipedia articles that may have off-topic sections from November 2025](/wiki/Category:Wikipedia_articles_that_may_have_off-topic_sections_from_November_2025 "Category:Wikipedia articles that may have off-topic sections from November 2025")
- [All articles that may have off-topic sections](/wiki/Category:All_articles_that_may_have_off-topic_sections "Category:All articles that may have off-topic sections")
- [All articles with failed verification](/wiki/Category:All_articles_with_failed_verification "Category:All articles with failed verification")
- [Articles with failed verification from December 2024](/wiki/Category:Articles_with_failed_verification_from_December_2024 "Category:Articles with failed verification from December 2024")
- [All articles with minor POV problems](/wiki/Category:All_articles_with_minor_POV_problems "Category:All articles with minor POV problems")
- [Articles with minor POV problems from November 2024](/wiki/Category:Articles_with_minor_POV_problems_from_November_2024 "Category:Articles with minor POV problems from November 2024")
