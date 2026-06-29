# Emulator Bridge Runner Diagnostic

Status: generated runner diagnostic report

Date: 2026-06-29

## Purpose

This report is the durable diagnostic surface for emulator-only readonly bridge runner failures.

It checks repository-local runner prerequisites and summarizes local generated capture state.

## Diagnostic summary

| Field | Value |
|---|---|
| Runner script present | True |
| Runner script | rom_lab/bridge/run_readonly_bridge.ps1 |
| Contract file present | True |
| Contract file | rom_lab/bridge/emulator_readonly_contract.json |
| Contract parse OK | True |
| Required serial pattern | ^emulator-[0-9]+$ |
| Readonly bridge entrypoint | rom_lab/scripts/invoke_emulator_adb_readonly.ps1 |
| Readonly bridge script present | True |
| Latest capture ID | readonly_bridge_20260629_153934_identity |
| Latest capture mode | identity |
| Latest capture target | emulator-only |
| Latest capture exit code | 0 |
| Latest capture OK | True |
| Diagnostic status | runner_ready |

## Interpretation

Runner prerequisites appear present and the latest capture succeeded.

## Local-only evidence

```text
rom_lab/reports/bridge_evidence/
```

Do not commit raw timestamped capture files by default.

## Boundary

This report preserves the emulator-only, read-only repository boundary.