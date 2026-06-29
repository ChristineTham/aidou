Tools
move to sidebar
hide
Actions
General
- <span id="t-permalink">[Permanent link](/w/index.php?title=Digital_watermarking&oldid=1359109402 "Permanent link to this revision of this page")</span>
- <span id="t-info">[Page information](/w/index.php?title=Digital_watermarking&action=info "More information about this page")</span>
- <span id="t-cite">[Cite this page](/w/index.php?title=Special:CiteThisPage&page=Digital_watermarking&id=1359109402&wpFormIdentifier=titleform "Information on how to cite this page")</span>
- <span id="t-urlshortener">[Get shortened URL](/w/index.php?title=Special:UrlShortener&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FDigital_watermarking)</span>
Print/export
- <span id="coll-download-as-rl">[Download as PDF](/w/index.php?title=Special:DownloadAsPdf&page=Digital_watermarking&action=show-download-screen "Download this page as a PDF file")</span>
In other projects
Appearance
move to sidebar
hide
From Wikipedia, the free encyclopedia
Marker covertly embedded in a signal
</figure>
The needed properties of a digital watermark depend on the [use case](/wiki/Use_case "Use case") in which it is applied. For marking media files with copyright information, a digital watermark has to be rather robust against modifications that can be applied to the carrier signal. Instead, if integrity has to be ensured, a fragile watermark would be applied.
Both [steganography](/wiki/Steganography "Steganography") and digital watermarking employ steganographic techniques to embed data covertly in noisy signals. While steganography aims for imperceptibility to human senses, digital watermarking tries to control the robustness as top priority.
Since a digital copy of data is the same as the original, digital watermarking is a passive protection tool. It just marks data, but does not degrade it or control access to the data.
One application of digital watermarking is *source tracking*. A watermark is embedded into a digital signal at each point of distribution. If a copy of the work is found later, then the watermark may be retrieved from the copy and the source of the distribution is known. This technique has reportedly been used to detect the source of illegally copied movies.
## History
[Watermarks](/wiki/Watermark "Watermark") are identification marks produced during the paper-making process. The first watermarks appeared in Italy during the 13th century, but their use rapidly spread across Europe. They were used as a means to identify the paper maker or the trade guild that manufactured the paper. The marks were often created by a wire sewn onto the paper mold. Watermarks continue to be used today as manufacturers' marks and to prevent forgery.
## Applications
Digital watermarking may be used for a wide range of applications, such as:
- Source tracking (different recipients get differently watermarked content)
- Broadcast monitoring (television news often contains watermarked video from international agencies)
- Video authentication
- Fraud and tamper detection
- [AI content watermarking](/wiki/AI_content_watermarking "AI content watermarking") (e.g. [Google](/wiki/Google "Google") SynthID and [OpenAI](/wiki/OpenAI "OpenAI") [Sora](/wiki/Sora_(text-to-video_model) "Sora (text-to-video model)"))
## Digital watermarking life-cycle phases
<figure typeof="mw:File/Thumb">
<figcaption>General digital watermark life-cycle phases with embedding-, attacking-, and detection and retrieval functions</figcaption>
</figure>
The information to be embedded in a signal is called a digital watermark, although in some contexts the phrase digital watermark means the difference between the watermarked signal and the cover signal. The signal where the watermark is to be embedded is called the *host* signal. A watermarking system is usually divided into three distinct steps, embedding, attack, and detection. In embedding, an algorithm accepts the host and the data to be embedded, and produces a watermarked signal.
*Detection* (often called extraction) is an algorithm that is applied to the attacked signal to attempt to extract the watermark from it. If the signal was unmodified during transmission, then the watermark still is present and it may be extracted. In *robust* digital watermarking applications, the extraction algorithm should be able to produce the watermark correctly, even if the modifications were strong. In *fragile* digital watermarking, the extraction algorithm should fail if any change is made to the signal.
## Classification
Digital watermarking techniques may be classified in several ways.
### Robustness
A digital watermark is called *fragile* if it fails to be detectable after the slightest modification. Fragile watermarks are commonly used for tamper detection (integrity proof). Modifications to an original work that clearly are noticeable, commonly are not referred to as watermarks, but as generalized [barcodes](/wiki/Barcode "Barcode")<sup>\[*[<span title="The text near this tag may need clarification or removal of jargon. (November 2025)">clarification needed</span>](/wiki/Wikipedia:Please_clarify "Wikipedia:Please clarify")*\]</sup>.
A digital watermark is called *semi-fragile* if it resists benign transformations, but fails detection after malignant transformations. Semi-fragile watermarks commonly are used to detect malignant transformations.
A digital watermark is called *robust* if it resists a designated class of transformations. Robust watermarks may be used in copy protection applications to carry copy and no access control information.
### Perceptibility
A digital watermark is called *imperceptible* if the original cover signal and the marked signal are perceptually indistinguishable.
A digital watermark is called *perceptible* if its presence in the marked signal is noticeable (e.g. digital on-screen graphics like a network logo, content bug, codes, opaque images). On videos and images, some are made transparent/translucent for convenience for consumers due to the fact that they block portion of the view; therefore degrading it.
This should not be confused with *perceptual*, that is, watermarking which uses the limitations of human perception to be imperceptible.
### Capacity
The length of the embedded message determines two different main classes of digital watermarking schemes:
- The message is conceptually zero-bit long and the system is designed in order to detect the presence or the absence of the watermark in the marked object. This kind of watermarking scheme is usually referred to as *zero-bit* or *presence watermarking schemes*.
### Embedding method
A digital watermarking method is said to be of *quantization type* if the marked signal is obtained by quantization. Quantization watermarks suffer from low robustness, but have a high information capacity due to rejection of host interference.
A digital watermarking method is referred to as *[amplitude modulation](/wiki/Amplitude_modulation "Amplitude modulation")* if the marked signal is embedded by additive modification which is similar to spread spectrum method, but is particularly embedded in the spatial domain.
## Evaluation and benchmarking
The evaluation of digital watermarking schemes may provide detailed information for a watermark designer or for end-users, therefore, different evaluation strategies exist. Often used by a watermark designer is the evaluation of single properties to show, for example, an improvement. Mostly, end-users are not interested in detailed information. They want to know if a given digital watermarking algorithm may be used for their application scenario, and if so, which parameter sets seems to be the best.
## Cameras
## Reversible data hiding
## Watermarking for relational databases
## See also
- [Audio watermark](/wiki/Audio_watermark "Audio watermark")
- [Automatic content recognition](/wiki/Automatic_content_recognition "Automatic content recognition")
- [Chip art](/wiki/Chip_art "Chip art")
- [Copy attack](/wiki/Copy_attack "Copy attack")
- [Digital on-screen graphic](/wiki/Digital_on-screen_graphic "Digital on-screen graphic")
- [EURion constellation](/wiki/EURion_constellation "EURion constellation")
- [Pattern Recognition (novel)](/wiki/Pattern_Recognition_(novel) "Pattern Recognition (novel)")
- [Printer tracking dots](/wiki/Printer_tracking_dots "Printer tracking dots")
- [Steganography](/wiki/Steganography "Steganography")
- [Text watermarking](/wiki/Text_watermarking "Text watermarking")
- [Traitor tracing](/wiki/Traitor_tracing "Traitor tracing")
- [Watermark (data file)](/wiki/Watermark_(data_file) "Watermark (data file)")
## References
<style data-mw-deduplicate="TemplateStyles:r1327269900">.mw-parser-output .reflist-columns-2{column-width:30em}.mw-parser-output .reflist-columns-3{column-width:25em}body.skin-vector-2022 .mw-parser-output .reflist-columns-2{column-width:27em}body.skin-vector-2022 .mw-parser-output .reflist-columns-3{column-width:22.5em}.mw-parser-output .references[data-mw-group=upper-alpha]{list-style-type:upper-alpha}.mw-parser-output .references[data-mw-group=upper-roman]{list-style-type:upper-roman}.mw-parser-output .references[data-mw-group=lower-alpha]{list-style-type:lower-alpha}.mw-parser-output .references[data-mw-group=lower-greek]{list-style-type:lower-greek}.mw-parser-output .references[data-mw-group=lower-roman]{list-style-type:lower-roman}.mw-parser-output div.reflist-liststyle-upper-alpha .references{list-style-type:upper-alpha}.mw-parser-output div.reflist-liststyle-upper-roman .references{list-style-type:upper-roman}.mw-parser-output div.reflist-liststyle-lower-alpha .references{list-style-type:lower-alpha}.mw-parser-output div.reflist-liststyle-lower-greek .references{list-style-type:lower-greek}.mw-parser-output div.reflist-liststyle-lower-roman .references{list-style-type:lower-roman}</style>
## Further reading
## External links
<style data-mw-deduplicate="TemplateStyles:r1314755338">.mw-parser-output .side-box{margin:4px 0;box-sizing:border-box;border:1px solid #aaa;font-size:88%;line-height:1.25em;background-color:var(--background-color-interactive-subtle,#f8f9fa);color:inherit;display:flow-root}.mw-parser-output .infobox .side-box{font-size:100%}.mw-parser-output .side-box-abovebelow,.mw-parser-output .side-box-text{padding:0.25em 0.9em}.mw-parser-output .side-box-image{padding:2px 0 2px 0.9em;text-align:center}.mw-parser-output .side-box-imageright{padding:2px 0.9em 2px 0;text-align:center}@media(min-width:500px){.mw-parser-output .side-box-flex{display:flex;align-items:center}.mw-parser-output .side-box-text{flex:1;min-width:0}}@media(min-width:640px){.mw-parser-output .side-box{width:238px}.mw-parser-output .side-box-right{clear:right;float:right;margin-left:1em}.mw-parser-output .side-box-left{margin-right:1em}}</style><style data-mw-deduplicate="TemplateStyles:r1311551236">@media print{body.ns-0 .mw-parser-output .sistersitebox{display:none!important}}@media screen{html.skin-theme-clientpref-night .mw-parser-output .sistersitebox img[src*="Wiktionary-logo-en-v2.svg"]{filter:invert(1)brightness(55%)contrast(250%)hue-rotate(180deg)}}@media screen and (prefers-color-scheme:dark){html.skin-theme-clientpref-os .mw-parser-output .sistersitebox img[src*="Wiktionary-logo-en-v2.svg"]{filter:invert(1)brightness(55%)contrast(250%)hue-rotate(180deg)}}</style>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
</tr>
&#10;<tr>
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
</tbody>
</table>
[Categories](/wiki/Help:Category "Help:Category"):
- [Digital watermarking](/wiki/Category:Digital_watermarking "Category:Digital watermarking")
- [Authentication methods](/wiki/Category:Authentication_methods "Category:Authentication methods")
- [Watermarking](/wiki/Category:Watermarking "Category:Watermarking")
- [Digital photography](/wiki/Category:Digital_photography "Category:Digital photography")
Hidden categories:
- [Articles with short description](/wiki/Category:Articles_with_short_description "Category:Articles with short description")
- [Short description matches Wikidata](/wiki/Category:Short_description_matches_Wikidata "Category:Short description matches Wikidata")
- [Wikipedia articles needing clarification from November 2025](/wiki/Category:Wikipedia_articles_needing_clarification_from_November_2025 "Category:Wikipedia articles needing clarification from November 2025")
- [Commons category link is on Wikidata](/wiki/Category:Commons_category_link_is_on_Wikidata "Category:Commons category link is on Wikidata")
