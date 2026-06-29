# Emulator Bridge Latest Capture Outcome

Status: generated latest capture outcome report

Date: 2026-06-29

## Purpose

This report is the durable, commit-safe summary target for the latest local emulator-only readonly bridge capture.

The raw timestamped capture files remain local generated evidence by default under:

```text
rom_lab/reports/bridge_evidence/
```

This report should be regenerated locally after running the capture wrapper.

## Current local capture status

| Field | Value |
|---|---|
| Capture files observed | not generated in this committed placeholder |
| Latest capture ID | pending local regeneration |
| Latest mode | pending local regeneration |
| Latest target | emulator-only |
| Latest exit code | pending local regeneration |
| Raw artifacts committed | no |
| Physical phone touched | no |
| Firmware required | no |
| Stock image accepted | no |
| Recovery anchor accepted | no |

## Local regeneration command

After running a local capture, regenerate this report with:

```powershell
.\scripts\build_emulator_bridge_latest_capture_outcome.ps1
```

Then review this report before committing it.

## Safety boundary

This summary does not authorize physical-device use, firmware acquisition, stock-image acceptance, recovery-anchor acceptance, raw command passthrough, or device mutation.
