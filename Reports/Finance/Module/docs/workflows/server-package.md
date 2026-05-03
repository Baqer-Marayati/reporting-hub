# Finance Review Workflow

## Purpose

Finance review happens directly from the active company PBIP. There is no required `ready.zip` package or `package-report.sh` step.

## Active PBIP Entry Points

- CANON: `Reports/Finance/Companies/CANON/Canon Financial Report/Canon Financial Report.pbip`
- PAPERENTITY: `Reports/Finance/Companies/PAPERENTITY/Paper Financial Report/Paper Financial Report.pbip`

## Routine

1. Finish report edits in the relevant company PBIP.
2. Validate report definitions and semantic-model paths with the repository validation checks.
3. Open the active company PBIP in Power BI Desktop.
4. Refresh and review the affected pages/visuals.
5. Capture screenshots when review evidence is needed.
6. Update Project Memory if current truth, decisions, or caveats changed.

## Notes

- PBIP remains the development source of truth.
- `PBIX` may still be created as a temporary review or transfer snapshot when explicitly needed, but it must not become the editable master.
- Generated package artifacts are not part of Finance done criteria.
