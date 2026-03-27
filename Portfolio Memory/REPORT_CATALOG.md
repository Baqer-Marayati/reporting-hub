# Report Catalog

## Active Reports

### Finance

- Module path: `Reports/Finance`
- Status: Active
- Notes: Current Al Jazeera financial reporting project

### DataExchange

- Module path: `Reports/DataExchange`
- Status: Active
- Notes: Isolated PBIP workspace for export operations; keeps Finance source untouched

### HR

- Module path: `Reports/HR`
- Status: Scaffolded
- Notes: Domain module created with baseline docs/memory and company-template layout

### Sales

- Module path: `Reports/Sales`
- Status: Scaffolded
- Notes: Domain module created with baseline docs/memory and company-template layout

### Service

- Module path: `Reports/Service`
- Status: Scaffolded
- Notes: Domain module created with baseline docs/memory and company-template layout

### Marketing

- Module path: `Reports/Marketing`
- Status: Scaffolded
- Notes: Domain module created with baseline docs/memory and company-template layout

### Inventory

- Module path: `Reports/Inventory`
- Status: Active
- Notes: Inventory Performance Report — 5-page PBIP report with SAP HANA ODBC semantic model (CANON schema). Covers stock position, warehouse distribution, movements, categories, and procurement. Awaiting Desktop validation.

## Planned Reports

- Logistics

Create these as modules under `Reports/` only when real project work begins.

## Module Creation Rule

When a planned report becomes real:
1. create it from `Shared/Templates/report-module-starter`
2. preferably use `./scripts/create-report-module.sh <ModuleName> "<ReportTitle>"`
3. update this file from planned to active
