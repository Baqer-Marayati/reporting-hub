# SAP Export Pipeline (Read-Only)

This pipeline extracts read-only SAP Business One data from HANA and writes snapshot files for assistant analysis.

## Scope

- Source: SAP Business One on HANA
- Access: read-only queries only
- Companies: `ALJAZEERA`, `CANON`, `PAPERENTITY`
- Excluded: `CANON_TEST...`
- Output lane: `Shared/Data Drops/incoming/<YYYY-MM-DD>/`
- Preferred format: `parquet` (falls back to `csv` only when requested)

## Datasets Exported

- `bp_master`
- `item_master`
- `ar_open_items`
- `ap_open_items`
- `journal_entries`

## Security

- No writes to SAP.
- Credentials are read from environment variables.
- Do not commit credentials into config files.

## Quick Start

1. Copy config template:

```bash
cp "Shared/SAP Export Pipeline/config.template.json" "Shared/SAP Export Pipeline/config.json"
```

2. Set credentials in shell:

```bash
export SAP_HANA_USER="readonly_user"
export SAP_HANA_PASSWORD="readonly_password"
```

3. Run export:

```bash
python3 "Shared/SAP Export Pipeline/scripts/export_snapshots.py" \
  --config "Shared/SAP Export Pipeline/config.json" \
  --snapshot-date 2026-03-22 \
  --format parquet
```

4. Validate:

```bash
python3 "Shared/SAP Export Pipeline/scripts/validate_snapshot.py" \
  --snapshot-dir "Shared/Data Drops/incoming/2026-03-22"
```

## Notes

- If parquet dependencies are missing, install `pyarrow`.
- Output file names follow:
  - `<dataset>__<YYYY-MM-DD>__v1.parquet`
  - `<dataset>__<YYYY-MM-DD>__v1.csv` (if csv mode)
