---
name: heading-numbering
description: 'Number Markdown section and subsection headings as N.M and N.M.K per chapter (e.g. 1.2, 2.3.1), leaving chapter titles and the References section unnumbered and skipping code fences. Idempotent — safe to re-run after adding, removing, or reordering sections. Use when adding numbered headings to a book or renumbering after edits.'
argument-hint: 'Name the chapter Markdown files to (re)number.'
user-invocable: true
---

# Section heading numbering

Adds and maintains section numbers on a Markdown book.

## Convention

- `## ` sections are numbered `N.M` (chapter.section): `## 1.2 Mental Models for AI`.
- `### ` subsections are numbered `N.M.K`: `### 2.2.1 Save the prompt as a skill`.
- The chapter `# ` title and the `## References` section stay **unnumbered**.
- Chapter number `N` is read from the first digits in the filename (`03-software.md` → 3). One file = one chapter.
- Headings inside ``` / ~~~ fences are ignored.
- The preface is front matter — leave it unnumbered (don't pass it).

## Use

```bash
python scripts/number_headings.py book/0[1-6]*.md
```

Existing numbers are stripped before renumbering, so re-running after you insert, delete, or reorder a section fixes every number in one pass. Numbering leaves the `## References` section alone, so it composes cleanly with [[apa-citations]] — run either order.

Options: `--skip <title>` to change which back-matter heading is left unnumbered; `--sequential` to number files by argument order instead of filename digits.

> [!TIP]
