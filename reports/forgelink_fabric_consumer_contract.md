# ForgeLink / ForgeWire Fabric Consumer Contract

Status: current consumer contract

Date: 2026-06-29

## Purpose

This report defines the safe downstream consumption contract for ForgeLink, ForgeWire, and ForgeWire Fabric style systems reading the Moto One Hyper ROM Lab emulator bridge status.

The contract is intentionally narrow. It allows downstream systems to consume committed, sanitized readiness surfaces for display, routing decisions, and handoff context. It does not grant authority to run ADB, run fastboot, launch the bridge, launch an emulator, inspect raw local capture artifacts, trust firmware, accept recovery anchors, or mutate a physical phone.

## Authoritative committed inputs

Downstream consumers may read these committed surfaces:

| Surface | Path | Meaning |
|---|---|---|
| Machine-readable status snapshot | `reports/emulator_bridge_status_snapshot.json` | Canonical JSON readiness state |
| Human/agent ready handoff | `reports/emulator_bridge_ready_handoff.md` | Durable ready handoff context |
| Current human status report | `reports/current_bridge_status.md` | Current readable bridge state summary |
| Latest sanitized capture outcome | `reports/emulator_bridge_latest_capture_outcome.md` | Commit-safe capture outcome summary |
| Consumer implementation | `rom_lab/bridge/forgelink_readiness_consumer.py` | Read-only readiness view builder |

Raw timestamped evidence under `rom_lab/reports/bridge_evidence/` is local-only by default and is not part of this consumer contract.

## Ready criteria

A downstream consumer may report the bridge as ready only when all of the following are true:

| Field | Required value |
|---|---|
| `status` | `ready` |
| `target` | `emulator-only` |
| `authority` | `readonly-emulator-inspection` |
| `latest_capture.exit_code` | `0` |
| `latest_capture.ok` | `true` |
| Ready handoff file | exists |
| `safety.physical_phone_touched` | `false` |
| `safety.firmware_required` | `false` |
| `safety.stock_image_accepted` | `false` |
| `safety.recovery_anchor_accepted` | `false` |
| `safety.raw_artifacts_committed` | `false` |

If any field is missing, contradictory, unsafe, or not ready, the downstream consumer must treat the bridge as not ready.

## Permitted downstream uses

ForgeLink, ForgeWire, and ForgeWire Fabric style systems may use this contract to:

- display bridge status to a human operator
- expose a JSON status card or diagnostic panel
- decide whether an emulator-only read-only integration surface is available
- attach readiness context to a session handoff
- block workflows that require physical-device authority, firmware trust, recovery acceptance, or mutation

## Non-authority boundary

This consumer contract is not an execution contract.

It does not authorize:

- ADB command passthrough
- fastboot command passthrough
- launching the emulator
- launching the bridge runner
- capturing new evidence
- reading ignored raw local evidence artifacts
- targeting a physical Android serial
- trusting firmware packages
- accepting stock images
- accepting recovery anchors
- flashing, booting, erasing, formatting, updating, sideloading, rooting, remounting, installing, uninstalling, partition mutation, slot mutation, vbmeta mutation, modem/persist/EFS/GPT mutation, or any equivalent write path

## Field semantics

| Field | Consumer interpretation |
|---|---|
| `ok` | Overall consumer readiness decision, not a permission grant |
| `status` | Bridge status from sanitized committed surfaces |
| `target` | Must remain `emulator-only` for readiness |
| `authority` | Must remain `readonly-emulator-inspection` for readiness |
| `capture_id` | Identifier of the sanitized latest capture outcome |
| `mode` | Named read-only capture/inspection mode |
| `exit_code` | Latest sanitized capture exit code |
| `bridge_ok` | Latest sanitized bridge result flag |
| `physical_phone_touched` | Must be false for readiness |
| `firmware_required` | Must be false for readiness |
| `stock_image_accepted` | Must be false for readiness |
| `recovery_anchor_accepted` | Must be false for readiness |
| `raw_artifacts_committed` | Must be false for readiness |
| `reason` | Human-readable explanation for ready/not-ready state |

## Required failure behavior

Downstream consumers must fail closed.

They must report not ready when:

- the status snapshot is missing or unreadable
- the ready handoff is missing
- the target is anything other than `emulator-only`
- the authority is anything other than `readonly-emulator-inspection`
- the status is anything other than `ready`
- the capture exit code is nonzero
- the capture OK flag is false
- any safety gate is true or missing in a way that cannot be proven safe

## Handoff meaning

A ready consumer state means only this:

```text
A committed, sanitized, emulator-only, read-only bridge readiness surface exists and can be displayed or consumed by downstream systems.
```

It does not mean this:

```text
A physical phone is safe to touch, firmware is trusted, recovery is accepted, raw ADB/fastboot passthrough is allowed, or mutation is authorized.
```

## Validation expectation

Changes to this contract should be validated with:

```powershell
python scripts\validate_repo.py
python -m unittest discover -s tests -v
.\scripts\validate_local.ps1
git status --short
```

Expected result:

```text
Repository governance validation passed.
All unit tests pass.
Local validation complete.
git status clean.
```
