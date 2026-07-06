#!/usr/bin/env python3
"""Generate the design-token files from the single source `theme.yml`.

`theme.yml` (repo root) holds the palette, colour roles, type sizes, fonts, and
per-chapter accents — the user edits that, and nothing else. This turns it into
every format-specific token file the pipeline needs, written into the Quarto
project dir (all git-ignored):

  _brand.yml   — Quarto brand (HTML + Typst PDF): palette, roles, typography.
  _tokens.scss — SCSS vars ($r-*, $font-size-root, …), layered by the HTML theme.
  _tokens.css  — CSS :root custom properties, bundled into the ePub.
  _tokens.typ  — Typst colour lets (c-*), imported by the PDF templates.
  _tokens.json — palette + chapter accents, read by the Python art/blurb scripts.

Font *files* stay pipeline detail below (they change only when the fonts do); the
font *families* come from theme.yml. Runs pre-render (build.sh + CI) before
build_site.py / gen_blurb.py. Usage: gen_theme.py [out-dir]  (default '.').
"""
import json
import os
import sys

# Font file mapping — pipeline detail, keyed by the families named in theme.yml.
FONT_FILES = """    - family: Noto Serif
      source: file
      files:
        - path: fonts/NotoSerif-Regular.ttf
          weight: 400
          style: normal
        - path: fonts/NotoSerif-Italic.ttf
          weight: 400
          style: italic
        - path: fonts/NotoSerif-Medium.ttf
          weight: 500
          style: normal
        - path: fonts/NotoSerif-SemiBold.ttf
          weight: 600
          style: normal
        - path: fonts/NotoSerif-Bold.ttf
          weight: 700
          style: normal
        - path: fonts/NotoSerif-BoldItalic.ttf
          weight: 700
          style: italic
    - family: Raleway
      source: file
      files:
        - path: fonts/Raleway-Medium.ttf
          weight: 500
          style: normal
        - path: fonts/Raleway-SemiBold.ttf
          weight: 600
          style: normal
        - path: fonts/Raleway-Bold.ttf
          weight: 700
          style: normal
        - path: fonts/Raleway-ExtraBold.ttf
          weight: 800
          style: normal
        - path: fonts/Raleway-Black.ttf
          weight: 900
          style: normal
    - family: Noto Serif JP
      source: file
      files:
        - path: fonts/NotoSerifJP-subset.ttf
          weight: 400
          style: normal
    - family: Noto Sans JP
      source: file
      files:
        - path: fonts/NotoSansJP-subset.ttf
          weight: 400
          style: normal"""


def load_theme(path):
    """Minimal YAML reader for theme.yml: top-level maps of `key: value`."""
    data, cur = {}, None
    for raw in open(path, encoding="utf-8"):
        line = raw.rstrip("\n")
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        indent = len(line) - len(line.lstrip())
        key, _, val = line.strip().partition(":")
        key, val = key.strip(), val.strip()
        if val[:1] in ('"', "'"):           # quoted (e.g. hex "#b565a7")
            val = val[1:].split(val[0], 1)[0]
        else:                               # unquoted: strip any trailing # comment
            val = val.split("#", 1)[0].strip()
        if indent == 0:
            if val:                       # top-level scalar (e.g. front-matter-accent)
                data[key] = val
                cur = None
            else:                         # top-level map opens
                cur = {}
                data[key] = cur
        else:
            cur[key] = val
    return data


def main():
    base = sys.argv[1] if len(sys.argv) > 1 else os.environ.get("QUARTO_PROJECT_DIR", ".")
    theme = load_theme(os.path.join(base, "..", "theme.yml"))
    colors = theme["colors"]
    roles = theme["roles"]
    typ = theme["type"]
    fonts = theme["fonts"]
    accents = {slug: colors[name] for slug, name in theme["chapter-accents"].items()}
    fm_name = theme["front-matter-accent"]   # top-level scalar: a palette name

    def role_val(v):
        return f'"{v}"' if v.startswith("#") else v

    # ---- _brand.yml ----
    palette = "\n".join(f'    {n}: "{h}"' for n, h in colors.items())
    brand = f"""# GENERATED from theme.yml by gen_theme.py — do not edit; edit theme.yml.
color:
  palette:
{palette}
  background: {role_val(roles["background"])}
  foreground: {roles["foreground"]}
  primary: {roles["primary"]}
  secondary: {roles["secondary"]}
  tertiary: {roles["tertiary"]}
  success: {roles["success"]}
  info: {roles["info"]}
  warning: {roles["warning"]}
  danger: {roles["danger"]}
  light: {roles["tertiary"]}
  dark: {roles["foreground"]}

typography:
  fonts:
{FONT_FILES}
  base:
    family: {fonts["body"]}
    line-height: {typ["line-height"]}
  headings:
    family: {fonts["headings"]}
    weight: {typ["heading-weight"]}
    color: {roles["heading"]}
  link:
    color: {roles["link"]}
"""
    open(os.path.join(base, "_brand.yml"), "w", encoding="utf-8").write(brand)

    # ---- _tokens.scss ----
    scss = ["/*-- scss:defaults --*/",
            "// GENERATED from theme.yml — do not edit.",
            f'$font-size-root: {typ["root-size"]};',
            f'$toc-font-size: {typ["toc-size"]};',
            f'$blockquote-font-size: {typ["blockquote-size"]};',
            f'$line-height: {typ["line-height"]};',
            f'$heading-weight: {typ["heading-weight"]};',
            f'$title-weight: {typ["title-weight"]};',
            f'$h1-font-size: {typ["h1-size"]};',
            f'$h2-font-size: {typ["h2-size"]};',
            f'$h3-font-size: {typ["h3-size"]};']
    scss += [f"$r-{n}: {h};" for n, h in colors.items()]
    open(os.path.join(base, "_tokens.scss"), "w", encoding="utf-8").write("\n".join(scss) + "\n")

    # ---- _tokens.css ----
    css = ["/* GENERATED from theme.yml — do not edit. */", ":root {",
           f'  --line-height: {typ["line-height"]};',
           f'  --heading-weight: {typ["heading-weight"]};',
           f'  --title-weight: {typ["title-weight"]};',
           f'  --h1-size: {typ["h1-size"]};',
           f'  --h2-size: {typ["h2-size"]};',
           f'  --h3-size: {typ["h3-size"]};']
    css += [f"  --r-{n}: {h};" for n, h in colors.items()]
    css += ["}"]
    open(os.path.join(base, "_tokens.css"), "w", encoding="utf-8").write("\n".join(css) + "\n")

    # ---- _tokens.typ ----
    tp = ["// GENERATED from theme.yml — do not edit."]
    tp += [f'#let c-{n} = rgb("{h}")' for n, h in colors.items()]
    open(os.path.join(base, "_tokens.typ"), "w", encoding="utf-8").write("\n".join(tp) + "\n")

    # ---- _tokens.json (for Python art/blurb scripts) ----
    open(os.path.join(base, "_tokens.json"), "w", encoding="utf-8").write(json.dumps({
        "colors": colors,
        "chapter_accents": accents,
        "front_matter_accent": colors[fm_name],
    }, ensure_ascii=False, indent=2))

    print("gen-theme: wrote _brand.yml, _tokens.scss, _tokens.css, _tokens.typ, _tokens.json")


if __name__ == "__main__":
    main()
