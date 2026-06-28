# 003 — Review Moto One Hyper ROM source viability

> **Status**: Active
> **Owners**: governance-owner (lead).
> **Depends on**: none.

## Intent

Inspect ROM source candidates for Motorola One Hyper (`def`) and SM6150 without
downloading full Android source or touching the phone. Produce a ranked source
viability recommendation and concrete first build/test target.

## Decisions

- Prefer generic emulator/Cuttlefish or emulator smoke testing before any large
  source sync.
- Treat `sorenlyulf/android_device_motorola_def` as the strongest def-specific
  device tree lead, but not a complete ROM without common/kernel/vendor inputs.
- Keep real-device writes blocked.

## Scope

- `rom_lab/research/source_viability_review_20260627.md`
- `rom_lab/research/sources_matrix.md`
- `rom_lab/reports/rom_lab_status_20260627.md`
- `rom_lab/scripts/check_android_build_host.ps1`
- `scripts/validate_repo.py`
- this work item and evidence

## Closeout

Each acceptance criterion is satisfied by linked evidence. When all are satisfied,
move this directory to `work/completed/` and regenerate the dashboard.
