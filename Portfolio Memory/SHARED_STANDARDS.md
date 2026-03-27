# Shared Standards

## Purpose

Use this file to record standards that should apply across more than one report module.

Examples:
- shared color systems
- naming rules
- date logic conventions
- reusable KPI conventions
- layout standards that should travel across departments

As of March 22, 2026, most detailed standards still live inside the Finance module and can be promoted here later when reuse becomes real.

## 2026-03-27 - Portfolio Visual Identity Standard

- All report modules must use one unified visual identity derived from the Finance report baseline.
- This includes:
  - page/background colors
  - chart and series color palette
  - KPI card styling
  - typography and visual hierarchy patterns
  - common spacing and layout rhythm where practical
- New modules (for example `Reports/Inventory`) should inherit this standard from the start, before custom styling.
- Any intentional deviation must be documented in that module's `Project Memory/DECISIONS.md` with a business reason.
- Until a dedicated token file is extracted, `Reports/Finance` is the reference implementation for theme and branding behavior.
