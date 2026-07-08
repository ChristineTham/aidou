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
import argparse, glob, json, os, re, shutil

# source filename -> (output slug, numbered?)
CHAPTERS = [
    ("00-preface.md", "preface", False),
    ("01-foundations.md", "foundations", True),
    ("02-productivity.md", "productivity", True),
    ("03-software.md", "software", True),
    ("04-disciplines.md", "disciplines", True),
    ("05-governance.md", "governance", True),
    ("06-mastery.md", "mastery", True),
]
ALERT = {"NOTE": "note", "TIP": "tip", "IMPORTANT": "important",
         "WARNING": "warning", "CAUTION": "caution"}
CHAPTER_PREFIX = re.compile(r"^Chapter\s+\d+\s*[—–-]\s*")

# Old page URLs kept alive as redirects after a slug rename (Quarto `aliases`).
ALIASES = {
    "software": ["/software-development.html"],
    "disciplines": ["/engineering-disciplines.html"],
}

# Thin decorative chapter banner (a seigaiha wave ribbon with the chapter's
# kanji medallion), placed under the chapter title. PNG (not SVG) so it renders
# reliably across HTML + Typst PDF + ePub. The kanji is used for the alt text.
BANNER_KANJI = {
    "foundations": "基", "productivity": "愛", "software": "創",
    "disciplines": "匠", "governance": "責", "mastery": "道",
}


# Per-chapter accent colour (matches the banner medallion) for the PDF title.
# Overridden at build time from _tokens.json (generated from theme.yml); these
# are the fallback if the token file is absent.
PDF_ACCENT = {
    "foundations": "#85677B", "productivity": "#D2386C",
    "software": "#EC809E", "disciplines": "#BE9CC1",
    "governance": "#93A9D1", "mastery": "#B565A7",
}


def load_token_accents(out_dir):
    """Chapter accents from _tokens.json (theme.yml), or {} if not generated yet."""
    p = os.path.join(out_dir, "_tokens.json")
    if os.path.isfile(p):
        try:
            return json.load(open(p, encoding="utf-8")).get("chapter_accents", {})
        except (ValueError, OSError):
            pass
    return {}


def estimate_title_pt(text, avail_pt=335.0, base=30.0, floor=14.0):
    """Approximate the font size (pt) at which `text` first fits one line in the
    PDF's ~335pt text column, in Raleway ExtraBold. Rough per-glyph advances (a
    CJK glyph is ~1em, capitals wider than lower-case, punctuation narrow); used
    only to warn when a title would be forced small. Typst does the real fit."""
    units = 0.0
    for ch in text:
        if ord(ch) > 0x2E80:
            units += 1.0
        elif ch in " iIl.,;:'!|()":
            units += 0.32
        elif ch.isupper():
            units += 0.70
        else:
            units += 0.56
    fit = avail_pt / units if units else base
    return max(floor, min(base, fit))


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
        est = estimate_title_pt(f"{number} {title}")
        if est < 22:
            print(f"note: PDF chapter title '{title}' wraps to two lines "
                  "(held at the 22pt floor rather than shrinking further).")
    else:
        inner = ink
    # fit-title (typst-fonts.typ) shrinks the title until it fits one line.
    return "```{=typst}\n" f"#block(below: 0.55em, fit-title[{inner}])\n" "```\n\n"


def banner_markdown(slug):
    """A full-width, caption-less banner image for `slug`, or "" if none.

    Chapters get their kanji-medallion tide; the preface gets the plain
    (no-kanji) front-matter tide."""
    # A PDF-only gap so the first paragraph doesn't sit tight under the banner.
    gap = "```{=typst}\n#v(1.1em)\n```\n\n"
    if slug in BANNER_KANJI:
        alt = (f"Decorative chapter banner: the kanji {BANNER_KANJI[slug]} on a "
               "medallion over a seigaiha wave pattern")
        return f'![](chapter-art/{slug}.png){{.chapter-banner fig-alt="{alt}"}}\n\n' + gap
    if slug == "preface":
        alt = "Decorative banner: a seigaiha wave pattern"
        return f'![](chapter-art/frontmatter.png){{.chapter-banner fig-alt="{alt}"}}\n\n' + gap
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


FALLBACK_COLORS = {
    "black-beauty": "#27272a", "granite-gray": "#615f5f", "grapeade": "#85677b",
    "rose-quartz": "#f7caca", "heavenly-pink": "#f4dede", "sugar-swizzle": "#f4eee8",
    "lupine": "#be9cc1", "radiant-orchid": "#b565a7", "raspberry-sorbet": "#d2386c",
    "morning-glory": "#ec809e", "spearmint": "#64bfa4", "serenity": "#93a9d1",
}


def load_token_colors(out_dir):
    """Palette (name -> hex) from _tokens.json (theme.yml), or the fallback."""
    p = os.path.join(out_dir, "_tokens.json")
    if os.path.isfile(p):
        try:
            return json.load(open(p, encoding="utf-8")).get("colors", FALLBACK_COLORS)
        except (ValueError, OSError):
            pass
    return FALLBACK_COLORS


def mermaid_init(colors):
    """A Mermaid `%%{init}%%` directive theming every diagram to the Rosely
    palette. Injected as the first line of each diagram so ALL render paths honour
    it identically — mermaid.js (HTML, client-side) and the PNG pre-renderer
    (PDF/ePub). This is the only place a theme reaches the pre-rendered formats."""
    c = colors
    ink, white = c.get("black-beauty", "#27272a"), "#ffffff"
    tv = {
        # No fontFamily override: the PDF/ePub PNG pre-renderer lacks the web
        # fonts, so a custom family falls back to a wider face and overflows the
        # layout-sized node boxes. Mermaid's default keeps node sizing correct.
        "primaryColor": c.get("heavenly-pink", "#f4dede"),
        "primaryBorderColor": c.get("radiant-orchid", "#b565a7"),
        "primaryTextColor": ink, "textColor": ink,
        "secondaryColor": c.get("rose-quartz", "#f7caca"),
        "tertiaryColor": c.get("sugar-swizzle", "#f4eee8"),
        "lineColor": c.get("grapeade", "#85677b"),
        # subgraph (cluster) background — light warm tint so it doesn't go dark
        "clusterBkg": c.get("warm", "#faf7f4"),
        "clusterBorder": c.get("lupine", "#be9cc1"),
        # section palette for timelines (also pie/journey): Rosely accents, cycled
        "cScale0": c.get("radiant-orchid", "#b565a7"),
        "cScale1": c.get("morning-glory", "#ec809e"),
        "cScale2": c.get("spearmint", "#64bfa4"),
        "cScale3": c.get("serenity", "#93a9d1"),
        "cScale4": c.get("lupine", "#be9cc1"),
        "cScale5": c.get("raspberry-sorbet", "#d2386c"),
        "cScaleLabel0": white, "cScaleLabel1": white, "cScaleLabel2": ink,
        "cScaleLabel3": ink, "cScaleLabel4": ink, "cScaleLabel5": white,
    }
    return "%%{init: " + json.dumps({"theme": "base", "themeVariables": tv},
                                    separators=(",", ":")) + "}%%"


DIA_CAP = re.compile(r"^:\s*(.+?)\s*\{#(dia-[A-Za-z0-9_-]+)\}\s*$")


def mermaid_cells(lines, init=""):
    """Turn ```mermaid fences into executable ```{mermaid} cells so Quarto
    renders them to images for the PDF/ePub (and client-side SVG for HTML), and
    inject the palette `init` directive as each diagram's first line.
    Diagrams keep their `<br/>` labels, which Mermaid renders as line breaks.

    A caption line directly after a diagram's closing fence — `: Caption. {#dia-slug}`
    — is folded into the cell as `%%| label:` + `%%| fig-cap:`, so the diagram
    becomes a numbered "Diagram N" custom float (see crossref in _quarto.yml)."""
    out, i, n = [], 0, len(lines)
    while i < n:
        if not re.match(r"^```mermaid\s*$", lines[i]):
            out.append(lines[i]); i += 1; continue
        body, j = [], i + 1
        while j < n and not re.match(r"^```\s*$", lines[j]):
            body.append(lines[j]); j += 1
        # look past the closing fence (and any blank lines) for a caption line
        k = j + 1
        while k < n and not lines[k].strip():
            k += 1
        m = DIA_CAP.match(lines[k]) if k < n else None
        out.append("```{mermaid}")
        if m:
            out.append(f"%%| label: {m.group(2)}")
            out.append(f'%%| fig-cap: "{m.group(1)}"')
        if init:
            out.append(init)
        out.extend(body)
        out.append("```")
        i = (k + 1) if m else (j + 1)
    return out


def strip_section_number(l):
    m = re.match(r"^(#{2,3}) \d+(?:\.\d+)* (.*)$", l)
    return (m.group(1) + " " + m.group(2)) if m else l


def copy_assets(out_dir, images_dir):
    """Copy the rasters the renderer needs from the images/ source of truth into
    the Quarto project dir (git-ignored there). Sources live in images/; Quarto
    and Typst resolve them locally as `cover.png` / `chapter-art/*.png`."""
    cover = os.path.join(images_dir, "cover.png")
    if os.path.exists(cover):
        shutil.copy2(cover, os.path.join(out_dir, "cover.png"))
    og = os.path.join(images_dir, "ogimage.jpg")   # social-share image (og:image)
    if os.path.exists(og):
        shutil.copy2(og, os.path.join(out_dir, "ogimage.jpg"))
    art_src = os.path.join(images_dir, "chapter-art")
    if os.path.isdir(art_src):
        art_dst = os.path.join(out_dir, "chapter-art")
        os.makedirs(art_dst, exist_ok=True)
        for png in glob.glob(os.path.join(art_src, "*.png")):
            shutil.copy2(png, os.path.join(art_dst, os.path.basename(png)))
        print(f"copied cover + chapter-art PNGs from {images_dir}")
    proj_src = os.path.join(images_dir, "projects")   # in-chapter figures (screenshots)
    if os.path.isdir(proj_src):
        proj_dst = os.path.join(out_dir, "projects")
        os.makedirs(proj_dst, exist_ok=True)
        for img in glob.glob(os.path.join(proj_src, "*")):
            if os.path.isfile(img):
                shutil.copy2(img, os.path.join(proj_dst, os.path.basename(img)))
    illus_src = os.path.join(images_dir, "illustrations")   # recoloured undraw SVGs (find-image)
    if os.path.isdir(illus_src):
        illus_dst = os.path.join(out_dir, "illustrations")
        os.makedirs(illus_dst, exist_ok=True)
        for img in glob.glob(os.path.join(illus_src, "*")):
            if os.path.isfile(img):
                shutil.copy2(img, os.path.join(illus_dst, os.path.basename(img)))


def wrap_references(body):
    """APA 7 reference list: start on a new page and hang-indent each entry.

    The per-chapter `## References` section (always last) is wrapped in a
    `.references` div and preceded by a page break. Styling per format:
      * PDF (Typst) — a raw `#pagebreak` before the div, and a `#set par(
        hanging-indent)` scoped *inside* the div's `#block[…]` (so it can't
        leak into the next chapter).
      * HTML / ePub — the `.references` class is styled in brand.scss / epub.css
        (hanging indent; ePub also gets `page-break-before`). Raw typst blocks
        are inert in these formats. On the web there are no pages, so only the
        hanging indent applies.
    """
    idx = next((i for i, l in enumerate(body) if re.match(r"^## References\s*$", l)), None)
    if idx is None:
        return body
    # first-line-indent:0 overrides orange-book's book-style paragraph indent (so
    # each entry's first line is flush); spacing restores a gap between entries.
    before = ["```{=typst}", "#pagebreak(weak: true)", "```", "",
              "::: {.references}", "```{=typst}",
              "#set par(hanging-indent: 1.5em, first-line-indent: 0em, spacing: 0.7em)",
              "```", ""]
    return (body[:idx] + before + ["## References {.unnumbered}"]
            + body[idx + 1:] + ["", ":::"])


INDEX_STOP = re.compile(r"^## References\b")
SEC_HEADING = re.compile(r"^#{2,4}\s+(\d+(?:\.\d+)*)\s+(.*)$")


def load_index_terms(repo_root):
    """Read index-terms.txt -> [(canonical, [surface_forms])], forms longest-first.

    Each line is `canonical | alias | alias`; blanks and #-comments are ignored.
    Every surface form (canonical + aliases) is searched in the text and folds
    into the one canonical entry. Returns [] if the file is absent (index off)."""
    path = os.path.join(repo_root, "index-terms.txt")
    entries = []
    if not os.path.exists(path):
        return entries
    for line in open(path, encoding="utf-8"):
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        parts = [p.strip() for p in line.split("|") if p.strip()]
        if parts:
            entries.append((parts[0], sorted(set(parts), key=len, reverse=True)))
    return entries


def pandoc_slug(title):
    """Approximate Pandoc's auto heading id (Quarto's anchor): lower-case, drop
    all but word chars/space/hyphen, spaces -> hyphens, must start with a letter."""
    t = re.sub(r"[*`_]", "", title.strip().lower())
    t = re.sub(r"[^\w\s-]", "", t)
    t = re.sub(r"\s+", "-", t.strip())
    t = re.sub(r"-+", "-", t)
    return re.sub(r"^[^a-z]+", "", t) or "section"


def _has_form(text, forms):
    return any(re.search(r"(?<![\w-])" + re.escape(f) + r"(?![\w-])", text, re.I)
               for f in forms)


def inject_index(body, chapter_no, chapter_slug, terms, index_map):
    """Append invisible Typst index markers to prose lines so in-dexter can
    page-number them in the PDF, and record each (term, section) in index_map
    for the ePub/HTML anchor index.

    High precision, not high recall: a term is indexed for a section only where
    the book actually *treats* it — either the term is in the section heading
    (a primary locator, bold via `#index-main`) or it appears *italicised* in the
    prose (a definitional use, regular via `#index`). Passing mentions are
    skipped, so common words like "agent" resolve to the handful of sections
    about them, not every page. One locator per term per section; stops at the
    References list. Mutates and returns `body`."""
    stop = next((i for i, l in enumerate(body) if INDEX_STOP.match(l)), len(body))
    in_code = False
    cur_num, cur_anchor = str(chapter_no), ""      # chapter intro -> chapter top
    marked = {}                                    # canonical -> {section keys}
    pending_main = []                              # heading terms awaiting a prose line

    def record(canon, main):
        seckey = (chapter_no, cur_num)
        if seckey in marked.get(canon, set()):
            return False
        marked.setdefault(canon, set()).add(seckey)
        index_map.setdefault(canon, {})[seckey] = (cur_num, cur_anchor, chapter_slug, main)
        return True

    for i in range(stop):
        line = body[i]
        s = line.lstrip()
        if s.startswith("```"):
            in_code = not in_code
            continue
        if in_code:
            continue
        m = SEC_HEADING.match(line)
        if m:
            cur_num, cur_anchor = m.group(1), pandoc_slug(m.group(2))
            pending_main = [c for c, forms in terms if _has_form(m.group(2), forms)]
            continue
        if not s or s[0] in "#:|" or s.startswith("!["):
            continue
        hits = []                                  # (is_main, canonical)
        for c in pending_main:                     # heading topics -> bold, at first prose line
            if record(c, True):
                hits.append((True, c))
        pending_main = []
        for span in re.findall(r"(?<!\*)\*([^*\n]+)\*(?!\*)", line):   # italic definitional uses
            for c, forms in terms:
                if _has_form(span, forms) and record(c, False):
                    hits.append((False, c))
        if hits:
            body[i] = line + "".join(
                (f"`#index-main[{c}]`{{=typst}}" if main else f"`#index[{c}]`{{=typst}}")
                for main, c in hits)
    return body


def write_index_chapter(out_dir, index_map):
    """Write the generated `index-of-terms.qmd` back-matter chapter: a Typst
    `#make-index()` for the page-numbered PDF index, and a letter-grouped anchor
    index (term -> section links) for ePub/HTML, split by `content-visible`."""
    def order(seckey):
        ch, num = seckey
        return (ch, [int(x) for x in num.split(".")])
    lines, letter = [], None
    for canon in sorted(index_map, key=str.lower):
        if canon[0].upper() != letter:
            letter = canon[0].upper()
            lines.append(f"\n**{letter}**\n")
        refs = index_map[canon]
        keys = sorted(refs, key=order)
        if len(keys) > 8:                          # a term that ran long: keep its
            primary = [k for k in keys if refs[k][3]]   # primary (heading) locators,
            keys = (primary or keys)[:8]           # else the first eight
        parts = []
        for k in keys:
            num, anchor, slug, main = refs[k]
            href = f"{slug}.qmd" + (f"#{anchor}" if anchor else "")
            link = f"[§{num}]({href})"
            parts.append(f"**{link}**" if main else link)
        disp = canon[0].upper() + canon[1:]
        lines.append(f"{disp} — " + ", ".join(parts) + "  ")
    # PDF: orange-book blanks level-1 heading rendering and would print a stale
    # "Chapter 6" running header on this unnumbered back-matter chapter, so we
    # drop the header and draw our own "Index" title (matching the Figures /
    # Diagrams / Tables list titles), then let in-dexter lay out the entries.
    typst = (
        "```{=typst}\n"
        "#set page(header: none)\n"
        '#block(text(font: "Raleway", weight: 800, size: 24pt, fill: rgb("#27272a"))[Index])\n'
        "#v(0.5em)\n"
        "#make-index(title: none)\n"
        "```"
    )
    content = (
        "# Index {.unnumbered}\n\n"
        '::: {.content-visible when-format="typst"}\n\n'
        + typst + "\n\n:::\n\n"
        '::: {.content-visible unless-format="typst"}\n\n'
        + "\n".join(lines).strip() + "\n\n:::\n"
    )
    with open(os.path.join(out_dir, "index-of-terms.qmd"), "w", encoding="utf-8") as f:
        f.write(content)
    print(f"index: {len(index_map)} terms -> index-of-terms.qmd")


def build(book_dir, out_dir):
    os.makedirs(out_dir, exist_ok=True)
    copy_assets(out_dir, os.path.join(os.path.dirname(book_dir.rstrip("/")) or ".", "images"))
    PDF_ACCENT.update(load_token_accents(out_dir))
    mermaid_directive = mermaid_init(load_token_colors(out_dir))
    repo_root = os.path.dirname(os.path.abspath(book_dir.rstrip("/")))
    index_terms = load_index_terms(repo_root)
    index_map = {}
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
        body = mermaid_cells(body, mermaid_directive)
        if numbered:
            chapter_no += 1
            if index_terms:
                body = inject_index(body, chapter_no, slug, index_terms, index_map)
        body = [strip_section_number(l) for l in body]
        # Source image links are written relative to the repo (../images/…) so a
        # raw Markdown preview of book/*.md resolves them; the build stages copies
        # into the Quarto dir (copy_assets), so strip the prefix to the in-project
        # path (projects/…, illustrations/…) the .qmd and _book output expect.
        body = [l.replace("../images/", "") for l in body]
        body = wrap_references(body)
        text = "\n".join(body).lstrip("\n")
        if numbered:
            disp = CHAPTER_PREFIX.sub("", title)
            alias = ""
            if slug in ALIASES:
                alias = "aliases:\n" + "".join(f"  - {a}\n" for a in ALIASES[slug])
            head = '---\ntitle: "' + disp + '"\n' + alias + '---\n\n'
            pdf = pdf_title(disp, chapter_no, slug)
        else:
            head = "# " + title + " {.unnumbered}\n\n"
            pdf = pdf_title(title, None, slug) if slug == "preface" else ""
        with open(os.path.join(out_dir, slug + ".qmd"), "w", encoding="utf-8") as f:
            f.write(head + pdf + banner_markdown(slug) + text + "\n")
        print(f"{src} -> {os.path.join(out_dir, slug + '.qmd')}")
    if index_terms:
        write_index_chapter(out_dir, index_map)


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--book", default="../book", help="directory of source chapter .md files")
    ap.add_argument("--out", default=".", help="Quarto project directory to write .qmd into")
    a = ap.parse_args()
    build(a.book, a.out)


if __name__ == "__main__":
    main()
