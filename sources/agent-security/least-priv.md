Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Principle_of_least_privilege&oldid=1361120144 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Principle_of_least_privilege&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Principle_of_least_privilege&id=1361120144&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FPrinciple_of_least_privilege)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Principle_of_least_privilege&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Security by granting only essential access
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
## Details
The principle means giving any user accounts or processes only those privileges which are essentially vital to perform its intended functions. For example, a user account for the sole purpose of creating backups does not need to install software: hence, it has rights only to run backup and backup-related applications. Any other privileges, such as installing new software, are blocked. The principle applies also to a personal computer user who usually does work in a normal user account, and opens a privileged, password protected account only when the situation absolutely demands it.
The principle (of least privilege) is widely recognized as an important design consideration towards enhancing and giving a much needed 'Boost' to the protection of data and functionality from faults ([fault tolerance](/wiki/Fault_tolerance "Fault tolerance")) and [malicious behavior](/wiki/Computer_security "Computer security").
Benefits of the principle include:
- Intellectual Security. When code is limited in the scope of changes it can make to a system, it is easier to test its possible actions and interactions with other security targeted applications. In practice for example, applications running with restricted rights will not have access to perform operations that could crash a machine, or adversely affect other applications running on the same system.
In practice, there exist multiple competing definitions of true (least privilege). As [program complexity](/wiki/Programming_complexity "Programming complexity") increases rapidly, so do the number of potential issues, rendering a predictive approach impractical. Examples include the values of variables it may process, addresses it will need, or the precise time such things will be required. Object capability systems allow, for instance, deferring granting a single-use privilege until the time when it will be used. Currently, the closest practical approach is to eliminate privileges that can be manually evaluated as unnecessary. The resulting set of privileges typically exceeds the true minimum required privileges for the process.
<style data-mw-deduplicate="TemplateStyles:r1244412712">.mw-parser-output .templatequote{overflow:hidden;margin:1em 0;padding:0 32px}.mw-parser-output .templatequotecite{line-height:1.5em;text-align:left;margin-top:0}@media(min-width:500px){.mw-parser-output .templatequotecite{padding-left:1.6em}}</style>
> Every program and every privileged user of the system should operate using the least amount of privilege necessary to complete the job.
[Peter J. Denning](/wiki/Peter_J._Denning "Peter J. Denning"), in his paper "Fault Tolerant Operating Systems", set it in a broader perspective among "The four fundamental principles of fault tolerance".
## Implementation
</figure>
## Similar principles
The [Trusted Computer System Evaluation Criteria](/wiki/Trusted_Computer_System_Evaluation_Criteria "Trusted Computer System Evaluation Criteria") (TCSEC) concept of [trusted computing base](/wiki/Trusted_computing_base "Trusted computing base") (TCB) minimization is a far more stringent requirement that is only applicable to the functionally strongest assurance classes(Link to Trusted Computer System Evaluation Criteria section Divisions and classes), namely the classes [B3](/wiki/Trusted_Computer_System_Evaluation_Criteria#B_–_Mandatory_protection "Trusted Computer System Evaluation Criteria") and [A1](/wiki/Trusted_Computer_System_Evaluation_Criteria#A_–_Verified_protection "Trusted Computer System Evaluation Criteria") (which are *functionally* identical but differ in terms of evidence and documentation required).
Least privilege is often associated with [privilege bracketing](/wiki/Privilege_bracketing "Privilege bracketing"): that is, assuming necessary privileges at the last possible moment and dismissing them as soon as no longer strictly necessary, therefore ostensibly reducing fallout from erroneous code that unintentionally exploits more privilege than is merited. Least privilege has also been interpreted in the context of distribution of [discretionary access control](/wiki/Discretionary_access_control "Discretionary access control") (DAC) permissions, for example asserting that giving user U read/write access to file F violates least privilege if U can complete their authorized tasks with only read permission.
## See also
- [User Account Control](/wiki/User_Account_Control "User Account Control")
- [Capability-based security](/wiki/Capability-based_security "Capability-based security")
- [Confused deputy problem](/wiki/Confused_deputy_problem "Confused deputy problem")
- [Need to know](/wiki/Need_to_know "Need to know")
- [Privilege bracketing](/wiki/Privilege_bracketing "Privilege bracketing")
- [Privilege escalation](/wiki/Privilege_escalation "Privilege escalation")
- [Privilege revocation (computing)](/wiki/Privilege_revocation_(computing) "Privilege revocation (computing)")
- [Privilege separation](/wiki/Privilege_separation "Privilege separation")
- [Protection ring](/wiki/Protection_ring "Protection ring")
- [Role-based access control](/wiki/Role-based_access_control "Role-based access control")
- [setuid](/wiki/Setuid "Setuid")
- [sudo](/wiki/Sudo "Sudo")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## Bibliography
<style data-mw-deduplicate="TemplateStyles:r1239549316">.mw-parser-output .refbegin{margin-bottom:0.5em}.mw-parser-output .refbegin-hanging-indents>ul{margin-left:0}.mw-parser-output .refbegin-hanging-indents>ul>li{margin-left:0;padding-left:3.2em;text-indent:-3.2em}.mw-parser-output .refbegin-hanging-indents ul,.mw-parser-output .refbegin-hanging-indents ul li{list-style:none}@media(max-width:720px){.mw-parser-output .refbegin-hanging-indents>ul>li{padding-left:1.6em;text-indent:-1.6em}}.mw-parser-output .refbegin-columns{margin-top:0.3em}.mw-parser-output .refbegin-columns ul{margin-top:0}.mw-parser-output .refbegin-columns li{page-break-inside:avoid;break-inside:avoid-column}@media screen{.mw-parser-output .refbegin{font-size:90%}}</style>
- Ben Mankin, *The Formalisation of Protection Systems*, Ph.D. thesis, University of Bath, 2004
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
[Categories](/wiki/Help:Category "Help:Category"):
- [Information theory](/wiki/Category:Information_theory "Category:Information theory")
- [Cybersecurity engineering](/wiki/Category:Cybersecurity_engineering "Category:Cybersecurity engineering")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [Articles needing additional references from April 2019](/wiki/Category:Articles_needing_additional_references_from_April_2019 "Category:Articles needing additional references from April 2019")
- [All articles needing additional references](/wiki/Category:All_articles_needing_additional_references "Category:All articles needing additional references")
- [All articles with unsourced statements](/wiki/Category:All_articles_with_unsourced_statements "Category:All articles with unsourced statements")
- [Articles with unsourced statements from April 2019](/wiki/Category:Articles_with_unsourced_statements_from_April_2019 "Category:Articles with unsourced statements from April 2019")
- [Webarchive template wayback links](/wiki/Category:Webarchive_template_wayback_links "Category:Webarchive template wayback links")
