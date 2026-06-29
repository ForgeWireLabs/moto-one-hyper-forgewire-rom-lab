# ForgeWire ROM Lab Bridge Plan

Status: ForgeWire / ForgeLink bridge planning report

Date: 2026-06-28

## Purpose

This report defines how the Moto One Hyper ROM lab should expose emulator-only inspection capability to future ForgeWire, ForgeLink, or ForgeWire Fabric control surfaces.

The bridge is not a phone-control system.

The bridge is not a firmware flashing layer.

The bridge is not a raw ADB or fastboot passthrough.

The bridge is a constrained adapter surface for named, read-only, emulator-only inspection modes.

## Design principle

External orchestration may ask the ROM lab to inspect an emulator.

External orchestration may not expand the ROM lab authority.

That means ForgeWire / ForgeLink / Fabric integration must be downstream of the bridge contract, not parallel to it.

```text
ForgeWire / ForgeLink request
        |
        v
Adapter normalization
        |
        v
Bridge protocol validation
        |
        v
Operation catalog lookup
        |
        v
Contract-gated runner
        |
        v
Read-only emulator implementation
```

Every layer must be able to reject the request.

No layer should be able to authorize behavior that the layer below it forbids.

## Allowed request class

A future external request may provide:

| Field | Meaning |
|---|---|
| request_id | Optional caller-provided correlation ID. |
| mode or operation | Required known read-only operation. |
| params | Optional bounded parameters accepted by the selected operation. |
| metadata | Optional non-authoritative caller metadata, if later allowed by protocol. |

A future external request must not provide:

| Forbidden class | Reason |
|---|---|
| physical serial | Would bypass emulator-only targeting. |
| arbitrary target | Would bypass contract target class. |
| raw command | Would bypass operation catalog. |
| raw shell | Would bypass protocol and runner boundaries. |
| raw ADB passthrough | Would bypass named mode enforcement. |
| raw fastboot passthrough | Would create physical-device risk. |
| mutation intent | The current phase is read-only. |
| firmware image path for execution | Firmware evidence is blocked and local-only. |
| partition mutation request | Physical storage mutation is out of scope. |
| bootloader / AVB / modem / radio / persist / EFS / GPT mutation | High-risk device areas remain forbidden. |

## Adapter responsibilities

The adapter should:

- accept a small external request shape
- normalize aliases into known bridge modes
- preserve request IDs
- reject unknown modes
- reject unknown fields
- reject forbidden fields
- reject mutation hints
- return structured validation failures
- never fall through to raw host execution
- never choose a physical device target
- never produce or accept firmware trust claims

## Bridge responsibilities

The existing bridge stack should remain authoritative for:

- allowed modes
- allowed parameters
- target class
- serial pattern
- read-only behavior
- forbidden field handling
- structured response shape
- local implementation invocation

## ForgeWire/Fabric event model

A future ForgeWire or Fabric event should record the bridge interaction as an inspection, not a device action.

Suggested event fields:

| Field | Description |
|---|---|
| event_type | `rom_lab.emulator.readonly_inspection` |
| request_id | Caller request ID or generated ID. |
| mode | Known bridge mode. |
| target_class | `android_emulator` |
| target_selector | Redacted or normalized emulator selector, not a physical serial. |
| result | success, validation_error, runtime_error, or skipped. |
| authority | read-only / emulator-only. |
| evidence_ref | Optional local evidence-run ID if recorded. |

Events should not include:

- physical serials
- secrets
- firmware package paths containing private local usernames unless intentionally redacted
- firmware bytes
- extracted image bytes
- raw command payloads
- mutation attempts

## Failure behavior

Failures should be explicit and structured.

| Failure | Required response |
|---|---|
| Unknown mode | validation error |
| Unknown field | validation error |
| Forbidden field | validation error |
| Physical serial | validation error |
| Missing emulator | runtime error or skipped, depending on invocation context |
| Local tool missing | runtime error with host-safe message |
| Evidence blocked | blocked status, not success |

## Security and safety posture

The bridge should be treated as a safety boundary, not just a convenience wrapper.

Important rules:

- external systems do not get raw ADB
- external systems do not get raw fastboot
- external systems do not get direct serial selection
- external systems do not get to decide that an image is trusted
- external systems do not get to approve physical-device actions
- physical-device actions require separate current-session human approval for one exact action

## Near-term implementation shape

The next implementation increment should remain local and emulator-only:

1. keep the bridge contract as the root of authority
2. keep operation catalog as the only mode source
3. keep protocol rejection strict
4. keep runner serial selection emulator-pattern-only
5. keep adapter stub as a normalizer, not an executor
6. optionally add structured evidence-run capture for local validation
7. document all resulting evidence in committed reports

## Acceptance criteria

| Criterion | State |
|---|---|
| Bridge plan exists | satisfied when committed |
| Builder script exists | satisfied when committed |
| README links bridge plan | satisfied when linked |
| Plan forbids raw command passthrough | satisfied by this report |
| Plan keeps physical phone out of scope | satisfied by this report |
| Plan keeps firmware evidence blocked | satisfied by this report |
| Local validation rerun | must be verified locally after pull |

## Current decision

The ForgeWire / ForgeLink / Fabric bridge direction is approved only as an emulator-only, read-only, contract-gated inspection surface.

No physical-device control is authorized.

No firmware trust claim is authorized.
