# Companies

Use this folder to host company-specific configuration, overlays, and PBIP projects.

Suggested structure:

```text
Companies/
  <CompanyCode>/
    config/
    overlays/
    <Actual Report Folder>/
      <Actual Report Folder>.pbip
      <Actual Report Folder>.Report/
      <Actual Report Folder>.SemanticModel/
    Records/screenshots/    # optional; module-level Records/ is also valid
```

Start from `_template/` and duplicate per company.
Record the final company PBIP paths in `../module.manifest.json` before treating the module as active.
