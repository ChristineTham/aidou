// Back cover for the PDF — a designed final page carrying the blurb.
// Inserted via `include-after-body` (see _quarto.yml). Matches the Rosely
// palette and echoes the front cover's 道 watermark.

#page(
  fill: rgb("#f4eee8"),
  margin: (x: 2.0cm, top: 2.6cm, bottom: 2.2cm),
  header: none,
  footer: none,
  numbering: none,
  background: place(
    right + bottom,
    dx: 2.0cm, dy: 1.6cm,
    text(font: "Noto Serif JP", size: 460pt, fill: rgb("#f7caca").transparentize(68%))[道],
  ),
)[
  #set text(font: "Noto Serif", fill: rgb("#3a3038"), size: 10.5pt)
  #set par(justify: true, leading: 0.72em)

  #text(font: "Raleway", weight: "bold", size: 22pt, fill: rgb("#b565a7"))[AI-dō] \
  #v(0.15em)
  #text(font: "Cormorant Garamond", style: "italic", size: 13pt, fill: rgb("#85677b"))[The Way of AI, grounded in practice (道)]

  #v(1.5em)

  Most AI writing sells tools, prompts, and features. Those go stale in a release. #emph[AI-dō] is about what lasts underneath — how you frame a problem, gather context, and verify a result.

  #v(0.9em)

  #stack(spacing: 0.6em,
    [#text(weight: "bold", fill: rgb("#b565a7"))[Method over model] — the advantage is the scaffolding you build, not the model you pick.],
    [#text(weight: "bold", fill: rgb("#b565a7"))[Discipline over hacks] — repeatable patterns, not one-off prompts.],
    [#text(weight: "bold", fill: rgb("#b565a7"))[Augmentation, not replacement] — AI to extend human judgement, never to outsource it.],
  )

  #v(0.9em)

  Written first-person by a former sceptic, with every claim cited to a primary source. Each chapter reads like a good textbook: state the idea, show why it holds, then prove it with a real example. It is for thoughtful professionals and engineers who want a durable practice, not a bag of prompts — a practice guide, not a reference manual.

  #v(1fr)

  #line(length: 100%, stroke: 0.5pt + rgb("#e0cdd9"))
  #v(0.7em)
  #text(font: "Raleway", size: 10pt, fill: rgb("#615f5f"))[
    #text(weight: "bold")[Chris Tham] · Hello Tham \
    Read online, or get the PDF and ePub: christham.net/aidou
  ]
]
