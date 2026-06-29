# ForgeLink Bridge Request / Response Examples

Status: current downstream examples

Date: 2026-06-29

## Purpose

This document gives ForgeLink, ForgeWire, and ForgeWire Fabric style consumers concrete request and response examples for the Moto One Hyper ROM Lab emulator-only read-only bridge adapter.

These examples are integration fixtures, not device instructions. They document the downstream adapter shape while preserving the existing safety boundary.

## Boundary

The adapter accepts named read-only bridge modes only.

It does not accept:

- physical device serials
- raw ADB arguments
- raw shell commands
- fastboot arguments
- push/pull paths
- flashing, booting, erasing, formatting, sideloading, rooting, remounting, installing, uninstalling, rebooting, partition mutation, slot mutation, vbmeta mutation, modem/persist/EFS/GPT mutation, or any equivalent write path

The adapter target remains `emulator-only`.

## Supported top-level request fields

| Field | Required | Meaning |
|---|---:|---|
| `mode` | yes, unless `operation` is used | Named read-only bridge mode |
| `operation` | yes, unless `mode` is used | Alias for `mode` |
| `params` | no | Object containing optional mode parameters |
| `request_id` | no | Correlation value preserved in successful responses |

Supported optional direct fields and `params` keys are:

| Field | Meaning |
|---|---|
| `PropName` | Android property name for `prop-read` |
| `SettingsNamespace` | `system`, `secure`, or `global` for `settings-read` |
| `SettingsKey` | Optional Android settings key |
| `LogLines` | Bounded logcat tail line count |

## Example 1: identity request

Request:

```json
{
  "request_id": "fw-demo-identity-001",
  "mode": "identity"
}
```

Successful response shape:

```json
{
  "ok": true,
  "mode": "identity",
  "target": "emulator-only",
  "stdout": "<sanitized runner stdout>",
  "stderr": "",
  "exit_code": 0,
  "request_id": "fw-demo-identity-001"
}
```

Consumer meaning:

```text
The emulator-only read-only identity mode completed through the contract-gated adapter path.
```

It does not mean:

```text
A physical Motorola One Hyper was inspected or authorized.
```

## Example 2: operation alias request

Request:

```json
{
  "request_id": "fw-demo-packages-001",
  "operation": "packages"
}
```

Successful response shape:

```json
{
  "ok": true,
  "mode": "packages",
  "target": "emulator-only",
  "stdout": "<sanitized runner stdout>",
  "stderr": "",
  "exit_code": 0,
  "request_id": "fw-demo-packages-001"
}
```

## Example 3: property read with params

Request:

```json
{
  "request_id": "fw-demo-prop-001",
  "mode": "prop-read",
  "params": {
    "PropName": "ro.build.fingerprint"
  }
}
```

Successful response shape:

```json
{
  "ok": true,
  "mode": "prop-read",
  "target": "emulator-only",
  "stdout": "<sanitized runner stdout>",
  "stderr": "",
  "exit_code": 0,
  "request_id": "fw-demo-prop-001"
}
```

## Example 4: bounded logcat tail

Request:

```json
{
  "request_id": "fw-demo-logcat-001",
  "mode": "logcat-tail",
  "params": {
    "LogLines": 100
  }
}
```

Successful response shape:

```json
{
  "ok": true,
  "mode": "logcat-tail",
  "target": "emulator-only",
  "stdout": "<bounded sanitized logcat tail>",
  "stderr": "",
  "exit_code": 0,
  "request_id": "fw-demo-logcat-001"
}
```

`LogLines` remains bounded by the bridge protocol and validation layer.

## Example 5: rejected physical-device target

Request:

```json
{
  "request_id": "fw-demo-reject-serial-001",
  "mode": "identity",
  "serial": "ZY22EXAMPLE"
}
```

Rejected response shape:

```json
{
  "ok": false,
  "mode": "identity",
  "target": "emulator-only",
  "stdout": "",
  "stderr": "Forbidden adapter fields: serial",
  "exit_code": 2
}
```

Consumer meaning:

```text
The adapter rejected a forbidden physical-targeting field before bridge execution.
```

## Example 6: rejected raw command request

Request:

```json
{
  "request_id": "fw-demo-reject-command-001",
  "mode": "identity",
  "command": "shell getprop"
}
```

Rejected response shape:

```json
{
  "ok": false,
  "mode": "identity",
  "target": "emulator-only",
  "stdout": "",
  "stderr": "Forbidden adapter fields: command",
  "exit_code": 2
}
```

Consumer meaning:

```text
The adapter rejected raw command passthrough before bridge execution.
```

## Downstream integration rule

A ForgeLink/Fabric consumer should treat this adapter as a narrow request normalizer and dispatcher for named read-only emulator modes.

It should not treat this adapter as a general Android device control surface.

## Validation expectation

Changes to these examples should be validated with:

```powershell
python scripts\validate_repo.py
python -m unittest discover -s tests -v
.\scripts\validate_local.ps1
git status --short
```
