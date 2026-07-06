Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Design_by_contract&oldid=1358864076 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Design_by_contract&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Design_by_contract&id=1358864076&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FDesign_by_contract)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Design_by_contract&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
</tr>
</tbody>
</table>
Approach for designing software
<figcaption>A design by contract scheme</figcaption>
</figure>
**Design by contract** (**DbC**), also known as **contract programming**, **programming by contract** and **design-by-contract programming**, is an approach for [designing software](/wiki/Software_design "Software design").
The DbC approach [assumes](/wiki/Offensive_programming "Offensive programming") all *client components* that invoke an operation on a *server component* will meet the preconditions specified as required for that operation.
Where this assumption is considered too risky (as in multi-channel or [distributed computing](/wiki/Distributed_computing "Distributed computing")), the [inverse approach](/wiki/Defensive_programming "Defensive programming") is taken, meaning that the *server component* tests that all relevant preconditions hold true (before, or while, processing the *client component'*s request) and replies with a suitable error message if not.
## History
Design by contract has its roots in work on [formal verification](/wiki/Formal_verification "Formal verification"), [formal specification](/wiki/Formal_specification "Formal specification") and [Hoare logic](/wiki/Hoare_logic "Hoare logic"). The original contributions include:
- A clear metaphor to guide the design process
- The connection with automatic [software documentation](/wiki/Software_documentation "Software documentation")
## Description
The central idea of DbC is a metaphor on how elements of a software system collaborate with each other on the basis of mutual *obligations* and *benefits*. The metaphor comes from business life, where a "client" and a "supplier" agree on a "contract" that defines, for example, that:
- The supplier must provide a certain product (obligation) and is entitled to expect that the client has paid its fee (benefit).
- The client must pay the fee (obligation) and is entitled to get the product (benefit).
- Both parties must satisfy certain obligations, such as laws and regulations, applying to all contracts.
- Expect a certain condition to be guaranteed on entry by any client module that calls it: the method's [precondition](/wiki/Precondition "Precondition")—an obligation for the client, and a benefit for the supplier (the method itself), as it frees it from having to handle cases outside of the precondition.
- Guarantee a certain property on exit: the method's [postcondition](/wiki/Postcondition "Postcondition")—an obligation for the supplier, and obviously a benefit (the main benefit of calling the method) for the client.
- Maintain a certain property, assumed on entry and guaranteed on exit: the [class invariant](/wiki/Class_invariant "Class invariant").
- What does the contract expect?
- What does the contract guarantee?
- What does the contract maintain?
Many [programming languages](/wiki/Programming_language "Programming language") have facilities to make [assertions](/wiki/Assertion_(software_development) "Assertion (software development)") like these. However, DbC considers these contracts to be so crucial to [software correctness](/wiki/Correctness_(computer_science) "Correctness (computer science)") that they should be part of the design process. In effect, DbC advocates [writing the assertions first](/wiki/Test-driven_development "Test-driven development").<sup>\[*[<span title="This claim needs references to reliable sources. (June 2019)">citation needed</span>](/wiki/Wikipedia:Citation_needed "Wikipedia:Citation needed")*\]</sup> Contracts can be written by [code comments](/wiki/Comment_(computer_programming) "Comment (computer programming)"), enforced by a [test suite](/wiki/Test_suite "Test suite"), or both, even if there is no special language support for contracts.
The notion of a contract extends down to the method/procedure level; the contract for each method will normally contain the following pieces of information:<sup>\[*[<span title="reliable source needed for the following list (September 2012)">citation needed</span>](/wiki/Wikipedia:Citation_needed "Wikipedia:Citation needed")*\]</sup>
- Acceptable and unacceptable input values or types, and their meanings
- Return values or types, and their meanings
- Error and [exception](/wiki/Exception_handling "Exception handling") condition values or types that can occur, and their meanings
- [Side effects](/wiki/Side_effect_(computer_science) "Side effect (computer science)")
- [Preconditions](/wiki/Precondition "Precondition")
- [Postconditions](/wiki/Postcondition "Postcondition")
- (more rarely) Performance guarantees, e.g. for time or space used
Subclasses in an [inheritance hierarchy](/wiki/Inheritance_(object-oriented_programming) "Inheritance (object-oriented programming)") are allowed to weaken preconditions (but not strengthen them) and strengthen postconditions and invariants (but not weaken them). These rules approximate [behavioural subtyping](/wiki/Liskov_substitution_principle "Liskov substitution principle").
All class relationships are between client classes and supplier classes. A client class is obliged to make calls to supplier features where the resulting state of the supplier is not violated by the client call. Subsequently, the supplier is obliged to provide a return state and data that does not violate the state requirements of the client.
For instance, a supplier data buffer may require that data is present in the buffer when a delete feature is called. Subsequently, the supplier guarantees to the client that when a delete feature finishes its work, the data item will, indeed, be deleted from the buffer. Other design contracts are concepts of [class invariant](/wiki/Class_invariant "Class invariant"). The class invariant guarantees (for the local class) that the state of the class will be maintained within specified tolerances at the end of each feature execution.
When using contracts, a supplier will verify that the contract conditions are satisfied—a practice known as [offensive programming](/wiki/Offensive_programming "Offensive programming")—the general idea being that code should "fail hard", with contract verification being the safety net.
DbC's "fail hard" property simplifies the debugging of contract behavior, as the intended behaviour of each method is clearly specified.
This approach differs substantially from that of [defensive programming](/wiki/Defensive_programming "Defensive programming"), where the supplier is responsible for figuring out what to do when a precondition is broken. More often than not, the supplier throws an exception to inform the client that the precondition has been broken, and in both cases—DbC and defensive programming alike—the client must figure out how to respond to that. In such cases, DbC makes the supplier's job easier.
Design by contract also defines criteria for correctness for a software module:
- If the class invariant AND precondition are true before a supplier is called by a client, then the invariant AND the postcondition will be true after the service has been completed.
- When making calls to a supplier, a software module should not violate the supplier's preconditions.
Design by contract can also facilitate code reuse, since the contract for each piece of code is fully documented. The contracts for a module can be regarded as a form of [software documentation](/wiki/Software_documentation "Software documentation") for the behavior of that module.
    int f(const int x)
        pre(x != 1) // a precondition assertion
        post(r : r == x && r != 2) // a postcondition assertion; r names the result object of f
    {
        contract_assert(x != 3); // an assertion statement
        return x;
    }
## Performance implications
Contract conditions should never be violated during execution of a bug-free program. Contracts are therefore typically only checked in debug mode during software development. Later at release, the contract checks are disabled to maximize performance.
This effectively eliminates the run-time costs of asserts in production code—irrespective of the number and computational expense of asserts used in development—as no such instructions will be included in production by the compiler.
## Relationship to software testing
Design by contract does not replace regular testing strategies, such as [unit testing](/wiki/Unit_testing "Unit testing"), [integration testing](/wiki/Integration_testing "Integration testing") and [system testing](/wiki/System_testing "System testing"). Rather, it complements external testing with internal self-tests that can be activated both for isolated tests and in production code during a test-phase.
The advantage of internal self-tests is that they can detect errors before they manifest themselves as invalid results observed by the client. This leads to earlier and more specific error detection.
The use of assertions can be considered to be a form of [test oracle](/wiki/Test_oracle "Test oracle"), a way of testing the design by contract implementation.
## Language support
### Languages with native support
Languages that implement most DbC features natively include:
- [Ada 2012](/wiki/Ada_(programming_language) "Ada (programming language)")
- [Ciao](/wiki/Ciao_(programming_language) "Ciao (programming language)")
- [Clojure](/wiki/Clojure "Clojure")
- [Cobra](/wiki/Cobra_(programming_language) "Cobra (programming language)")
- [Eiffel](/wiki/Eiffel_(programming_language) "Eiffel (programming language)")
- [Fortress](/wiki/Fortress_(programming_language) "Fortress (programming language)")
- [Kotlin](/wiki/Kotlin "Kotlin")
- [Mercury](/wiki/Mercury_(programming_language) "Mercury (programming language)")
- [Sather](/wiki/Sather "Sather")
- [Vala](/wiki/Vala_(programming_language) "Vala (programming language)")
- [Vienna Development Method](/wiki/Vienna_Development_Method "Vienna Development Method") (VDM)
Further, the standard method combination in the [Common Lisp Object System](/wiki/Common_Lisp_Object_System "Common Lisp Object System") has the method qualifiers `:before`, `:after` and `:around` that allow writing contracts as auxiliary methods, among other uses.
## See also
- [Component-based software engineering](/wiki/Component-based_software_engineering "Component-based software engineering")
- [Correctness (computer science)](/wiki/Correctness_(computer_science) "Correctness (computer science)")
- [Defensive programming](/wiki/Defensive_programming "Defensive programming")
- [Fail-fast system](/wiki/Fail-fast_system "Fail-fast system")
- [Formal methods](/wiki/Formal_methods "Formal methods")
- [Hoare logic](/wiki/Hoare_logic "Hoare logic")
- [Modular programming](/wiki/Modular_programming "Modular programming")
- [Program derivation](/wiki/Program_derivation "Program derivation")
- [Test-driven development](/wiki/Test-driven_development "Test-driven development")
- [Typestate analysis](/wiki/Typestate_analysis "Typestate analysis")
## Notes
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## Bibliography
<style data-mw-deduplicate="TemplateStyles:r1239549316">.mw-parser-output .refbegin{margin-bottom:0.5em}.mw-parser-output .refbegin-hanging-indents>ul{margin-left:0}.mw-parser-output .refbegin-hanging-indents>ul>li{margin-left:0;padding-left:3.2em;text-indent:-3.2em}.mw-parser-output .refbegin-hanging-indents ul,.mw-parser-output .refbegin-hanging-indents ul li{list-style:none}@media(max-width:720px){.mw-parser-output .refbegin-hanging-indents>ul>li{padding-left:1.6em;text-indent:-1.6em}}.mw-parser-output .refbegin-columns{margin-top:0.3em}.mw-parser-output .refbegin-columns ul{margin-top:0}.mw-parser-output .refbegin-columns li{page-break-inside:avoid;break-inside:avoid-column}@media screen{.mw-parser-output .refbegin{font-size:90%}}</style>
- Mitchell, Richard, and McKim, Jim: *Design by Contract: by example*, Addison-Wesley, 2002
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
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
Disciplines
</tr>
&#10;<tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
design</a></th>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
design</a></th>
<ul>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
</ul>
</tr>
<tr>
design</a></th>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
design</a></th>
<ul>
<ul>
</ul></li>
<ul>
</ul></li>
</ul>
</tr>
<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
design<br />
<ul>
<ul>
</ul></li>
</ul>
</tr>
</tbody>
</table>
</tr>
</tbody>
</table>
</tr>
<tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
Approaches
</tr>
&#10;<tr>
<ul>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
<ul>
</ul></li>
</ul>
<ul>
</ul>
</tr>
</tbody>
</table>
</tr>
<tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
<ul>
<li>Tools</li>
<li>Intellectual property</li>
<li>Organizations</li>
<li>Awards</li>
</ul>
</tr>
&#10;<tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
<ul>
<ul>
</ul></li>
</ul>
</tr>
<tr>
property</th>
<ul>
<ul>
</ul></li>
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
</tbody>
</table>
</tr>
<tr>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
Related topics
</tr>
&#10;<tr>
<ul>
</ul>
<ul>
<ul>
</ul></li>
</ul>
</tr>
</tbody>
</table>
</tr>
</tbody>
</table>
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
</tbody>
</table>
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
<tr>
specific<br />
language</a><br />
(DSL)</th>
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
<tr>
of concerns</a></th>
<ul>
</ul>
</tr>
<tr>
</tr>
</tbody>
</table>
[Categories](/wiki/Help:Category "Help:Category"):
- [Software design](/wiki/Category:Software_design "Category:Software design")
- [Programming paradigms](/wiki/Category:Programming_paradigms "Category:Programming paradigms")
Hidden categories:
- [Articles needing additional references from July 2025](/wiki/Category:Articles_needing_additional_references_from_July_2025 "Category:Articles needing additional references from July 2025")
- [All articles needing additional references](/wiki/Category:All_articles_needing_additional_references "Category:All articles needing additional references")
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [All articles with unsourced statements](/wiki/Category:All_articles_with_unsourced_statements "Category:All articles with unsourced statements")
- [Articles with unsourced statements from June 2019](/wiki/Category:Articles_with_unsourced_statements_from_June_2019 "Category:Articles with unsourced statements from June 2019")
- [Articles with unsourced statements from September 2012](/wiki/Category:Articles_with_unsourced_statements_from_September_2012 "Category:Articles with unsourced statements from September 2012")
- [Articles with example code](/wiki/Category:Articles_with_example_code "Category:Articles with example code")
