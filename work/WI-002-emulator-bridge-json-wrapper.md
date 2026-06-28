# WI-002 - Emulator Bridge JSON Wrapper

Status: proposed

## Goal

Add a small wrapper around the contract-gated emulator bridge runner that returns a structured JSON response.

## Why

ForgeLink and ForgeWire Fabric should not parse raw PowerShell console output directly. They need a stable response shape with success status, mode, target, stdout, stderr, and exit code.

## Scope

In scope:

- wrapper script or Python adapter that calls the existing contract-gated runner
- JSON response envelope matching emulator_readonly_protocol.json
- tests that validate response shape without requiring a live emulator
- documentation of expected wrapper behavior

Out of scope:

- arbitrary ADB command support
- physical device serial selection
- fastboot exposure
- write actions
- live phone interaction

## Deliverables

- a wrapper implementation
- tests for request validation and response shape
- docs linking wrapper behavior to the protocol

## Acceptance

- invalid modes are rejected
- forbidden request fields are rejected
- target remains emulator-only
- response includes ok, mode, target, stdout, stderr, and exit_code
- tests pass without requiring a live emulator

## Safety

The wrapper must delegate target selection to the existing contract-gated runner and must not accept physical device serials.
