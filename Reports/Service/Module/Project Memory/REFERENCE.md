# Reference

## Core paths

- Module root: `Reports/Service/`
- PBIP project (CANON tenant): `Reports/Service/Companies/CANON/Canon Service Report/Canon Service Report.pbip`
- PBIP project (PAPERENTITY tenant): `Reports/Service/Companies/PAPERENTITY/Paper Service Report/Paper Service Report.pbip`
- Report definition (CANON): `Reports/Service/Companies/CANON/Canon Service Report/Canon Service Report.Report/definition/`
- Semantic model (CANON): `Reports/Service/Companies/CANON/Canon Service Report/Canon Service Report.SemanticModel/definition/`
- Company config: `Reports/Service/Companies/CANON/config/`

## Portfolio standards

- Report module contract: `Portfolio/Shared/Standards/report-module-contract.md`
- Visual identity: `Portfolio/Shared/Standards/portfolio-visual-identity.md`
- Page layout contract: `Portfolio/Shared/Standards/page-layout-spec.md`
- Theme tokens: `Portfolio/Shared/Standards/portfolio-theme.tokens.json`
- Canonical theme JSON (copy target): `Portfolio/Shared/Themes/Custom_Theme49412231581938193.json`

## Data source

- Platform: SAP HANA (ODBC, DSN `HANA_B1`)
- Tenant database: `HV107C21694P01`
- Schema: `CANON`
- Direct ODBC pattern (per `Portfolio/Shared/ChatContext/LESSONS.md` 2026-04-14):
  `Driver={HDBODBC};ServerNode=hana-vm-107:30041;DatabaseName=HV107C21694P01;UID=...;PWD=...;Encrypt=FALSE;`

## Automation (module)

- Package: `Reports/Service/Module/scripts/package-report.ps1` (defaults to this module's PBIP folder)
- Clear model cache: `Reports/Service/Module/scripts/clear-model-cache.ps1`
- Structure check: `Reports/Service/Module/scripts/validate-structure.ps1`
- Discovery / verification helpers (untracked at time of writing — commit when stable):
  - `verify_dim_equipment.ps1`
  - `disc_oins_oscl_project.ps1` / `disc_oins_oscl_project2.ps1`
  - `disc_production_calls.ps1`
  - `disc_production_clients.ps1`
  - `disc_production_def_compare.ps1`
  - `disc_ocrd_solution_type.ps1`
  - `disc_solution_type_distribution.ps1`
