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
| Capture file | readonly_bridge_20260629_153934_identity.json |
| Capture ID | readonly_bridge_20260629_153934_identity |
| Mode | identity |
| Target | emulator-only |
| Exit code | 0 |
| Bridge result OK | True |
| Stdout line count | 13 |
| Stderr line count | 0 |
| Triage status | success |
| Raw artifacts committed | no |
| Physical phone touched | no |
| Firmware required | no |
| Stock image accepted | no |
| Recovery anchor accepted | no |

## Interpretation

The latest capture succeeded. No failure triage is needed for the latest capture.

## Local-only evidence

Raw local evidence remains under:

```text
rom_lab/reports/bridge_evidence/
```

Do not commit raw timestamped capture files by default.

## Safety boundary

This report does not authorize physical-device use, firmware acquisition, stock-image acceptance, recovery-anchor acceptance, raw command passthrough, or device mutation.