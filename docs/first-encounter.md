# First Encounter Guide

Use this guide when a new human contributor or AI agent opens the repository for the first time.

## 1) Identify Your Scope First

Choose one scope before doing anything:

- **Portfolio scope**: standards, templates, catalog, architecture
- **Domain scope**: Finance/HR/Sales/Service/Marketing module work
- **Data exchange scope**: extraction/transfer workspace in `Reports/DataExchange`

If your task is about one report domain, move to that domain module immediately.

## 2) Follow the Navigation Chain

Read this chain in order:
1. `AGENTS.md`
2. `docs/foundation.md`
3. `docs/portfolio-architecture.md`
4. `docs/structure.md`
5. `docs/agent-operating-playbook.md`
6. `docs/ai-index.md`
7. `Portfolio Memory/REPORT_CATALOG.md`
8. `Portfolio Memory/CURRENT_STATUS.md`

Then read the target domain module's:
- `README.md`
- `AGENTS.md`
- `Project Memory/CURRENT_STATUS.md`
- `Project Memory/DECISIONS.md`

## 3) Understand the Contract

Every domain module is expected to follow:
- `Shared/Standards/report-module-contract.md`

Minimum expected shape:

```text
Reports/<Domain>/
  Core/
  Companies/
  scripts/
  Exports/
  Records/
  Archive/
  docs/
  Project Memory/
```

## 4) Source-of-Truth Rule

- PBIP files are editable source of truth.
- Packaged zips are review artifacts.
- Never treat an export artifact as editable master.

## 5) Packaging and Validation Rule

After meaningful report edits:
1. run screenshot capture workflow
2. review target pages from the latest capture set
3. rebuild review package
4. update memory files

## 6) Multi-Company Rule

Company-specific differences go under:
- `Reports/<Domain>/Companies/<CompanyCode>/config`
- `Reports/<Domain>/Companies/<CompanyCode>/overlays`

Use config-first. Add overlays only when config cannot satisfy the requirement.

## 7) Common Failure Modes

- Reviewing an old package instead of the latest one.
- Mixing screenshot casing (`Screenshots` vs `screenshots`); canonical is `Records/screenshots`.
- Keeping stale off-canvas visuals and hidden filters in PBIP pages.
- Writing live status in `Shared/` instead of module memory files.

## 8) Practical First Actions

If no additional context is provided:
1. validate structure with `scripts/validate-structure.ps1`
2. confirm target domain in `Portfolio Memory/REPORT_CATALOG.md`
3. confirm source-of-truth path in the domain `README.md`
4. follow contribution constraints in `CONTRIBUTING.md`
