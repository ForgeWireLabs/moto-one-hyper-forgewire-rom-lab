# Emulator-Only Test Matrix

Status: emulator-only validation matrix

Date: 2026-06-28

## Purpose

This report defines the safe test surface for the ROM lab after the phase closeout.

The matrix covers local repository validation, read-only emulator bridge validation, ForgeLink adapter boundary checks, and no-phone-touch policy enforcement.

It does not require a physical phone.

It does not require stock firmware.

It does not accept any stock image or recovery anchor.

## Test boundary

| Boundary | Required behavior |
|---|---|
| Target class | emulator serials only |
| Operation model | named read-only modes only |
| Command model | no arbitrary shell passthrough |
| Physical phone | blocked by default |
| Firmware | local-only if later acquired; not part of this matrix |
| Repo contents | no committed firmware/image/archive artifacts |
| Evidence | metadata and local validation records only |

## Required local validation commands

Run these before committing any follow-up work:

```powershell
python scripts\validate_repo.py
python -m unittest discover -s tests -v
.\scripts\validate_local.ps1
git status --short
```

Expected result:

- repository governance validation passes
- unit tests pass
- local validation completes
- git status is clean after intentional commits

## Unit-test coverage map

| Test family | Intended proof |
|---|---|
| `test_rom_lab_profile` | Device profile does not claim stock boot verification or root availability prematurely. |
| `test_rom_lab_safety` | Large or forbidden firmware/image/archive artifacts are not committed; execution scripts avoid destructive command families. |
| `test_no_phone_touch_policy` | Policy exists, requires current-session gate approval, treats known real serial as non-target, and defaults to emulator targets. |
| `test_emulator_bridge_contract` | Contract exists, targets emulator-only use, and names forbidden behavior families. |
| `test_emulator_bridge_operations` | Operation catalog is read-only, bounded, and a subset of contract-allowed modes. |
| `test_emulator_bridge_protocol` | Protocol requires a known mode and rejects direct targeting fields. |
| `test_emulator_bridge_runner` | Runner loads contract before invocation and does not expose raw ADB or fastboot authority. |
| `test_emulator_bridge_json_wrapper` | JSON wrapper returns structured success and validation-error responses. |
| `test_forgelink_adapter_stub` | Adapter normalizes allowed requests and rejects unknown or forbidden fields. |

## Bridge operation expectations

| Mode class | Safe expectation | Rejected expansion |
|---|---|---|
| identity | Report emulator identity facts from an allowed emulator target | Physical serial targeting |
| properties | Read bounded property information | Setting properties or persistent configuration |
| packages | List or summarize package metadata | Installing, uninstalling, disabling, or modifying packages |
| logcat | Capture bounded logs | Unbounded logging, state mutation, or shell passthrough |
| storage/status | Summarize read-only status facts | Formatting, remounting, pushing files, deleting files, or changing partitions |

## Adapter expectations

A future ForgeLink / ForgeWire adapter should:

- accept only a named operation or mode
- normalize aliases into known bridge modes
- preserve caller request IDs when present
- reject unknown top-level fields
- reject unknown parameter fields
- reject physical target fields
- reject raw command fields
- return structured validation errors instead of falling through to host execution

## Negative tests that must stay true

The system must continue rejecting requests that attempt to provide:

- physical device serials
- raw shell commands
- direct target selectors
- direct ADB passthrough
- direct fastboot passthrough
- write/mutation flags
- firmware image paths for execution
- partition names for mutation
- slot switching intent
- bootloader, AVB, modem, radio, persist, EFS, or GPT mutation intent

## Evidence expectations

Any future evidence run for this matrix should include:

- command actually run
- date/time
- environment summary
- artifact list
- result
- linked work item
- provenance level

It should not include:

- firmware package bytes
- extracted image bytes
- private secrets
- physical-device mutation logs
- unapproved physical-device command attempts

## Acceptance criteria for this matrix

| Criterion | State |
|---|---|
| Matrix exists as a committed report | satisfied when committed |
| Builder script exists | satisfied when committed |
| README links matrix | satisfied when linked |
| Local validation remains green | must be verified locally after pull |
| No physical device is required | satisfied by design |
| No firmware is required | satisfied by design |

## Current decision

Use this matrix to guide the next emulator-only bridge and ForgeLink/Fabric adapter work.

Do not expand the bridge into physical-device control.
