---
name: upgrade-version
description: 'Bump the book''s edition ("Edition X.Y") and add a Changelog entry, keeping the version string in sync across the web landing page, the PDF copyright page, the ePub colophon, and the Changelog. Use whenever the user wants to release/cut a new edition, bump the version, or update the changelog — e.g. "release Edition 1.1", "bump the version", "cut a new edition", "upgrade the version".'
argument-hint: 'The new edition (e.g. 1.1), the release date, and a short note of what changed.'
user-invocable: true
---

# Upgrade the book's edition

The book is versioned as **"Edition X.Y"** with a release date. The version string
appears in four hand-synced places, and every edition gets a Changelog entry. This
skill bumps all of them in one pass. (Background: the [[project-versioning-changelog]]
memory records the convention.)

## What gets updated

1. `quarto/typst-show.typ` — the PDF copyright-page edition line.
2. `quarto/index.qmd` — the web landing `.edition` line.
3. `quarto/index.qmd` — the ePub colophon edition line.
4. `quarto/changelog.qmd` — a **new entry prepended at the top** (newest first).

## Steps

1. **Gather the inputs.** You need three things; ask the user for any that are missing:
   - the new edition number (e.g. `1.1`, or `2.0` for a major revision),
   - the release date (spelled out, e.g. `15 August 2026` — don't guess it),
   - a short summary of what changed since the last edition, as one or more bullets.

   For the changelog bullets, prefer real, reader-facing changes (new chapter, new
   section, a source added, a correction) over mechanical build tweaks. If unsure what
   changed, skim `git log` since the last edition's date and summarise honestly — do
   not invent entries.

2. **Run the bump.** From the repo root:

   ```bash
   python .agents/skills/upgrade-version/scripts/bump_version.py \
     --version 1.1 --date "15 August 2026" \
     --note "Added the glossary" --note "Reworked §4.2 on orchestration"
   ```

   `--note` is repeatable (one per bullet) and optional; without it the script writes
   just the edition line and reminds you to add the summary to `quarto/changelog.qmd`
   by hand. The script edits in place and errors loudly if any of the four patterns has
   drifted (so a format change can't silently skip a spot).

3. **Verify.** Build and confirm the new edition shows everywhere:

   ```bash
   cd quarto && ./build.sh
   ```

   Expect "Output created". Then check the edition string is `X.Y` and the date is
   right on: the web landing page (`_book/index.html`, the `.edition` line), the PDF
   copyright page and the Changelog page (`_book/ai-do.pdf`), and the ePub colophon +
   Changelog (`_book/ai-do.epub`). Rendering the PDF pages to confirm is worthwhile for
   a release.

4. **Report, don't commit.** Summarise what changed (old → new edition, the date, the
   changelog bullets added). **Do not commit, push, or deploy unless the user asks** —
   that is the book's standing rule ([[feedback-no-auto-commit]]). If they do ask, the
   deploy is the usual push-to-`main` GitHub Action ([[book-build]]).

## Notes

- Editions are `MAJOR.MINOR`: bump MINOR for ordinary content/fix releases, MAJOR for a
  substantial restructure. Judge from the size of what changed; ask the user if unsure.
- `quarto/changelog.qmd` and `quarto/index.qmd` are hand-authored and git-kept (via
  `.gitignore` `!` exceptions); the other generated `quarto/*.qmd` are ephemeral.
- If the version-string format itself ever changes, update both the four source spots
  and the regexes in `scripts/bump_version.py` together.
