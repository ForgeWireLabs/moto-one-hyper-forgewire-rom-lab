# Emulator Bridge Latest Capture Outcome

Status: generated latest capture outcome report

Date: 2026-06-29

## Purpose

This report is the durable, commit-safe summary target for the latest local emulator-only readonly bridge capture.

The raw timestamped capture files remain local generated evidence by default under:

```text
rom_lab/reports/bridge_evidence/
```

## Latest local capture summary

| Field | Value |
|---|---|
| Capture file observed | readonly_bridge_20260629_153934_identity.json |
| Capture ID | readonly_bridge_20260629_153934_identity |
| Timestamp UTC | 2026-06-29T15:39:34.9765594Z |
| Mode | identity |
| Target | emulator-only |
| Exit code | 0 |
| Bridge result OK | True |
| Stdout line count | 13 |
| Stderr line count | 0 |
| Runner | rom_lab/bridge/run_readonly_bridge.ps1 |
| Raw artifacts committed | no |
| Physical phone touched | no |
| Firmware required | no |
| Stock image accepted | no |
| Recovery anchor accepted | no |

## Interpretation

The latest local capture completed successfully through the contract-gated emulator-only bridge wrapper.

This report summarizes local generated evidence without committing raw timestamped capture artifacts.

## Local commands

```powershell
powershell -ExecutionPolicy Bypass -File .\rom_lab\bridge\capture_readonly_bridge_evidence.ps1 -Mode identity
.\scripts\build_emulator_bridge_latest_capture_outcome.ps1
python scripts\validate_repo.py
python -m unittest discover -s tests -v
.\scripts\validate_local.ps1
git status --short
```

## Safety boundary

This summary does not authorize physical-device use, firmware acquisition, stock-image acceptance, recovery-anchor acceptance, raw command passthrough, or device mutation.
