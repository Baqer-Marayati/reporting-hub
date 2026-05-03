# Repository Structure

## Top-Level Layout

### `Companies`

Company-specific active PBIP projects and source-of-truth report files.

Contains:
- one folder per company code
- the real report folder name for that company
- `.pbip`, `.Report/`, and `.SemanticModel/` trios that must stay aligned
- local Power BI metadata excluded by `.gitignore`

Current active entry points:
- `Reports/Finance/Companies/CANON/Canon Financial Report/Canon Financial Report.pbip`
- `Reports/Finance/Companies/PAPERENTITY/Paper Financial Report/Paper Financial Report.pbip`

### `Module/Design Benchmarks`

Living benchmark and visual reference area.

Use this folder for:
- benchmark PBIP shells
- screenshots
- reference themes
- inspiration or replacement design records

### `Module/Project Memory`

Operational memory for continuity across work sessions.

Key files:
- `PROJECT_DNA.md`
- `CURRENT_STATUS.md`
- `DECISIONS.md`
- `MODEL_NOTES.md`
- `NEXT_STEPS.md`
- `REFERENCE.md`
- `PAGE_MAP.md`
- `DATA_GAPS.md`
- `POWERBI_PATTERNS.md`

### `Module/docs`

Stable documentation for repository onboarding and structure.

Use this folder for:
- setup instructions
- architecture and structure summaries
- page-purpose summaries
- data-context notes that help orient future work
- repeatable workflows
- stable standards
- glossary and quick-scan issue summaries

### `Module/CHANGELOG.md`

High-level milestone record only.
Do not turn it into a detailed diary of every micro-edit.

## Documentation Split

Use each layer for a different purpose:

- `AGENTS.md`
  - universal AI entrypoint and read order
- `docs/foundation.md`
  - broad operating foundation, tooling, integrations, and startup context
- `README.md`
  - quick orientation and links
- `docs/`
  - stable repo-facing documentation
- `Project Memory/`
  - active truth, decisions, current state, and handoff context

Recommended substructure inside `docs/`:
- `workflows/`
  - repeated operating procedures and checklists
- `standards/`
  - naming, formatting, and layout rules
- root `docs/*.md`
  - orientation docs such as setup, pages, known issues, and glossary

## Source Of Truth Rules

- Active editable reports live under `Companies/<CODE>/<Actual Report Folder>/`.
- `PBIP` is the development source of truth.
- `PBIX` can be created temporarily for review but must not replace the PBIP workflow.
- `Module/Design Benchmarks/Sample 2` is the active design benchmark unless memory states otherwise.
- `AGENTS.md` should stay aligned with `README.md`, `docs/`, and `Project Memory` so new agents can recover context quickly.
