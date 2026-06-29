# Emulator Bridge Failure Triage

Status: generated failure triage report

Date: 2026-06-29

## Purpose

This report is the durable, commit-safe triage surface for a failed emulator-only readonly bridge capture.

It summarizes local ignored capture artifacts without committing raw timestamped capture files.

## Latest capture triage

| Field | Value |
|---|---|
| Latest capture found | yes |
| Capture file | readonly_bridge_20260629_143257_identity.json |
| Capture ID | readonly_bridge_20260629_143257_identity |
| Mode | identity |
| Target | emulator-only |
| Exit code | 1 |
| Bridge result OK | False |
| Stdout line count | 0 |
| Stderr line count | 1 |
| Triage status | runner_failure |
| Raw artifacts committed | no |
| Physical phone touched | no |
| Firmware required | no |
| Stock image accepted | no |
| Recovery anchor accepted | no |

## Interpretation

The latest failure appears related to the contract runner or wrapper path. Review the runner path and contract file presence locally.

## Local-only evidence

Raw local evidence remains under:

```text
rom_lab/reports/bridge_evidence/
```

Do not commit raw timestamped capture files by default.

## Safety boundary

This report does not authorize physical-device use, firmware acquisition, stock-image acceptance, recovery-anchor acceptance, raw command passthrough, or device mutation.