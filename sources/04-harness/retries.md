Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Idempotence&oldid=1359310770 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Idempotence&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Idempotence&id=1359310770&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FIdempotence)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Idempotence&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Property of operations
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
For the concepts in algebra, see [Idempotent (ring theory)](/wiki/Idempotent_(ring_theory) "Idempotent (ring theory)") and [Idempotent matrix](/wiki/Idempotent_matrix "Idempotent matrix").
</figure>
## Definition
## Examples
- In a [Boolean ring](/wiki/Boolean_ring "Boolean ring"), multiplication is idempotent.
- In a [Tropical semiring](/wiki/Tropical_semiring "Tropical semiring"), addition is idempotent.
### Idempotent functions
- [constant](/wiki/Constant_function "Constant function") functions are idempotent;
- the [identity function](/wiki/Identity_function "Identity function") is idempotent;
- the [floor](/wiki/Floor_and_ceiling_functions "Floor and ceiling functions"), [ceiling](/wiki/Floor_and_ceiling_functions "Floor and ceiling functions") and [fractional part](/wiki/Fractional_part "Fractional part") functions are idempotent;
- the [subgroup generated](/wiki/Generating_set_of_a_group "Generating set of a group") function from the power set of a group to itself is idempotent;
- the [convex hull](/wiki/Convex_hull "Convex hull") function from the power set of an [affine space](/wiki/Affine_space "Affine space") over the [reals](/wiki/Real_number "Real number") to itself is idempotent;
- the [closure](/wiki/Closure_(topology) "Closure (topology)") and [interior](/wiki/Interior_(topology) "Interior (topology)") functions of the power set of a [topological space](/wiki/Topological_space "Topological space") to itself are idempotent;
- the idempotent [endomorphisms](/wiki/Endomorphism "Endomorphism") of a [vector space](/wiki/Vector_space "Vector space") are its [projections](/wiki/Projection_(linear_algebra) "Projection (linear algebra)").
### Idempotent morphisms
## Computer science meaning
In [computer science](/wiki/Computer_science "Computer science"), the term *idempotence* may have a different meaning depending on the context in which it is applied:
- in [functional programming](/wiki/Functional_programming "Functional programming"), a [pure function](/wiki/Pure_function "Pure function") is idempotent if it is idempotent in the mathematical sense given in [the definition](#Definition).
This is a very useful property in many situations, as it means that an operation can be repeated or retried as often as necessary without causing unintended effects. With non-idempotent operations, the algorithm may have to keep track of whether the operation was already performed or not.
### Computer science examples
A function looking up a customer's name and address in a [database](/wiki/Database "Database") is typically idempotent, since this will not cause the database to change. Similarly, a request for changing a customer's address to XYZ is typically idempotent, because the final address will be the same no matter how many times the request is submitted. However, a customer request for placing an order is typically not idempotent since multiple requests will lead to multiple orders being placed. A request for canceling a particular order is idempotent because no matter how many requests are made the order remains canceled.
A sequence of idempotent subroutines where at least one subroutine is different from the others, however, is not necessarily idempotent if a later subroutine in the sequence changes a value that an earlier subroutine depends on—*idempotence is not closed under sequential composition*. For example, suppose the initial value of a variable is 3 and there is a subroutine sequence that reads the variable, then changes it to 5, and then reads it again. Each step in the sequence is idempotent: both steps reading the variable have no side effects and the step changing the variable to 5 will always have the same effect no matter how many times it is executed. Nonetheless, executing the entire sequence once produces the output (3, 5), but executing it a second time produces the output (5, 5), so the sequence is not idempotent.
    int x = 3;
    void inspect() { printf("%d\n", x); }
    void change() { x = 5; }
    void sequence() { inspect(); change(); inspect(); }
    int main() {
      sequence();  // prints "3\n5\n"
      sequence();  // prints "5\n5\n"
      return 0;
    }
Violation of the unique identification requirement in storage or deletion typically causes violation of idempotence. For example, storing or deleting a given set of content without specifying a unique identifier: POST requests, which do not need to be idempotent, often do not contain unique identifiers, so the creation of the identifier is delegated to the receiving system which then creates a corresponding new record. Similarly, PUT and DELETE requests with nonspecific criteria may result in different outcomes depending on the state of the system – for example, a request to delete the most recent record. In each case, subsequent executions will further modify the state of the system, so they are not idempotent.
In [service-oriented architecture](/wiki/Service-oriented_architecture "Service-oriented architecture") (SOA), a multiple-step orchestration process composed entirely of idempotent steps can be replayed without side-effects if any part of that process fails.
Many operations that are idempotent often have ways to "resume" a process if it is interrupted – ways that finish much faster than starting all over from the beginning. For example, [resuming a file transfer](/wiki/Upload#Resumability_of_file_transfers "Upload"), [synchronizing files](/wiki/Rsync "Rsync"), creating a [software build](/wiki/Software_build "Software build"), installing an application and all of its dependencies with a [package manager](/wiki/Package_manager "Package manager"), etc.
## Applied examples
<figcaption>A typical crosswalk button is an example of an idempotent system.</figcaption>
</figure>
Similarly, the elevator "close" button may be pressed many times to the same effect as once, since the doors close on a fixed schedule – unless the "open" button is pressed. The "open" button is not idempotent, because each press adds further delay.
## See also
- [Biordered set](/wiki/Biordered_set "Biordered set")
- [Closure operator](/wiki/Closure_operator "Closure operator")
- [Fixed point (mathematics)](/wiki/Fixed_point_(mathematics) "Fixed point (mathematics)")
- [Idempotent analysis](/wiki/Idempotent_analysis "Idempotent analysis")
- [Idempotent matrix](/wiki/Idempotent_matrix "Idempotent matrix")
- [Idempotent relation](/wiki/Idempotent_relation "Idempotent relation") – a generalization of idempotence to binary relations
- [Idempotent (ring theory)](/wiki/Idempotent_(ring_theory) "Idempotent (ring theory)")
- [Involution (mathematics)](/wiki/Involution_(mathematics) "Involution (mathematics)")
- [Iterated function](/wiki/Iterated_function "Iterated function")
- [Nilpotent](/wiki/Nilpotent "Nilpotent")
- [Pure function](/wiki/Pure_function "Pure function")
- [Referential transparency](/wiki/Referential_transparency "Referential transparency")
## Notes
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## References
    The defining equation of nilpotent and idempotent expressions are respectively A<sup>n</sup> = 0 and A<sup>n</sup> = A; but with reference to idempotent expressions, it will always be assumed that they are of the form A<sup>n</sup> = A unless it be otherwise distinctly stated." </span></span>
## Further reading
<style data-mw-deduplicate="TemplateStyles:r1239549316">.mw-parser-output .refbegin{margin-bottom:0.5em}.mw-parser-output .refbegin-hanging-indents>ul{margin-left:0}.mw-parser-output .refbegin-hanging-indents>ul>li{margin-left:0;padding-left:3.2em;text-indent:-3.2em}.mw-parser-output .refbegin-hanging-indents ul,.mw-parser-output .refbegin-hanging-indents ul li{list-style:none}@media(max-width:720px){.mw-parser-output .refbegin-hanging-indents>ul>li{padding-left:1.6em;text-indent:-1.6em}}.mw-parser-output .refbegin-columns{margin-top:0.3em}.mw-parser-output .refbegin-columns ul{margin-top:0}.mw-parser-output .refbegin-columns li{page-break-inside:avoid;break-inside:avoid-column}@media screen{.mw-parser-output .refbegin{font-size:90%}}</style>
## External links
<style data-mw-deduplicate="TemplateStyles:r1314755338">.mw-parser-output .side-box{margin:4px 0;box-sizing:border-box;border:1px solid #aaa;font-size:88%;line-height:1.25em;background-color:var(--background-color-interactive-subtle,#f8f9fa);color:inherit;display:flow-root}.mw-parser-output .infobox .side-box{font-size:100%}.mw-parser-output .side-box-abovebelow,.mw-parser-output .side-box-text{padding:0.25em 0.9em}.mw-parser-output .side-box-image{padding:2px 0 2px 0.9em;text-align:center}.mw-parser-output .side-box-imageright{padding:2px 0.9em 2px 0;text-align:center}@media(min-width:500px){.mw-parser-output .side-box-flex{display:flex;align-items:center}.mw-parser-output .side-box-text{flex:1;min-width:0}}@media(min-width:640px){.mw-parser-output .side-box{width:238px}.mw-parser-output .side-box-right{clear:right;float:right;margin-left:1em}.mw-parser-output .side-box-left{margin-right:1em}}</style><style data-mw-deduplicate="TemplateStyles:r1311551236">@media print{body.ns-0 .mw-parser-output .sistersitebox{display:none!important}}@media screen{html.skin-theme-clientpref-night .mw-parser-output .sistersitebox img[src*="Wiktionary-logo-en-v2.svg"]{filter:invert(1)brightness(55%)contrast(250%)hue-rotate(180deg)}}@media screen and (prefers-color-scheme:dark){html.skin-theme-clientpref-os .mw-parser-output .sistersitebox img[src*="Wiktionary-logo-en-v2.svg"]{filter:invert(1)brightness(55%)contrast(250%)hue-rotate(180deg)}}</style>
<style data-mw-deduplicate="TemplateStyles:r1356078539">.mw-parser-output .portal-bar{font-size:88%;font-weight:bold;display:flex;justify-content:center;align-items:baseline}.mw-parser-output .portal-bar-bordered{padding:0 2em;background-color:#fdfdfd;border:1px solid #a2a9b1;clear:both;margin:1em auto 0}.mw-parser-output .portal-bar-related{font-size:100%;justify-content:flex-start}.mw-parser-output .portal-bar-unbordered{padding:0 1.7em;margin-left:0}.mw-parser-output .portal-bar-header{margin:0 1em 0 0.5em;flex:0 0 auto;min-height:24px}.mw-parser-output .portal-bar-content{display:flex;flex-flow:row wrap;flex:0 1 auto;padding:0.15em 0;column-gap:1em;align-items:baseline;margin:0;list-style:none}.mw-parser-output .portal-bar-content-related{margin:0;list-style:none}.mw-parser-output .portal-bar-item{display:inline-block;margin:0.15em 0.2em;min-height:24px;line-height:24px}@media screen and (max-width:768px){.mw-parser-output .portal-bar{font-size:88%;font-weight:bold;display:flex;flex-flow:column wrap;align-items:baseline}.mw-parser-output .portal-bar-header{text-align:center;flex:0;padding-left:0.5em;margin:0 auto}.mw-parser-output .portal-bar-related{font-size:100%;align-items:flex-start}.mw-parser-output .portal-bar-content{display:flex;flex-flow:row wrap;align-items:center;flex:0;column-gap:1em;border-top:1px solid #a2a9b1;margin:0 auto;list-style:none}.mw-parser-output .portal-bar-content-related{border-top:none;margin:0;list-style:none}}.mw-parser-output .navbox+link+.portal-bar,.mw-parser-output .navbox+style+.portal-bar,.mw-parser-output .navbox+link+.portal-bar-bordered,.mw-parser-output .navbox+style+.portal-bar-bordered,.mw-parser-output .navbox+span.mw-empty-elt+.portal-bar,.mw-parser-output .navbox+span.mw-empty-elt+.portal-bar-bordered,.mw-parser-output .sister-bar+link+.portal-bar,.mw-parser-output .sister-bar+style+.portal-bar,.mw-parser-output .portal-bar+.navbox-styles+.navbox,.mw-parser-output .portal-bar+.navbox-styles+.sister-bar{margin-top:-1px}</style>
**Idempotence** at Wikipedia's [<span id="sister-projects" style="white-space:nowrap;">sister projects</span>](/wiki/Wikipedia:Wikimedia_sister_projects "Wikipedia:Wikimedia sister projects"):
[Categories](/wiki/Help:Category "Help:Category"):
- [Properties of binary operations](/wiki/Category:Properties_of_binary_operations "Category:Properties of binary operations")
- [Algebraic properties of elements](/wiki/Category:Algebraic_properties_of_elements "Category:Algebraic properties of elements")
- [Closure operators](/wiki/Category:Closure_operators "Category:Closure operators")
- [Mathematical relations](/wiki/Category:Mathematical_relations "Category:Mathematical relations")
- [Theoretical computer science](/wiki/Category:Theoretical_computer_science "Category:Theoretical computer science")
Hidden categories:
- [CS1 French-language sources (fr)](/wiki/Category:CS1_French-language_sources_(fr) "Category:CS1 French-language sources (fr)")
- [Webarchive template wayback links](/wiki/Category:Webarchive_template_wayback_links "Category:Webarchive template wayback links")
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [All articles with unsourced statements](/wiki/Category:All_articles_with_unsourced_statements "Category:All articles with unsourced statements")
- [Articles with unsourced statements from March 2017](/wiki/Category:Articles_with_unsourced_statements_from_March_2017 "Category:Articles with unsourced statements from March 2017")
