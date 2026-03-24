# Repository Structure

## Root Layer

The repository root is now the portfolio layer, not a single-report project folder.

## Main Areas

### `Reports`

Contains one folder per report module.

Current modules:
- `Finance` (active)
- `DataExchange` (active exchange workspace)
- `HR` (scaffolded)
- `Sales` (scaffolded)
- `Service` (scaffolded)
- `Marketing` (scaffolded)

### `Shared`

Contains reusable material shared across multiple report modules.

### `Portfolio Memory`

Contains cross-report truth and planning context.

### `docs`

Contains stable portfolio-level orientation and architecture docs.

### `Archive`

Contains retired or historical portfolio-level material.

## Navigation Rule

If the task is about one report, go into that report module.
If the task is about standards, shared assets, or multi-report planning, stay at the portfolio layer.

## Contract Rule

All report modules should align to:
- `Shared/Standards/report-module-contract.md`
