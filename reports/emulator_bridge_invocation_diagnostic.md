# Emulator Bridge Invocation Diagnostic

Status: generated invocation diagnostic report

Date: 2026-06-29

## Purpose

This report is the durable diagnostic surface for the readonly emulator bridge invocation layer.

It focuses on the script that actually locates ADB, selects an emulator serial, and runs bounded readonly modes.

## Current status

| Field | Value |
|---|---|
| Invocation script present | pending local generation |
| ADB path configured | pending local generation |
| Emulator serial selection present | pending local generation |
| Identity mode present | pending local generation |
| Latest capture ID | pending local generation |
| Latest capture exit code | pending local generation |
| Latest capture OK | pending local generation |
| Diagnostic status | pending local generation |

## Local regeneration command

```powershell
.\scripts\build_emulator_bridge_invocation_diagnostic.ps1
```

## Diagnostic statuses

| Status | Meaning |
|---|---|
| invocation_ready | Invocation script structure is present and latest capture succeeded. |
| adb_path_check_needed | Invocation script requires local ADB path verification. |
| emulator_visibility_check_needed | Invocation script structure is present but latest capture is not successful. |
| invocation_prereq_failed | Invocation script or required mode structure is missing. |
| no_capture | Invocation structure is present but no local capture was found. |
| unknown | Diagnostic could not determine a stronger status. |

## Boundary

This report preserves the emulator-only, read-only repository boundary.
