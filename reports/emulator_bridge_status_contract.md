# Emulator Bridge Status Contract

Status: ForgeLink / ForgeWire Fabric readable status contract

Date: 2026-06-29

## Purpose

This contract defines the machine-readable status surface for the Moto One Hyper ROM lab emulator-only readonly bridge.

It is intended for future ForgeLink and ForgeWire Fabric consumers that need to read bridge readiness without receiving raw capture artifacts or any physical-device authority.

This is a status surface, not a control surface.

## Source of truth

The status snapshot is derived from the committed sanitized capture outcome report:

```text
reports/emulator_bridge_latest_capture_outcome.md
```

The raw timestamped bridge captures remain local generated evidence under:

```text
rom_lab/reports/bridge_evidence/
```

Those raw capture files are ignored by Git by default.

## Schema file

```text
rom_lab/bridge/emulator_bridge_status_schema.json
```

## Snapshot file

```text
reports/emulator_bridge_status_snapshot.json
```

## Status values

| Status | Meaning |
|---|---|
| ready | Latest sanitized capture indicates a successful contract-gated emulator-only bridge run. |
| not_ready | Latest sanitized capture exists but does not indicate success, or no successful capture is available. |
| blocked | A safety or evidence gate blocks a stronger claim. |
| unknown | Required summary data is missing or cannot be parsed. |

## Current expected mapping

The latest capture outcome currently records a non-success bridge result. Therefore the status snapshot should report:

```json
{
  "status": "not_ready"
}
```

A non-success bridge capture does not invalidate the safety boundary. It means the bridge status is not ready for downstream use until the local cause is inspected and a successful emulator-only capture is summarized.

## Allowed consumer behavior

ForgeLink / ForgeWire Fabric consumers may:

- read the snapshot
- display readiness status
- display the latest sanitized capture ID
- decide whether to skip emulator bridge dependent work
- record the status as evidence metadata

Consumers must not:

- treat this as phone-control authority
- infer firmware trust
- infer stock image acceptance
- infer recovery anchor acceptance
- request raw command passthrough
- request physical-device targeting
- bypass the bridge contract runner

## Safety constants

The snapshot must continue to report:

| Field | Required value |
|---|---|
| target | emulator-only |
| authority | readonly-emulator-inspection |
| physical_phone_touched | false |
| firmware_required | false |
| stock_image_accepted | false |
| recovery_anchor_accepted | false |
| raw_artifacts_committed | false |

## Current decision

Expose bridge readiness as a read-only status snapshot.

Do not expose a control API.

Do not expand authority beyond emulator-only inspection.
