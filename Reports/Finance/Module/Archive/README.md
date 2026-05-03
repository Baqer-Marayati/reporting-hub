# Finance Archive

This folder stores retired or superseded Finance-module material.

Use it for:
- old snapshots
- failed experiments worth preserving
- superseded benchmark variants
- retired exports that still need traceability

Do not leave archived material mixed into the active Finance working folders.

## Snapshot Index

These entries are historical restore points. They are **not** active source-of-truth PBIPs and should not be edited as live report projects.

| Snapshot | Contents | Current retention |
| --- | --- | --- |
| `Financial Report_pre-restore_20260325_224854/` | Full pre-restore PBIP snapshot nested under `Financial Report/`. | Keep in Git until the user approves deletion or external archival. |
| `Financial Report_pre-restore_20260326_174712/` | Full pre-restore PBIP snapshot with `.pbip`, `.Report/`, and `.SemanticModel/` at the snapshot root. | Keep in Git until the user approves deletion or external archival. |
| `Financial Report_pre-restore_20260326_181746/` | Full pre-restore PBIP snapshot with `.pbip`, `.Report/`, and `.SemanticModel/` at the snapshot root. | Keep in Git until the user approves deletion or external archival. |

## Retention Options

1. Keep all snapshots in Git and rely on this index for navigation.
2. Keep only the newest or most meaningful snapshot in Git, then move older snapshots to an external archive outside the repo.
3. Replace large snapshots with a short restoration note that points to a tagged commit or external archive location.

Do not delete or move these snapshots without explicit approval.
