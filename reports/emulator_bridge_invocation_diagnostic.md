# Emulator Bridge Invocation Diagnostic

Status: generated invocation diagnostic report

Date: 2026-06-29

## Purpose

This report is the durable diagnostic surface for the readonly emulator bridge invocation layer.

It checks the script that locates ADB, selects an emulator serial, and runs bounded readonly modes.

## Diagnostic summary

| Field | Value |
|---|---|
| Invocation script present | True |
| Invocation script | rom_lab/scripts/invoke_emulator_adb_readonly.ps1 |
| ADB path configured | yes |
| ADB path | C:\Android\Sdk\platform-tools\adb.exe |
| Emulator serial selection present | True |
| Identity mode present | True |
| Bounded invoker present | True |
| Missing emulator message present | True |
| Latest capture ID | readonly_bridge_20260629_143257_identity |
| Latest capture mode | identity |
| Latest capture target | emulator-only |
| Latest capture exit code | 1 |
| Latest capture OK | False |
| Diagnostic status | emulator_visibility_check_needed |

## Interpretation

Invocation structure appears present, but the latest capture is not successful. Confirm the configured emulator is running and visible locally before rerunning capture.

## Local-only evidence

```text
rom_lab/reports/bridge_evidence/
```

Do not commit raw timestamped capture files by default.

## Boundary

This report preserves the emulator-only, read-only repository boundary.