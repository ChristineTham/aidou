Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Test-driven_development&oldid=1360554329 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Test-driven_development&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Test-driven_development&id=1360554329&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FTest-driven_development)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Test-driven_development&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Method of writing code
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
## History
<style data-mw-deduplicate="TemplateStyles:r1244412712">.mw-parser-output .templatequote{overflow:hidden;margin:1em 0;padding:0 32px}.mw-parser-output .templatequotecite{line-height:1.5em;text-align:left;margin-top:0}@media(min-width:500px){.mw-parser-output .templatequotecite{padding-left:1.6em}}</style>
> The original description of TDD was in an ancient book about programming. It said you take the input tape, manually type in the output tape you expect, then program until the actual output tape matches the expected output. After I'd written the first xUnit framework in [Smalltalk](/wiki/Smalltalk "Smalltalk") I remembered reading this and tried it out. That was the origin of TDD for me. When describing TDD to older programmers, I often hear, "Of course. How else could you program?" Therefore I refer to my role as "rediscovering" TDD.
## Coding cycle
<figcaption>A graphical representation of the test-driven development lifecycle</figcaption>
</figure>
1\. List scenarios for the new feature  
List the expected variants in the new behavior. "There's the basic case & then what-if this service times out & what-if the key isn't in the database yet &…" The developer can discover these specifications by asking about [use cases](/wiki/Use_case "Use case") and [user stories](/wiki/User_story "User story"). A key benefit of TDD is that it makes the developer focus on requirements *before* writing code. This is in contrast with the usual practice, where unit tests are only written *after* code.
2\. Write a test for an item on the list  
Write an automated test that *would* pass if the variant in the new behavior is met.
3\. Run all tests. The new test should *fail* – for *expected* reasons  
This shows that new code is actually needed for the desired feature. It validates that the [test harness](/wiki/Test_harness "Test harness") is working correctly. It rules out the possibility that the new test is flawed and will always pass.
4\. Write the simplest code that passes the new test  
Inelegant code and [hard coding](/wiki/Hard_coding "Hard coding") is acceptable. The code will be honed in Step 6. No code should be added beyond the tested functionality.
5\. All tests should now pass  
If any fail, fix failing tests with minimal changes until all pass.
6\. Refactor as needed while ensuring all tests continue to pass  
- moving code to where it most logically belongs
- removing [duplicate code](/wiki/Duplicate_code "Duplicate code")
- making [names](/wiki/Identifier_(computer_languages) "Identifier (computer languages)") [self-documenting](/wiki/Self-documenting_code "Self-documenting code")
- splitting methods into smaller pieces
- re-arranging [inheritance hierarchies](/wiki/Inheritance_(object-oriented_programming) "Inheritance (object-oriented programming)")
<!-- -->
Repeat  
Repeat the process, starting at step 2, with each test on the list until all tests are implemented and passing.
## Test-driven work
1.  "Add a check" replaces "Add a test"
2.  "Run all checks" replaces "Run all tests"
3.  "Do the work" replaces "Write some code"
4.  "Run all checks" replaces "Run tests"
5.  "Clean up the work" replaces "Refactor code"
6.  "Repeat"
## Development style
To achieve some advanced design concept such as a [design pattern](/wiki/Design_pattern "Design pattern"), tests are written that generate that design. The code may remain simpler than the target pattern, but still pass all required tests. This can be unsettling at first but it allows the developer to focus only on what is important.
Each test case fails initially: This ensures that the test really works and can catch an error. Once this is shown, the underlying functionality can be implemented. This has led to the "test-driven development mantra", which is "red/green/refactor", where red means *fail* and green means *pass*. Test-driven development constantly repeats the steps of adding test cases that fail, passing them, and refactoring. Receiving the expected test results at each stage reinforces the developer's mental model of the code, boosts confidence and increases productivity.
### Code visibility
<style data-mw-deduplicate="TemplateStyles:r1353705441">.mw-parser-output .hatnote{font-style:italic}.mw-parser-output div.hatnote{padding-left:1.6em;margin-bottom:0.5em}.mw-parser-output .hatnote i{font-style:normal}.mw-parser-output .hatnote+span.mw-empty-elt+.hatnote,.mw-parser-output .hatnote+link+.hatnote{margin-top:-0.5em}@media print{body.ns-0 .mw-parser-output .hatnote{display:none!important}}</style>
Main article: [Unit_testing § Code_Visibility](/wiki/Unit_testing#Code_Visibility "Unit testing")
In test-driven development, writing tests before implementation raises questions about testing [private methods](/wiki/Access_modifiers "Access modifiers") versus testing only through [public interfaces](/wiki/Interface_(computing) "Interface (computing)"). This choice affects the design of both test code and production code.
### Test isolation
Test-driven development relies primarily on [unit tests](/wiki/Unit_testing "Unit testing") for its rapid red-green-refactor cycle. These tests execute quickly by avoiding process boundaries, network connections, or external dependencies. While TDD practitioners also write [integration tests](/wiki/Integration_testing "Integration testing") to verify component interactions, these slower tests are kept separate from the more frequent unit test runs. Testing multiple integrated modules together also makes it more difficult to identify the source of failures.
Since test doubles don't prove the connection to real external components, TDD practitioners supplement unit tests with [integration testing](/wiki/Integration_testing "Integration testing") at appropriate levels. To keep execution faster and more reliable, testing is maximized at the unit level while minimizing slower tests at higher levels.
### Keep the unit small
For TDD, a unit is most commonly defined as a class, or a group of related functions often called a module. Keeping units relatively small is claimed to provide critical benefits, including:
- Reduced debugging effort – When test failures are detected, having smaller units aids in tracking down errors.
## Best practices
### Test structure
Effective layout of a test case ensures all required actions are completed, improves the readability of the test case, and smooths the flow of execution. Consistent structure helps in building a self-documenting test case. A commonly applied structure for test cases has (1) setup, (2) execution, (3) validation, and (4) cleanup.
- Setup: Put the unit under test (UUT) or the overall test system in the state needed to run the test.
- Execution: Trigger/drive the UUT to perform the target behavior and capture all output, such as return values and output parameters. This step is usually very simple.
- Validation: Ensure the results of the test are correct. These results may include explicit outputs captured during execution or state changes in the UUT.
### Individual best practices
### <span id="Practices_to_avoid.2C_or_.22anti-patterns.22"></span>Practices to avoid, or "anti-patterns"
See also: [Anti-pattern](/wiki/Anti-pattern "Anti-pattern")
- Having test cases depend on system state manipulated from previously executed test cases (i.e., you should always start a unit test from a known and pre-configured state).
- Dependencies between test cases. A test suite where test cases are dependent upon each other is brittle and complex. Execution order should not be presumed. Basic refactoring of the initial test cases or structure of the UUT causes a spiral of increasingly pervasive impacts in associated tests.
- Interdependent tests. Interdependent tests can cause cascading false negatives. A failure in an early test case breaks a later test case even if no actual fault exists in the UUT, increasing defect analysis and debug efforts.
- Testing precise execution, timing or performance.
- Testing implementation details.
- Slow running tests.
## Comparison and demarcation
### TDD and ATDD
### TDD and BDD
## Software for TDD
There are many testing frameworks and tools that are useful in TDD.
### xUnit frameworks
### TAP results
Testing frameworks may accept unit test output in the language-agnostic [Test Anything Protocol](/wiki/Test_Anything_Protocol "Test Anything Protocol") created in 1987.
## TDD for complex systems
### Designing for testability
Complex systems require an architecture that meets a range of requirements. A key subset of these requirements includes support for the complete and effective testing of the system. Effective modular design yields components that share traits essential for effective TDD.
- [High Cohesion](/wiki/Cohesion_(computer_science) "Cohesion (computer science)") ensures each unit provides a set of related capabilities and makes the tests of those capabilities easier to maintain.
- [Low Coupling](/wiki/Coupling_(computer_programming) "Coupling (computer programming)") allows each unit to be effectively tested in isolation.
- Published Interfaces restrict Component access and serve as contact points for tests, facilitating test creation and ensuring the highest fidelity between test and production unit configuration.
### Managing tests for large teams
In a larger system, the impact of poor component quality is magnified by the complexity of interactions. This magnification makes the benefits of TDD accrue even faster in the context of larger projects. However, the complexity of the total population of tests can become a problem in itself, eroding potential gains. It sounds simple, but a key initial step is to recognize that test code is also important software and should be produced and maintained with the same rigor as the production code.
## Advantages and disadvantages
### Potential benefits
### Limitations
TDD is not a substitute for other forms of [software testing](/wiki/Software_testing "Software testing"). Since TDD is commonly practiced through [unit testing](/wiki/Unit_testing "Unit testing"), it may not adequately test behavior that depends on user interfaces, databases, distributed systems, hardware, timing, security properties, or interactions between components. These areas often require additional [integration testing](/wiki/Integration_testing "Integration testing"), [system testing](/wiki/System_testing "System testing"), acceptance testing, usability testing, or other specialized testing methods.
Tests written during TDD may share the same misunderstandings as the production code. If a developer misinterprets a requirement, both the test and the implementation can encode the same incorrect assumption, causing the test to pass while the software remains wrong. A large number of passing tests can therefore create a false sense of security if the tests are incomplete, overly narrow, or focused on implementation details rather than externally visible behavior.
## Conference
## See also
<style data-mw-deduplicate="TemplateStyles:r1184024115">.mw-parser-output .div-col{margin-top:0.3em;column-width:30em}.mw-parser-output .div-col-small{font-size:90%}.mw-parser-output .div-col-rules{column-rule:1px solid #aaa}.mw-parser-output .div-col dl,.mw-parser-output .div-col ol,.mw-parser-output .div-col ul{margin-top:0}.mw-parser-output .div-col li,.mw-parser-output .div-col dd{page-break-inside:avoid;break-inside:avoid-column}</style>
- [Acceptance testing](/wiki/Acceptance_testing "Acceptance testing")
- [Behavior-driven development](/wiki/Behavior-driven_development "Behavior-driven development")
- [Design by contract](/wiki/Design_by_contract "Design by contract")
- [Inductive programming](/wiki/Inductive_programming "Inductive programming")
- [Integration testing](/wiki/Integration_testing "Integration testing")
- [List of software development philosophies](/wiki/List_of_software_development_philosophies "List of software development philosophies")
- [List of unit testing frameworks](/wiki/List_of_unit_testing_frameworks "List of unit testing frameworks")
- [Mock object](/wiki/Mock_object "Mock object")
- [Programming by example](/wiki/Programming_by_example "Programming by example")
- [Sanity check](/wiki/Sanity_check "Sanity check")
- [Self-testing code](/wiki/Self-testing_code "Self-testing code")
- [Software testing](/wiki/Software_testing "Software testing")
- [Transformation Priority Premise](/wiki/Transformation_Priority_Premise "Transformation Priority Premise")
- [Unit testing](/wiki/Unit_testing "Unit testing")
- [Continuous test-driven development](/wiki/Continuous_test-driven_development "Continuous test-driven development")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## External links
[Categories](/wiki/Help:Category "Help:Category"):
- [Extreme programming](/wiki/Category:Extreme_programming "Category:Extreme programming")
- [Software development philosophies](/wiki/Category:Software_development_philosophies "Category:Software development philosophies")
- [Software development process](/wiki/Category:Software_development_process "Category:Software development process")
- [Software testing](/wiki/Category:Software_testing "Category:Software testing")
Hidden categories:
- [CS1 maint: deprecated archival service](/wiki/Category:CS1_maint:_deprecated_archival_service "Category:CS1 maint: deprecated archival service")
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
- [Wikipedia articles needing clarification from February 2022](/wiki/Category:Wikipedia_articles_needing_clarification_from_February_2022 "Category:Wikipedia articles needing clarification from February 2022")
