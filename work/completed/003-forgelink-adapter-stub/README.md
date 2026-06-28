# WI-003 - ForgeLink Adapter Stub

Status: complete

## Goal

Create a thin ForgeLink-facing adapter stub for the emulator-only Android bridge.

## Why

ForgeLink integration should begin at the boundary contract, not by giving ForgeLink raw ADB access. This keeps Android integration aligned with the repository safety model.

## Scope

In scope:

- adapter interface definition
- request validation against emulator_readonly_protocol.json
- operation alias support for ForgeLink-style requests
- params object support for wrapper parameters
- delegation to the JSON wrapper
- tests that do not execute a live emulator

Out of scope:

- live ForgeLink dispatch
- arbitrary shell access
- physical device targeting
- installing apps
- flashing or firmware mutation

## Deliverables

- rom_lab/bridge/forgelink_adapter_stub.py
- tests/test_forgelink_adapter_stub.py
- structured validation behavior
- mock-tested wrapper delegation

## Acceptance

- adapter reads protocol fields
- adapter rejects forbidden fields
- adapter rejects unknown modes
- adapter accepts mode or operation
- adapter supports params for allowed wrapper fields
- adapter delegates to the JSON wrapper
- adapter does not call subprocess during unit tests
- 50 tests pass

## Evidence

Implemented in commit:

- 231d7f2 Add ForgeLink adapter stub

## Safety

The adapter is incapable of targeting the physical Motorola One Hyper because it does not accept physical serial fields and delegates execution to the emulator-only JSON wrapper.
