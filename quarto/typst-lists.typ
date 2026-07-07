// Front-matter lists of Figures, Diagrams, and Tables, placed right after the
// Contents (via `include-before-body` in _quarto.yml). Each targets the Quarto
// float kind for that element type; the custom "Diagram" kind comes from the
// crossref `dia` key. Titles match the "Contents" heading style in typst-show.typ.
#import "_tokens.typ": *

#let list-title(name) = {
  pagebreak(to: "odd")
  block(text(font: "Raleway", weight: 800, size: 24pt, fill: c-black-beauty)[#name])
  v(0.5em)
}

#list-title[Figures]
#outline(title: none, target: figure.where(kind: "quarto-float-fig"))

#list-title[Diagrams]
#outline(title: none, target: figure.where(kind: "quarto-float-dia"))

#list-title[Tables]
#outline(title: none, target: figure.where(kind: "quarto-float-tbl"))
