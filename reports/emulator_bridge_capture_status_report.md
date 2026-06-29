# Emulator Bridge Capture Status Report

Status: generated capture status report

Date: 2026-06-28

## Purpose

This report records the durable repository status for emulator-only readonly bridge evidence capture.

The raw timestamped capture artifacts are local generated evidence by default. They are not the durable committed record unless explicitly reviewed and sanitized later.

## Current implementation

| Area | State |
|---|---|
| Capture plan | present |
| Capture plan builder | present |
| Capture wrapper | present |
| Capture tests | present |
| README link | present |
| Generated capture directory policy | present |
| Raw capture artifacts committed by default | no |
| Physical phone required | no |
| Firmware required | no |
| Stock image accepted | no |
| Recovery anchor accepted | no |

## Capture command

```powershell
powershell -ExecutionPolicy Bypass -File .\rom_lab\bridge\capture_readonly_bridge_evidence.ps1 -Mode identity
```

The command delegates to the existing contract runner:

```text
rom_lab/bridge/capture_readonly_bridge_evidence.ps1
        |
        v
rom_lab/bridge/run_readonly_bridge.ps1
        |
        v
rom_lab/scripts/invoke_emulator_adb_readonly.ps1
```

The capture wrapper must not call around the contract runner.

## Output policy

Default generated output directory:

```text
rom_lab/reports/bridge_evidence/
```

Default generated files:

```text
readonly_bridge_<timestamp>_<mode>.json
readonly_bridge_<timestamp>_<mode>.md
```

These generated files are ignored by Git by default.

The committed durable artifact is this summary/status report, not raw timestamped capture output.

## Why raw captures are local by default

Raw emulator capture files may contain host-specific details, timestamps, package lists, logs, environment facts, or other operational noise that should not become permanent public repository evidence without review.

The safer pattern is:

1. run capture locally
2. inspect generated JSON/markdown
3. summarize safe conclusions into a committed report
4. leave raw timestamped artifacts local unless explicitly sanitized and accepted

## Safety boundary

This report does not authorize:

- touching the physical Motorola One Hyper
- acquiring firmware
- accepting a firmware package
- accepting boot.img
- accepting recovery.img
- accepting vendor_boot.img
- accepting vbmeta.img
- booting or flashing the physical phone
- pushing, installing, uninstalling, rebooting, remounting, or mutating device state
- raw ADB passthrough
- raw fastboot passthrough

## Current decision

Use local generated captures for emulator-only inspection evidence.

Commit summarized status reports by default.

Keep raw generated captures ignored unless a future evidence review explicitly accepts one sanitized artifact.
