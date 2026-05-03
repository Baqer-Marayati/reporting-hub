# Scripts

Automation scripts for the Finance module.

Current scripts:
- `capture-pages.ps1` — full-page screenshot capture. By default it resolves the selected company PBIP from `../../module.manifest.json`, saves to `Module/Records/screenshots/<CompanyCode>`, and reads **how many pages** to click from `…Report/definition/pages/pages.json` next to the PBIP (fallback: 10). Override with `-CompanyCode`, `-PbipPath`, `-OutputDir`, or `-PageCount` if needed.
- `clear-model-cache.ps1` — removes only `.pbi/cache.abf` under the selected company semantic model so Power BI Desktop reloads the model from source after Git changes. Use `-CompanyCode CANON`, `-CompanyCode PAPERENTITY`, or default `ALL`.
- `open-design-benchmark.ps1` — opens `Design Benchmarks/Sample 2/Wiise Financial Dashboards-2.pbip` in Power BI Desktop (Windows: `PBIDesktop.exe`; macOS: `open -a "Microsoft Power BI Desktop"`).
- `validate-structure.ps1` — module structure checks.

Planned additions:
- Extend manifest-driven checks as the module layout evolves.
