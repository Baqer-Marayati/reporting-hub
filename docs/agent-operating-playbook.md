# Agent Operating Playbook

This playbook defines how AI agents should operate in this repository with low ambiguity and low risk.

## Execution Model

- Treat `reporting-hub` root as the portfolio coordination layer.
- Treat `Reports/<Domain>/` as a self-contained delivery module.
- Make changes inside one scope at a time (portfolio or one domain), then validate.

## Decision Routing

When deciding where to write:
- cross-domain standard -> `Shared/` or `docs/`
- domain-specific behavior -> `Reports/<Domain>/docs` or `Project Memory/DECISIONS.md`
- active progress log -> `Project Memory/CURRENT_STATUS.md`
- company-specific settings -> `Reports/<Domain>/Companies/<CompanyCode>/config`

## Safe Editing Rules

- Prefer minimal diffs in PBIP/TMDL JSON-like files.
- Avoid broad refactors unless explicitly requested.
- Remove stale hidden visuals and stale interactions when repairing pages.
- Keep archive/history out of active working folders.

## Validation Chain

Use this order after report changes:
1. structure validation script
2. screenshot capture of all pages
3. targeted page review
4. package generation
5. memory/status update

## Packaging Contract

- Output review artifacts under module `Exports/`.
- Include date/time and context in archive names.
- Prune old archives with retention script to prevent storage drift.

## Multi-Company Pattern

For each domain:
- `Core/` holds shared report core assets for that domain.
- `Companies/<CompanyCode>/config` holds company profile + datasource map + publish targets.
- `Companies/<CompanyCode>/overlays` holds optional per-company visual/model exceptions.

## First-Response Standard for Agents

Before substantial edits, state:
1. current known state from module memory
2. exact files to touch first
3. one clarifying question only if blocking

Then proceed without unnecessary waiting.
