#!/usr/bin/env python3
"""Generate Quarto chapter pages from the book's Markdown (single source).

Reads the canonical chapters in `book/*.md` and writes Quarto `.qmd` pages into
the Quarto project directory, applying the transforms that make them render
cleanly to HTML + PDF (Typst) + ePub:

  * the leading `# ` heading becomes the page title (frontmatter); for the
    preface it becomes an unnumbered inline H1 so Quarto numbers the six
    chapters 1..6 and leaves the preface unnumbered;
  * our manual `1.1` / `1.2.1` section numbers are stripped so Quarto numbers
    natively (consistent across all three formats, with working cross-refs);
  * `## References` is marked `{.unnumbered}`;
  * GitHub alerts (`> [!NOTE]`) become native Quarto callouts (`::: {.callout-note}`);
  * ```mermaid fences become executable ```{mermaid} cells so Quarto renders
    them to images (PNG) for the PDF/ePub and client-side SVG for HTML.

`book/*.md` is never modified. Run it directly, or let Quarto's `pre-render`
hook call it before every render/preview.

Usage:
    build_site.py --book ../book --out .        # from the quarto/ project dir
    build_site.py --book book --out quarto       # from the repo root
"""
import argparse, os, re

# source filename -> (output slug, numbered?)
CHAPTERS = [
    ("00-preface.md", "preface", False),
    ("01-foundations.md", "foundations", True),
    ("02-productivity.md", "productivity", True),
    ("03-software-development.md", "software-development", True),
    ("04-engineering-disciplines.md", "engineering-disciplines", True),
    ("05-governance.md", "governance", True),
    ("06-mastery.md", "mastery", True),
]
ALERT = {"NOTE": "note", "TIP": "tip", "IMPORTANT": "important",
         "WARNING": "warning", "CAUTION": "caution"}
CHAPTER_PREFIX = re.compile(r"^Chapter\s+\d+\s*[—–-]\s*")

# Thin decorative chapter banner (a seigaiha wave ribbon with the chapter's
# kanji medallion), placed under the chapter title. PNG (not SVG) so it renders
# reliably across HTML + Typst PDF + ePub. The kanji is used for the alt text.
BANNER_KANJI = {
    "foundations": "基", "productivity": "愛", "software-development": "創",
    "engineering-disciplines": "匠", "governance": "責", "mastery": "道",
}


# Per-chapter accent colour (matches the banner medallion) for the PDF title.
PDF_ACCENT = {
    "foundations": "#85677B", "productivity": "#D2386C",
    "software-development": "#EC809E", "engineering-disciplines": "#BE9CC1",
    "governance": "#93A9D1", "mastery": "#B565A7",
}


def pdf_title(title, number, slug):
    """A clean chapter/front-matter title for the PDF only.

    orange-book's boxed title is suppressed in the Typst build (heading-style is
    out of range), so we render our own: the chapter number in the chapter's
    accent colour + the title in ink, matching the web/ePub and sitting above
    the banner. Emitted as a ```{=typst}``` block so HTML/ePub ignore it (they
    show the real heading)."""
    ink = '#text(fill: rgb("#27272A"))[' + title + "]"
    if number is not None:
        acc = PDF_ACCENT.get(slug, "#B565A7")
        inner = f'#text(fill: rgb("{acc}"))[{number}]#h(0.5em)' + ink
    else:
        inner = ink
    return ("```{=typst}\n"
            '#block(below: 0.55em, text(font: "Raleway", weight: 800, '
            f"size: 30pt)[{inner}])\n"
            "```\n\n")


def banner_markdown(slug):
    """A full-width, caption-less banner image for `slug`, or "" if none.

    Chapters get their kanji-medallion tide; the preface gets the plain
    (no-kanji) front-matter tide."""
    if slug in BANNER_KANJI:
        alt = (f"Decorative chapter banner: the kanji {BANNER_KANJI[slug]} on a "
               "medallion over a seigaiha wave pattern")
        return f'![](chapter-art/{slug}.png){{.chapter-banner fig-alt="{alt}"}}\n\n'
    if slug == "preface":
        alt = "Decorative banner: a seigaiha wave pattern"
        return f'![](chapter-art/frontmatter.png){{.chapter-banner fig-alt="{alt}"}}\n\n'
    return ""


def convert_alerts(lines):
    out, i = [], 0
    while i < len(lines):
        m = re.match(r"^>\s*\[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]\s*(.*)$", lines[i])
        if not m:
            out.append(lines[i]); i += 1; continue
        body = [m.group(2).strip()] if m.group(2).strip() else []
        i += 1
        while i < len(lines) and lines[i].startswith(">"):
            body.append(re.sub(r"^>\s?", "", lines[i])); i += 1
        while body and not body[0].strip():
            body.pop(0)
        while body and not body[-1].strip():
            body.pop()
        out.append("::: {.callout-" + ALERT[m.group(1)] + "}")
        out.extend(body)
        out.append(":::")
    return out


def mermaid_cells(lines):
    """Turn ```mermaid fences into executable ```{mermaid} cells so Quarto
    renders them to images for the PDF/ePub (and client-side SVG for HTML).
    Diagrams keep their `<br/>` labels, which Mermaid renders as line breaks."""
    out = []
    for l in lines:
        if re.match(r"^```mermaid\s*$", l):
            out.append("```{mermaid}")
        else:
            out.append(l)
    return out


def strip_section_number(l):
    m = re.match(r"^(#{2,3}) \d+(?:\.\d+)* (.*)$", l)
    return (m.group(1) + " " + m.group(2)) if m else l


def build(book_dir, out_dir):
    os.makedirs(out_dir, exist_ok=True)
    chapter_no = 0
    for src, slug, numbered in CHAPTERS:
        path = os.path.join(book_dir, src)
        if not os.path.exists(path):
            print(f"skip (missing): {path}")
            continue
        lines = open(path, encoding="utf-8").read().split("\n")
        h1 = next(i for i, l in enumerate(lines) if l.startswith("# "))
        title = lines[h1][2:].strip()
        body = lines[:h1] + lines[h1 + 1:]
        body = convert_alerts(body)
        body = mermaid_cells(body)
        body = [strip_section_number(l) for l in body]
        body = [re.sub(r"^## References\s*$", "## References {.unnumbered}", l) for l in body]
        text = "\n".join(body).lstrip("\n")
        if numbered:
            chapter_no += 1
            disp = CHAPTER_PREFIX.sub("", title)
            head = '---\ntitle: "' + disp + '"\n---\n\n'
            pdf = pdf_title(disp, chapter_no, slug)
        else:
            head = "# " + title + " {.unnumbered}\n\n"
            pdf = pdf_title(title, None, slug) if slug == "preface" else ""
        with open(os.path.join(out_dir, slug + ".qmd"), "w", encoding="utf-8") as f:
            f.write(head + pdf + banner_markdown(slug) + text + "\n")
        print(f"{src} -> {os.path.join(out_dir, slug + '.qmd')}")


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--book", default="../book", help="directory of source chapter .md files")
    ap.add_argument("--out", default=".", help="Quarto project directory to write .qmd into")
    a = ap.parse_args()
    build(a.book, a.out)


if __name__ == "__main__":
    main()
