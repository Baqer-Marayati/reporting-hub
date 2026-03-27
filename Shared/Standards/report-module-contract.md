# Report Module Contract

This standard defines the minimum folder contract for all domain modules under `Reports/` (for example `Finance`, `HR`, `Sales`, `Service`, `Marketing`).

## Goals

- Keep module structure consistent across domains.
- Support multiple companies per domain with moderate isolation.
- Keep source-of-truth PBIP work separate from review/archival artifacts.
- Make automation predictable (package, capture, retention, validation).

## Required Module Structure

Each domain module must include:

```text
Reports/<Domain>/
  AGENTS.md
  README.md
  docs/
  Project Memory/
  Core/
  Companies/
  scripts/
  Exports/
  Records/
  Archive/
```

## Folder Responsibilities

- `Core/`
  - Shared domain baseline assets:
    - base PBIP(s), common semantic logic, shared visual patterns.
  - No company-specific secrets or one-off overrides.

- `Companies/<CompanyCode>/config/`
  - Company profile and environment mapping.
  - Recommended files:
    - `company.profile.json`
    - `datasource.map.json`
    - `publish.targets.json`

- `Companies/<CompanyCode>/overlays/`
  - Optional company-specific overrides only.
  - Use overrides only when config cannot solve the requirement.

- `Exports/Server Packages/`
  - Review-ready packaged artifacts.
  - Keep a stable `latest` artifact and a rolling archive.

- `Records/screenshots/`
  - Screenshot capture runs, diagnostics, and review evidence.
  - Use lowercase `screenshots` casing only.

- `Archive/`
  - Historical module-level snapshots and retired material.

- `scripts/`
  - Domain automation wrappers:
    - package/build
    - screenshot capture
    - archive retention
    - structure validation

- `Project Memory/`
  - Durable project context:
    - `CURRENT_STATUS.md`
    - `DECISIONS.md`
    - `NEXT_STEPS.md`
    - `PROJECT_DNA.md`
    - `REFERENCE.md`

## Required Operating Rules

- PBIP source remains the editable source of truth.
- Review happens from packaged artifacts, not raw PBIP folders.
- Modules must adopt the portfolio visual identity standard (shared theme/branding) unless an exception is explicitly approved and recorded in module decisions.
- Every meaningful report edit must be followed by:
  1) full screenshot capture pass,
  2) packaging to review artifact,
  3) memory update.
- Archive retention follows rolling-window policy (default keep last 20 builds).

## Naming Conventions

- Domain folders: PascalCase (`Finance`, `HR`, `Sales`, `Service`, `Marketing`).
- Company folders: short uppercase code (`ALJAZEERA`, `COMPANY_B`).
- Screenshot folder casing: `Records/screenshots` only.
- Packaged builds:
  - stable: `<ReportName> - ready.zip`
  - archived: `YYYYMMDD_HHMM__<CompanyCode>__<ReportName>__<ShortSha>.zip`

## Migration Guidance

- Existing domain modules can align incrementally.
- Create contract folders first, then move/normalize assets with minimal disruption.
- Mark deprecated paths with README notes before deleting.
