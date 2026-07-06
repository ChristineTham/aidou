Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Capability-based_security&oldid=1342003344 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Capability-based_security&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Capability-based_security&id=1342003344&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FCapability-based_security)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Capability-based_security&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Computer safety concept
**Capability-based security** is a concept in the design of [secure computing](/wiki/Computer_security "Computer security") systems, one of the existing [security models](/wiki/Computer_security_model "Computer security model"). A **capability** (known in some systems as a **key**) is a communicable, unforgeable [token](/wiki/Access_token "Access token") of authority. It refers to a value that [references](/wiki/Reference_(computer_science) "Reference (computer science)") an [object](/wiki/Object_(computer_science) "Object (computer science)") along with an associated set of [access rights](/wiki/Access_control "Access control"). A [user](/wiki/User_(computing) "User (computing)") [program](/wiki/Computer_program "Computer program") on a [capability-based operating system](/wiki/Capability-based_operating_system "Capability-based operating system") must use a capability to access an object. Capability-based security refers to the principle of designing user programs such that they directly share capabilities with each other according to the [principle of least privilege](/wiki/Principle_of_least_privilege "Principle of least privilege"), and to the operating system infrastructure necessary to make such transactions efficient and secure. Capability-based security is to be contrasted with an approach that uses [traditional UNIX permissions](/wiki/File-system_permissions "File-system permissions") and [access control lists](/wiki/Access-control_list "Access-control list").
Although most operating systems implement a facility which resembles capabilities, they typically do not provide enough support to allow for the exchange of capabilities among possibly mutually untrusting entities to be the primary means of granting and distributing access rights throughout the system. A capability-based system, in contrast, is designed with that goal in mind.
## Introduction
Capabilities achieve their objective of improving system security by being used in place of forgeable [references](/wiki/Reference_(computer_science) "Reference (computer science)"). A forgeable reference (for example, a [path name](/wiki/Path_(computing) "Path (computing)")) identifies an object, but does not specify which access rights are appropriate for that object and the user program which holds that reference. Consequently, any attempt to access the referenced object must be validated by the operating system, based on the [ambient authority](/wiki/Ambient_authority "Ambient authority") of the requesting program, typically via the use of an [access-control list](/wiki/Access-control_list "Access-control list") (ACL). Instead, in a system with capabilities, the mere fact that a user program possesses that capability entitles it to use the referenced object in accordance with the rights that are specified by that capability. In theory, a system with capabilities removes the need for any access control list or similar mechanism by giving all entities all and only the capabilities they will actually need.
A capability is typically implemented as a [privileged](/wiki/Privilege_(computing) "Privilege (computing)") [data structure](/wiki/Data_structure "Data structure") that consists of a section that specifies access rights, and a section that uniquely identifies the object to be accessed. The user does not access the data structure or object directly, but instead via a [handle](/wiki/Handle_(computing) "Handle (computing)"). In practice, it is used much like a [file descriptor](/wiki/File_descriptor "File descriptor") in a traditional operating system (a traditional handle), but to access every object on the system. Capabilities are typically stored by the operating system in a list, with some mechanism in place to prevent the program from directly modifying the contents of the capability (so as to forge access rights or change the object it points to). Some systems have also been based on [capability-based addressing](/wiki/Capability-based_addressing "Capability-based addressing") (hardware support for capabilities), such as [Plessey System 250](/wiki/Plessey_System_250 "Plessey System 250").
Programs possessing capabilities can perform functions on them, such as passing them on to other programs, converting them to a less-privileged version, or deleting them. The operating system must ensure that only specific operations can occur to the capabilities in the system, in order to maintain the integrity of the security policy.
Capabilities as discussed in this article should not be confused with Portable Operating System Interface ([POSIX](/wiki/POSIX "POSIX")) 1e/2c "[Capabilities](#POSIX_capabilities)". The latter are coarse-grained privileges that cannot be transferred between processes.
## Examples
A capability is defined to be a protected [object](/wiki/Object_(computer_science) "Object (computer science)") reference which, by virtue of its possession by a user process, grants that process the capability (hence the name) to interact with an object in certain ways. Those ways might include reading data associated with an object, modifying the object, executing the data in the object as a process, and other conceivable access rights. The capability logically consists of a reference that uniquely identifies a particular object and a set of one or more of these rights.
Suppose that, in a user process's memory space, there exists the following string:
    /etc/passwd
Although this identifies a unique object on the system, it does not specify access rights and hence is not a capability. Suppose there is instead the following pair of values:
    /etc/passwd
    O_RDWR
This pair identifies an object along with a set of access rights. The pair, however, is still not a capability because the user process's *possession* of these values says nothing about whether that access would actually be legitimate.
Now suppose that the user program successfully executes the following statement:
    int fd = open("/etc/passwd", O_RDWR);
The variable `fd` now contains the index of a file descriptor in the process's file descriptor table. This file descriptor *is* a capability. Its existence in the process's file descriptor table is sufficient to show that the process does indeed have legitimate access to the object. A key feature of this arrangement is that the file descriptor table is in [kernel memory](/wiki/Kernel_(operating_system) "Kernel (operating system)") and cannot be directly manipulated by the user program.
## Sharing between processes
In a capability-based system, the capabilities themselves are passed between processes and storage using a mechanism that is known by the operating system to maintain the integrity of those capabilities.
## POSIX capabilities
## Implementations
Notable research and commercial systems employing capability-based security include the following:
- [Tahoe-LAFS](/wiki/Tahoe-LAFS "Tahoe-LAFS"), an open-source capability-based filesystem
- [RedoxOS](/wiki/RedoxOS "RedoxOS")
- [L4 microkernel family](/wiki/L4_microkernel_family "L4 microkernel family"):
  - OKL4 from Open Kernel Labs
  - [seL4](/wiki/SeL4 "SeL4") from NICTA
  - Fiasco.OC and NOVA from [TU Dresden](/wiki/TU_Dresden "TU Dresden")
- [WebAssembly](/wiki/WebAssembly "WebAssembly") System Interface (WASI)
### Discontinued
- [Amoeba](/wiki/Amoeba_(operating_system) "Amoeba (operating system)") distributed operating system
- [GNOSIS](/wiki/GNOSIS "GNOSIS"), an operating system developed at [Tymshare](/wiki/Tymshare "Tymshare")
  - [KeyKOS](/wiki/KeyKOS "KeyKOS"), successor to GNOSIS
- [Hydra (operating system)](/wiki/Hydra_(operating_system) "Hydra (operating system)"), part of the [C.mmp](/wiki/C.mmp "C.mmp") project at [Carnegie Mellon University](/wiki/Carnegie_Mellon_University "Carnegie Mellon University")
- [Intel iAPX 432](/wiki/Intel_iAPX_432 "Intel iAPX 432")
- [Plessey System 250](/wiki/Plessey_System_250 "Plessey System 250")
- [Flex](/wiki/Flex_machine "Flex machine")
## See also
- [Privilege separation](/wiki/Privilege_separation "Privilege separation")
- [Role-based access control](/wiki/Role-based_access_control "Role-based access control")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## Further reading
POSIX "capabilities" in Linux:
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
- [Computer security models](/wiki/Category:Computer_security_models "Category:Computer security models")
- [Access control](/wiki/Category:Access_control "Category:Access control")
- [Capability systems](/wiki/Category:Capability_systems "Category:Capability systems")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description is different from Wikidata](/wiki/Category:Short_description_is_different_from_Wikidata "Category:Short description is different from Wikidata")
