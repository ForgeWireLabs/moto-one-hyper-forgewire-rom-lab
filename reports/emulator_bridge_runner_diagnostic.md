# Emulator Bridge Runner Diagnostic

Status: generated runner diagnostic report

Date: 2026-06-29

## Purpose

This report is the durable, commit-safe diagnostic surface for emulator-only readonly bridge runner failures.

It checks repository-local runner prerequisites and summarizes local generated capture state without expanding authority or committing raw timestamped capture artifacts.

## Current status

| Field | Value |
|---|---|
| Runner script present | pending local generation |
| Contract file present | pending local generation |
| Contract parse OK | pending local generation |
| Contract target | pending local generation |
| Physical device allowed | pending local generation |
| Required serial pattern | pending local generation |
| Readonly bridge entrypoint | pending local generation |
| Readonly bridge script present | pending local generation |
| Latest capture ID | pending local generation |
| Latest capture exit code | pending local generation |
| Latest capture OK | pending local generation |
| Diagnostic status | pending local generation |
| Physical phone touched | no |
| Firmware required | no |
| Stock image accepted | no |
| Recovery anchor accepted | no |

## Local regeneration command

```powershell
.\scripts\build_emulator_bridge_runner_diagnostic.ps1
```

## Diagnostic statuses

| Status | Meaning |
|---|---|
| runner_ready | Runner prerequisites are present and the latest capture is successful. |
| runner_prereq_failed | Runner, contract, or readonly bridge entrypoint prerequisites are missing or invalid. |
| runner_capture_failed | Runner prerequisites are present but the latest capture is not successful. |
| no_capture | Runner prerequisites are present but no local capture was found. |
| unknown | Diagnostic could not determine a stronger status. |

## Safety boundary

This report preserves the emulator-only, read-only repository boundary and does not expand authority.
