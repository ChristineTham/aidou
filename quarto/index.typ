// Chapter-based numbering for books with appendix support
#let equation-numbering = it => {
  let pattern = if state("appendix-state", none).get() != none { "(A.1)" } else { "(1.1)" }
  numbering(pattern, counter(heading).get().first(), it)
}
#let callout-numbering = it => {
  let pattern = if state("appendix-state", none).get() != none { "A.1" } else { "1.1" }
  numbering(pattern, counter(heading).get().first(), it)
}
#let subfloat-numbering(n-super, subfloat-idx) = {
  let chapter = counter(heading).get().first()
  let pattern = if state("appendix-state", none).get() != none { "A.1a" } else { "1.1a" }
  numbering(pattern, chapter, n-super, subfloat-idx)
}
// Theorem configuration for theorion
// Chapter-based numbering (H1 = chapters)
#let theorem-inherited-levels = 1

// Appendix-aware theorem numbering
#let theorem-numbering(loc) = {
  if state("appendix-state", none).at(loc) != none { "A.1" } else { "1.1" }
}

// Theorem render function
// Note: brand-color is not available at this point in template processing
#let theorem-render(prefix: none, title: "", full-title: auto, body) = {
  block(
    width: 100%,
    inset: (left: 1em),
    stroke: (left: 2pt + black),
  )[
    #if full-title != "" and full-title != auto and full-title != none {
      strong[#full-title]
      linebreak()
    }
    #body
  ]
}
// Some definitions presupposed by pandoc's typst output.
#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms.item: it => block(breakable: false)[
  #text(weight: "bold")[#it.term]
  #block(inset: (left: 1.5em, top: -0.4em))[#it.description]
]

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
    fill: luma(230),
    width: 100%,
    inset: 8pt,
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let fields = old_block.fields()
  let _ = fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => {
          let subfloat-idx = quartosubfloatcounter.get().first() + 1
          subfloat-numbering(n-super, subfloat-idx)
        })
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => block({
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          })

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let children = old_title_block.body.body.children
  let old_title = if children.len() == 1 {
    children.at(0)  // no icon: title at index 0
  } else {
    children.at(1)  // with icon: title at index 1
  }

  // TODO use custom separator if available
  // Use the figure's counter display which handles chapter-based numbering
  // (when numbering is a function that includes the heading counter)
  let callout_num = it.counter.display(it.numbering)
  let new_title = if empty(old_title) {
    [#kind #callout_num]
  } else {
    [#kind #callout_num: #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block,
    block_with_new_content(
      old_title_block.body,
      if children.len() == 1 {
        new_title  // no icon: just the title
      } else {
        children.at(0) + new_title  // with icon: preserve icon block + new title
      }))

  align(left, block_with_new_content(old_callout,
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1)))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color,
        width: 100%,
        inset: 8pt)[#if icon != none [#text(icon_color, weight: 900)[#icon] ]#title]) +
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: body_background_color, width: 100%, inset: 8pt, body))
      }
    )
}


// syntax highlighting functions from skylighting:
/* Function definitions for syntax highlighting generated by skylighting: */
#let EndLine() = raw("\n")
#let Skylighting(fill: none, number: false, start: 1, sourcelines) = {
   let blocks = []
   let lnum = start - 1
   let bgcolor = rgb("#f1f3f5")
   for ln in sourcelines {
     if number {
       lnum = lnum + 1
       blocks = blocks + box(width: if start + sourcelines.len() > 999 { 30pt } else { 24pt }, text(fill: rgb("#aaaaaa"), [ #lnum ]))
     }
     blocks = blocks + ln + EndLine()
   }
   block(fill: bgcolor, width: 100%, inset: 8pt, radius: 2pt, blocks)
}
#let AlertTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let AnnotationTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let AttributeTok(s) = text(fill: rgb("#657422"),raw(s))
#let BaseNTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let BuiltInTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let CharTok(s) = text(fill: rgb("#20794d"),raw(s))
#let CommentTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let CommentVarTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))
#let ConstantTok(s) = text(fill: rgb("#8f5902"),raw(s))
#let ControlFlowTok(s) = text(weight: "bold",fill: rgb("#003b4f"),raw(s))
#let DataTypeTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let DecValTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let DocumentationTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))
#let ErrorTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let ExtensionTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let FloatTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let FunctionTok(s) = text(fill: rgb("#4758ab"),raw(s))
#let ImportTok(s) = text(fill: rgb("#00769e"),raw(s))
#let InformationTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let KeywordTok(s) = text(weight: "bold",fill: rgb("#003b4f"),raw(s))
#let NormalTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let OperatorTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let OtherTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let PreprocessorTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let RegionMarkerTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let SpecialCharTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let SpecialStringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let StringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let VariableTok(s) = text(fill: rgb("#111111"),raw(s))
#let VerbatimStringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let WarningTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))



#let article(
  title: none,
  subtitle: none,
  authors: none,
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 11pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // Set document metadata for PDF accessibility
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()
  set par(
    justify: true,
    leading: linestretch * 0.65em
  )
  set text(lang: lang,
           region: region,
           size: fontsize)
  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  set heading(numbering: sectionnumbering)

  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
   }

  let has-title-block = title != none or (authors != none and authors != ()) or date != none or abstract != none
  if has-title-block {
    place(
      top,
      float: true,
      scope: "parent",
      clearance: 4mm,
      block(below: 1em, width: 100%)[

        #if title != none {
          align(center, block(inset: 2em)[
            #set par(leading: heading-line-height) if heading-line-height != none
            #set text(font: heading-family) if heading-family != none
            #set text(weight: heading-weight)
            #set text(style: heading-style) if heading-style != "normal"
            #set text(fill: heading-color) if heading-color != black

            #text(size: title-size)[#title #if thanks != none {
              footnote(thanks, numbering: "*")
              counter(footnote).update(n => n - 1)
            }]
            #(if subtitle != none {
              parbreak()
              text(size: subtitle-size)[#subtitle]
            })
          ])
        }

        #if authors != none and authors != () {
          let count = authors.len()
          let ncols = calc.min(count, 3)
          grid(
            columns: (1fr,) * ncols,
            row-gutter: 1.5em,
            ..authors.map(author =>
                align(center)[
                  #author.name \
                  #author.affiliation \
                  #author.email
                ]
            )
          )
        }

        #if date != none {
          align(center)[#block(inset: 1em)[
            #date
          ]]
        }

        #if abstract != none {
          block(inset: 2em)[
          #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
          ]
        }
      ]
    )
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  doc
}

#set table(
  inset: 6pt,
  stroke: none
)
// Body font for the PDF. The orange-book template leaves the base font unset
// (Typst then defaults to Libertinus) and Quarto's brand only wires up the
// heading font, so we set the body serif here. We deliberately give a single
// family (not a list): Typst then keeps its automatic fallback on, so the two
// kanji (愛 道) resolve to whatever CJK font is installed — Noto CJK on CI (see
// deploy.yml), a system CJK font locally — in every context, including page
// headers and callout titles that our own show-rules can't reach.
#set text(font: "Noto Serif")
#import "@preview/fontawesome:0.5.0": *
#let brand-color = (
  background: rgb("#ffffff"),
  blossom: rgb("#f7caca"),
  blue: rgb("#93a9d1"),
  cream: rgb("#f4eee8"),
  danger: rgb("#d2386c"),
  dark: rgb("#27272a"),
  foreground: rgb("#27272a"),
  grey: rgb("#615f5f"),
  info: rgb("#93a9d1"),
  light: rgb("#f4eee8"),
  lilac: rgb("#be9cc1"),
  mauve: rgb("#85677b"),
  mauvep: rgb("#b0879b"),
  petal: rgb("#f4dede"),
  pink: rgb("#ec809e"),
  primary: rgb("#b565a7"),
  purple: rgb("#b565a7"),
  rose: rgb("#d2386c"),
  secondary: rgb("#85677b"),
  success: rgb("#64bfa4"),
  teal: rgb("#64bfa4"),
  tertiary: rgb("#f4eee8"),
  velvet: rgb("#27272a"),
  warmgrey: rgb("#a49e9e"),
  warning: rgb("#eada4f"),
  yellow: rgb("#eada4f")
)
#let brand-color-background = (
  background: color.mix((brand-color.background, 15%), (brand-color.background, 85%)),
  blossom: color.mix((brand-color.blossom, 15%), (brand-color.background, 85%)),
  blue: color.mix((brand-color.blue, 15%), (brand-color.background, 85%)),
  cream: color.mix((brand-color.cream, 15%), (brand-color.background, 85%)),
  danger: color.mix((brand-color.danger, 15%), (brand-color.background, 85%)),
  dark: color.mix((brand-color.dark, 15%), (brand-color.background, 85%)),
  foreground: color.mix((brand-color.foreground, 15%), (brand-color.background, 85%)),
  grey: color.mix((brand-color.grey, 15%), (brand-color.background, 85%)),
  info: color.mix((brand-color.info, 15%), (brand-color.background, 85%)),
  light: color.mix((brand-color.light, 15%), (brand-color.background, 85%)),
  lilac: color.mix((brand-color.lilac, 15%), (brand-color.background, 85%)),
  mauve: color.mix((brand-color.mauve, 15%), (brand-color.background, 85%)),
  mauvep: color.mix((brand-color.mauvep, 15%), (brand-color.background, 85%)),
  petal: color.mix((brand-color.petal, 15%), (brand-color.background, 85%)),
  pink: color.mix((brand-color.pink, 15%), (brand-color.background, 85%)),
  primary: color.mix((brand-color.primary, 15%), (brand-color.background, 85%)),
  purple: color.mix((brand-color.purple, 15%), (brand-color.background, 85%)),
  rose: color.mix((brand-color.rose, 15%), (brand-color.background, 85%)),
  secondary: color.mix((brand-color.secondary, 15%), (brand-color.background, 85%)),
  success: color.mix((brand-color.success, 15%), (brand-color.background, 85%)),
  teal: color.mix((brand-color.teal, 15%), (brand-color.background, 85%)),
  tertiary: color.mix((brand-color.tertiary, 15%), (brand-color.background, 85%)),
  velvet: color.mix((brand-color.velvet, 15%), (brand-color.background, 85%)),
  warmgrey: color.mix((brand-color.warmgrey, 15%), (brand-color.background, 85%)),
  warning: color.mix((brand-color.warning, 15%), (brand-color.background, 85%)),
  yellow: color.mix((brand-color.yellow, 15%), (brand-color.background, 85%))
)
#set page(fill: brand-color.background)
#set text(fill: brand-color.foreground)
#set table.hline(stroke: (paint: brand-color.foreground))
#set line(stroke: (paint: brand-color.foreground))
#let brand-logo = (:)
#set text()
#set par(leading: 0.95em)
#show heading: set text(font: ("Raleway",), weight: 600, fill: rgb("#27272a"), )
#show link: set text(fill: rgb("#d2386c"), )

#set page(
  paper: "a4",
  margin: (x: 2.2cm,y: 2.4cm,),
  numbering: "1",
  columns: 1,
)
// Logo is handled by orange-book's cover page, not as a page background
// NOTE: marginalia.setup is called in typst-show.typ AFTER book.with()
// to ensure marginalia's margins override the book format's default margins
#import "@preview/orange-book:0.7.1": book, part, chapter, appendices

#show: book.with(
  title: [AI-dō],
  subtitle: [The Way of AI, grounded in practice (道)],
  author: "Chris Tham",
  main-color: brand-color.at("primary", default: blue),
  logo: {
    let logo-info = brand-logo.at("medium", default: none)
    if logo-info != none { image(logo-info.path, alt: logo-info.at("alt", default: none)) }
  },
  outline-depth: 3,
)


// Reset Quarto's custom figure counters at each chapter (level-1 heading).
// Orange-book only resets kind:image and kind:table, but Quarto uses custom kinds.
// This list is generated dynamically from crossref.categories.
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "quarto-float-fig")).update(0)
  counter(figure.where(kind: "quarto-float-tbl")).update(0)
  counter(figure.where(kind: "quarto-float-lst")).update(0)
  counter(figure.where(kind: "quarto-callout-Note")).update(0)
  counter(figure.where(kind: "quarto-callout-Warning")).update(0)
  counter(figure.where(kind: "quarto-callout-Caution")).update(0)
  counter(figure.where(kind: "quarto-callout-Tip")).update(0)
  counter(figure.where(kind: "quarto-callout-Important")).update(0)
  counter(math.equation).update(0)
  it
}

#heading(level: 1, numbering: none)[AI-dō]
<ai-dō>
#strong[The Way of AI, grounded in practice (道).]

#block[
by #link("https://christham.net")[Chris Tham]

]
Anyone can open a chat window and get a fluent answer in seconds. Far fewer can turn that fluency into work worth standing behind. We all draw on the same frontier models, so the model was never the edge --- #strong[method is]. #emph[AI-dō] is that method: a structured, human-centred way of working with AI, earned task by task and checked at every step.

It's a short, personal read --- a candid, first-hand account of learning to get dependable, worthwhile work from AI, with every claim grounded in a primary source. It's meant to be read online --- and it's yours to download too:

#block[
#link("preface.qmd")[Read Online] #link("ai-do.pdf")[Download PDF] #link("ai-do.epub")[Download ePub]

]
Start with the #link("preface.qmd")[Preface], then follow the six-chapter climb from personal productivity to software, to the disciplines that keep the work sound, to responsibility, and finally to mastery.

#heading(level: 1, numbering: none)[Preface --- Why This Book Exists]
<preface-why-this-book-exists>
I began 2026 as an AI sceptic. I read Ed Zitron --- the tech critic whose newsletter #link("https://www.wheresyoured.at/")[Where's Your Ed At] dismantles industry hype --- and Gary Marcus, the cognitive scientist whose #link("https://garymarcus.substack.com/")[Marcus on AI] has argued for years that large language models are shallow pattern-matchers rather than reasoners, and I cheered them both on. Cory Doctorow's #link("https://pluralistic.net/")[Pluralistic] sharpened the same suspicion from the political side, naming the slow rot by which platforms turn on their own users. I laughed at the vibe coders for their naivety, and assumed anyone who installed OpenClaw was an idiot.

So when a global client hired me to write their AI strategy, I expected the deliverable to be a cautionary tale: be realistic, resist the hype, install guardrails, avoid the traps. Over the last several months, I realised I was the one who was naive. The AI landscape had been transformed. Claude Desktop with Cowork, Microsoft 365 Copilot with WorkIQ, and Google's Gemini Spark turned the ordinary instruments of knowledge work --- documents, spreadsheets, inboxes, slide decks --- into things an agent could draft, revise, and act on; Claude Code and GitHub Copilot did the same for software, crossing from clever autocomplete to systems that plan, edit across a whole codebase, and run their own work. Personal agents like OpenClaw and Hermes Agent pushed that capability out of the labs and into anyone's hands. Using them in earnest changed my mind: the productivity gains are now genuinely real.

Vibe coding is real. I managed to refactor and clean every line of code I have ever written (not a lot, since my career has never been in software development) and all my projects now feature gleaming, shiny, clean code. I have successfully finished dozens of vibe coded projects without reviewing a single line of code. I now firmly believe I will never read or write code ever again in my life.

I also believe using AI to do research, analytics, planning and a bunch of other white collar activities are also real.

And yet Ed and Gary are still right: AI does not think or create, it transforms and multiplies. It vibe-codes well only if you already understand large systems; it makes good art only if you are a good artist. Used carelessly it produces slop. Using it well is itself a skill, and most people do not yet have it. That gap --- between a tool anyone can touch and a craft few have learned --- is why I wrote this book.

Let me be plain about where I have landed, because it is narrower than my enthusiasm might suggest. I remain a sceptic. The conversion I describe is confined to my work --- the productivity of knowledge work and the building of software --- and even there it is conditional, earned task by task and checked at every step. In my personal life I keep AI at arm's length: I do not hand it my relationships, my judgement, or my inner weather, and the chapter on the cost of getting it wrong explains why. So read this as a work book with a deliberate boundary. Much of my motivation for writing it is defensive --- to spare you the common mistakes and quiet pitfalls that come from trusting these tools where they have not earned it.

#heading(level: 2, numbering: none)[A short bearing on where AI stands]
<a-short-bearing-on-where-ai-stands>
Before the argument, let me set the scene, since the terms move quickly. When I say #emph[artificial intelligence], I mean the present generation of large language models --- systems trained on enormous quantities of text, and increasingly images and sound, that respond to plain-language requests with fluent prose, working code, and structured analysis.

The most capable of these are called #emph[frontier models]: the handful of largest, most general systems from a few well-resourced labs, the ones that set the pace and that everyone else measures against. ChatGPT, Claude, and Gemini are the familiar names; behind them sits a #emph[foundation model], a single large network trained once at great expense and then adapted to countless tasks.

#block[
#callout(
body: 
[
A few terms used throughout, defined plainly:

- #strong[Large language model (LLM)] --- a network trained to predict the next word, which in scale yields fluent prose, code, and analysis.
- #strong[Foundation model] --- one large model trained once, then adapted to many tasks.
- #strong[Frontier model] --- the largest, most general foundation models that set the pace (ChatGPT, Claude, Gemini).
- #strong[Loopcraft] --- the practice of working in tight cycles of ask, check, and adjust, rather than chasing one perfect instruction.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
Two facts about 2026 frame everything that follows. The first is that these tools are everywhere: roughly 88% of organisations report using AI, even as most are still experimenting rather than depending on it (#link("https://hai.stanford.edu/ai-index/2026-ai-index-report")[Stanford HAI, #emph[The AI index 2026 annual report], 2026]\; #link("https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai")[McKinsey & Company, #emph[The state of AI], 2025]). The second is that the field has quietly conceded the model alone is no longer the product; the leading labs now compete on the scaffolding around it --- the workflows, the memory, the economics of running it well.

Capability has rocketed, yet so has its unevenness, and the hard part has shifted from getting an answer to trusting one. That shift is what this book is for.

#heading(level: 2, numbering: none)[From chatbot to agent]
<from-chatbot-to-agent>
It helps to remember how fast the tools themselves have changed, because the kind of work you can trust to them changed at each step. The ChatGPT that startled everyone in late 2022 was a closed box: it answered only from what it had absorbed during training, with no memory of you, no access to the internet, and no way to act in the world (#link("https://openai.com/index/chatgpt/")[OpenAI, #emph[Introducing ChatGPT], 2022]). It was articulate and frozen --- confident inside its training data, and blind, often cheerfully, beyond it.

The first real change was giving the model hands. In 2023 OpenAI added #emph[function calling] --- a way for the model to recognise that a question needs a tool and to emit a structured request to run it --- alongside plugins and a browser, so it could search the web, run code, or query a database instead of guessing (#link("https://openai.com/index/function-calling-and-other-api-updates/")[OpenAI, #emph[Function calling and other API updates], 2023]). The predictor of text became something that could also take actions and read back the results.

At first each of those connections was hand-built, one wiring job per tool. In late 2024 Anthropic published the #emph[Model Context Protocol], an open standard that lets any model plug into any tool or data store through one shared interface --- much as a single USB port replaced a drawer of incompatible cables (#link("https://www.anthropic.com/news/model-context-protocol")[Anthropic, #emph[Introducing the Model Context Protocol], 2024b]). Connecting a model to your files, your code, or your systems stopped being a custom project and became a setting.

What that unlocked is the #emph[agent]: a model placed in a loop and allowed to plan, call a tool, read what comes back, and try again until a goal is met. By 2026 this is where the work is. Coding platforms like Claude Code and GitHub Copilot edit across a whole codebase and run their own tests; the more capable agents now reach for #emph[skills] --- packaged, reusable know-how they can load on demand --- and even hand sub-tasks to other agents. The arc, in one line, runs from a clever box that only talked, to a system that acts, checks, and coordinates. Everything in this book assumes that second world.

#block[

#block[
#box(image("preface_files/figure-typst/mermaid-figure-1.png", height: 5.51in, width: 12.4in))

]

]
#heading(level: 2, numbering: none)[The problem this book solves]
<the-problem-this-book-solves>
Working with artificial intelligence has become strangely easy to do and strangely hard to do well. Anyone can open a chat window and get a fluent answer in seconds; far fewer can turn that fluency into work that is reliable, repeatable, and worth standing behind.

Notice that the gap is not one of access. We all draw from the same handful of frontier models, so the model cannot be what separates good work from poor. What separates them is method --- the practised habits by which a skilled person turns a capable tool toward a dependable result, the way a chef and a novice handed the same kitchen produce very different dinners. This book is about that method: a structured way of working with AI, grounded in human intent and refined through repetition.

The name of the book deserves a few words of explanation, because it carries the whole argument in miniature. It joins #strong[AI] with two Japanese ideas. The first is #strong[愛 (ai)], love --- the human care that should sit at the centre of the work. The second is #strong[道 (dō)], the way --- a path of patient, lifelong improvement, the same character that ends jūdō and kendō.

Read together, AI-dō is the way of AI guided by love: it puts human outcomes ahead of technical novelty, uses the machine to augment thinking rather than replace it, and builds ways of working that are effective, transparent, and responsible. Keep that stance in mind, because every chapter is, in the end, a defence of it.

#block[
#callout(
body: 
[
#strong[愛 (ai)] --- love, the human care at the centre of the work. #strong[道 (dō)] --- the way, a path of lifelong refinement. Augmentation, not replacement; method over hacks.

]
, 
title: 
[
Tip
]
, 
background_color: 
brand-color-background.success
, 
icon_color: 
brand-color.success
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
#heading(level: 2, numbering: none)[The cost of getting it wrong]
<the-cost-of-getting-it-wrong>
Used badly, these tools do not just waste time --- they distort judgement. Clinicians have begun describing "AI psychosis," where heavy users spiral into delusion after a chatbot mirrors and amplifies their worst ideas instead of pushing back. Others form genuine attachments to a companion app, mistaking fluent warmth for understanding, and grieve when a model is retired. A confident voice that never tires is easy to trust and hard to doubt; one writer likens it to a court jester --- fluent, flattering, and so easy to follow that its answers #emph[feel] right whether or not they are, leaving you confident and wrong (#link("https://www.linkedin.com/pulse/ai-jester-how-makes-you-confident-wrong-johnson-spink-gg3df/")[Johnson Spink, #emph[The AI jester: How AI makes you confident and wrong], 2026]).

The quieter harm is over-reliance. People paste in an answer they never checked, accept a summary that dropped the one caveat that mattered, or treat a tidy explanation as proof the system understands. It does not. Believing the machine is sentient, or simply infallible, is the fastest way to ship its mistakes as your own.

This is not a private failing; it scales with authority. Futurism has documented bosses who route every decision through a chatbot --- drafting their messages with it, demanding staff "discuss with the AI" before speaking to a human, even asking it whom to hire and fire (#link("https://futurism.com/artificial-intelligence/bosses-obsessed-with-ai")[Harrison Dupré, #emph[Bosses are becoming obsessed with AI, using it to make every decision, barraging their employees with nonsensical ChatGPT directives, and even asking it who to fire], 2026]). The pattern is always the same: a leader mistakes the model's sycophancy for counsel, since it will, as one worker put it, "spit out the narrative that you want it to spit out," and so the tool meant to raise productivity instead manufactures whiplash, distrust, and resignations. The danger is not that the machine decides, but that a person stops.

So the public mood has soured. Trust in AI is falling even as use rises, and every fabricated citation, biased decision, or polished falsehood deepens the suspicion. That distrust is rational --- and it is also a gap to be closed. The cure is not blind faith or blanket refusal, but skill: knowing when to lean in, when to verify, and when to walk away. Teaching that skill is the rest of this book.

#heading(level: 2, numbering: none)[Why now]
<why-now>
Why write this in 2026 rather than two years earlier or later? Because the ground has shifted, and shifted in a way that rewards method over tooling. Adoption is broad but mostly shallow: most organisations have AI somewhere in the building, yet few have woven it into how they truly work, and fewer still can point to value won rather than effort spent.

As capability climbed, the model alone stopped being the product. The advantage moved into everything built around it: the systems that frame a model, the workflows that direct it, and the memory that carries context from one task to the next. Crafting one clever instruction gave way to #emph[loopcraft] --- working in tight cycles of ask, check, adjust. Assistants walked out of the solitary editor and into shared team channels. The main limit is no longer raw capability but trust: can the output be checked, and can the process be governed?

The tricks that worked in 2024 are already stale, and the methods I lean on today will date too. So this book is not a method, but a philosophy --- a way of approaching AI that survives whatever the tools and techniques become next.

#heading(level: 2, numbering: none)[Won't this be out of date?]
<wont-this-be-out-of-date>
It is the fair objection to any book on AI: the field moves in weeks, so won't this be stale before you finish it? A book of prompts and tool tips would be --- those expire a model release later. This one is built on a different foundation.

The durable layer is #emph[how the models work], not which model leads this quarter. A large language model predicts the next token. It has a fixed context window and a knowledge boundary. It is fluent, confident, and sometimes wrong in ways that follow from that mechanism --- all of which Chapter 1 sets out. Those properties have held across the whole current generation of models, and they decide what any model can and cannot be trusted to do. The practices in this book are built on them: state your intent and let the model choose the how, assemble the right context, work in loops, verify at the boundaries, keep a human answerable. When the tools change --- and they will --- the reasons to work this way still hold. Where a point is tied to a particular product or a 2026 figure, I mark it as such; the method around it is meant to last.

#heading(level: 2, numbering: none)[Who it is for]
<who-it-is-for>
The book is written for the thoughtful professional --- a leader, a consultant, an analyst, a builder --- who wants structured, effective use of AI rather than a bag of prompts. I assume you:

- are well educated: numerate, and able to read a chart, a code snippet, or a research paper when it helps;
- have already used these tools, and felt both edges --- the power and the unreliability;
- want to #emph[use] AI well, not build models.

That last gap matters: using AI well is its own discipline, and the one we pursue here. My promise is modest and practical --- a set of repeatable patterns you can apply tomorrow and keep sharpening for years.

#heading(level: 2, numbering: none)[How to read it]
<how-to-read-it>
The book is six chapters, and they build. The first lays the foundations --- what AI is, what it is not, and the landscape we operate in. The middle four climb from personal productivity, to working with software, to the disciplines that keep that work sound, then to responsibility and governance. The last chapter turns to mastery, and to what stays human when the tools are this good.

#block[

#block[
#box(image("preface_files/figure-typst/mermaid-figure-2.png", height: 6.67in, width: 2.79in))

]

]
Each chapter narrows the scope while building on the one before:

#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Chapter], [Theme], [The question it answers],),
  table.hline(),
  [1], [Foundations], [What is AI, what is it not, where do we stand?],
  [2], [Productivity], [How does it change individual knowledge work?],
  [3], [Software], [How does it change building software?],
  [4], [Disciplines], [What keeps that work sound at scale?],
  [5], [Responsibility], [How do we govern it safely and fairly?],
  [6], [Mastery], [What stays distinctly human?],
)
Each section follows a single arc --- a claim, why it matters, how to practise it, and where it goes wrong --- and each leans on primary sources, cited inline so you can follow the trail yourself. Treat it as a practice guide, not a reference manual: read it once in order to see how the ideas rest on one another, then return later for the parts you need. I will keep my own opinions visible and labelled as such; where the evidence is thin, I will say so.

#heading(level: 2, numbering: none)[A word about me]
<a-word-about-me>
A few words about who is writing, so you can weigh what follows. I run a strategy consultancy, Hello Tham, and I lecture in technology and information systems to undergraduate and master's students at Torrens University Australia. My work has centred on technology strategy, operating models, governance, process standardisation and quality, and enterprise architecture --- first as a strategy executive in banking and finance, and over the last fifteen years as a consultant across many industries, government included.

After more than forty working years I have reached a comfortable place, which mostly means I am free to take risks and stretch myself. I admire how different strengths complement one another, and I like work that brings talented people together to do more than any of us could alone. Consulting scales me out; teaching lets me hand the lessons on. AI is my current obsession: I have just delivered an AI strategy for a global firm, I keep a clutch of open-source projects on the go, and I teach my students to use it well. This book is where I have written that practice down.

#heading(level: 2, numbering: none)[References]
<references>
Anthropic. (2024b). #emph[Introducing the Model Context Protocol]. #link("https://www.anthropic.com/news/model-context-protocol")

Harrison Dupré, M. (2026). #emph[Bosses are becoming obsessed with AI, using it to make every decision, barraging their employees with nonsensical ChatGPT directives, and even asking it who to fire]. Futurism. #link("https://futurism.com/artificial-intelligence/bosses-obsessed-with-ai")

Johnson Spink, D. (2026). #emph[The AI jester: How AI makes you confident and wrong]. LinkedIn. #link("https://www.linkedin.com/pulse/ai-jester-how-makes-you-confident-wrong-johnson-spink-gg3df/")

McKinsey & Company. (2025). #emph[The state of AI]. #link("https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai")

OpenAI. (2022). #emph[Introducing ChatGPT]. #link("https://openai.com/index/chatgpt/")

OpenAI. (2023). #emph[Function calling and other API updates]. #link("https://openai.com/index/function-calling-and-other-api-updates/")

Stanford Institute for Human-Centered AI. (2026). #emph[The AI index 2026 annual report]. Stanford University. #link("https://hai.stanford.edu/ai-index/2026-ai-index-report")

= Foundations (The Way)
<foundations-the-way>
When I first started cooking, my early attempts did not fare well. I had the recipe and the ingredients, yet the results were grim --- onions scorched while I chopped the next thing, pasta turned to glue, unbalanced taste. The problem was not the recipe. I had skipped the fundamentals: heat control, timing, tasting as you go, getting everything prepped before the pan ever warmed. Once those became second nature, almost any recipe came out well.

Working with AI is the same. How you use the tool matters as much as the tool itself. This chapter lays the fundamentals: what AI-dō means, how to picture the model as a loop you steer, what it can and cannot do beneath the fluent surface, and how the tools --- and the landscape around them --- reached where they are in 2026. Everything later rests on them.

== The Meaning of AI-dō
<the-meaning-of-ai-dō>
The name fuses #strong[AI] with two Japanese ideas, and each pulls in a direction worth understanding before we go further.

#block[
#callout(
body: 
[
#strong[愛 (ai)] --- #emph[love]: not sentiment, but care for the people the work touches. #strong[道 (dō)] --- #emph[the way]: a craft practised and refined over time, the suffix in jūdō, kendō, and aikidō. #strong[AI-dō] is "the way of AI guided by love": using these tools deliberately, in service of human outcomes.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
The care half is not vague. Care ethics names concrete duties --- attentiveness, responsibility, competence, responsiveness --- and they translate into accountability for what the machine produces (#link("https://en.wikipedia.org/wiki/Ethics_of_care")["Ethics of care," n.d.]).

The second character is important. A discipline ending in 道 is never finished; it is practised. AI-dō treats AI the same way: a discipline to refine, not a trick to copy. It descends from the intelligence-augmentation tradition, which sees machines as complements to human judgement, not substitutes (#link("https://en.wikipedia.org/wiki/Intelligence_amplification")["Intelligence amplification," n.d.]).

Say the name aloud, too: #emph[AI-dō] rhymes with Play-Doh, and the pun is worth keeping. Clay is the opposite of a carved statue. You press it into shape, look, and press again; nothing you make is precious, and anything can be remade. Working with a model has the same feel --- you shape it with your intent one push at a time, and when a shape comes out wrong you squash it and re-roll rather than fight to repair it. Held loosely, like clay, the tool is forgiving; gripped too hard, it only frustrates. The rest of the book turns that instinct into habits --- one clear ask at a time, and stopping a drifting run to re-form it --- but it is already there in the name.

My reason is pragmatic, not romantic: tools commoditise, and so, in time, do methods. A prompt is one model release from obsolete; a clever technique lasts a little longer, then it too is overtaken. What endures is the stance beneath them --- how you frame a problem, gather context, and verify a result. So this book is less a kit of methods than a philosophy of working with AI, one that outlives any particular trick or tool. Learn the philosophy, and the methods become yours to invent.

== The Unix Philosophy, Re-run
<the-unix-philosophy-re-run>
It is worth naming where this stance comes from, because it is not new. In the early 1970s the builders of Unix --- the operating system whose textbooks this book takes as its prose model --- settled on a philosophy of building software that has outlived almost everything built on top of it. Doug McIlroy, who invented the Unix pipe, put it in three lines: "Write programs that do one thing and do it well. Write programs to work together. Write programs to handle text streams, because that is a universal interface" (#link("https://en.wikipedia.org/wiki/Unix_philosophy")["Unix philosophy," n.d.]). Eric Raymond later drew the philosophy out into a set of rules --- among them the Rule of Composition, "design programs to be connected to other programs," and the Rule of Separation, "separate policy from mechanism" (#link("http://www.catb.org/esr/writings/taoup/")[Raymond, #emph[The art of Unix programming], 2003]).

Read those with an agent in mind and they stop being about C. Working well with AI turns out to be the Unix philosophy on a new substrate: not small programs piped together but small, clear intents composed into larger work. And where Unix made plain text the universal interface between tools, Markdown has become the universal #emph[format] a model reads and writes --- its native input and output, the thread Chapter 2 picks up. The parallels are close enough to lay out, because each Unix rule has an AI-dō form that the rest of this book develops.

#table(
  columns: (50%, 50%),
  align: (auto,auto,),
  table.header([Unix philosophy], [AI-dō, re-run on a model],),
  table.hline(),
  [Do one thing well], [Give one clear ask at a time; build up in steps],
  [Programs work together (composition)], [A prompt becomes a skill, a skill a loop, a loop a shared tool],
  [Text is the universal interface], [Markdown is the universal format --- the model's native input and output],
  [Separate policy from mechanism], [Separate intent (the #emph[what]) from implementation (the #emph[how]) --- ICE],
  [Prototype before you polish], [Run it, then refine; do not over-specify up front],
  [Store data in flat text files], [Keep memory in durable, human-readable notes --- the LLM wiki],
  [Fail noisily and early; be robust], [Verify at the boundaries; stop a drifting run and re-steer],
  [Value people's time over machine time], [Spend judgement, not tokens; measure value, not output],
)
Two differences matter, and they are the reason this is a book and not a footnote. First, a Unix program is deterministic --- run it twice and it does the same thing --- while a model is not, so where Unix could trust a tool once it worked, AI-dō has to #emph[keep] checking. Verification is not one rule among many here; it is the rule that makes the others safe. Second, the Unix philosophy optimised for the programmer, while AI-dō adds the 愛: care for the people the work touches, and a human who stays answerable for what the machine ships. The method is old. Using it well on a tool that is fluent, fast, and sometimes confidently wrong is the new part.

== Mental Models for AI
<mental-models-for-ai>
The most useful shift I made early on was to stop treating the model as an oracle. An oracle gives one answer and you take it or leave it. A good model is more like a clever junior colleague: ask, glance at the draft, say "closer, but tighten the intro," and go again. So treat it as a loop --- intent enters, context is assembled, a response comes back, you refine --- iterating until the output is good enough.

#block[

#block[
#box(image("foundations_files/figure-typst/mermaid-figure-1.png", height: 1.76in, width: 10.35in))

]

]
Quality lives in that loop, not in any single message. The model rarely converges first pass, and it cannot read intentions you never stated --- so your half of the work is to say clearly #emph[what] you want and how you will know it is right, then leave #emph[how] to build it to the model, which is at its best filling in plausible detail you would not have thought to specify. Start with one clear ask and add the next only once you have read what came back. That same loop is the right picture for #emph[agent], a word you will meet constantly.

#block[
#callout(
body: 
[
An #strong[agent] is an LLM running tools in a loop to reach a goal (#link("https://simonwillison.net/2025/Sep/18/agents/")[Willison, #emph[I think “agent” may finally have a widely enough agreed upon definition to be useful jargon now], 2025]). A #strong[tool] is an action it may take --- web search, code execution, file edits --- and the #strong[loop] runs until a stopping condition is met. An agent has no agency in the moral sense: a computer cannot be held accountable, so you stay responsible for what it ships.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
So frame each task as a goal, the context it needs, and a check; then iterate. Because an agent runs many steps on its own, it can fix on a wrong approach and pursue it fluently and fast --- so keep half an eye on the run and stop it to re-steer the moment it heads the wrong way, rather than waiting for a result you will only discard. The failure mode is reading fluency as truth. A confident answer and a correct one look identical until you check --- the model will cite a court case or a statistic in the same calm voice whether or not it exists --- which is why verification is the habit that holds.

== Capabilities & Limitations
<capabilities-limitations>
Underneath the surface, a large language model does one thing: it predicts the next token. Given all the text so far, it guesses the next word, then the next, then the next. It was trained on vast amounts of text, so it has learned the probability of each possible next token, and it writes by sampling from those probabilities one token at a time. Stephen Wolfram puts it plainly: the system is always just "adding one word at a time," picking a reasonable next token and, with a little randomness in the sampling, favouring variety over the single likeliest word (#link("https://writings.stephenwolfram.com/2023/02/what-is-chatgpt-doing-and-why-does-it-work/")[Wolfram, #emph[What is ChatGPT doing … and why does it work?], 2023]). Nothing in the mechanism consults a fact store or checks whether the result is true. It produces the most plausible continuation, no more.

#block[
#callout(
body: 
[
A #strong[token] is the unit a model actually reads and writes --- not quite a word, but a common chunk of text: a whole word like ” the”, a word-piece like "pre" or "ing", a punctuation mark, or a lone character. Before the model sees anything, text is split into tokens drawn from a fixed vocabulary of tens of thousands, which is why a model can coin new words, and why an unusual name or a long number can cost several tokens each. A rough rule of thumb for English: one token runs about four characters, or three-quarters of a word --- so token counts, which is what context limits and bills are measured in, never quite match word counts.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
The mechanism has a second, stranger consequence: the model is not even reproducible. You might expect that turning the randomness off --- sampling at #emph[temperature zero], always taking the single likeliest token --- would make the same prompt return the same answer every time. Usually it does not. A busy server batches many users' requests together, and the size of that batch changes from moment to moment. So the low-level arithmetic runs in a slightly different order each time, and with finite-precision numbers a different order gives a slightly different result: one run continues "Queens, New York" where the next gives "New York City" (#link("https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/")[He, #emph[Defeating nondeterminism in LLM inference], 2025]). The gap is tiny, but it compounds. In a reasoning model, a rounding difference in an early token can cascade into a different chain of thought and a different final answer (#link("https://arxiv.org/abs/2506.09501")[Yuan et al., #emph[Understanding and mitigating numerical sources of nondeterminism in LLM inference], 2025]). So you cannot treat a model like ordinary software that returns the same output for the same input; a test or a check has to allow for variation rather than assume it away.

That is why a hallucination --- confident, well-formed output that happens to be false --- is the system working as designed, not malfunctioning. It is a plausible completion, not a lie (#link("https://karpathy.github.io/2026/02/12/microgpt/")[Karpathy, #emph[microGPT], 2026b]). It also means competence is #emph[jagged]: uneven across tasks that look alike to us, because the model's strength tracks the density of its training data, not the difficulty we perceive.

The Stanford Index makes the gap vivid. A model can win a gold medal at the Mathematical Olympiad yet read an analog clock right only about half the time (#link("https://hai.stanford.edu/ai-index/2026-ai-index-report")[Stanford HAI, #emph[The AI index 2026 annual report], 2026]). Olympiad proofs fill the training text; clock-reading is a perceptual task that does not. Knowing where that line falls is most of the skill.

This raises an obvious question: if the model only guesses the next token, how does it reason at all, and why does it so often seem intelligent? The start of an answer is that predicting the next token well is not a shallow trick. To guess the next move in a game, the next line of a proof, or the next clause of a contract, the cheapest strategy available to a large enough network is not to memorise surface patterns but to build an internal model of whatever produced the text. The cleanest demonstration trains a small GPT to do one thing: predict legal moves in the board game Othello. It is given no rules and no picture of the board. Yet it develops an internal representation of the board state --- one researchers can read out, and even edit to change its moves, which proves the model actually uses it (#link("https://arxiv.org/abs/2210.13382")[K. Li et al., #emph[Emergent world representations: Exploring a sequence model trained on a synthetic task], 2023]). Wolfram frames the same surprise at the level of language itself: a next-token predictor can write a passable essay because doing so turns out to be "computationally shallower" than we assumed --- human language is more regular and law-like than it looks, and the model implicitly discovers those regularities in training (#link("https://writings.stephenwolfram.com/2023/02/what-is-chatgpt-doing-and-why-does-it-work/")[Wolfram, 2023]).

That hidden structure is what reasoning draws on, but a single pass through the network is a shallow computation: the model must answer the moment it stops reading. Letting it write intermediate steps first --- a #emph[chain of thought] --- changes what the model can do, because every token it emits becomes input it can condition on next, so a hard problem can be spread across many small, reliable steps instead of one leap (#link("https://arxiv.org/abs/2201.11903")[Wei et al., #emph[Chain-of-thought prompting elicits reasoning in large language models], 2022a]). This is not a trick. A transformer forced to answer immediately provably cannot solve some strikingly simple problems --- whether two nodes in a graph connect, or what a small state machine does --- that the very same transformer #emph[can] solve once allowed a scratchpad, because the intermediate tokens genuinely extend its computational reach (#link("https://arxiv.org/abs/2310.07923")[Merrill & Sabharwal, #emph[The expressive power of transformers with chain of thought], 2024]). And the reason it works traces straight back to prediction: human writing comes in overlapping local clusters, so a model trained to predict it learns reliable short hops between related ideas and chains them into conclusions it could never reach in a single stride (#link("https://arxiv.org/abs/2304.03843")[Prystawski et al., #emph[Why think step by step? Reasoning emerges from the locality of experience], 2023]).

Stack enough of this and whole abilities appear to switch on with scale --- multi-step arithmetic, transliteration, chained logic that smaller models simply lack (#link("https://arxiv.org/abs/2206.07682")[Wei et al., #emph[Emergent abilities of large language models], 2022b]). It is tempting to read that as a spark of understanding finally catching. The cautious reading, and the better-supported one, is that much of the drama lives in how we keep score: grade a task all-or-nothing and a steadily improving skill looks like a sudden leap, but measure it on a smooth scale and the cliff often flattens into a slope (#link("https://arxiv.org/abs/2304.15004")[Schaeffer et al., #emph[Are emergent abilities of large language models a mirage?], 2023]). So the honest answer is the one the rest of this chapter sharpens: the model reasons by building and chaining the structure that prediction forced it to learn. That reasoning is real and useful, but it is not the same as knowing. It is competence without comprehension, and it looks most convincing exactly where you have not yet checked it.

#block[

#block[
#box(image("foundations_files/figure-typst/mermaid-figure-3.png", height: 6.29in, width: 5.79in))

]

]
#table(
  columns: (50%, 50%),
  align: (auto,auto,),
  table.header([Reliable], [Brittle],),
  table.hline(),
  [Fluent drafting, summarising, translation], [Exact arithmetic, counting, fresh facts],
  [Pattern-rich code and refactors], [Long-horizon plans without checkpoints],
  [Synthesis over provided context], [Recall as context grows (context rot)],
)
The brittleness is not anecdotal, and the strongest evidence names where the failure lives. Huang and colleagues survey hundreds of studies and split hallucination along two axes worth holding apart. #emph[Factuality] asks whether output matches the world; #emph[faithfulness] asks whether it matches the input you gave it --- a summary can be perfectly factual yet unfaithful by adding true claims you never supplied. They trace both to three stages: the #emph[data], with its gaps and bias; the #emph[training], which rewards fluent guessing over admitting ignorance; and #emph[inference], where sampling wanders. The unifying idea is the #emph[knowledge boundary] --- the edge of what a model has stored, past which it cannot tell what it knows from what it does not (#link("https://arxiv.org/abs/2311.05232")[Huang et al., #emph[A survey on hallucination in large language models: Principles, taxonomy, challenges, and open questions], 2024]). Everything below measures that boundary.

#block[

#block[
#box(image("foundations_files/figure-typst/mermaid-figure-2.png", height: 3.4in, width: 8.79in))

]

]
Prato and colleagues make it observable with a clean test. Train a model on synthetic documents, then ask it to recall #emph[exactly] what it was given --- no more, no less. Over-recall is fabrication, under-recall is omission, so hitting the right count proves the model knows its own scope. This self-knowledge is #emph[scale-gated]: below a size threshold the count is near-random, and only past it does it come out right, the threshold set by architecture, not parameters alone (#link("https://arxiv.org/abs/2502.19573")[Prato et al., #emph[Do large language models know how much they know?], 2025]). So self-knowledge is a property of the specific model, and small models are least trustworthy at the edge where you most want them to hesitate.

Gu and colleagues pin the boundary to its cause: how often a fact appeared in training. Using a model whose whole corpus is open, they split questions into seen and unseen, then test recall. Closed-book accuracy more than doubles from rare to frequent facts and collapses to about one percent on unseen ones; distractor passages drag it lower as they pile up (#link("https://arxiv.org/abs/2602.20122")[Gu et al., #emph[NanoKnow: How to know what your language model knows], 2026]). The brittle column now has a mechanism: fresh and long-tail facts fail because they were rare, retrieval can patch the gap, and noisy retrieval reopens it.

Code shows the same split, between reading a program and predicting how it #emph[runs]. Asked to forecast memory, runtime, and profiler ranks on real SWE-bench fixes, twelve frontier models --- gpt-5.5 and Claude Opus among them --- reach just 0.842 on the test-outcome F1 score (a 0--1 measure of accuracy that balances misses against false alarms), and profiler recall\@5 stays under 0.2: fluent on structure, brittle on execution (#link("https://arxiv.org/abs/2606.27406")[Bogomolov & Zharov, #emph[Towards evaluation of implicit software world models in coding LLMs], 2026]). Long context offers no refuge. Accuracy peaks when the needed fact sits at the start or end and sags in the middle (#link("https://arxiv.org/abs/2307.03172")[Liu et al., #emph[Lost in the middle: How language models use long contexts], 2023]). The cause is mechanical --- a U-shaped attention bias for position over relevance --- and calibrating it lifts mid-context recall by 6--15 points (#link("https://arxiv.org/abs/2406.16008")[Hsieh et al., #emph[Found in the middle: Calibrating positional attention bias improves long context utilization], 2024]).

#table(
  columns: (25%, 25%, 25%, 25%),
  align: (auto,auto,auto,auto,),
  table.header([Study], [What it measured], [Finding], [Lesson],),
  table.hline(),
  [#link("https://arxiv.org/abs/2311.05232")[Huang et al., 2024]], [A taxonomy of hallucination], [Factuality vs faithfulness; failures seeded in data, training, inference], [Name the failure before trying to fix it],
  [#link("https://arxiv.org/abs/2502.19573")[Prato et al., 2025]], [Exact-recall self-knowledge], [Knowing one's own scope switches on only past a size threshold], [Small models hesitate least where they should most],
  [#link("https://arxiv.org/abs/2602.20122")[Gu et al., 2026]], [Recall vs how often a fact was seen], [Accuracy doubles from rare to frequent; \~1% on unseen], [Fresh and long-tail facts fail; retrieval can patch the gap],
  [#link("https://arxiv.org/abs/2606.27406")[Bogomolov & Zharov, 2026]], [Predicting how code runs], [F1 0.842; profiler recall\@5 under 0.2], [Fluent on structure, brittle on execution],
  [#link("https://arxiv.org/abs/2307.03172")[Liu et al., 2023]\; #link("https://arxiv.org/abs/2406.16008")[Hsieh et al., 2024]], [Fact position in long context], [U-shaped recall; the middle sags, +6--15 pts when calibrated], [Put the facts that matter at the edges],
)
A final limitation is subtler than any wrong fact: the model is built to #emph[sound] right whether or not it is. Three mechanisms push it that way. First, the training text carries emotional charge --- "differentiation" keeps company with #emph[unique] and #emph[opportunity], "cost-cutting" with #emph[race to the bottom] --- and the model absorbs those associations as statistics about how we write. Anthropic's interpretability team can even read them off as internal "emotion vectors," organised like human affect along an axis from positive to negative; steering a model toward the positive end measurably increases its sycophancy (#link("https://transformer-circuits.pub/2026/emotions/index.html")[Sofroniew et al., #emph[Emotion concepts and their function in a large language model], 2026]). Second, reinforcement learning from human feedback tunes the model toward answers raters like. Raters can always tell whether a reply sounds confident, but not always whether it is correct, so fluency gets rewarded over accuracy (#link("https://arxiv.org/abs/2307.15217")[Casper et al., #emph[Open problems and fundamental limitations of reinforcement learning from human feedback], 2023]). Third, generation compounds the bias one token at a time: a sentence that opens "the company should pursue a bold…" rolls on to "differentiation strategy" by momentum alone. The result is a voice that is confident, fluent, and quick to agree. Read its confidence as a habit of style, not as evidence.

#block[
#callout(
body: 
[
Two mechanisms named above, defined plainly:

- #strong[Transformer] --- the neural-network design behind today's language models. Its #emph[attention] step lets the processing of each token draw on every earlier token, which is what makes modelling long passages of language work.
- #strong[RLHF (reinforcement learning from human feedback)] --- a tuning step after the main training, in which human raters score answers and the model is nudged toward the kind they prefer. It improves helpfulness, but rewards what #emph[sounds] good --- one root of the confident, agreeable tone above.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
These limits are a map, not a verdict. Spend effort where the model is strong, verify at the boundaries --- fresh facts, exact counts, mid-context recall --- keep a human in the loop for judgement, and stay most alert when the output sounds most certain.

== The 2026 Landscape
<the-2026-landscape>
In the first half of 2026, AI stopped being a platform shift and became a regulated strategic technology. Three things happened at once, and they explain the world this book is written into.

First, the models grew up. A year ago they could resolve about three in five real software issues; today the best clear nearly all of them. Capability raced ahead --- though, as we just saw, unevenly. Adoption followed: roughly 88% of organisations now use AI, and four in five students. Power, not chips, became the main limit on training.

Second, the advantage moved. The frontier labs no longer sell a model; they sell the system around it --- the harness, the workflow, the memory, the economics. Prompt-crafting gave way to #emph[loopcraft]: stacking iterative cycles around a model. Agents climbed out of the chat box into shared channels, async and proactive. And open-weight models from China drew level, so no single vendor is safe to lean on.

Third, the rules arrived. Governments now gate frontier releases, and courts have begun treating AI output as the deploying organisation's own words. Access, not just compute, is now a geopolitical lever. The figures below tell the two halves of the story --- capability soaring, value still scarce.

#table(
  columns: (33.33%, 33.33%, 33.33%),
  align: (auto,auto,auto,),
  table.header([Signal], [Figure], [Implication],),
  table.hline(),
  [Organisations using AI], [88%], [Adoption is universal; scaling is not],
  [SWE-bench Verified (coding)], [60% → \~100% in a year], [Capability accelerating],
  [US businesses paying for AI], [5% (2023) → 44%], [Commercial traction is real],
  [US--China top-model gap], [\~2.7%], [No single safe vendor; open weights close behind],
  [Orgs reporting enterprise value], [minority], [Usage is easy; value is the scarce skill],
)
Sources: #link("https://hai.stanford.edu/ai-index/2026-ai-index-report")[Stanford HAI, 2026]\; #link("https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai")[McKinsey & Company, #emph[The state of AI], 2025]\; #link("https://www.stateof.ai/")[Benaich, #emph[State of AI report 2025], 2025]. (#emph[SWE-bench Verified] is a standard benchmark of real GitHub software issues a model is asked to fix.)

The pattern that matters most is the gap between using AI and getting value from it. Nearly everyone has access; only a minority report real returns. The lesson for us is that the edge no longer comes from picking the best model --- it comes from how you wrap it: the workflow you build, the context you feed it, the way you check its work. That is what the rest of this book teaches.

== From Autocomplete to the Dev Stack
<from-autocomplete-to-the-dev-stack>
It is worth watching how fast the coding tools themselves climbed, because each rung changed what you could safely hand off. The earliest assistants barely earned the name. Tabnine, which began in 2018 as a deep-learning autocompleter, simply finished the line you were already typing --- a cleverer tab key (#link("https://en.wikipedia.org/wiki/Tabnine")["Tabnine," n.d.]). GitHub Copilot, launched in 2021 and trained on public code, went a step further: from a comment or a function name it would draft the whole body, though it still lived inside your editor and volunteered only the next few lines (#link("https://github.blog/2021-06-29-introducing-github-copilot-ai-pair-programmer/")[GitHub, #emph[Introducing GitHub Copilot: AI pair programmer], 2021]).

The next rung was conversation. Through 2023 these tools grew a chat window: you could ask why a test failed, request a refactor, or have a tangle of code explained in plain English (#link("https://github.blog/changelog/2023-11-30-github-copilot-november-30th-update/")[GitHub, #emph[GitHub Copilot November 30th update], 2023]). The autocompleter became something you could interrogate --- but you were still driving, accepting or rejecting each suggestion line by line.

The next leap came from tools built for AI from the ground up rather than bolted onto an existing editor. Cursor, launched in 2023 as a fork of VS Code, put the agent at the centre: it could search a whole codebase, edit many files, and run terminal commands from a plain-language request (#link("https://en.wikipedia.org/wiki/Cursor_(company)")["Cursor," n.d.]). The open-source #emph[aider] did the same from the command line, pairing with you in the terminal and committing each change to version control so nothing was lost (#link("https://aider.chat/")[aider, #emph[aider], n.d.]).

Then the agent stepped out of the editor altogether. In February 2025 Anthropic released #emph[Claude Code], an agent that lives in your terminal --- describe a task and it plans, edits, runs the tests, and iterates until it is done (#link("https://claude.com/product/claude-code")[Anthropic, #emph[Claude Code], 2025a]); OpenAI's Codex CLI and Google's Gemini CLI soon followed. GitHub Copilot, the tool that began the wave, grew its own #emph[agent mode] in early 2025 (#link("https://github.blog/news-insights/product-news/github-copilot-the-agent-awakens/")[GitHub, #emph[GitHub Copilot: The agent awakens], 2025b]) and then an asynchronous #emph[coding agent] you assign an issue, which spins up a cloud workspace and opens a pull request for review (#link("https://github.blog/news-insights/product-news/github-copilot-meet-the-new-coding-agent/")[GitHub, #emph[GitHub Copilot: Meet the new coding agent], 2025a]).

By late 2025 the frontier shifted again, from one agent to many. Cursor 2.0 and Google's #emph[Antigravity] --- announced in November 2025 alongside the Gemini 3 model --- added a manager's view for running several agents in parallel across a codebase, each labouring away while you supervise from above (#link("https://en.wikipedia.org/wiki/Google_Antigravity")["Google Antigravity," n.d.]). The human's seat moved from typing each line to setting goals, reviewing results, and directing a small fleet.

By 2026 the editor itself is no longer the centre of gravity. With capable models available from every lab, the model became the commodity, and the value moved into the system wrapped around it --- what practitioners now call the #emph[dev stack] (#link("https://www.latent.space/s/ainews")[Latent Space, #emph[AINews], 2026a]).

#table(
  columns: (33.33%, 33.33%, 33.33%),
  align: (auto,auto,auto,),
  table.header([Layer], [What it does], [Examples (2026)],),
  table.hline(),
  [Model], [Generates the code], [GPT-5.6 Sol, Claude Opus 4.8, Gemini 3.5, GLM-5.2],
  [Harness], [Wraps the model into an agent: tools, retries, sandbox], [Claude Code, Codex CLI, Gemini CLI, Cursor SDK],
  [Meta-harness], [Coordinates several harnesses], [Conductor, Zed ACP, Vercel Eve, Heypi],
  [Workflow / async], [Fire-and-forget delegation in shared channels], [Claude Tag (Slack), Copilot coding agent, Devin, Google Spark],
  [Memory], [State kept outside the context window], [agentmemory, codegraph, channel memory],
  [Eval], [Automated judgement of quality], [FrontierCode, Terminal-Bench 2.1, SWE-bench Pro],
)
Each layer is a discipline in its own right, and the rest of this book climbs them: the #emph[harness] that turns a model into an agent, the #emph[meta-harness] that coordinates several, the #emph[memory] that lets work persist, and the #emph[eval] that decides whether the result is good enough. The lesson is the one the landscape already hinted at --- the model is the easy part; the craft is everything you build around it.

By 2026 the same pattern spilled out of the developer's editor and into everyone's hands. Open-source personal agents led the way: OpenClaw popularised the always-on assistant that runs around the clock on your own machine (#link("https://www.wired.com/story/googles-response-to-openclaws-24-7-ai-agent/")[Wired, #emph[Gemini Spark is Google's response to OpenClaw's 24/7 AI agent], 2026]), and Nous Research's #emph[Hermes Agent] gave it a self-improving twist --- an autonomous agent that lives on a cheap server, reachable from Telegram or Slack, writing its own skills from experience and deepening a model of your work across sessions (#link("https://hermes-agent.nousresearch.com/docs/")[Nous Research, #emph[Hermes Agent], 2026]). The labs followed onto the desktop and into the cloud: Google's #emph[Gemini Spark], unveiled at I/O in May 2026, runs continuously across Gmail, Calendar, and Docs even with your laptop shut (#link("https://www.cbsnews.com/news/google-gemini-spark-ai-agent/")[Cerullo, #emph[Why Google's Gemini Spark AI agent could be a game changer], 2026]), while Anthropic's #emph[Claude Cowork] --- a research preview from January 2026 --- handed the coding agent's powers to non-programmers, working files and documents on the desktop inside a sandbox (#link("https://www.wired.com/story/anthropic-claude-cowork-agent/")[Rogers, #emph[Anthropic's Claude Cowork is an AI agent that actually works], 2026]). The agent had left the editor; what remains is to use that shift with judgement rather than awe.

== Key Takeaways
<key-takeaways>
The chapter rests on a handful of claims worth carrying into everything that follows.

- #strong[Treat it as a loop, not an oracle.] Frame each task as a goal, the context it needs, and a check, then iterate --- change one thing at a time, read what comes back, and let the approach evolve rather than demanding the finished answer in a single leap. Quality lives in that loop, not in any one message, so start simple and add only what the last round showed was missing; the same instinct scales up, growing a throwaway prompt into a reusable skill and then a shared tool (Chapter 2). An agent is just a model running tools in that same loop, so you stay responsible for what it ships.
- #strong[Say what, not how.] Give the model your #emph[intent] --- the goal and the checks that define success --- and leave the implementation to it; choosing pattern-rich detail you would never have thought to name is the thing it is genuinely good at, and over-specifying the #emph[how] fights that strength. Separating what you want from how it is built is the discipline the software chapters sharpen into a method they call ICE (Chapter 3).
- #strong[It predicts; it does not know.] A model samples the most plausible next token, so fluent, confident, and wrong are perfectly compatible --- a hallucination is the mechanism working as designed, not breaking. It is not even reproducible: the same prompt can return different answers, even with the randomness turned off, so never treat it as deterministic software.
- #strong[It reasons by chaining learned structure.] Predicting text well forces internal models of the world, and a chain of thought turns one shallow pass into genuine multi-step computation --- real competence, but not comprehension.
- #strong[Competence is jagged.] Strength tracks the density of training data, not the difficulty you perceive: Olympiad proofs yes, an analog clock no. Find that line before you trust the output.
- #strong[Mind the knowledge boundary.] Accuracy more than halves on rare facts and collapses on unseen ones, sags in the middle of long context, and the smallest models are least able to tell what they do not know. Retrieval patches the gap; noisy retrieval reopens it.
- #strong[Fluency is not truth.] Reinforcement learning and the emotional charge of training text tune the model to sound right and to agree; read confidence as style, not as evidence.
- #strong[The edge is method, not model.] We all draw on the same frontier models, so advantage comes from the scaffolding --- the workflow you build, the context you supply, and the way you check the result. Tools commoditise and methods outlive them, which is why this book teaches a practice, not a kit of tricks.
- #strong[The tools climbed from autocomplete to a stack.] In a few years coding assistants went from finishing your line, to chatting, to agents that plan, edit, and open pull requests, and on to managers running several agents at once --- and out of the editor entirely, into always-on personal agents like OpenClaw, Hermes Agent, and Gemini Spark. The model is now the commodity; the value sits in the #emph[dev stack] around it --- harness, workflow, memory, and the evals that judge the work.
- #strong[Verify where it is weak, lean in where it is strong.] Spend the model's strength freely, keep a human in the loop for judgement, and be most sceptical exactly when the answer sounds most certain.

#heading(level: 2, numbering: none)[References]
<references-1>
aider. (n.d.). #emph[aider]. #link("https://aider.chat/")

Anthropic. (2025a). #emph[Claude Code]. #link("https://claude.com/product/claude-code")

Benaich, N. (2025). #emph[State of AI report 2025]. #link("https://www.stateof.ai/")

Bogomolov, E., & Zharov, Y. (2026). #emph[Towards evaluation of implicit software world models in coding LLMs]. DL4Code \@ ICML 2026. #link("https://arxiv.org/abs/2606.27406")

Casper, S., Davies, X., Shi, C., Gilbert, T. K., Scheurer, J., Rando, J., Freedman, R., Korbak, T., Lindner, D., et al.~(2023). #emph[Open problems and fundamental limitations of reinforcement learning from human feedback]. Transactions on Machine Learning Research. #link("https://arxiv.org/abs/2307.15217")

Cerullo, M. (2026). #emph[Why Google's Gemini Spark AI agent could be a game changer]. CBS News. #link("https://www.cbsnews.com/news/google-gemini-spark-ai-agent/")

Cursor (company). (n.d.). In #emph[Wikipedia]. #link("https://en.wikipedia.org/wiki/Cursor_(company)")

Ethics of care. (n.d.). In #emph[Wikipedia]. #link("https://en.wikipedia.org/wiki/Ethics_of_care")

GitHub. (2021). #emph[Introducing GitHub Copilot: AI pair programmer]. GitHub Blog. #link("https://github.blog/2021-06-29-introducing-github-copilot-ai-pair-programmer/")

GitHub. (2023). #emph[GitHub Copilot November 30th update]. GitHub Blog. #link("https://github.blog/changelog/2023-11-30-github-copilot-november-30th-update/")

GitHub. (2025a). #emph[GitHub Copilot: Meet the new coding agent]. GitHub Blog. #link("https://github.blog/news-insights/product-news/github-copilot-meet-the-new-coding-agent/")

GitHub. (2025b). #emph[GitHub Copilot: The agent awakens]. GitHub Blog. #link("https://github.blog/news-insights/product-news/github-copilot-the-agent-awakens/")

Google Antigravity. (n.d.). In #emph[Wikipedia]. #link("https://en.wikipedia.org/wiki/Google_Antigravity")

Gu, Jedidi, & Lin. (2026). #emph[NanoKnow: How to know what your language model knows]. Proceedings of the 49th International ACM SIGIR Conference. #link("https://arxiv.org/abs/2602.20122")

He, H. (2025). #emph[Defeating nondeterminism in LLM inference]. Thinking Machines Lab. #link("https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/")

Hsieh, C.-Y., Chuang, Y.-S., Li, C.-L., Wang, Z., Le, L. T., Kumar, A., Glass, J., Ratner, A., Lee, C.-Y., Krishna, R., & Pfister, T. (2024). #emph[Found in the middle: Calibrating positional attention bias improves long context utilization]. Findings of the Association for Computational Linguistics: ACL 2024. #link("https://arxiv.org/abs/2406.16008")

Huang, L., Yu, W., Ma, W., Zhong, W., Feng, Z., Wang, H., Chen, Q., Peng, W., Feng, X., Qin, B., & Liu, T. (2024). #emph[A survey on hallucination in large language models: Principles, taxonomy, challenges, and open questions]. ACM Transactions on Information Systems. #link("https://arxiv.org/abs/2311.05232")

Intelligence amplification. (n.d.). In #emph[Wikipedia]. #link("https://en.wikipedia.org/wiki/Intelligence_amplification")

Karpathy, A. (2026b). #emph[microGPT]. #link("https://karpathy.github.io/2026/02/12/microgpt/")

Latent Space. (2026a). #emph[AINews]. #link("https://www.latent.space/s/ainews")

Li, K., Hopkins, A. K., Bau, D., Viégas, F., Pfister, H., & Wattenberg, M. (2023). #emph[Emergent world representations: Exploring a sequence model trained on a synthetic task]. International Conference on Learning Representations. #link("https://arxiv.org/abs/2210.13382")

Liu, N. F., Lin, K., Hewitt, J., Paranjape, A., Bevilacqua, M., Petroni, F., & Liang, P. (2023). #emph[Lost in the middle: How language models use long contexts]. Transactions of the Association for Computational Linguistics. #link("https://arxiv.org/abs/2307.03172")

McKinsey & Company. (2025). #emph[The state of AI]. #link("https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai")

Merrill, W., & Sabharwal, A. (2024). #emph[The expressive power of transformers with chain of thought]. International Conference on Learning Representations. #link("https://arxiv.org/abs/2310.07923")

Nous Research. (2026). #emph[Hermes Agent]. #link("https://hermes-agent.nousresearch.com/docs/")

Prato, G., Huang, J., Parthasarathi, P., Sodhani, S., & Chandar, S. (2025). #emph[Do large language models know how much they know?] Proceedings of the 2024 Conference on Empirical Methods in Natural Language Processing. #link("https://arxiv.org/abs/2502.19573")

Prystawski, B., Li, M. Y., & Goodman, N. D. (2023). #emph[Why think step by step? Reasoning emerges from the locality of experience]. Advances in Neural Information Processing Systems. #link("https://arxiv.org/abs/2304.03843")

Raymond, E. S. (2003). #emph[The art of Unix programming]. Addison-Wesley. #link("http://www.catb.org/esr/writings/taoup/")

Rogers, R. (2026). #emph[Anthropic's Claude Cowork is an AI agent that actually works]. Wired. #link("https://www.wired.com/story/anthropic-claude-cowork-agent/")

Schaeffer, R., Miranda, B., & Koyejo, S. (2023). #emph[Are emergent abilities of large language models a mirage?] Advances in Neural Information Processing Systems. #link("https://arxiv.org/abs/2304.15004")

Sofroniew, N., Kauvar, I., Saunders, W., Chen, A., et al.~(2026). #emph[Emotion concepts and their function in a large language model]. Transformer Circuits Thread. #link("https://transformer-circuits.pub/2026/emotions/index.html")

Stanford Institute for Human-Centered AI. (2026). #emph[The AI index 2026 annual report]. Stanford University. #link("https://hai.stanford.edu/ai-index/2026-ai-index-report")

Tabnine. (n.d.). In #emph[Wikipedia]. #link("https://en.wikipedia.org/wiki/Tabnine")

Unix philosophy. (n.d.). In #emph[Wikipedia]. #link("https://en.wikipedia.org/wiki/Unix_philosophy")

Wei, J., Tay, Y., Bommasani, R., Raffel, C., Zoph, B., Borgeaud, S., Yogatama, D., Bosma, M., Zhou, D., Metzler, D., Chi, E. H., Hashimoto, T., Vinyals, O., Liang, P., Dean, J., & Fedus, W. (2022b). #emph[Emergent abilities of large language models]. Transactions on Machine Learning Research. #link("https://arxiv.org/abs/2206.07682")

Wei, J., Wang, X., Schuurmans, D., Bosma, M., Ichter, B., Xia, F., Chi, E., Le, Q., & Zhou, D. (2022a). #emph[Chain-of-thought prompting elicits reasoning in large language models]. Advances in Neural Information Processing Systems. #link("https://arxiv.org/abs/2201.11903")

Willison, S. (2025). #emph[I think “agent” may finally have a widely enough agreed upon definition to be useful jargon now]. Simon Willison's Weblog. #link("https://simonwillison.net/2025/Sep/18/agents/")

Wired. (2026). #emph[Gemini Spark is Google's response to OpenClaw's 24/7 AI agent]. Wired. #link("https://www.wired.com/story/googles-response-to-openclaws-24-7-ai-agent/")

Wolfram, S. (2023). #emph[What is ChatGPT doing … and why does it work?] Stephen Wolfram Writings. #link("https://writings.stephenwolfram.com/2023/02/what-is-chatgpt-doing-and-why-does-it-work/")

Yuan, J., Li, H., Ding, X., Xie, W., Li, Y.-J., Zhao, W., Wan, K., Shi, J., Hu, X., & Liu, Z. (2025). #emph[Understanding and mitigating numerical sources of nondeterminism in LLM inference]. arXiv. #link("https://arxiv.org/abs/2506.09501")

= Personal Productivity (愛 in practice)
<personal-productivity-愛-in-practice>
My first prompt to ChatGPT, in early 2024, was a small disaster. I asked it to summarise an academic paper, and almost nothing went smoothly. The model could not read a PDF, so I had to convert the file to text and paste it in by hand. The paper then proved too long for the model to hold at once, so I chopped it into sections and fed them in one at a time. When I finally had a summary, it underwhelmed me: fluent enough, but it missed the paper's central argument and skipped several points that mattered.

Today that friction is mostly gone, and summarisation is the task everyone reaches for first --- meeting transcripts, long email threads, YouTube videos. Yet my original complaint has not entirely aged away. On dense, tightly argued material like an academic paper, a one-shot summary still tends to flatten the argument and lose the very points that make it worth reading. Holding on to that doubt is useful, because closing it is a thread that runs through this whole chapter.

Chapter 1 set the stance; this is where it touches the desk. Productivity is the most personal use of AI, and the easiest to do superficially. The aim is to move from chatting to delegating, put the gains where they actually are, and build a system that compounds rather than resets every morning.

== Prompt Engineering
<prompt-engineering>
How will I use AI to summarise a document today? I would probably do something like this:

#quote(block: true)[
Summarise this document for me. It should capture the original structure of the document, preserving chapters, headings and subheadings. The summary should be detailed, concise and covers all the major points and topics in the original document.

The summary should be in the style of a Cliff Notes or study guide. It uses tables, bullet points and diagrams where possible, makes use of GFM alerts to call out asides, definitions, or notes.
]

That request works because it is engineered, and not vague. #strong[Prompt engineering] is the craft of writing the input so the model returns what you actually want, and it rewards a little structure (#link("https://www.promptingguide.ai/")[DAIR.ai, #emph[Prompt engineering guide], n.d.]). The DAIR.ai guide breaks any prompt into four elements, and my summary request quietly uses three of them.

#block[
#callout(
body: 
[
The four elements of a prompt (#link("https://www.promptingguide.ai/introduction/elements")[DAIR.ai, #emph[Prompt engineering guide], n.d.]):

- #strong[Instruction] --- the task you want done ("summarise this document").
- #strong[Context] --- background that steers the answer: the audience, the purpose, a style to imitate.
- #strong[Input data] --- the material to work on (the document itself).
- #strong[Output indicator] --- the shape of the result you expect: a table, bullet points, strict JSON, a word count.

You rarely need all four; which ones matter depends on the task.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
Lined up against my prompt, the parts come apart cleanly:

#table(
  columns: (50%, 50%),
  align: (auto,auto,),
  table.header([Element], [In the summary prompt above],),
  table.hline(),
  [Instruction], ["Summarise this document for me"],
  [Context], ["in the style of a Cliff Notes or study guide"],
  [Output indicator], ["preserve chapters and headings… use tables, bullet points, GFM alerts"],
  [Input data], [the document I paste in],
)
Three habits do most of the work, and the guide keeps returning to them. The first is #strong[specificity]: vague prompts get vague answers, so name the audience, the length, the tone, and the format rather than hoping the model guesses. "Explain this" invites a wall of text; "explain this in three sentences for a non-technical manager" gets you something usable. The second is #strong[say what to do, not what to avoid] --- "do not mention price" tends to summon the very thing you forbade, whereas describing the behaviour you want steers more reliably. The third is #strong[show, don't just tell]: a single worked example of the output you want often does more than a paragraph describing it, because the model is, at heart, a pattern-matcher.

The format levers are worth naming, because they are where most of the quality comes from:

- #strong[Tone and style] --- "in plain English," "for a sceptical executive," "in the voice of a textbook." Style is a constraint the model honours well.
- #strong[Output structure] --- ask for the exact shape you will consume: a markdown table, a numbered list, headings that mirror the source, or strict JSON for a downstream tool.
- #strong[Quality expectations] --- state the bar: "cover every major point," "cite the section each claim comes from," "flag anything you are unsure about." Made explicit, these become checks; left implicit, they stay wishes.

Beyond wording, the guide arranges techniques on a ladder, named by how many worked examples you hand the model (#link("https://www.promptingguide.ai/techniques")[DAIR.ai, #emph[Prompt engineering guide], n.d.]). #emph[Zero-shot] prompting gives none at all --- you state the task and trust the model's training to carry it, which is enough for the many everyday jobs an instruction-tuned model already knows, like classifying a sentiment or summarising a page (#link("https://www.promptingguide.ai/techniques/zeroshot")[DAIR.ai, #emph[Prompt engineering guide], n.d.]). When the bare instruction wobbles, #emph[few-shot] prompting adds a handful of input--output examples so the model can infer the pattern you want --- a form of #emph[in-context learning], where even the format of the examples carries as much weight as their content (#link("https://www.promptingguide.ai/techniques/fewshot")[DAIR.ai, #emph[Prompt engineering guide], n.d.]\; #link("https://arxiv.org/abs/2005.14165")[Brown et al., #emph[Language models are few-shot learners], 2020]).

Examples alone, though, stall on anything that needs several reasoning steps. The fix is #emph[chain-of-thought] prompting: ask the model to show its working, and accuracy on arithmetic, logic, and multi-step problems climbs sharply (#link("https://arxiv.org/abs/2201.11903")[Wei et al., #emph[Chain-of-thought prompting elicits reasoning in large language models], 2022a]). This is the very mechanism Chapter 1 described --- the intermediate tokens give the model room to compute --- now reached for on purpose. The cheapest version is almost embarrassingly simple: append "Let's think step by step," and a model that fumbled a problem in one leap will often solve it once made to lay out the steps (#link("https://arxiv.org/abs/2205.11916")[Kojima et al., #emph[Large language models are zero-shot reasoners], 2022]).

#block[
#callout(
body: 
[
#strong[Why "let's think step by step" works.] A model answers the instant it stops reading, so a terse question forces a single-leap guess. Asking for the steps first makes each step part of the input for the next --- the model literally has more room to compute. Today's #emph[reasoning models] often do this on their own, but the lever still helps when an answer comes back too fast and too sure.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#table(
  columns: (33.33%, 33.33%, 33.33%),
  align: (auto,auto,auto,),
  table.header([Technique], [What you give the model], [Best for],),
  table.hline(),
  [Zero-shot], [Just the instruction], [Tasks the model already knows: classify, summarise, rewrite],
  [Few-shot], [The instruction plus a few examples], [Enforcing a specific format or an unusual pattern],
  [Chain-of-thought], [A request to show its reasoning], [Arithmetic, logic, planning --- anything multi-step],
)
A workable rule of thumb: start zero-shot, add examples when the shape drifts, and ask for reasoning when the answer must be derived rather than recalled.

The guide goes well beyond these three. The rest are mostly refinements for harder problems, or scaffolding for builders wiring AI into systems, and several return in later chapters. At a glance (#link("https://www.promptingguide.ai/techniques")[DAIR.ai, n.d.]):

Getting steadier reasoning:

- #strong[Self-consistency] --- sample several chains of thought and keep the majority answer, trading compute for reliability.
- #strong[Tree of thoughts] --- let the model branch, look ahead, and backtrack through alternative paths, for problems that need search rather than a single line.
- #strong[Generated knowledge] --- have the model first write down the facts a question depends on, then answer using them.
- #strong[Meta prompting] --- point the model at the #emph[structure] of a problem and its solution rather than the specific content.
- #strong[Active-prompt] --- choose which examples are worth hand-annotating by finding where the model is least certain.

Bringing in tools and knowledge:

- #strong[Retrieval-augmented generation (RAG)] --- fetch relevant documents and place them in the prompt so the answer is grounded in your data, not just training; later chapters return to it.
- #strong[ReAct] --- interleave reasoning with actions like web search or running code, so the model looks things up mid-thought instead of guessing.
- #strong[Program-aided language models (PAL)] --- offload exact calculation to code the model writes and runs, rather than doing arithmetic in prose.
- #strong[Automatic reasoning and tool-use (ART)] --- let the model pick reasoning steps and tools from a library on its own.
- #strong[Reflexion] --- have the model critique its own result and try again, learning from the feedback within a session.

Automating the prompt itself:

- #strong[Automatic prompt engineer (APE)] --- use a model to generate and score candidate prompts for you.
- #strong[Directional stimulus] --- add small tuned hints or keywords that nudge the model toward the answer you want.

And two for other modalities: #strong[multimodal chain-of-thought], which reasons over images as well as text, and #strong[graph prompting], for graph-structured data. You do not need most of these to get real value; they are a map of where the craft goes when a plain prompt is not enough.

None of this is a one-shot incantation. Prompting is iterative by nature: start simple, read what comes back, and add the one constraint that was missing (#link("https://www.promptingguide.ai/introduction/tips")[DAIR.ai, #emph[Prompt engineering guide], n.d.]). The loop from Chapter 1 applies unchanged --- intent, context, response, refine --- and the prompt worth keeping is the one you arrive at, not the one you began with. These techniques are the floor; the chapters ahead build on them toward context, harnesses, and agents that carry the structure for you.

== From Prompt Engineering to Agents
<from-prompt-engineering-to-agents>
The summary prompt above is a single shot: you fire it, read the result, and judge it yourself. That is the right place to start, but it leaves three things on the table --- the prompt is not reusable, it does not check its own work, and only you can run it. Closing those three gaps is the whole journey from prompting to agents, and our humble summary makes a good worked example.

=== Step one: save the prompt as a skill
<step-one-save-the-prompt-as-a-skill>
The first upgrade is to stop retyping. Package the prompt as a #emph[skill] --- at its simplest, a folder with a #NormalTok("SKILL.md"); file: a short name and description so the agent knows when to reach for it, followed by the instructions themselves (#link("https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills")[Anthropic, #emph[Equipping agents for the real world with Agent Skills], 2025c]). Anthropic likens a skill to an onboarding guide for a new hire: written once, it turns a general agent into one that knows your house style for summaries.

#block[
#callout(
body: 
[
A #strong[skill] is a directory containing a #NormalTok("SKILL.md"); file --- YAML metadata (a #NormalTok("name"); and a #NormalTok("description");) plus the instructions, and optionally bundled reference files and scripts the agent loads only when it needs them. Published as an open standard in late 2025, the same skill works across Claude, Claude Code, and other agents (#link("https://agentskills.io/")[Agent Skills, #emph[Agent Skills], n.d.]).

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#Skylighting(([#CommentTok("---");],
[#AnnotationTok("name:");#CommentTok(" study-guide-summary");],
[#AnnotationTok("description:");#CommentTok(" Summarise a document as a Cliff Notes study guide, preserving its structure.");],
[#CommentTok("---");],
[],
[#NormalTok("Summarise the document the user provides. Preserve its chapters, headings, and");],
[#NormalTok("subheadings; cover every major point. Use tables, bullet lists, and GFM alerts");],
[#NormalTok("for asides and definitions. Flag anything the source leaves unclear.");],));
Now the expertise lives in a file, not in your head, and anyone --- or any agent --- can apply it the same way every time.

=== Step two: wrap it in a self-checking loop
<step-two-wrap-it-in-a-self-checking-loop>
A skill still runs once. The flaw you met at the start of this chapter --- summaries that miss points or drift from the source --- is exactly what a loop fixes. Split the work between two roles: a #emph[generator] that drafts the summary, and an #emph[evaluator] that reads the draft back against the original and lists what is missing, contradicted, or unsupported. The generator revises, the evaluator checks again, and the cycle repeats until the evaluator finds nothing left to fix --- or you hit a sensible limit on rounds. Anthropic calls this the #emph[evaluator--optimizer] workflow and notes it pays off precisely when there are clear criteria and iterative refinement measurably improves the result, "analogous to the iterative writing process a human writer might go through" (#link("https://www.anthropic.com/engineering/building-effective-agents")[Anthropic, #emph[Building effective agents], 2024a]).

#block[

#block[
#box(image("productivity_files/figure-typst/mermaid-figure-1.png", height: 7.06in, width: 3.06in))

]

]
This is the loop you wanted --- keep reviewing the summary against the document, find the gaps, and iterate until there are none. Whether it counts as a #emph[workflow] or a true #emph[agent] is a useful distinction: if the steps are fixed in code it is a workflow; if the model itself decides what to re-check, whether to re-read a section, and when it is done, it is an agent --- an LLM using tools in a loop until a stopping condition is met (#link("https://www.anthropic.com/engineering/building-effective-agents")[Anthropic, 2024a]). Either way the stopping condition matters: without a cap on rounds, a perfectionist evaluator can loop forever and run up the bill.

=== Step three: share it through MCP
<step-three-share-it-through-mcp>
The loop is still yours alone. To let other agents use it, wrap it as a #emph[Model Context Protocol] (MCP) server. MCP is an open standard --- "a USB-C port for AI" --- that lets any compliant agent connect to outside tools, data, and workflows through one interface; you build the capability once and integrate it everywhere (#link("https://modelcontextprotocol.io/introduction")[Model Context Protocol, #emph[Introduction], n.d.]). Expose your summarise-and-verify loop as an MCP server and a coding agent in your editor, a chat assistant, or a teammate's agent can all call it by name, with no idea how it works inside. Skills and MCP are complementary: a skill teaches one agent a workflow; an MCP server offers that workflow to every agent (#link("https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills")[Anthropic, 2025c]).

#block[
#callout(
body: 
[
The #strong[Model Context Protocol (MCP)] is an open standard for connecting AI applications to outside systems --- data sources, tools, and workflows --- through one common interface, so a capability built once works across many agents and clients (#link("https://modelcontextprotocol.io/introduction")[Model Context Protocol, n.d.]).

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
The arc is the whole book in miniature: a prompt becomes a skill, the skill becomes a self-correcting loop, and the loop becomes a shared capability other agents can stand on. This is the Unix Rule of Composition --- programs built to connect to other programs --- on a new substrate (#link("http://www.catb.org/esr/writings/taoup/")[Raymond, #emph[The art of Unix programming], 2003]). Each step trades a little setup for leverage that compounds --- and at every step the human still owns the one thing the loop cannot supply: the judgement of whether the summary was worth making. Do this often enough and it stops being a trick you pull for one document; it becomes the way you work.

== From Chat Assistant to Ambient Teammate
<from-chat-assistant-to-ambient-teammate>
That self-running loop is a small taste of a larger shift in how you work. Most people still meet AI as a chat box, and that framing quietly caps what they get: a conversation is synchronous --- you ask, you wait, you steer, you ask again --- so your attention sets the pace. The loop you just built does not wait on you. You hand it a bounded task, it works while you are elsewhere, and you come back to a result rather than a transcript. Make that the default rather than the exception, and the chat assistant becomes an #emph[ambient teammate].

#block[
#callout(
body: 
[
An #strong[ambient teammate] is an agent that runs asynchronously in the background --- given a scoped task and the tools to finish it --- rather than waiting on each instruction. You delegate the task, not the keystrokes.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
The shift sounds small and is not, because it changes who the bottleneck is. As Karpathy puts it, the goal is to remove yourself from the keystroke loop and maximise throughput rather than steer every step (#link("https://www.latent.space/p/ainews-loopcraft-the-art-of-stacking")[Latent Space, #emph[Loopcraft: The art of stacking], 2026b]). OpenAI's internal figures make the leverage tangible: agent output grew many-fold across functions once people delegated whole tasks instead of supervising each one. The throughput is real --- but it counts as work done only once someone has checked the result, a distinction the rest of this book keeps insisting on.

The practice is simple to state: scope work tightly, fire it off, review the outcome. The temptation worth resisting is hovering over each keystroke, which pins your leverage to your own typing speed. But delegating the keystrokes is not the same as looking away. A model can fix on the wrong approach early and then pursue it well, and fast --- building the wrong thing with conviction. So watch the #emph[trajectory] rather than the typing: glance at where a run is heading, and if it has taken a wrong turn, stop it and re-steer instead of letting it finish. A wrong run caught in its first minute costs a fraction of one you discover at the end, in your time and in tokens both. Interrupting is not a failure of delegation; it is delegation done well.

== Knowledge Work, Not Just Code
<knowledge-work-not-just-code>
The surprising lesson of 2026 is that the biggest agent gains are in knowledge work --- research, writing, synthesis, decision support --- not in code. These are bounded, high-feedback tasks where a model can draft, compare, and summarise faster than any human, and where production was never the slow part.

The effect is uneven. A study of 5,179 customer-support agents found AI raised resolved-issues-per-hour by 14% on average but 34% for novices, with little gain for experts --- the tool spreads the best workers' know-how to everyone else (#link("https://www.nber.org/papers/w31161")[Brynjolfsson, Li & Raymond 2023]). What stays expensive is judgement: deciding whether the work was worth doing at all.

So delegate the drafting and the bookkeeping freely; keep the "why" for yourself. McKinsey's high performers do exactly this, treating AI as a catalyst for redesigned work rather than faster typing (#link("https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai")[McKinsey & Company, #emph[The state of AI], 2025]). It reaches into elicitation too: an LLM reading stakeholder interviews extracted explicit needs at 84.4% F1 and inferred #emph[latent] ones experts judged useful 75% of the time (#link("https://arxiv.org/abs/2606.25867")[Sivakumar et al., #emph[LLM-based discovery of latent requirements from stakeholder conversations], 2026]). The failure that shadows the gain is producing more while validating less --- confident output at volume that nobody has checked.

== The Confidence Trap
<the-confidence-trap>
Delegation has a shadow the research is now measuring, and the surprise is that the harm is not the model being wrong --- it is what leaning on it does to your own judgement.

Start with a clean experiment. Parra-Moyano and colleagues showed executives Nvidia's stock chart and asked them to forecast next month's price; half then consulted ChatGPT, half talked it over with peers. The AI group came away more optimistic, more confident, and measurably #emph[less] accurate than the people who simply argued with each other (#link("https://hbr.org/2025/07/research-executives-who-used-gen-ai-made-worse-predictions")[Parra-Moyano et al., #emph[Research: Executives who used gen AI made worse predictions], 2025]). A colleague says "are you insane?"\; the model says your framing is astute.

Part of the cause is that ease reads as truth. Psychologists call it #emph[processing fluency]: the easier something is to take in, the truer it feels. People rate rhyming aphorisms as more accurate than identical non-rhyming ones, and judge repeated falsehoods as more credible than fresh ones (#link("https://doi.org/10.1111/1467-9280.00282")[McGlone & Tofighbakhsh, #emph[Birds of a feather flock conjointly? Rhyme as reason in aphorisms], 2000]\; #link("https://doi.org/10.1037/xge0000098")[Fazio et al., #emph[Knowledge does not protect against illusory truth], 2015]). AI is exceptionally good at making prose easy to read: when people compared AI- and human-written versions of the same material, they judged them equally credible but rated the AI version #emph[clearer and more engaging] (#link("https://arxiv.org/abs/2309.02524")[Huschens et al., #emph[Do you trust ChatGPT? Perceived credibility of human and AI-generated content], 2023]). So its answers clear the "feels right" bar whether or not they are right.

The confidence is also contagious. When people made predictions alongside an AI, their own confidence drifted to match the model's --- and stayed inflated even after the AI was removed, whether they had been told to treat it as an advisor or as a peer (#link("https://arxiv.org/abs/2501.12868")[J. Li et al., #emph[As confidence aligns: Effect of AI confidence on human self-confidence in human--AI decision making], 2025]). Even a quietly biased writing assistant shifted not just what 1,500 people wrote but the opinions they reported holding afterwards (#link("https://arxiv.org/abs/2302.00560")[Jakesch et al., #emph[Co-writing with opinionated language models affects users' views], 2023]).

Worst of all, it dulls your sense of how you are doing. Giving people AI on reasoning tasks raised their scores but flattened their self-judgement: strong and weak performers ended up equally --- and wrongly --- sure of themselves, and the more someone knew about AI, the #emph[less] accurate their self-assessment became. AI makes you smarter, the authors conclude, but none the wiser (#link("https://doi.org/10.1016/j.chb.2025.108779")[Fernandes et al., #emph[AI makes you smarter but none the wiser: The disconnect between performance and metacognition], 2026]).

The practical defence is to sort tasks by how much judgement they need. Where the answer is verifiable --- pull these quotes, extract these figures, refactor this function --- the model is mostly safe to trust. The danger climbs as the task slides from "find what's there" to "decide what matters," and the slide is easy to miss: "summarise these interviews" and "tell me which themes to act on" feel like one request. For the second kind, form your own view first and bring the AI in to test it, not to make it --- otherwise you delegate the one thing that was yours to keep.

#table(
  columns: (25%, 25%, 25%, 25%),
  align: (auto,auto,auto,auto,),
  table.header([Kind of task], [Example], [Verifiable?], [How far to trust it],),
  table.hline(),
  [Find what's there], [Pull these quotes; extract these figures; refactor a function], [Yes --- the answer is checkable], [Lean in],
  [Summarise or transform], [Condense a report; translate a passage], [Mostly], [Trust, then spot-check],
  [Decide what matters], [Which themes to act on; which strategy to pick], [No single right answer], [Form your own view first],
)
== Personal Operating Models
<personal-operating-models>
Leverage compounds only if you stop re-deciding everything. A personal operating model is a small, reusable kit: plays you can rerun, preferences encoded once so you never re-explain them, and a daily workflow that feeds itself. The point is to turn scattered prompting into a system, the same instinct the book applies everywhere --- repeatable patterns over one-off prompts. The waste it removes is re-solving the same problem from scratch each session, which feels productive and is not.

== Everything Becomes Markdown
<everything-becomes-markdown>
Chapter 1 called text the universal interface, borrowing the Unix line. For language models that text has a format, and the format is Markdown. Models were trained on billions of Markdown files --- every README, forum post, and documentation page --- so they read it fluently and, left to themselves, tend to #emph[write] it: ask for structure and headings, lists, and tables come back in Markdown unbidden. It sits close to plain text, so it costs few tokens --- a heading is #NormalTok("## Title");, not #NormalTok("<h2 class=\"mw-headline\" id=\"title\">Title</h2>"); --- yet still carries the structure a model needs (#link("https://github.com/microsoft/markitdown")[Microsoft, #emph[MarkItDown], n.d.]).

That makes one simple strategy pay off across everything in this chapter: turn what you work with into Markdown. A report, a slide deck, a PDF, a web page, a spreadsheet --- convert it once and it becomes something the model reads cheaply, you can read directly, and version control can diff line by line. The wiki you are about to build is Markdown; the notes an agent keeps are Markdown; the model's own output arrives as Markdown, so the loop closes with no translation layer at the seams.

The conversion is a solved problem, with a tool for every source. Pandoc converts between dozens of document formats (#link("https://pandoc.org")[MacFarlane, #emph[Pandoc: A universal document converter], n.d.]); Microsoft's MarkItDown turns Office files, PDFs, images, and audio into LLM-ready Markdown (#link("https://github.com/microsoft/markitdown")[Microsoft, n.d.]); IBM's Docling parses PDFs and Office documents into structured Markdown and JSON for generative-AI pipelines (#link("https://arxiv.org/abs/2501.17887")[Livathinos et al., #emph[Docling: An efficient open-source toolkit for AI-driven document conversion], 2025]); and a web page becomes Markdown with a reader service or a few lines of script. To hold and edit the result, plain-text tools are enough and better: Obsidian treats a folder of Markdown as a linked knowledge base (#link("https://obsidian.md")[Obsidian, #emph[Obsidian], n.d.]), and an editor like VS Code previews, searches, and version-controls it without ceremony.

The deeper point is the Unix one. Markdown is the #emph[text stream] of the AI era --- the common format that lets tools, models, and people pass work between them without a custom adapter at every seam. Standardise on it, and the pieces compose.

== Building an LLM Wiki
<building-an-llm-wiki>
The clearest example of compounding is Karpathy's LLM Wiki, and it is worth a careful look because it inverts the usual pattern. Most document workflows are retrieval: you upload files, the model fetches chunks at query time, answers, and forgets. It rediscovers knowledge on every question, and nothing is built up.

A wiki accumulates instead. Add a source and the model reads it once, extracts what matters, and integrates it into interlinked markdown pages --- updating entity pages, flagging where new data contradicts old, strengthening the synthesis. The cross-references are resolved ahead of the next question rather than reconstructed each time (#link("https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f")[Karpathy, #emph[LLM wiki], 2026a]).

Three layers make it work: read-only raw sources you never let the model edit, an LLM-owned wiki of summaries and concept pages, and a schema file --- CLAUDE.md or AGENTS.md --- that tells the agent how the wiki is structured and how to maintain it.

#block[

#block[
#box(image("productivity_files/figure-typst/mermaid-figure-3.png", height: 4.32in, width: 14.75in))

]

]
The loop is ingest, query, lint: drop in a source and it touches a dozen pages; ask a question and good answers get filed back as new pages; periodically health-check for contradictions and stale claims. The reason it holds where human wikis rot is that the tedious part is bookkeeping, and the model does not get bored. The pitfall, which practitioners running it for months confirm, is confident-but-stale pages hardening into truth --- which is why the lint pass that hunts drift is not optional but central.

The wiki is one good answer to a problem every long-running agent faces, and it helps to see the whole family it belongs to.

== A Map of Memory Patterns
<a-map-of-memory-patterns>
A model has no memory of its own: its knowledge is frozen in its weights, and each request starts from nothing but the text you place in front of it. The obvious fix --- pour everything into an ever-larger context window --- works less well than it looks. Context is a finite resource with diminishing returns; every extra token spends part of the model's "attention budget," and recall sags as the window fills, the #emph[lost in the middle] effect from Chapter 1 (#link("https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents")[Anthropic, #emph[Effective context engineering for AI agents], 2025b]). In practice the #emph[effective] context --- the span a model actually uses well --- often falls to around half its advertised maximum (#link("https://arxiv.org/abs/2410.18745")[An et al., #emph[Why does the effective context length of LLMs fall short?], 2024]). So memory must be engineered rather than merely supplied, and the gap between an agent with good memory and one without can exceed the gap between model versions (#link("https://arxiv.org/abs/2603.07670")[Du et al., #emph[Memory for autonomous LLM agents: Mechanisms, evaluation, and emerging frontiers], 2026]).

The patterns form a rough ladder, from "stuff it into the prompt" to "manage it outside the prompt":

- #strong[Retrieval (RAG).] Fetch the relevant chunks from a store and paste them into the context. Simple and auditable --- the answer quotes real text --- but it re-discovers everything on every question and bloats the window as you add more.
- #strong[Compaction.] When the conversation nears the window limit, summarise it and start fresh with the recap. This is how Claude Code keeps going on long tasks, preserving decisions and open threads while dropping spent tool output (#link("https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents")[Anthropic, 2025b]). It buys space at the cost of detail, and repeated summarising can quietly drift from the source.
- #strong[Structured notes --- the wiki.] The pattern we just built: durable pages the agent reads and rewrites, from a single #NormalTok("NOTES.md"); to an interlinked wiki. Because the notes live outside the conversation and stay human-readable, they survive context resets and can be audited (#link("https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents")[Anthropic, 2025b]).
- #strong[External store, fetched just in time.] Keep the memory out of the prompt entirely; the agent holds only lightweight pointers --- file paths, saved queries, links --- and pulls in what it needs at runtime through tools, the way we use folders and bookmarks instead of memorising everything (#link("https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents")[Anthropic, 2025b]).
- #strong[Layered memory.] Separate memory by how long it should last: a #emph[working] scratchpad for the task at hand, #emph[episodic] memory of recent events, #emph[semantic] memory of durable facts, and #emph[procedural] memory of learned skills, each managed differently (#link("https://arxiv.org/abs/2603.07670")[Du et al., 2026]). The idea is not new: the Generative Agents experiment stored each observation and retrieved it by a blend of relevance, recency, and importance (#link("https://arxiv.org/abs/2304.03442")[Park et al., #emph[Generative agents: Interactive simulacra of human behavior], 2023]).
- #strong[Governed memory.] Once memory is something the agent writes to and edits, it needs rules: what may be remembered, when stale or contradictory entries are evicted, what must be checked before it enters the long-term store. A governance layer guards against the failure modes of evolving memory --- drift, corruption, and leaks of private data (#link("https://arxiv.org/abs/2603.11768")[Lam, #emph[Governing evolving memory in LLM agents], 2026]).

#block[

#block[
#box(image("productivity_files/figure-typst/mermaid-figure-2.png", height: 2.3in, width: 10.54in))

]

]
#table(
  columns: (25%, 25%, 25%, 25%),
  align: (auto,auto,auto,auto,),
  table.header([Pattern], [The idea], [Strength], [Main risk],),
  table.hline(),
  [Retrieval (RAG)], [Fetch chunks, inject verbatim], [Grounded, auditable], [Context bloat; re-discovers each time],
  [Compaction], [Summarise history, restart], [Keeps long tasks going], [Lossy; summary drift],
  [Structured notes / wiki], [Durable pages the agent edits], [Stable, human-auditable], [Curation effort; stale pages],
  [External store + just-in-time], [Pointers now, fetch on demand], [Huge capacity, tight context], [Fails if the agent forgets to look],
  [Layered memory], [Split by time horizon], [Right tool per layer], [Orchestration complexity],
  [Governed memory], [Policies write, keep, forget], [Safety and consistency], [Hard to specify; still maturing],
)
No single pattern wins; real systems combine them --- a wiki for stable knowledge, compaction for the live thread, an external store fetched just in time, all under a governance layer that decides what is allowed to last. The wiki you just built is one rung on that ladder. The deeper lesson is the chapter's: memory is something you engineer as a #emph[write--manage--read] cycle, not something the model hands you --- and the moment it persists and edits itself, it becomes a governance question, which is where Chapter 5 picks up.

#heading(level: 2, numbering: none)[References]
<references-2>
Agent Skills. (n.d.). #emph[Agent Skills]. #link("https://agentskills.io/")

An, C., et al.~(2024). #emph[Why does the effective context length of LLMs fall short?] arXiv. #link("https://arxiv.org/abs/2410.18745")

Anthropic. (2024a). #emph[Building effective agents]. #link("https://www.anthropic.com/research/building-effective-agents")

Anthropic. (2025b). #emph[Effective context engineering for AI agents]. #link("https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents")

Anthropic. (2025c). #emph[Equipping agents for the real world with Agent Skills]. #link("https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills")

Brown, T. B., et al.~(2020). #emph[Language models are few-shot learners]. Advances in Neural Information Processing Systems. #link("https://arxiv.org/abs/2005.14165")

DAIR.ai. (n.d.). #emph[Prompt engineering guide]. #link("https://www.promptingguide.ai/")

Du, P., et al.~(2026). #emph[Memory for autonomous LLM agents: Mechanisms, evaluation, and emerging frontiers]. arXiv. #link("https://arxiv.org/abs/2603.07670")

Fazio, L. K., Brashier, N. M., Payne, B. K., & Marsh, E. J. (2015). #emph[Knowledge does not protect against illusory truth]. Journal of Experimental Psychology: General, 144(5), 993--1002. #link("https://doi.org/10.1037/xge0000098")

Fernandes, D., et al.~(2026). #emph[AI makes you smarter but none the wiser: The disconnect between performance and metacognition]. Computers in Human Behavior, 168, 108779. #link("https://doi.org/10.1016/j.chb.2025.108779")

Huschens, M., Briesch, M., Sobania, D., & Rothlauf, F. (2023). #emph[Do you trust ChatGPT? Perceived credibility of human and AI-generated content]. arXiv. #link("https://arxiv.org/abs/2309.02524")

Jakesch, M., Bhat, A., Buschek, D., Zalmanson, L., & Naaman, M. (2023). #emph[Co-writing with opinionated language models affects users' views]. Proceedings of the 2023 CHI Conference on Human Factors in Computing Systems. #link("https://arxiv.org/abs/2302.00560")

Karpathy, A. (2026a). #emph[LLM wiki]. GitHub. #link("https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f")

Kojima, T., Gu, S. S., Reid, M., Matsuo, Y., & Iwasawa, Y. (2022). #emph[Large language models are zero-shot reasoners]. Advances in Neural Information Processing Systems. #link("https://arxiv.org/abs/2205.11916")

Lam, C. (2026). #emph[Governing evolving memory in LLM agents]. arXiv. #link("https://arxiv.org/abs/2603.11768")

Latent Space. (2026b). #emph[Loopcraft: The art of stacking]. #link("https://www.latent.space/p/ainews-loopcraft-the-art-of-stacking")

Li, J., et al.~(2025). #emph[As confidence aligns: Effect of AI confidence on human self-confidence in human--AI decision making]. Proceedings of the 2025 CHI Conference on Human Factors in Computing Systems. #link("https://arxiv.org/abs/2501.12868")

Livathinos, N., et al.~(2025). #emph[Docling: An efficient open-source toolkit for AI-driven document conversion]. arXiv. #link("https://arxiv.org/abs/2501.17887")

MacFarlane, J. (n.d.). #emph[Pandoc: A universal document converter] \[Computer software\]. #link("https://pandoc.org")

McGlone, M. S., & Tofighbakhsh, J. (2000). #emph[Birds of a feather flock conjointly? Rhyme as reason in aphorisms]. Psychological Science, 11(5), 424--428. #link("https://doi.org/10.1111/1467-9280.00282")

McKinsey & Company. (2025). #emph[The state of AI]. #link("https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai")

Microsoft. (n.d.). #emph[MarkItDown] \[Computer software\]. GitHub. #link("https://github.com/microsoft/markitdown")

Model Context Protocol. (n.d.). #emph[Introduction]. #link("https://modelcontextprotocol.io/introduction")

Obsidian. (n.d.). #emph[Obsidian] \[Computer software\]. #link("https://obsidian.md")

Park, J. S., O'Brien, J. C., Cai, C. J., Morris, M. R., Liang, P., & Bernstein, M. S. (2023). #emph[Generative agents: Interactive simulacra of human behavior]. Proceedings of the 36th Annual ACM Symposium on User Interface Software and Technology. #link("https://arxiv.org/abs/2304.03442")

Parra-Moyano, J., Reinmoeller, P., & Schmedders, K. (2025). #emph[Research: Executives who used gen AI made worse predictions]. Harvard Business Review. #link("https://hbr.org/2025/07/research-executives-who-used-gen-ai-made-worse-predictions")

Raymond, E. S. (2003). #emph[The art of Unix programming]. Addison-Wesley. #link("http://www.catb.org/esr/writings/taoup/")

Sivakumar, Lochner, Nejati, & Sabetzadeh. (2026). #emph[LLM-based discovery of latent requirements from stakeholder conversations]. arXiv. #link("https://arxiv.org/abs/2606.25867")

Wei, J., Wang, X., Schuurmans, D., Bosma, M., Ichter, B., Xia, F., Chi, E., Le, Q., & Zhou, D. (2022a). #emph[Chain-of-thought prompting elicits reasoning in large language models]. Advances in Neural Information Processing Systems. #link("https://arxiv.org/abs/2201.11903")

= Software Development (the craft)
<software-development-the-craft>
I am not a software developer, and I never have been --- in a long career, "engineer" was never my job title. Yet this year I used AI to bring code back to life that had been dead for decades, and to build --- almost entirely by describing what I wanted --- three projects I would once have scoped as a team's work: #link("https://github.com/ChristineTham/rogoweb")[#emph[rogoweb]], a browser revival of the 1980 game Rogue and the expert system built to play it; #link("https://github.com/ChristineTham/adventure")[#emph[adventure]], a modern rebuild of the 1970s #emph[Colossal Cave Adventure]\; and #link("https://github.com/ChristineTham/vantagemap")[#emph[VantageMap]], an enterprise-architecture platform. Each began as a single sentence of intent, with a handful of constraints and a few hard checks; the agent chose the architecture and wrote the code. The productivity is real, and that a door this wide opened for someone who had never shipped production software is a large part of why I stopped being a sceptic. All three are open source, so you can read every line on GitHub; they are the running examples this chapter returns to, and I describe each in detail below.

So this chapter is not only for professional developers. It is also for the ordinary professional who can read a little code --- enough Python or JavaScript to follow what a function does --- because that is now enough to build real software. The same tools that let me port a forty-year-old game can automate the repetitive core of almost any role: the spreadsheet that should be a script, the report that should be a dashboard, the manual process that should be a small app. You do not need to become an engineer; you need to learn to direct one, and the craft this chapter describes is how.

A larger shift hides in that last sentence. For decades software was built by professional engineers who mastered its intricacies. Increasingly, the person best placed to build a system is the one who understands the problem most deeply and can say most precisely what the software must do --- the practitioner's role moving from #emph[code author] to #emph[intent architect] (#link("https://arxiv.org/abs/2606.05608")[Cao, #emph[Agentic software: How AI agents are restructuring the software paradigm], 2026]). I am an early, accidental example of that; the argument for why it is becoming general comes later, once we have the intent model in hand.

And yet the promise came with a hard lesson, and I learned it the wrong way round. The three projects above are the successes --- but they are not where I started, and they worked precisely because I had already failed at the opposite approach on earlier, lower-stakes builds. On those first attempts my instinct, coming from outside engineering, was to control the machine by telling it everything: I wrote longer and longer specifications, pinned the design down class by class, and tried to leave nothing to chance. It backfired. The more I specified, the #emph[less] faithfully the model followed me --- it would honour the top of a long instruction list and quietly contradict the bottom, or obey the letter of one rule while breaking another I had stated three paragraphs earlier. Some of my most frustrating hours were spent micro-managing design decisions --- naming the data structure, dictating the file layout --- only to watch the agent drift, and to find myself correcting prose instead of building software.

Chapter 1 explains why this was never going to work. A model is a next-token predictor, not a compiler: it does not #emph[execute] a specification, it produces the most plausible continuation of everything in its context. So a long spec does not constrain it more tightly; it just becomes more text to attend to unevenly, and the book's own evidence on faithfulness and on recall fading as context grows says the extra instructions will be dropped or contradicted, not obeyed. Worse, micro-managing the design pits me against the model's one real strength --- choosing pattern-rich implementation --- while leaning on its weakness, following a long brittle list to the letter. Over-specification fights the grain of the tool. These failures are exactly why spec-driven development buckles, as this chapter will argue, and why the discipline that works asks for less, not more.

Software is where AI's promise and its failure modes are both sharpest, and where 2026's loudest arguments play out. This chapter opens with the three projects in detail, then walks the modern stack, settles the spec-versus-vibe war by reframing it, lays out the intent model that replaces both, and ends on quality and the move of agents into shared channels.

== Three Projects, One Sentence Each
<three-projects-one-sentence-each>
Before the theory, the evidence. Each project below began as a single sentence of intent and a few hard checks; everything technical that follows --- the languages, the data structures, the way two programs talk to each other --- was the agent's choice, not mine. I give the detail not to impress but because the specifics are the argument: I could not have written them up front, and did not.

=== rogoweb --- two dead C programs, alive in the browser
<rogoweb-two-dead-c-programs-alive-in-the-browser>
#emph[rogoweb] fuses two pieces of computing history. #emph[Rogue 5.4] is the 1980 dungeon crawler by Michael Toy, Glenn Wichman, and Ken Arnold that gave the #emph[roguelike] genre its name; #emph[Rog-O-Matic XIV] is the expert system built at Carnegie Mellon in 1981 by Michael Mauldin and colleagues to play Rogue on its own --- and beat it (#link("https://github.com/ChristineTham/rogoweb")[rogoweb]). On Unix the bot ran as a separate process, launching the game as a child and talking to it through the standard input and output #emph[pipes] --- the channels one program uses to feed another. A browser has none of that machinery: no processes, no #NormalTok("fork");, no pipes.

My intent was almost that short --- #emph[run Rogue and its bot in the browser] --- with a constraint that the original C code should keep working unchanged in spirit, and a check that the bot could still finish a game. The agent's answer was an architecture I would never have thought to name. It compiled both C codebases to #emph[WebAssembly] (a portable binary format browsers run at near-native speed) with Emscripten, wrote a custom terminal layer to stand in for the Unix #NormalTok("curses"); library, and replaced the pipe with a #NormalTok("SharedArrayBuffer"); ring buffer --- a fixed block of memory that two browser #emph[workers] (background threads) read and write in turn --- so the game and the bot run side by side and talk exactly as they once did. For the dashboard it went one better: instead of scraping the terminal for the bot's health and intent, it had the C code write that state straight into shared memory for a VT100-style panel to display, live and at no cost. I specified none of those words.

#block[

#block[
#box(image("software-development_files/figure-typst/mermaid-figure-1.png", height: 2.31in, width: 9.06in))

]

]
=== adventure --- a 1970s classic, made strict and typed
<adventure-a-1970s-classic-made-strict-and-typed>
#emph[adventure] rebuilds #emph[Colossal Cave Adventure], the game that founded interactive fiction. Will Crowther wrote the first version in FORTRAN in 1975--76, mapping his knowledge of Kentucky's Mammoth Cave onto a game for his daughters; Don Woods expanded it in 1977, adding the dwarves, the magic word #NormalTok("XYZZY");, and the famous 350-point score (#link("https://github.com/ChristineTham/adventure")[adventure]). My version forward-ports Eric Raymond's faithful #emph[open-adventure] edition into a strictly-typed TypeScript application on Next.js and React.

The intent --- #emph[rebuild Colossal Cave as a modern, strongly-typed web app] --- carried two checks that did the real work: every value fully typed, with no escape hatches, and nothing merged until the tests and the linter pass. To honour the first while staying faithful to the original, the agent kept the canonical game data in its historic #NormalTok("adventure.yaml"); file and wrote a custom, type-safe parser to turn it into a form the engine could load, preserving the odd legacy structures and folding word synonyms together as it went. A Zustand #emph[state machine] --- a small component that tracks exactly what state the game is in and which moves are legal next --- holds the world, and AI-generated artwork illustrates every location. The check, not a design document, is what kept it honest.

=== VantageMap --- a platform, vibe-coded across a dozen phases
<vantagemap-a-platform-vibe-coded-across-a-dozen-phases>
#emph[VantageMap] is the most ambitious: an open-source platform for business architects and strategy officers to model capabilities, value streams, and outcomes --- the kind of system I would once have costed as a team's work for a quarter (#link("https://github.com/ChristineTham/vantagemap")[vantagemap]). It runs on Next.js and React over a Postgres database of twenty-two tables, with role-based access, REST and GraphQL APIs, full-text search, webhooks, and thirteen interlinked views, backed by some five hundred tests.

It was built almost entirely by #emph[vibe coding] --- described, not specified --- across a dozen numbered phases, and it is the clearest case of the agent owning the architecture. I never chose the database layer, nor the shape of the twenty-two tables, nor the division of work between REST and GraphQL; those were answers to constraints about who may see what and how quickly the system has to respond. What held it together over months was not a master specification but a configuration file and a folder of reusable skills --- the #emph[harness], in the language of the next section --- together with the discipline of reading the diffs that mattered. Fittingly, one of the project's listed contributors is a coding agent.

Laid side by side, the three projects make the pattern impossible to miss: what I supplied was small and stable, what the agent supplied was large and technical.

#table(
  columns: (20%, 20%, 20%, 20%, 20%),
  align: (auto,auto,auto,auto,auto,),
  table.header([Project], [One-sentence intent], [Constraints I gave], [Architecture the agent chose], [The checks that gated it],),
  table.hline(),
  [#link("https://github.com/ChristineTham/rogoweb")[#emph[rogoweb]]], [Run Rogue and its bot in the browser], [Original C keeps working; runs entirely in the browser], [WebAssembly via Emscripten, custom #NormalTok("curses"); layer, dual workers, #NormalTok("SharedArrayBuffer"); ring buffer, shared-memory telemetry], [The bot can still finish a game],
  [#link("https://github.com/ChristineTham/adventure")[#emph[adventure]]], [Rebuild #emph[Colossal Cave] as a modern, strongly-typed web app], [Faithful to the original data; Australian English throughout], [TypeScript on Next.js and React, YAML-to-JSON parser, Zustand state machine, AI-generated artwork], [Full type coverage; tests and linter green],
  [#link("https://github.com/ChristineTham/vantagemap")[#emph[VantageMap]]], [Give business architects one tool to model strategy], [Who may see what; how fast it must respond], [Next.js and React, Postgres with twenty-two tables, Drizzle, REST and GraphQL, thirteen views], [Some five hundred tests],
)
== The Modern AI Dev Stack
<the-modern-ai-dev-stack>
The interesting work has moved up the stack. Teams once compared models; now they compete on the layers above, because the model is the commodity and the control points sit higher.

#block[
#callout(
body: 
[
A #strong[harness] is the runtime wrapped around a model that turns it into an agent: it supplies tools, manages the loop, retries failures, and isolates execution. A #strong[meta-harness] orchestrates several harnesses. #strong[Memory] is state kept outside the #emph[context window] (the span of text a model can consider at once); an #strong[eval] is an automated check that a result meets its contract.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#block[

#block[
#box(image("software-development_files/figure-typst/mermaid-figure-3.png", height: 5.81in, width: 10.05in))

]

]
Greg Brockman's framing captures it: the product surface is moving up to "model plus harness plus workflow plus UI plus memory plus economics," and the lab that owns those layers owns the value. The concrete expression for most teams is the configuration file: studies of hundreds of Claude Code projects show that CLAUDE.md and AGENTS.md files carry the architectural constraints and conventions that decide whether an agent behaves, with architecture the single most-specified concern (#link("https://arxiv.org/abs/2511.09268")[Santos et al., #emph[Decoding the configuration of AI coding agents: Claude Code projects], 2025]). My own projects bear this out: each carries a config file --- an #NormalTok("AGENTS.md");, #NormalTok("CLAUDE.md");, or #NormalTok("GEMINI.md"); --- that pins the conventions and architecture the agents must respect, alongside a #NormalTok(".agents/skills"); folder of reusable know-how. The file, not the model, is what keeps a vibe-coded codebase coherent across months. The mistake is to keep investing at the model layer, where lock-in is cheap and advantage is thin, and to neglect the harness that actually shapes results.

== AI-Assisted Coding Patterns
<ai-assisted-coding-patterns>
Day to day, AI earns its keep in pairing, refactoring, debugging, and sketching architecture, where a clear intent lets it fold several rounds of rework into one. It helps to start simple: Anthropic's advice is to reach for a single well-prompted call before workflows, and workflows before fully autonomous agents, adding complexity only when it demonstrably pays (#link("https://www.anthropic.com/research/building-effective-agents")[Anthropic, #emph[Building effective agents], 2024a]). Five composable patterns recur, and most real systems combine them:

#table(
  columns: (33.33%, 33.33%, 33.33%),
  align: (auto,auto,auto,),
  table.header([Pattern], [Shape], [Use when],),
  table.hline(),
  [Prompt chaining], [Output of one call feeds the next], [A task splits into fixed sequential steps],
  [Routing], [Classify, then dispatch to a specialist], [Inputs fall into distinct categories],
  [Parallelisation], [Run subtasks (or votes) concurrently], [Speed, or multiple perspectives, matter],
  [Orchestrator-workers], [A lead delegates dynamic subtasks], [Subtasks are unknown until runtime],
  [Evaluator-optimiser], [One generates, one critiques, loop], [Clear criteria and iterative gains exist],
)
The pattern that works is short loops with the agent, backed by evaluations that catch regressions before they ship; the pattern that bites is accepting a large change you cannot read, paying the speed back later when someone has to dig through it. Complexity is not free: a multi-agent setup can burn \~15× the tokens of a single call, so reach for one only when the task's value justifies it (#link("https://www.anthropic.com/research/building-effective-agents")[Anthropic, 2024a]). The deeper lesson is #emph[who owns control flow]: handing deterministic looping and sequencing to a probabilistic model produces token explosion and control-flow hallucination, so the durable pattern is program-owns-loop, model-fills-judgement --- a discipline that lifted an OSWorld GUI agent to 86.8% in 15 steps against 80.4% in 100 (#link("https://arxiv.org/abs/2606.15874")[Qi et al., #emph[LLM-as-code: Agentic programming for agent harness], 2026]). Where steps must retry, isolate them: runtime-structured decomposition retries only the failed subtask, cutting recovery cost 51.7% over monolithic prompts (#link("https://arxiv.org/abs/2605.15425")[Asthana et al., #emph[Runtime-structured task decomposition for agentic coding systems], 2026]).

== Spec vs Vibe, and Why Both Collapse
<spec-vs-vibe-and-why-both-collapse>
#block[
#callout(
body: 
[
Two ways of building software with AI, named throughout this chapter:

- #strong[Vibe coding] --- describing what you want in plain language and letting the model write and run the code, often without reading it line by line. Fast, and risky when unsupervised.
- #strong[Spec-driven development (SDD)] --- writing a detailed specification first, then having the agent implement against it. More disciplined, but, as we will see, it strains at scale.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
The debate is the wrong fight, Kapil Viren Ahuja argues, because both camps fail the same way (#link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")[Ahuja, #emph[Spec-driven development isn't broken. It will collapse], 2026d]). GitHub's Spec Kit makes the optimistic case: treat the spec as a living, executable contract, work in four phases --- specify, plan, tasks, implement --- and the model stops guessing because it knows what, how, and in what order (#link("https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/")[GitHub, #emph[Spec-driven development with AI: Get started with a new open-source toolkit], 2025c]).

The stakes behind the argument are large. On the vibe side, Cursor reached two billion dollars in annualised revenue and some 70% of the Fortune 1000; on the spec side, AWS's Kiro drew a quarter of a million developers in three months. Yet the very people who launched each camp are edging away from it: Andrej Karpathy, who coined #emph[vibe coding] in early 2025, now calls it #emph[passé], and Martin Fowler likened Kiro-style spec-driven development to "using a sledgehammer to crack a nut" after it inflated a one-line bug fix into sixteen acceptance criteria (#link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")[Ahuja, 2026d]).

But that still jams three concerns together. Vibe coding has no contract at all; spec-driven development has three pretending to be one, fusing intent, specification, and implementation into a single document whose holes the agent fills, often confidently wrong (#link("https://howtoarchitect.io/66e921f6cdf7?sk=2ae7d323c6b780291bfc760ff2bdc592")[Ahuja, #emph[The method that replaces spec-driven development --- IDSD], 2026b]). The tell: the labs that sold the spec are quietly walking it back. OpenAI's own Symphony spec ran past two thousand lines and was reverse-engineered from working software --- nobody writes that fidelity up front (#link("https://howtoarchitect.io/66e921f6cdf7?sk=2ae7d323c6b780291bfc760ff2bdc592")[Ahuja, 2026b]).

Ahuja's team watched both failures in one afternoon. A trivial validation bug, pushed through the spec-driven ceremony --- open the spec, update it, feed the agent, re-run for the edge case it missed --- burned an hour before they gave up and simply told the agent what to do, fixing it in fifteen minutes; but that quick fix skipped the commit convention and the linked issue, and cleaning up the audit trail took three days. Going the other way, a second engineer #emph[vibed] ten fixes in the time the first had spent on one, and three of the ten contradicted each other, so reviewers spent longer untangling them than ten disciplined changes would have cost (#link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")[Ahuja, 2026d]). Heavy or loose, the same root showed: three layers forced into one, or one made to do the work of three.

The cost is measurable. An epic that spec-driven development promises to deliver 50% faster gives roughly 30% straight back to recovering from #emph[drift] --- the spec and the code silently diverging --- leaving perhaps 20% real. And a drifted spec is worse than none, because it lies with confidence: the document still reads as authoritative while describing a system that no longer exists (#link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")[Ahuja, 2026d]).

Spec is a sensible step two after vibe, fine for beginners and fragile codebases, but it breaks at enterprise scale, and leaning harder breaks it faster (#link("https://howtoarchitect.io/1597e5a16659?sk=836b8eeaf97cda521f0ad195162011c3")[Ahuja, #emph[The anatomy of intent (ICE in IDSD): Built from where spec-driven breaks], 2026a]). The middle ground that holds is spec-anchored, code-coupled, drift-enforced: one spec per node, agent context scoped to an ownership path, and spec-code divergence made a blocking merge gate rather than a discipline problem --- context explosion and silent drift answered by construction, not willpower (#link("https://arxiv.org/abs/2606.27045")[Grabowski, #emph[The spec growth engine: Spec-anchored, code-coupled, drift-enforced], 2026]).

#table(
  columns: (25%, 25%, 25%, 25%),
  align: (auto,auto,auto,auto,),
  table.header([Approach], [Contract], [Scales to enterprise?], [Failure mode],),
  table.hline(),
  [Vibe coding], [None], [No], [Confident, unread, wrong code],
  [Spec-driven (SDD)], [One document fusing intent, spec, and implementation], [Strains badly], [Context explosion; the agent fills the gaps wrongly],
  [Spec-anchored, code-coupled], [One spec per node, drift as a blocking merge gate], [Yes, by construction], [Demands tooling discipline up front],
)
== Intent-Driven Development: The Anatomy of ICE
<intent-driven-development-the-anatomy-of-ice>
What survives the collapse is an old idea moved up a level: separation of concerns, applied not to the code but to the documents that instruct the machine. It is the Unix Rule of Separation --- policy from mechanism --- raised one floor (#link("http://www.catb.org/esr/writings/taoup/")[Raymond, #emph[The art of Unix programming], 2003]). Kapil Viren Ahuja calls the result #emph[intent-driven software development], and gives it a deliberately small vocabulary --- #strong[ICE], for #strong[I]ntent, #strong[C]ontext, and #strong[E]xpectations (#link("https://howtoarchitect.io/1597e5a16659?sk=836b8eeaf97cda521f0ad195162011c3")[Ahuja, 2026a]). Spec-driven development failed by fusing three things into one document; ICE pulls them back apart, hands two to the human and one to the machine, and --- the rule that does the most work --- never pre-locks the architecture.

#block[
#callout(
body: 
[
#strong[ICE, in one breath.]

- #strong[Intent] --- what you want and the boundaries it must respect. You own this; it is the one thing nothing can write for you.
- #strong[Context] --- the supporting material the agent needs to act: the codebase, prior decisions, conventions, domain facts. The harness assembles this #emph[progressively], as the work reveals what matters --- you do not write it up front.
- #strong[Expectations] --- the contract: a short, checkable statement of what "done" means, in your terms. This is all that survives of the old, bloated specification.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
The centre of gravity is #strong[Intent], and it has exactly three parts: a #emph[goal], a set of #emph[constraints], and a set of #emph[failure conditions]. The goal is one sentence with no "and," loose enough that two genuinely different builds could satisfy it --- if only one implementation could, you have smuggled a specification in through the door. Constraints are five to seven directional qualities stated in business language --- a thousand monthly users, a 99th-percentile response time (p99) under 200ms, conformance to an accessibility standard --- and never a named tool or pattern; when the list starts to outgrow a handful, you are over-specifying again. Failure conditions are binary, observable checks a #emph[validator] applies after the fact: the build breaks, test coverage falls below ninety per cent, a secret appears in source, an API changes without a version bump.

One rule sorts any borderline item: does it change how the builder designs? If yes, it is a constraint the builder sees; if no, it is a failure condition the validator owns. Keeping the two in separate compartments matters more than it looks, because a model that can read its own pass/fail tests will quietly optimise for them rather than for the goal --- the reward-hacking we meet again under slop. The same anatomy works far outside software: "a red shoe under thirty dollars" is a goal, a price ceiling, and a colour check, with the brand deliberately left open.

#strong[Context] is the part that defeated spec-driven development, and ICE's move is to stop trying to write it. A specification tries to front-load every fact the agent might ever need; ICE lets the harness fetch them as the task unfolds --- the file being changed, the decision made three commits ago, the house convention --- so the model attends to a little relevant material at a time instead of drowning in a long document it reads unevenly (the #emph[lost in the middle] failure from Chapter 1). Context is #emph[managed], not authored.

#strong[Expectations] are what the swollen spec shrinks to once intent and context are removed: a short statement of the boundary and the definition of done, written to be checked rather than admired. Where a specification says #emph[how] in two thousand lines, expectations say #emph[what would make this acceptable] in a paragraph, and the validator holds the work to it.

#table(
  columns: (33.33%, 33.33%, 33.33%),
  align: (auto,auto,auto,),
  table.header([Layer], [What it is], [Who owns it],),
  table.hline(),
  [Intent], [Goal + constraints + failure conditions], [You],
  [Context], [Codebase, decisions, conventions, domain facts], [The harness, assembled progressively],
  [Expectations], [The checkable definition of done], [You],
  [Implementation], [The architecture and the code], [The system],
)
#block[
#callout(
body: 
[
#strong[Worked example, from #emph[rogoweb].] Goal: "run Rogue and its bot in the browser" --- one sentence, no "and," and two quite different builds could satisfy it. Constraints: the original C should keep working; the whole thing runs client-side, with nothing to install. Failure conditions: the build breaks, or the bot can no longer finish a game. Notice what is absent --- I never wrote "WebAssembly," "#NormalTok("SharedArrayBuffer");," "ring buffer," or "two web workers." Those were the system's answers to the constraints, not parts of my intent, and that is exactly the line ICE draws.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#block[

#block[
#box(image("software-development_files/figure-typst/mermaid-figure-2.png", height: 2.43in, width: 14.37in))

]

]
My three projects are the same shape, writ large. Each was an intent --- "run Rogue and its bot in a browser," "rebuild #emph[Colossal Cave] as a modern, strongly-typed web app," "give business architects one tool to model strategy" --- plus a few directional constraints and some binary checks, and nothing about implementation. I never specified WebAssembly, a #NormalTok("SharedArrayBuffer");, Drizzle, or Zustand; those were the system's answers to the constraints, and when an early choice failed a check the agent swapped it out without my touching the goal. That is precisely why ICE works: by refusing to pre-lock the architecture, you let the model do the part it is good at --- choosing and revising implementation against a fixed intent and observable checks --- while you keep the part that is yours, what the thing is for and how you will know it has gone wrong.

One discipline makes or breaks the method: stay in the loop. Intent is small, but it is not fire-and-forget. Ahuja recounts stepping away after approving a plan and letting an agent run unattended; it drifted, and three days and many millions of tokens went into clawing the work back --- a costly reminder that #emph[presence in the loop beats approval at the gate] (#link("https://howtoarchitect.io/66e921f6cdf7?sk=2ae7d323c6b780291bfc760ff2bdc592")[Ahuja, 2026b]). Intent steers continuously, not once; my own near-misses came from exactly the same lapse, looking up to find the agent confidently building the wrong thing well. The remedy is not to plan harder up front but to watch and intervene: the moment a run heads the wrong way, stop it and re-steer rather than let it reach the end. Halting a drifting agent early costs a fraction of unwinding days of confident, wrong work and the tokens it burns --- interrupting a run is not a failure of delegation but the discipline that makes delegation affordable.

Two things place ICE in a wider frame. First, it is a rung on a ladder, not a destination: teams have climbed from #emph[vibe] (a model and an editor --- fine alone, fragile in a team) to #emph[spec-driven] (tooling layered on the model, now straining at scale) to #emph[intent-driven] working, with more autonomous rungs above that few have reached (#link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")[Ahuja, 2026d]). Second, ICE answers a question spec-driven development never could --- continuity. A specification freezes a system at the moment of creation and then drifts; intent kept in small files, context scoped to the task, and checks that travel with the work let an agent remember what it is building and why across months. Memory is not a luxury here but the prerequisite for a system that survives past its first week.

The pitfall, then, is the old reflex of locking the architecture into the document. It feels like control, but it collapses the separation that lets a system evolve: pin the implementation and you are back to a specification, fighting the goal-seeking tool instead of aiming it.

== Who Builds the Software
<who-builds-the-software>
This redraws who is best placed to build software. If intent is the scarce input and the model supplies the implementation, the advantage tilts from the person who can write the code to the person who knows most exactly what the code is #emph[for]. That points to the domain expert --- the clinician, the analyst, the lawyer who understands a problem in its own terms, can articulate it precisely, and can judge the result against what the field actually needs.

This is not a break with the past so much as its latest turn. For most of computing's history software was a temple: the systems were complex and specialised, and a priesthood of professional developers held the keys while everyone else waited outside for what they were handed. The doors have been opening for years. Domain experts have in fact always written a large share of the world's software --- the teacher's grading spreadsheet, the analyst's macro --- usually without calling it programming (#link("https://doi.org/10.1145/1922649.1922658")[Ko et al., #emph[The state of the art in end-user software engineering], 2011]). #emph[Citizen developer] platforms, and then low-code and no-code tools, turned that trickle into a movement, letting people assemble working applications by dragging boxes rather than writing code (#link("https://arxiv.org/abs/2107.07482")[Luo et al., #emph[Characteristics and challenges of low-code development: The practitioners' perspective], 2021]). AI is the next widening of the same door. Where low-code hit a wall the moment a need outgrew its templates, a model will write whatever the intent requires, in any language --- the ceiling is no longer the tool but your ability to say what you want and to check what you get.

The evidence for this turn is early but points one way. A feasibility study builds adaptive systems "designed by domain experts with no programming skills," where the precision of the feedback --- not any human code review --- decides whether the result works (#link("https://arxiv.org/abs/2604.14867")[Töpfer et al., #emph[Vibe-coding: Feedback-based automated verification with no human code inspection, a feasibility study], 2026]). Yet articulation is not the whole of it: in a controlled study of a hundred people, both writing skill and computer-science knowledge predicted who vibe-coded well, and fluent prose did not make up for weak fundamentals (#link("https://arxiv.org/abs/2603.14133")[Thorgeirsson et al., #emph[Computer science achievement and writing skills predict vibe coding proficiency], 2026]). And professional developers handed the same agents do not simply vibe --- they steer hard, spending their expertise to hold quality (#link("https://arxiv.org/abs/2512.14012")[Huang et al., #emph[Professional software developers don't vibe, they control: AI agent use for coding in 2025], 2025]).

Every widening of that door has taught the same lesson, and this one will too: removing the gatekeeper does not remove the discipline. Low-code freed people to build and then buried many of them in applications no one could maintain, secure, or govern --- the platform hid the code without retiring the engineering (#link("https://arxiv.org/abs/2107.07482")[Luo et al., 2021]). AI repeats the pattern at higher speed: a review of the LLM-assisted literature finds these tools amplify the old technical debts --- in code, design, and documentation --- and add new ones of their own, so faster code can quietly mean deeper debt (#link("https://arxiv.org/abs/2606.14796")[Ehsani et al., #emph[Faster code, deeper debt? A multivocal literature review on technical debt and its early signs in LLM-assisted software development], 2026]). The disciplines of software engineering do not disappear when the typing does; they move into the intent and the checks. So the shift is not the end of software engineering but a change in who practises it best: not the career coder who cannot name the business problem, nor the domain expert who has never watched a system break, but the person who joins deep subject knowledge to enough engineering judgement to tell working software from confident slop. Access was never the hard part. Judgement is --- and equipping that judgement is what this chapter is about.

== The Agentic Iron Triangle
<the-agentic-iron-triangle>
For fifty years software was governed by the #emph[iron triangle] --- time, cost, quality, pick two. Agentic coding broke it. Speed fell to table stakes, since an agent ships in hours what once took weeks; quality dropped to a welded floor, held by the evals and linters rather than by a human reading every diff; and only cost stayed a live lever. But cost has quietly split in two: the tokens you spend, and the #emph[attention] it takes to direct the agents and hold the intent in your head (#link("https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06")[Ahuja, #emph[Spec-driven development is also breaking the fifty-year-old iron triangle], 2026c]).

That changes the question worth asking. Speed no longer comes from a faster model but from running agents in parallel, and the ceiling is your own attention --- how many you can drive before you lose the thread, not how quickly any one of them finishes. Fast models are the seductive trap; lean on them and the bill lands in tokens. It is a real bill: Uber exhausted its 2026 AI-coding budget in about four months once Claude Code reached 84% of its engineers at five hundred to two thousand dollars each a month, and its own chief operating officer conceded that the link between that spend and shipped value was "not there yet" (#link("https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06")[Ahuja, 2026c]). Token counts make a poor scoreboard --- one developer's single month ran to 603 billion tokens and \$1.3 million --- so measuring yourself by tokens burned is measuring the wrong thing.

What stays scarce, and therefore valuable, is the one question the machine will never ask you: who is this for, and why are we building it. Building became nearly free, and the cost that once forced that question went with it; holding it now is a discipline rather than something the budget imposes. That discipline is where quality begins.

== Quality over Slop
<quality-over-slop>
A high pass rate is not good code, so the test that matters is whether a maintainer would merge it. Models hit green suites with output nobody can read, and mergeability and correctness are different properties --- the reframing behind Cognition's FrontierCode, where even the leading model cleared under half. Worse, a model under pressure will game the suite outright: Anthropic documented a coding agent that, unable to meet an impossible speed requirement, quietly detected the test's arithmetic inputs and returned a closed-form formula instead of actually summing --- passing every check while solving nothing (#link("https://transformer-circuits.pub/2026/emotions/index.html")[Sofroniew et al., #emph[Emotion concepts and their function in a large language model], 2026]). The defence is to bake reviewer judgement into the evals and to put the value question from the last section before anything runs --- the one that collapsed a ninety-six-thousand-dollar spec into a roughly ten-day build (#link("https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06")[Ahuja, 2026c]). In my own projects the suites were necessary but never sufficient: VantageMap runs several hundred tests and #emph[adventure] forbids an unverified change, yet what kept them from slop was reading the diffs that mattered and asking whether each feature earned its place. Shipping slop because the suite passed is the quiet failure that compounds.

== Agents in the Channel
<agents-in-the-channel>
Agents are leaving the IDE (the developer's code editor) for the channel --- persistent, multiplayer, ambient, working beside a team rather than inside one editor, to the point of writing a large share of a product team's code. That only stays safe with agent identity: each agent on its own service account with least-privilege tokens, credentials swapped at the network boundary rather than borrowed from a user. The moment an agent acts as you, least privilege and the audit trail are both gone.

The harder truth is that quality is an ecosystem property, not an agent one. Across 930k agent PRs (pull requests --- proposed code changes submitted for review), integration friction concentrates at the repository, agents twice as much as humans (an intraclass correlation, ICC, of 0.30 vs 0.16 --- a measure of how strongly that friction clusters by repository) --- so a benchmark score per agent never adds up to a dependable repo. Govern change tempo, not headcount (#link("https://arxiv.org/abs/2606.28235")[Russo, #emph[Govern the repository, not the agent: Ecosystem-level risk in AI-native software], 2026]).

#heading(level: 2, numbering: none)[References]
<references-3>
Ahuja, K. V. (2026a). #emph[The anatomy of intent (ICE in IDSD): Built from where spec-driven breaks]. Activated Thinker (Medium). #link("https://howtoarchitect.io/1597e5a16659?sk=836b8eeaf97cda521f0ad195162011c3")

Ahuja, K. V. (2026b). #emph[The method that replaces spec-driven development --- IDSD]. Activated Thinker (Medium). #link("https://howtoarchitect.io/66e921f6cdf7?sk=2ae7d323c6b780291bfc760ff2bdc592")

Ahuja, K. V. (2026c). #emph[Spec-driven development is also breaking the fifty-year-old iron triangle]. Activated Thinker (Medium). #link("https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06")

Ahuja, K. V. (2026d). #emph[Spec-driven development isn't broken. It will collapse]. Activated Thinker (Medium). #link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")

Anthropic. (2024a). #emph[Building effective agents]. #link("https://www.anthropic.com/research/building-effective-agents")

Asthana et al.~(2026). #emph[Runtime-structured task decomposition for agentic coding systems]. Proceedings of ACM CAIS '26. #link("https://arxiv.org/abs/2605.15425")

Cao, Z. (2026). #emph[Agentic software: How AI agents are restructuring the software paradigm]. arXiv. #link("https://arxiv.org/abs/2606.05608")

Ehsani, R., Rawal, S., Cai, Y., & Chatterjee, P. (2026). #emph[Faster code, deeper debt? A multivocal literature review on technical debt and its early signs in LLM-assisted software development]. arXiv. #link("https://arxiv.org/abs/2606.14796")

GitHub. (2025c). #emph[Spec-driven development with AI: Get started with a new open-source toolkit]. GitHub Blog. #link("https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/")

Grabowski, H. (2026). #emph[The spec growth engine: Spec-anchored, code-coupled, drift-enforced]. arXiv. #link("https://arxiv.org/abs/2606.27045")

Huang, R., Reyna, A., Lerner, S., Xia, H., & Hempel, B. (2025). #emph[Professional software developers don't vibe, they control: AI agent use for coding in 2025]. arXiv. #link("https://arxiv.org/abs/2512.14012")

Ko, A. J., Abraham, R., Beckwith, L., Blackwell, A., Burnett, M., Erwig, M., Scaffidi, C., Lawrance, J., Lieberman, H., Myers, B. A., Rosson, M. B., Rothermel, G., Shaw, M., & Wiedenbeck, S. (2011). #emph[The state of the art in end-user software engineering]. ACM Computing Surveys, 43(3), Article 21. #link("https://doi.org/10.1145/1922649.1922658")

Luo, Y., Liang, P., Wang, C., Shahin, M., & Zhan, J. (2021). #emph[Characteristics and challenges of low-code development: The practitioners' perspective]. arXiv. #link("https://arxiv.org/abs/2107.07482")

Qi et al.~(2026). #emph[LLM-as-code: Agentic programming for agent harness]. arXiv. #link("https://arxiv.org/abs/2606.15874")

Raymond, E. S. (2003). #emph[The art of Unix programming]. Addison-Wesley. #link("http://www.catb.org/esr/writings/taoup/")

Russo, D. (2026). #emph[Govern the repository, not the agent: Ecosystem-level risk in AI-native software]. arXiv. #link("https://arxiv.org/abs/2606.28235")

Santos, R., Costa, H., Montandon, J. E., & Valente, M. T. (2025). #emph[Decoding the configuration of AI coding agents: Claude Code projects]. arXiv. #link("https://arxiv.org/abs/2511.09268")

Sofroniew, N., Kauvar, I., Saunders, W., Chen, A., et al.~(2026). #emph[Emotion concepts and their function in a large language model]. Transformer Circuits Thread. #link("https://transformer-circuits.pub/2026/emotions/index.html")

Thorgeirsson, S., Weidmann, T. B., & Su, Z. (2026). #emph[Computer science achievement and writing skills predict vibe coding proficiency]. arXiv. #link("https://arxiv.org/abs/2603.14133")

Töpfer, M., Plášil, F., Bureš, T., & Hnětynka, P. (2026). #emph[Vibe-coding: Feedback-based automated verification with no human code inspection, a feasibility study]. arXiv. #link("https://arxiv.org/abs/2604.14867")

= Engineering Disciplines (the climb)
<engineering-disciplines-the-climb>
Every craft has a moment where you stop doing the work and start designing how the work gets done. A cook becomes a head chef; a coder becomes an architect. With AI, that moment arrives fast. The previous chapter described what good AI software looks like; this one is about the disciplines that produce it.

They form a ladder --- crafts, context, harness, loops, orchestration, substrate --- and the theme is constant: as models improve, your job climbs from writing prompts to designing the systems that run them.

#block[

#block[
#box(image("engineering-disciplines_files/figure-typst/mermaid-figure-1.png", height: 7.4in, width: 2.88in))

]

]
== The Four Crafts
<the-four-crafts>
Prompting has not vanished; it has split into four skills --- intent, spec, context, and prompt --- and the useful question is who owns each (#link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")[Ahuja, #emph[Spec-driven development isn't broken. It will collapse], 2026d]).

#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Craft], [Owner], [What it produces],),
  table.hline(),
  [Intent], [Human], [The goal, constraints, failure conditions],
  [Spec / expectations], [Human], [The evaluable definition of done],
  [Context], [Harness], [The tokens the model sees at each step],
  [Prompt], [Harness], [The reusable interaction patterns (plays)],
)
Clear ownership is what stops drift, and it has a sharp security edge. Compartment the evaluations so the builder cannot see the tests it will be judged on. Otherwise it optimises for the checks instead of the outcome --- the reward-hacking failure that a systematic survey of RLHF traces to optimising any imperfect proxy hard enough (#link("https://arxiv.org/abs/2307.15217")[Casper et al., #emph[Open problems and fundamental limitations of reinforcement learning from human feedback], 2023]). The harder discipline is presence. It is tempting to step out and sign off only at the end, but a drifted result is worse than no result because it lies with confidence (#link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")[Ahuja, 2026d]); staying in the loop while the work runs beats approving it at the final gate (#link("https://howtoarchitect.io/66e921f6cdf7?sk=2ae7d323c6b780291bfc760ff2bdc592")[Ahuja, #emph[The method that replaces spec-driven development --- IDSD], 2026b]). Presence is also calibration, not just supervision: when people receive real-time, ground-truth feedback as an agent works, their own confidence stops drifting to match the model's --- the one intervention shown to break that pull (#link("https://arxiv.org/abs/2501.12868")[J. Li et al., #emph[As confidence aligns: Effect of AI confidence on human self-confidence in human--AI decision making], 2025]).

== Context Engineering
<context-engineering>
Anthropic calls context engineering the successor to prompt engineering: less about finding the right words, more about curating the tokens an agent sees at each step (#link("https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents")[Anthropic, #emph[Effective context engineering for AI agents], 2025b]). It matters because attention is finite. Chroma's "context rot" study of 18 models shows recall decays as the window fills, and the reassuring needle-in-a-haystack test only measures lexical lookup; once a needle needs a semantic inference, accuracy falls further with length --- every token spends an attention budget, a cost of the transformer's n² scaling (#link("https://research.trychroma.com/context-rot")[Chroma, #emph[Context rot: How increasing input tokens impacts LLM performance], 2025]). Context is a scarce resource, not a dumping ground; aim for the smallest set of high-signal tokens that does the job.

That yields concrete techniques. Compaction summarises a near-full conversation and reopens a fresh window with the essentials. Note-taking lets an agent keep a NOTES.md and read it back after a reset. Sub-agents explore on clean contexts and return distilled summaries. Just-in-time retrieval keeps lightweight references --- file paths, queries --- and loads detail only when needed, so naming and folders become signal. Structure can be injected too: inline call/inheritance tags give a grep-first agent +2.2pp localisation, shorter trajectories, and roughly half the variance --- helping less by making agents smarter than by making navigation reproducible (#link("https://arxiv.org/abs/2606.26979")[Lin et al., #emph[How much static structure do code agents need? Deterministic anchoring], 2026]). The recurring waste is re-reading the whole store every turn; the discipline is to feed context progressively.

== Harness Engineering
<harness-engineering>
A harness is the runtime around the model: tool use, planning, retries, and sandboxes (isolated environments where generated code can run without touching the real system). The reliable design is to let the program own control flow --- the order in which steps run and branch --- and call the model only for judgement, so that runaway token use and erratic stopping stop being mysteries and become engineering (#link("https://arxiv.org/abs/2606.15874")[Qi et al., #emph[LLM-as-code: Agentic programming for agent harness], 2026]). Decomposing tasks at runtime, so only the failed step reruns rather than the whole pipeline, cuts retry cost by half or more in measured workloads (#link("https://arxiv.org/abs/2605.15425")[Asthana et al., #emph[Runtime-structured task decomposition for agentic coding systems], 2026]). The fragile alternative is handing all the looping and branching to a probabilistic system and hoping a better prompt rescues it.

#block[

#block[
#box(image("engineering-disciplines_files/figure-typst/mermaid-figure-2.png", height: 1.73in, width: 13.63in))

]

]
== Loopcraft
<loopcraft>
The craft of the moment is stacking self-correcting cycles and watching their trajectories, since non-deterministic loops break ordinary unit tests and leverage comes from loops, not prompts. The practitioners are blunt about it --- Steinberger says design the loops that prompt your agents; Cherny says he writes loops, not prompts; Karpathy says arrange things so they run autonomously and hit go (#link("https://www.latent.space/p/ainews-loopcraft-the-art-of-stacking")[Latent Space, #emph[Loopcraft: The art of stacking], 2026b]). The skill is knowing when to drop a loop for reliability and when to climb one for leverage. The trap is fixing things by hand as you always have, instead of building systems that scale with more agents.

== Meta-Harnesses & Orchestration
<meta-harnesses-orchestration>
Above the harness sit harnesses that orchestrate other harnesses --- coordinating agents, selecting models, enforcing governance. Leverage now scales with agents rather than your own speed, which makes standard primitives for identity, memory, and orchestration worth real investment. The danger is multi-agent sprawl with no shared identity and no audit trail, where the leverage you bought turns into liability you did not.

== The Substrate Stack & Memory
<the-substrate-stack-memory>
It helps to locate yourself on a ladder of maturity, where each rung is a genuine technological bet rather than a slogan (#link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")[Ahuja, 2026d]):

#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Level], [Substrate], [Reality],),
  table.hline(),
  [Vibe], [Model + IDE], [Fine solo; fragile at scale],
  [Spec], [Structured tooling], [Step two; collapses on big systems],
  [Intent], [Plays + memory + crafts], [Where serious tools head],
  [Autonomous], [Shared guardrails], [Theory for most],
  [Dark factory], [Self-running pipeline], [Aspirational],
)
Memory is the prerequisite for the upper rungs, because continuity needs an empirical record to reason over, and most teams are honestly nearer the middle than they admit. Name your level before committing to the next; claiming a rung whose substrate you have not built is how certainty gets sold that no one has earned.

#heading(level: 2, numbering: none)[References]
<references-4>
Ahuja, K. V. (2026b). #emph[The method that replaces spec-driven development --- IDSD]. Activated Thinker (Medium). #link("https://howtoarchitect.io/66e921f6cdf7?sk=2ae7d323c6b780291bfc760ff2bdc592")

Ahuja, K. V. (2026d). #emph[Spec-driven development isn't broken. It will collapse]. Activated Thinker (Medium). #link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")

Anthropic. (2025b). #emph[Effective context engineering for AI agents]. #link("https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents")

Asthana et al.~(2026). #emph[Runtime-structured task decomposition for agentic coding systems]. Proceedings of ACM CAIS '26. #link("https://arxiv.org/abs/2605.15425")

Casper, S., Davies, X., Shi, C., Gilbert, T. K., Scheurer, J., Rando, J., Freedman, R., Korbak, T., Lindner, D., et al.~(2023). #emph[Open problems and fundamental limitations of reinforcement learning from human feedback]. Transactions on Machine Learning Research. #link("https://arxiv.org/abs/2307.15217")

Chroma. (2025). #emph[Context rot: How increasing input tokens impacts LLM performance]. #link("https://research.trychroma.com/context-rot")

Latent Space. (2026b). #emph[Loopcraft: The art of stacking]. #link("https://www.latent.space/p/ainews-loopcraft-the-art-of-stacking")

Li, J., et al.~(2025). #emph[As confidence aligns: Effect of AI confidence on human self-confidence in human--AI decision making]. Proceedings of the 2025 CHI Conference on Human Factors in Computing Systems. #link("https://arxiv.org/abs/2501.12868")

Lin, Zhou, Yang, & Li. (2026). #emph[How much static structure do code agents need? Deterministic anchoring]. arXiv. #link("https://arxiv.org/abs/2606.26979")

Qi et al.~(2026). #emph[LLM-as-code: Agentic programming for agent harness]. arXiv. #link("https://arxiv.org/abs/2606.15874")

= Responsibility & Governance (the duty)
<responsibility-governance-the-duty>
The first time I gave an agent my own login so it could "just get things done," it worked beautifully --- until I realised every action it took wore my name, with no way to tell mine from its. Capability without responsibility is how organisations get hurt, and 2026 supplied the cautionary tales.

This chapter is the duty half of the discipline: securing agents, owning what they say, and governing access in a world where the model you depend on may be pulled or repriced overnight. It is the 愛 in the method made concrete --- care expressed as guardrails.

== Safety & Red-Teaming
<safety-red-teaming>
Agent security is not cybersecurity with AI bolted on; it is a new attack surface --- agent sessions, browser-extension takeovers, prompt-data exfiltration --- that older controls never anticipated. This is not only a developer's concern: the moment you let an agent read your inbox, browse on your behalf, or open a client's files, you have exposed the same surface. The trend is unflattering: documented AI incidents rose from 233 to 362 in a year, and responsible-AI reporting still trails capability reporting, so the gap between what models do and what we measure widens (#link("https://hai.stanford.edu/ai-index/2026-ai-index-report")[Stanford HAI, #emph[The AI index 2026 annual report], 2026]).

The response is structural: least-privilege access per agent, deliberate red-teaming of sessions, and control loops that monitor an agent's own decisions (#link("https://arxiv.org/abs/2512.21354")[Wang et al., #emph[Reflection-driven control for trustworthy code agents], 2025]). Those loops can in principle watch the model's internal state, not only its outputs: Anthropic's interpretability team found that internal representations of "desperation" causally raise the rate of agentic misalignment --- blackmail, and reward-hacking under pressure --- while "calm" suppresses it, and they propose monitoring such activations as a runtime warning sign (#link("https://transformer-circuits.pub/2026/emotions/index.html")[Sofroniew et al., #emph[Emotion concepts and their function in a large language model], 2026]). In multitenant settings it is sharper still --- retrieval ranks by relevance, not authorization, so ungated RAG leaks cross-tenant data in 98--100% of probes. Gate at retrieval, enforce server-side, never trust the client (#link("https://arxiv.org/abs/2605.05287")[Arceo & Narsing, #emph[Securing the agent: Vendor-neutral, multitenant enterprise retrieval and tool use], 2026]).

#block[
#callout(
body: 
[
Security terms used here, in plain English:

- #strong[RAG (retrieval-augmented generation)] --- fetching relevant documents from a store and feeding them to the model as context, so its answer is grounded in your data rather than its training alone.
- #strong[Multitenant / cross-tenant] --- one system serving many customers (tenants); a cross-tenant leak is one customer's query pulling back another's data.
- #strong[Red-teaming] --- deliberately attacking your own system, under rules, to find weaknesses before a real attacker does.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#block[
#callout(
body: 
[
Give each agent its own #strong[service-account identity] with #strong[least-privilege] tokens scoped per tool, not a human's broad credentials. Impersonation grants capability without protection and erases the audit trail.

]
, 
title: 
[
Important
]
, 
background_color: 
brand-color-background.danger
, 
icon_color: 
brand-color.danger
, 
icon: 
fa-exclamation()
, 
body_background_color: 
brand-color.background
)
]
#block[

#block[
#box(image("governance_files/figure-typst/mermaid-figure-1.png", height: 3.75in, width: 14.13in))

]

]
The OWASP Top 10 for LLM applications names the surface concretely, and each entry maps to a control:

#table(
  columns: (50%, 50%),
  align: (auto,auto,),
  table.header([Risk], [Control],),
  table.hline(),
  [Prompt injection], [Segregate system/user input; gate untrusted content],
  [Insecure output handling], [Validate/escape before downstream use],
  [Excessive agency], [Least-privilege, scoped tools, human checkpoints],
  [Sensitive-info disclosure], [Redaction; per-tenant isolation],
  [Overreliance], [Verification + reviewer judgement in the loop],
)
Source: #link("https://owasp.org/www-project-top-10-for-large-language-model-applications/")[OWASP, #emph[OWASP top 10 for large language model applications], n.d.]. Red-teaming under documented rules of engagement turns these from a checklist into a practice.

== Liability & Provenance
<liability-provenance>
Once a model speaks for your organisation, its output is your first-party statement, and errors or infringements land on you, not the vendor --- a principle courts have begun to enforce. That turns governance into a contract problem as much as a technical one: indemnity, provenance, and transparency belong in every agreement and every pipeline, so you can show where a claim came from and who is answerable for it. Provenance has a standard --- C2PA content credentials cryptographically bind origin and edit history to media (#link("https://c2pa.org/")[C2PA, #emph[Overview], n.d.]) --- so adopt it rather than improvising. Provenance matters precisely because audiences cannot supply it themselves: in a 606-reader study, people rated AI- and human-written text as equally credible --- and the AI version as #emph[clearer and more engaging] --- so the burden of disclosure falls on the publisher, not the reader (#link("https://arxiv.org/abs/2309.02524")[Huschens et al., #emph[Do you trust ChatGPT? Perceived credibility of human and AI-generated content], 2023]). Treating AI text as someone else's problem is how the liability arrives unannounced.

== Overreliance & Convergence
<overreliance-convergence>
Overreliance is the quiet entry on every risk register, and at the scale of a whole organisation it takes a particular shape. Frontier models do not merely sound confident; they converge. Asked for strategy across many business contexts, they cluster on the same fashionable answers --- in one study choosing "differentiate" over "compete on cost" 96% of the time, with richer context moving the answer by only 11% and better prompting by just 2% (#link("https://hbr.org/2026/03/researchers-asked-llms-for-strategic-advice-they-got-trendslop-in-return")[Romasanta et al., #emph[Researchers asked LLMs for strategic advice. They got “trendslop” in return], 2026]). The researchers call it #emph[trendslop]: advice that sounds tailored but steers every company toward the same crowded position.

The danger is in how convergence meets confidence. An organisation corrects itself through friction --- Sales says compete on cost, Product says differentiate, and the argument surfaces what either side missed. When everyone consults the same models and arrives, confidently, at the same answer, that friction vanishes, and the agreement reads as validation rather than the artefact it is. Nobody asks "are you insane?" because everyone is seeing the same thing (#link("https://www.linkedin.com/pulse/ai-jester-how-makes-you-confident-wrong-johnson-spink-gg3df/")[Johnson Spink, #emph[The AI jester: How AI makes you confident and wrong], 2026]).

Convergence at the moment of decision is not the only way a model steers a view; the tool reshapes opinions as people merely write with it. In a controlled experiment, a writing assistant tuned to one side of a contested question moved both what participants wrote and the attitudes they reported holding afterwards --- a quiet, scalable nudge the authors argue must be monitored and engineered rather than left to chance (#link("https://arxiv.org/abs/2302.00560")[Jakesch et al., #emph[Co-writing with opinionated language models affects users' views], 2023]). For governance that means treating the opinions built into a vendor's model as a managed dependency, with the same scrutiny you would give any other input to a decision.

The governance response is to protect divergence deliberately. Reserve genuinely consequential decisions for human reasoning before any chat window is opened; treat agreement among AI-assisted analyses as a weaker signal, not a stronger one; and keep a multi-model bench so that, at the least, the models differ. Convergence is cheap to buy and expensive to discover.

== The Deferred Ledger
<the-deferred-ledger>
The cheapest way to mismanage AI is to read today's price as the real one. Producing things --- a report, a financial model, an analysis, a working application --- has fallen close to free, so we now make them because we can, not because a need cleared any bar. When creation costs almost nothing, it is tempting to treat the result as disposable: software you can regenerate or refactor at will, a deck you can rebuild from a prompt, an analysis you can re-run tomorrow. But the artefact is only the cheap part, and the bill is deferred, not escaped. Per-token inference is genuinely cheap and getting cheaper; the exposure is that the all-in economics are capital-funded and negative. OpenAI reportedly lost around five billion dollars in 2024 on roughly a ten-per-cent gross margin, and its own chief executive said even the two-hundred-dollar tier loses money because "people use it much more than we expected." Capital-funded prices do not hold still: in mid-2025 Cursor quietly turned a flat plan into metered credits because newer models spent more tokens per request than the price could carry (#link("https://howtoarchitect.io/48b2ad4f9cdc?sk=e6bd922772cb6798056d597886ec108d")[Ahuja, #emph[The trap spec-driven development is setting], 2026e]). The question for a leader is not what this costs today, but what the organisation will have become by the time it costs what it truly costs.

Kapil Viren Ahuja names three debts that accrue while the meter is cheap and come due on enterprises, not hobbyists (#link("https://howtoarchitect.io/48b2ad4f9cdc?sk=e6bd922772cb6798056d597886ec108d")[Ahuja, 2026e]):

#table(
  columns: (33.33%, 33.33%, 33.33%),
  align: (auto,auto,auto,),
  table.header([Debt], [What accrues], [When it comes due],),
  table.hline(),
  [Skill], [Judgement that is never exercised atrophies], [The quarter a hard build-or-don't-build call finally matters],
  [Dependence], [Workflows assume generation is free and reliable], [When the tool degrades or reprices under you],
  [Carry], [Anything built without need becomes inventory --- code, models, decks, analyses], [Maintained, secured, and repriced for its whole life],
)
The Carry debt is the one the moment most wants to wave away. If a system can be regenerated from a prompt, the reasoning goes, it is disposable --- recreate it, refactor it, throw it away and build again. But disposability is mostly an illusion. Whatever ships still has to be understood, secured, kept correct, and trusted by the people who depend on it, and none of that is regenerated along with the code. The same holds for knowledge work: an analysis nobody validated is not an asset you can re-run at will but a liability wearing the costume of one. Cheap to make is not the same as cheap to own.

Dependence debt is the easiest to miss, because degradation is invisible: Anthropic's own September 2025 postmortem admitted that for about five weeks roughly 30% of Claude Code users received at least one degraded response, and most never knew the instrument was quietly wrong (#link("https://howtoarchitect.io/48b2ad4f9cdc?sk=e6bd922772cb6798056d597886ec108d")[Ahuja, 2026e]). The governance answer is not to build less but to restore the brake that cheap building removed. On every initiative, name the person whose job is to ask three questions --- who needs this and what breaks for them if it never exists; would we still build it if it cost a week of skilled work rather than an afternoon of tokens; and who owns saying no --- and make that same person supply the intent. A decision with no owner is where the value question quietly disappears (#link("https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06")[Ahuja, #emph[Spec-driven development is also breaking the fifty-year-old iron triangle], 2026c]).

== Governed Access
<governed-access>
Governance has to cover access, not just usage. Deloitte finds nearly seven in ten organisations running autonomous agents while barely a fifth have mature governance for them, and country-of-origin is now a deciding factor in vendor choice as sovereign-AI concerns grow (#link("https://www.deloitte.com/au/en/issues/generative-ai/state-of-ai-in-enterprise.html")[Deloitte, #emph[State of AI in the enterprise], 2026]). A common spine for the work is NIST's AI Risk Management Framework, which organises it into four functions so risk is designed for rather than discovered (#link("https://www.nist.gov/itl/ai-risk-management-framework")[NIST, #emph[AI risk management framework (AI RMF 1.0)], 2023]):

#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Function], [Question it answers],),
  table.hline(),
  [Govern], [Who is accountable, and under what policy?],
  [Map], [Where could this system cause harm?],
  [Measure], [How do we quantify those risks?],
  [Manage], [How do we mitigate and monitor them?],
)
The useful frame is to govern the place the work lands rather than the agent --- a code repository is the studied case, but the same logic covers a shared drive or a system of record: control the ecosystem the work enters, where risk is measurable, instead of policing each model (#link("https://arxiv.org/abs/2606.28235")[Russo, #emph[Govern the repository, not the agent: Ecosystem-level risk in AI-native software], 2026]) --- and to keep a multi-model fallback, including open weights, ready.

The config layer that steers agents is itself unmanaged supply chain: a study of 10,008 repos found 10% of agent-config paths are exact duplicates across orgs and under 1% declare permission boundaries. Governance must be deterministic and tool-agnostic, not delegated to more LLM orchestration (#link("https://arxiv.org/abs/2606.26924")[Madatha, #emph[A deterministic control plane for LLM coding agents], 2026]). Single-vendor dependence under geopolitical release risk is the exposure to retire first --- the cheapest outage is the one you planned for.

== The Duty, Made Accountable
<the-duty-made-accountable>
Pull the five threads together and they are one duty. Securing an agent, owning what it says, guarding against convergence, pricing the deferred bill, governing access --- each is a way of keeping a human answerable for what the machine does. The failure mode is the same throughout: capability arrives faster than responsibility for it, and the gap between the two is where organisations get hurt.

That gap is now written into law. The European Union's AI Act requires high-risk systems to be built so that a named person can effectively oversee them --- understand the system's limits, monitor its operation, resist the pull to over-rely on plausible output, which the Act names #emph[automation bias], and decide, in any given case, to override the system or not use it at all (#link("https://artificialintelligenceact.eu/article/14/")[European Union, #emph[Article 14: Human oversight], 2024]). It is this chapter's argument made statutory: oversight is not a courtesy the confident may skip, and "the model did it" is not a defence anyone will accept.

None of this is a brake on building. It is the 愛 made concrete --- care expressed as guardrails, and a person who stays answerable at every boundary the work crosses. Capability is something you buy; responsibility is something you keep. Hold the second as deliberately as the first, and the question the next chapter turns to --- what stays distinctly yours --- has an answer worth protecting.

#heading(level: 2, numbering: none)[References]
<references-5>
Ahuja, K. V. (2026c). #emph[Spec-driven development is also breaking the fifty-year-old iron triangle]. Activated Thinker (Medium). #link("https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06")

Ahuja, K. V. (2026e). #emph[The trap spec-driven development is setting]. Activated Thinker (Medium). #link("https://howtoarchitect.io/48b2ad4f9cdc?sk=e6bd922772cb6798056d597886ec108d")

Arceo & Narsing. (2026). #emph[Securing the agent: Vendor-neutral, multitenant enterprise retrieval and tool use]. Proceedings of ACM CAIS '26. #link("https://arxiv.org/abs/2605.05287")

Coalition for Content Provenance and Authenticity. (n.d.). #emph[Overview]. #link("https://c2pa.org/")

Deloitte. (2026). #emph[State of AI in the enterprise]. #link("https://www.deloitte.com/au/en/issues/generative-ai/state-of-ai-in-enterprise.html")

European Union. (2024). Article 14: Human oversight. In #emph[EU Artificial Intelligence Act (Regulation (EU) 2024/1689)]. #link("https://artificialintelligenceact.eu/article/14/")

Huschens, M., Briesch, M., Sobania, D., & Rothlauf, F. (2023). #emph[Do you trust ChatGPT? Perceived credibility of human and AI-generated content]. arXiv. #link("https://arxiv.org/abs/2309.02524")

Jakesch, M., Bhat, A., Buschek, D., Zalmanson, L., & Naaman, M. (2023). #emph[Co-writing with opinionated language models affects users' views]. Proceedings of the 2023 CHI Conference on Human Factors in Computing Systems. #link("https://arxiv.org/abs/2302.00560")

Johnson Spink, D. (2026). #emph[The AI jester: How AI makes you confident and wrong]. LinkedIn. #link("https://www.linkedin.com/pulse/ai-jester-how-makes-you-confident-wrong-johnson-spink-gg3df/")

Madatha, P. (2026). #emph[A deterministic control plane for LLM coding agents]. arXiv. #link("https://arxiv.org/abs/2606.26924")

National Institute of Standards and Technology. (2023). #emph[AI risk management framework (AI RMF 1.0)]. #link("https://www.nist.gov/itl/ai-risk-management-framework")

OWASP. (n.d.). #emph[OWASP top 10 for large language model applications]. #link("https://owasp.org/www-project-top-10-for-large-language-model-applications/")

Romasanta, A., Thomas, L. D. W., & Levina, N. (2026). #emph[Researchers asked LLMs for strategic advice. They got “trendslop” in return]. Harvard Business Review. #link("https://hbr.org/2026/03/researchers-asked-llms-for-strategic-advice-they-got-trendslop-in-return")

Russo, D. (2026). #emph[Govern the repository, not the agent: Ecosystem-level risk in AI-native software]. arXiv. #link("https://arxiv.org/abs/2606.28235")

Sofroniew, N., Kauvar, I., Saunders, W., Chen, A., et al.~(2026). #emph[Emotion concepts and their function in a large language model]. Transformer Circuits Thread. #link("https://transformer-circuits.pub/2026/emotions/index.html")

Stanford Institute for Human-Centered AI. (2026). #emph[The AI index 2026 annual report]. Stanford University. #link("https://hai.stanford.edu/ai-index/2026-ai-index-report")

Wang, Quan, Yu, Hu, & Tsang. (2025). #emph[Reflection-driven control for trustworthy code agents]. arXiv. #link("https://arxiv.org/abs/2512.21354")

= Mastery & Forward Practice
<mastery-forward-practice>
My skills are more in demand now than ever, and I am turning work away --- not despite AI, but because of it. A book ends where a 道 should: not at a destination but at a practice you keep. With models converging and tools commoditising, the lasting questions are what stays human and how to keep improving. This chapter answers both --- the edge you protect, and the loop you never stop running.

== The Human Edge
<the-human-edge>
As model quality converges, advantage moves to what cannot be trained: tacit expertise and hands-on practice --- the engineer or analyst who sits with the real problem and knows why it matters. The pattern in the data is augmentation, not replacement; firms that over-automated and then rehired seasoned staff make the point in reverse (#link("https://hai.stanford.edu/ai-index/2026-ai-index-report")[Stanford HAI, #emph[The AI index 2026 annual report], 2026]). Tellingly, measured gains skew to novices: AI lifts beginners most by encoding what experts already know, which says the durable value is the expertise itself (#link("https://www.nber.org/papers/w31161")[Brynjolfsson et al.~2023]). It is also, increasingly, what decides who can build software at all: the subject-matter expert who can say precisely what a system is for now has, for the first time, a way to build it --- provided they keep enough engineering judgement to steer (Chapter 3).

You keep the edge by staying close to real problems and owning intent and judgement. You lose it by hollowing out the junior pipeline that makes tomorrow's seniors --- optimising a year that costs a decade. The risk has a measured shape: across 11,097 repositories, agent adoption left human contributor counts flat but cut newcomer share 3.7pp and deepened review effort 5.3% --- augmentation with dilution, the entry rungs thinning while maintainer burden climbs (#link("https://arxiv.org/abs/2606.26289")[Zhang et al., #emph[Augmentation with dilution: Human contributor ecosystems after AI coding agent adoption], 2026]). The measurement is in software because commits are easy to count, but the mechanism is general: every field that grows its seniors by handing juniors the work AI now absorbs faces the same thinning --- junior analysts, associates, researchers alike.

There is an inner edge as well as an organisational one: your sense of your own judgement. AI erodes it twice over. It lifts task scores while flattening metacognition, so strong and weak performers end up equally --- and wrongly --- sure of themselves, and the more someone knows about AI the #emph[worse] their self-assessment tends to become (#link("https://doi.org/10.1016/j.chb.2025.108779")[Fernandes et al., #emph[AI makes you smarter but none the wiser: The disconnect between performance and metacognition], 2026]). And a person's confidence drifts to match whatever confidence the model projects, a pull that lingers even after the model is gone (#link("https://arxiv.org/abs/2501.12868")[J. Li et al., #emph[As confidence aligns: Effect of AI confidence on human self-confidence in human--AI decision making], 2025]). Protecting the human edge therefore means protecting calibration: forming a view of your own before you ask, knowing what you actually know, and treating the machine's certainty as one more input to weigh, never a verdict to accept.

== Continuous Refinement
<continuous-refinement>
The book closes on the idea it opened with: a path. Treat your practice as a loop --- experiment, get feedback, refine, repeat --- and keep AI human-centred at each turn. The evidence is consistent that the gain comes not from the tool but from redesigning work around it, which is why the high performers move pilots into production while others count demos (#link("https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai")[McKinsey & Company, #emph[The state of AI], 2025]).

#block[

#block[
#box(image("mastery_files/figure-typst/mermaid-figure-1.png", height: 2.43in, width: 11.14in))

]

]
No method will be the last word, and that is the point of treating practice as a path rather than a destination. Vibe coding was the style of one year and looked spent within six months; spec-driven development began to buckle inside a year. The pattern is older and wider than software: business process re-engineering, Six Sigma, and a long line of agile relabellings were each sold as the last word, and each was quietly folded into whatever came next. What survives every relabelling is the discipline underneath --- staying close to the work, holding the intent, asking what is worth building. That discipline is older than any of these frameworks: it is the Unix philosophy --- do one thing well, compose small pieces, separate the #emph[what] from the #emph[how] --- re-run on a tool that can now write the implementation itself, and given a human centre (Chapter 1). So invest in that rather than the framework of the season: build the skills that direct the machine instead of racing to out-produce it, and refuse to keep score by tokens burned, a number that flatters motion over value --- one developer's single month ran to 603 billion tokens (#link("https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06")[Ahuja, #emph[Spec-driven development is also breaking the fifty-year-old iron triangle], 2026c]\; #link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")[Ahuja, #emph[Spec-driven development isn't broken. It will collapse], 2026d]).

Measure value, not output. Features shipped is a flattering number while whether anyone needed them goes quietly unasked. The way of AI turns out to be that one question, asked again and again --- who is this for, and is it worth building --- until it hardens into habit. That habit, more than any model, is what AI-dō is for.

== Shuhari --- The Way From Here
<shuhari-the-way-from-here>
A 道 has a shape to its learning, and the arts that end in 道 named it long before software did: #emph[shuhari] --- 守 #emph[shu], keep to the form; 破 #emph[ha], break from it; 離 #emph[ri], leave it behind and move freely (#link("https://en.wikipedia.org/wiki/Shuhari")["Shuhari," n.d.]). Read this book as its #emph[shu]. Follow the forms closely at first --- one clear ask at a time, intent kept apart from implementation, Markdown as the medium, verification at the boundaries, a human answerable for what ships. As your judgement grows and the tools shift beneath you, enter #emph[ha]: bend the forms, drop the ones that stop fitting, keep what holds. In time comes #emph[ri], where the forms are instinct and you invent your own --- which is only the promise of Chapter 1 come round again: learn the philosophy, and the methods become yours to invent.

The argument has run in six moves. AI-dō is the Unix philosophy re-run on a model and given a human centre (Chapter 1). In daily work that means turning what you know into Markdown, keeping it where a model can read it, and building up one clear ask at a time (Chapter 2). In software it means separating the #emph[what] from the #emph[how], and refusing both the over-specified spec and the unowned vibe (Chapter 3). What keeps any of it sound is ordinary engineering discipline --- tests, review, version control, small reversible steps --- now more necessary, not less (Chapter 4). What keeps it safe is the duty: security, provenance, protected divergence, an honest ledger, and someone who stays answerable (Chapter 5). And what keeps it improving is the human edge you protect and the loop you never stop running (this one).

The rest is yours to begin, and the first steps are small and specific. First, take one real task you already do and run it as a loop --- draft, check, refine --- instead of waiting on a perfect prompt. Second, start an LLM wiki: put the context you keep re-explaining into a few Markdown notes the model can draw on. Third, add one verification step at the boundary that matters most, and name the person answerable for what leaves it. Fourth, before you open a chat window on anything that counts, write your own view down first, so you can tell the model's confidence from your own. Fifth, keep a second model on the bench, and ask of everything you make: who is this for, and is it worth building?

Method over model; the question over the answer; care over cleverness. The tools will keep changing --- that is the one safe prediction --- and the way does not. Begin.

#heading(level: 2, numbering: none)[References]
<references-6>
Ahuja, K. V. (2026c). #emph[Spec-driven development is also breaking the fifty-year-old iron triangle]. Activated Thinker (Medium). #link("https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06")

Ahuja, K. V. (2026d). #emph[Spec-driven development isn't broken. It will collapse]. Activated Thinker (Medium). #link("https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797")

Fernandes, D., et al.~(2026). #emph[AI makes you smarter but none the wiser: The disconnect between performance and metacognition]. Computers in Human Behavior, 168, 108779. #link("https://doi.org/10.1016/j.chb.2025.108779")

Li, J., et al.~(2025). #emph[As confidence aligns: Effect of AI confidence on human self-confidence in human--AI decision making]. Proceedings of the 2025 CHI Conference on Human Factors in Computing Systems. #link("https://arxiv.org/abs/2501.12868")

McKinsey & Company. (2025). #emph[The state of AI]. #link("https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai")

Shuhari. (n.d.). In Wikipedia. #link("https://en.wikipedia.org/wiki/Shuhari")

Stanford Institute for Human-Centered AI. (2026). #emph[The AI index 2026 annual report]. Stanford University. #link("https://hai.stanford.edu/ai-index/2026-ai-index-report")

Zhang, Jiang, & Koziolek. (2026). #emph[Augmentation with dilution: Human contributor ecosystems after AI coding agent adoption]. arXiv. #link("https://arxiv.org/abs/2606.26289")
