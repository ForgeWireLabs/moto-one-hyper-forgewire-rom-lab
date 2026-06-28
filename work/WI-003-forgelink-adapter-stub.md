# WI-003 - ForgeLink Adapter Stub

Status: proposed

## Goal

Create a thin ForgeLink-facing adapter stub for the emulator-only Android bridge.

## Why

ForgeLink integration should begin at the boundary contract, not by giving ForgeLink raw ADB access. This keeps Android integration aligned with the repository safety model.

## Scope

In scope:

- adapter interface definition
- request validation against emulator_readonly_protocol.json
- operation lookup from emulator_readonly_operations.json
- command construction for the existing contract-gated runner
- tests that do not execute a live emulator

Out of scope:

- live ForgeLink dispatch
- arbitrary shell access
- physical device targeting
- installing apps
- flashing or firmware mutation

## Deliverables

- adapter stub file
- adapter tests
- short documentation explaining the integration seam

## Acceptance

- adapter reads protocol and operations files
- adapter rejects forbidden fields
- adapter rejects unknown modes
- adapter produces a safe runner invocation
- adapter does not call subprocess during unit tests unless explicitly mocked

## Safety

The adapter must be incapable of targeting the physical Motorola One Hyper.
