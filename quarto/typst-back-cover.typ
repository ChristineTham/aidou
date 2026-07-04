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

  #text(font: "Raleway", weight: 800, size: 22pt, fill: rgb("#b565a7"))[AI-dō] \
  #v(0.15em)
  #text(font: "Cormorant Garamond", style: "italic", size: 13pt, fill: rgb("#85677b"))[The Way of AI, grounded in practice (道)]

  #v(1.5em)

  #include "_blurb.typ"

  #v(1fr)

  #line(length: 100%, stroke: 0.5pt + rgb("#e0cdd9"))
  #v(0.7em)
  #text(font: "Raleway", size: 10pt, fill: rgb("#615f5f"))[
    #text(weight: "bold")[Chris Tham] · Hello Tham \
    Read online, or get the PDF and ePub: christham.net/aidou
  ]
]
