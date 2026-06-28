# 002 — Scaffold Moto One Hyper custom ROM lab

> **Status**: Active
> **Owners**: governance-owner (lead).
> **Depends on**: none.

## Intent

Create a text-only ROM research/build lab for Motorola One Hyper (`def`) that
keeps generic emulator/GSI work separate from true device-port work and keeps
real-device flashing blocked.

## Decisions

- Build the lab and decision matrix before downloading Android source.
- Treat emulator and GSI boots as useful generic evidence, not proof of hardware
  compatibility.
- Keep all firmware-write actions blocked unless Jeremy explicitly approves a
  specific current-session action.

## Scope

- `rom_lab/`
- `tests/`
- `scripts/validate_repo.py`
- `.gitignore`
- this work item and evidence

## Closeout

Each acceptance criterion is satisfied by linked evidence. When all are satisfied,
move this directory to `work/completed/` and regenerate the dashboard.
