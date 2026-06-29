# Emulator Bridge Evidence Capture Plan

Status: emulator-only evidence capture plan

Date: 2026-06-28

## Purpose

This report defines the next implementation target for the emulator-only ROM lab integration phase: structured evidence capture around the existing read-only bridge boundary.

The capture layer records bridge invocation metadata and structured results for local validation and later ForgeWire / ForgeLink / Fabric integration.

It does not expand bridge authority.

It does not touch the physical phone.

It does not require firmware.

It does not accept stock images or recovery anchors.

## Existing authority boundary

The current bridge stack is already contract-gated:

```text
emulator_readonly_contract.json
        |
        v
run_readonly_bridge.ps1
        |
        v
invoke_emulator_adb_readonly.ps1
```

The evidence capture layer must sit above the existing contract runner:

```text
capture_readonly_bridge_evidence.ps1
        |
        v
run_readonly_bridge.ps1
        |
        v
contract-gated read-only emulator bridge
```

The capture script must not bypass the contract runner.

## Capture goals

| Goal | Description |
|---|---|
| Record request metadata | mode, bounded parameters, generated capture ID, timestamp, repo-relative runner path. |
| Record result metadata | exit code, success/failure status, stdout/stderr line counts, output paths. |
| Preserve safety posture | target remains emulator-only; physical-device fields remain absent. |
| Produce local evidence | write JSON and markdown summaries to a local output directory. |
| Avoid sensitive bytes | do not store firmware packages, extracted images, secrets, or physical-device mutation logs. |

## Default output location

The default output should stay under a local report/evidence folder such as:

```text
rom_lab/reports/bridge_evidence/
```

Future runs may choose a local-only external output directory if evidence contains host-specific details.

Generated files should use a timestamped prefix:

```text
readonly_bridge_<yyyyMMdd_HHmmss>_<mode>.json
readonly_bridge_<yyyyMMdd_HHmmss>_<mode>.md
```

## JSON shape

The JSON summary should contain only metadata and bounded output summaries:

```json
{
  "schema": "rom_lab.emulator_bridge_evidence.v1",
  "capture_id": "readonly_bridge_20260628_000000_identity",
  "timestamp_utc": "2026-06-28T00:00:00Z",
  "target": "emulator-only",
  "mode": "identity",
  "parameters": {
    "PropName": "ro.build.fingerprint",
    "SettingsNamespace": "global",
    "SettingsKey": "",
    "LogLines": 100
  },
  "runner": "rom_lab/bridge/run_readonly_bridge.ps1",
  "result": {
    "ok": true,
    "exit_code": 0,
    "stdout_lines": 10,
    "stderr_lines": 0
  },
  "artifacts": {
    "markdown": "rom_lab/reports/bridge_evidence/readonly_bridge_20260628_000000_identity.md",
    "json": "rom_lab/reports/bridge_evidence/readonly_bridge_20260628_000000_identity.json"
  },
  "safety": {
    "physical_device_allowed": false,
    "firmware_required": false,
    "stock_image_acceptance": "blocked",
    "recovery_anchor_acceptance": "blocked"
  }
}
```

## Markdown summary shape

The markdown summary should include:

- capture ID
- timestamp
- mode
- target class
- command path, not raw ADB command passthrough
- exit code
- stdout/stderr line counts
- safety notes
- truncated stdout/stderr excerpts when appropriate

## Allowed parameters

The capture script may accept the same bounded parameters as the existing runner:

| Parameter | Default | Notes |
|---|---|---|
| Mode | identity | Must be accepted by the contract runner. |
| PropName | ro.build.fingerprint | Used only by prop-read mode. |
| SettingsNamespace | global | Must remain system, secure, or global. |
| SettingsKey | empty | Optional bounded settings key. |
| LogLines | 100 | Bounded by underlying bridge validation. |
| OutputDirectory | rom_lab/reports/bridge_evidence | Local capture destination. |

## Forbidden behavior

The capture layer must not introduce:

- raw ADB passthrough
- raw fastboot passthrough
- direct serial selection
- physical-device target fields
- firmware execution
- file push/pull/install/uninstall behavior
- reboot behavior
- slot switching
- bootloader, AVB, modem, radio, persist, EFS, GPT, or partition mutation
- stock-image trust claims
- recovery-anchor trust claims

## Test expectations

Add tests that prove:

- capture script exists
- capture script delegates to `rom_lab/bridge/run_readonly_bridge.ps1`
- capture script mentions `emulator-only`
- capture script writes JSON and markdown summaries
- capture script does not contain raw forbidden command families
- capture script does not accept serial, target, adb, fastboot, flash, erase, wipe, or mutation parameters

## Done state

This target is complete when:

- this plan exists
- a matching builder script exists
- a capture script exists
- tests cover the capture boundary
- README links the evidence capture plan
- local validation passes
- no phone is touched
- no firmware is acquired or committed

## Current decision

Proceed with a capture layer above the existing contract runner.

Do not bypass the contract runner.

Do not expand beyond emulator-only read-only inspection.
