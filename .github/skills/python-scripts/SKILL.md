---
name: python-scripts
description: 'Write and execute Python scripts in this workspace, installing any packages they need with conda or pip. Use for data analysis, charts, quick computations, scraping/parsing research sources, validating numbers cited in the book, or any one-off automation that benefits from running real Python.'
argument-hint: 'Describe what the script should do, any input/output files, and which libraries (if known). Mention whether you want a reusable script saved or a one-off run.'
user-invocable: true
---
# Python Scripts Skill

Author, install dependencies for, and run Python scripts inside the `aidou` workspace.

## When to Use

Use this skill when a task benefits from executing real Python, for example:

- Verifying or computing numbers/statistics cited in the book before writing them.
- Parsing, cleaning, or summarising research sources (Markdown, HTML, PDF, CSV, JSON).
- Generating charts or tables from data.
- Quick automation: file processing, bulk renames, link checking, scraping.
- Prototyping or sanity-checking an algorithm described in the text.

**Trigger phrases**: "run a python script", "compute", "plot", "parse this data", "check these numbers", "scrape", "generate a chart".

## Environment (verified 2026-06-30)

| Item | Value |
|------|-------|
| Package manager | conda 26.3.2 (Miniconda at `C:\Users\ctham\AppData\Local\miniconda3`) |
| Active env | `base` (the only environment) |
| Python | 3.13.13 |
| pip | 26.0.1 |
| conda channels | `conda-forge`, `defaults` |
| Platform | Windows, `win-64`, PowerShell |

Both `pip install` and `conda install` work. PyPI and the conda channels are reachable.

> [!IMPORTANT]
> **TLS verification is disabled** on this machine (corporate proxy / self-signed
> certificate). conda commands print `InsecureRequestWarning` for
> `conda.anaconda.org` and `repo.anaconda.com`. Installs still succeed, but over
> unverified HTTPS. This is expected here — do not treat the warning as a failure.

> [!IMPORTANT]
> **PowerShell exit-code quirk.** conda writes warnings to *stderr*, which makes
> PowerShell raise a `RemoteException` and return **exit code 1 even when the
> command succeeded**. Never judge success by exit code alone — inspect stdout
> (the package list, "Would install…", or solved-environment block) to confirm.

## Workflow

1. **Decide scope.** A one-off computation can run inline with `python -c "…"`.
   Anything reusable or longer than a few lines: save a `.py` file (see layout below).
2. **Check for the package first.** Before installing, run `conda list <pkg>` or
   `python -c "import <pkg>"` — it may already be present.
3. **Install only what's missing.** Prefer `conda install -c conda-forge <pkg>`
   for scientific/binary packages (numpy, pandas, matplotlib, scipy, lxml).
   Use `pip install <pkg>` for pure-Python or PyPI-only packages.
4. **Write the script**, then run it and inspect stdout.
5. **Clean up** temporary scratch scripts unless the user wants them kept.

## Installing packages

Check first, then install only if missing:

```powershell
conda list pandas                       # already installed?
conda install -c conda-forge pandas     # binary/scientific deps -> conda
pip install some-pure-python-pkg        # PyPI-only -> pip
```

To confirm an install actually worked despite the exit-code quirk, verify by import:

```powershell
python -c "import pandas, sys; print(pandas.__version__)"
```

If conda's stderr noise makes terminal output hard to read, filter the warnings:

```powershell
conda install -c conda-forge pandas 2>&1 |
  Select-String -Pattern "InsecureRequestWarning|warnings.warn" -NotMatch
```

For an unattended install, add `-y` to skip the conda confirmation prompt.

## Running scripts

Inline one-off:

```powershell
python -c "print(sum(range(101)))"
```

Saved script:

```powershell
python scripts/<name>.py
```

## Conventions for this repo

- Save reusable scripts in `scripts/` (e.g. `scripts/check_numbers.py`), matching
  the existing `scripts/html2md.ps1`.
- Read inputs from `research/`, `sources/`, or `book/` with **relative paths** so
  scripts are portable.
- Keep scripts small and single-purpose; print results to stdout.
- Don't add a `requirements.txt` or new env unless the user asks — install into `base`.
- Never commit large generated data/binaries without asking.

## Worked example

Count words in a chapter:

```python
# scripts/wordcount.py
from pathlib import Path

text = Path("book/02-productivity.md").read_text(encoding="utf-8")
print(f"{len(text.split()):,} words")
```

```powershell
python scripts/wordcount.py
```

## Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| Exit code 1 but output looks fine | PowerShell + conda stderr warnings | Ignore exit code; check stdout / verify by import |
| `InsecureRequestWarning` flood | TLS verification disabled (proxy) | Expected; filter with `Select-String … -NotMatch` |
| `Solving environment: failed` for a real package | Package not on configured channels | Try `-c conda-forge`, or fall back to `pip install` |
| `ModuleNotFoundError` after install | Installed into a different interpreter | Run `python -c "import sys; print(sys.executable)"` to confirm it's the Miniconda `base` python |
