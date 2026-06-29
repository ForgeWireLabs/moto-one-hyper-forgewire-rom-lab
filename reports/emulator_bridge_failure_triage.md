# Emulator Bridge Failure Triage

Status: generated failure triage report

Date: 2026-06-29

## Purpose

This report is the durable, commit-safe triage surface for a failed emulator-only readonly bridge capture.

It is generated from local ignored capture artifacts under:

```text
rom_lab/reports/bridge_evidence/
```

The raw timestamped capture files remain local-only by default.

## Current status

| Field | Value |
|---|---|
| Latest capture found | pending local generation |
| Capture ID | pending local generation |
| Mode | pending local generation |
| Exit code | pending local generation |
| Bridge result OK | pending local generation |
| Stderr line count | pending local generation |
| Triage status | pending local generation |
| Raw artifacts committed | no |
| Physical phone touched | no |
| Firmware required | no |
| Stock image accepted | no |
| Recovery anchor accepted | no |

## Local regeneration command

```powershell
.\scripts\build_emulator_bridge_failure_triage.ps1
```

## Triage categories

| Category | Meaning |
|---|---|
| no_capture | No local capture artifact was found. |
| success | Latest capture succeeded; no failure triage needed. |
| missing_emulator | Failure appears consistent with no emulator or no matching emulator serial. |
| runner_failure | Failure appears to originate in the contract runner or wrapper path. |
| bridge_failure | Failure appears to originate in the underlying readonly bridge. |
| unknown_failure | Failure exists but the sanitized triage could not classify it. |

## Safety boundary

This report does not authorize physical-device use, firmware acquisition, stock-image acceptance, recovery-anchor acceptance, raw command passthrough, or device mutation.
