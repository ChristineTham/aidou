Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=DevOps&oldid=1361497844 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=DevOps&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=DevOps&id=1361497844&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FDevOps)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=DevOps&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
## Page version status
This is an accepted version of this page
Integration of software development and operations
<figcaption>DevOps is at the intersection of Development (Software Engineering), Technology Operations and Quality Assurance (QA)</figcaption>
</figure>
## History
## Relevant metrics
- Deployment Frequency: Time between code deployments.
- Mean Lead Time for Changes: Time between code commit and deployment.
- Change Failure Rate: Percentage of deployments causing production issues.
- Failed Deployment Recovery Time (formerly Mean Time to Recover)
- Reliability: Measures operational performance by focusing on availability and adherence to user expectations.
## Relationship to other approaches
### Agile
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
Main article: [Agile software development](/wiki/Agile_software_development "Agile software development")
### ArchOps
### <span id="Continuous_Integration_and_Delivery_.28CI.2FCD.29"></span>Continuous Integration and Delivery (CI/CD)
Main article: [CI/CD](/wiki/CI/CD "CI/CD")
### Database DevOps
### Mobile DevOps
Main article: [Mobile DevOps](/wiki/Mobile_DevOps "Mobile DevOps")
### Site Reliability Engineering
Main article: [Site reliability engineering](/wiki/Site_reliability_engineering "Site reliability engineering")
### <span id="Toyota_Production_System.2C_Lean_Thinking.2C_Kaizen"></span>Toyota Production System, Lean Thinking, Kaizen
Main article: [Toyota Production System](/wiki/Toyota_Production_System "Toyota Production System")
### <span id="DevSecOps.2C_Shifting_Security_Left"></span>DevSecOps, Shifting Security Left
As its name implies, DevSecOps integrates DevOps within security practices. Contrary to a traditional centralized security team model, each delivery team is empowered to factor the correct security controls into their software delivery. Teams perform tests and implement security practices earlier in the development lifecycle, hence the term "[shift left](/wiki/Shift-left_testing "Shift-left testing")". Security is tested in three main areas: static, software composition, and dynamic.
Checking software statically via [static application security testing](/wiki/Static_application_security_testing "Static application security testing") (SAST) is [white-box testing](/wiki/White-box_testing "White-box testing") with special focus on security. Depending on the programming language, different tools are needed to do such static code analysis. The software composition is analyzed, especially libraries, and the version of each component is checked against vulnerability lists published by [CERT](/wiki/Computer_emergency_response_team "Computer emergency response team") and other expert groups. When giving software to clients, library licenses and their match to the license of the software distributed are in focus, especially [copyleft](/wiki/Copyleft "Copyleft") licenses.
In dynamic testing, also called [black-box testing](/wiki/Black-box_testing "Black-box testing"), software is tested without knowing its inner functions. In DevSecOps this practice may be referred to as [dynamic application security testing](/wiki/Dynamic_application_security_testing "Dynamic application security testing") (DAST) or penetration testing. The goal is early detection of defects including [cross-site scripting](/wiki/Cross-site_scripting "Cross-site scripting") and [SQL injection](/wiki/SQL_injection "SQL injection") vulnerabilities.
## Culture
## GitOps
## Best practices for cloud systems
- **Number of Pipelines**: Small teams can be more productive by having one [repository](/wiki/Repository_(version_control) "Repository (version control)") and one pipeline. In contrast, larger organizations may have separate repositories and pipelines for each team or even separate repositories and pipelines for each service within a team.
- **Permissions**: In the context of [pipeline-related](/wiki/CI/CD "CI/CD") permissions, adhering to the [principle of least privilege](/wiki/Principle_of_least_privilege "Principle of least privilege") can be challenging due to the dynamic nature of [architecture](/wiki/Software_architecture "Software architecture"). Administrators may opt for more relaxed permissions while implementing compensating [security controls](/wiki/Security_controls "Security controls") to minimize the blast radius.
## DataOps
### History
<figcaption>DataOps heritage from DevOps, Agile, and manufacturing</figcaption>
</figure>
### Goals and philosophy
### Implementation
- *“Establish progress and performance measurements at every stage of the data flow. Where possible, benchmark data-flow cycle times.*
- *Define rules for an abstracted semantic layer. Ensure everyone is “speaking the same language” and agrees upon what the data (and metadata) is and is not.*
- *Validate with the “eyeball test”: Include continuous-improvement -oriented human feedback loops. Consumers must be able to trust the data, and that can only come with incremental validation.*
- Automate as many stages of the data flow as possible including BI, data science, and analytics.
- *Using benchmarked performance information, identify bottlenecks and then optimize for them. This may require investment in commodity hardware, or automation of a formerly-human-delivered data-science step in the process.*
- *Establish governance discipline, with a particular focus on two-way data control, data ownership, transparency, and comprehensive [data lineage](/wiki/Data_lineage "Data lineage") tracking through the entire workflow.*
- *Design process for growth and extensibility. The data flow model must be designed to accommodate volume and variety of data. Ensure enabling technologies are priced affordably to scale with that enterprise data growth.”*
### Events
## See also
- [DevOps toolchain](/wiki/DevOps_toolchain "DevOps toolchain") – Tools for software development
- [Infrastructure as code](/wiki/Infrastructure_as_code "Infrastructure as code") – Data center management method
- [Lean software development](/wiki/Lean_software_development "Lean software development") – Use of lean manufacturing principles in software development
- [List of build automation software](/wiki/List_of_build_automation_software "List of build automation software")
- [Site reliability engineering](/wiki/Site_reliability_engineering "Site reliability engineering") – Use of software engineering practices for IT
- [Value stream](/wiki/Value_stream "Value stream") – Principle in economics
- [Twelve-Factor App methodology](/wiki/Twelve-Factor_App_methodology "Twelve-Factor App methodology") – Software methodology
## Notes
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## References
## Further reading
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
[Category](/wiki/Help:Category "Help:Category"):
- [DevOps](/wiki/Category:DevOps "Category:DevOps")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [Wikipedia pending changes protected pages](/wiki/Category:Wikipedia_pending_changes_protected_pages "Category:Wikipedia pending changes protected pages")
- [All pages needing factual verification](/wiki/Category:All_pages_needing_factual_verification "Category:All pages needing factual verification")
- [Wikipedia articles needing factual verification from May 2026](/wiki/Category:Wikipedia_articles_needing_factual_verification_from_May_2026 "Category:Wikipedia articles needing factual verification from May 2026")
- [CS1 maint: location missing publisher](/wiki/Category:CS1_maint:_location_missing_publisher "Category:CS1 maint: location missing publisher")
