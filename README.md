# Moto One Hyper ForgeWire ROM Lab

Evidence-gated Android ROM research lab for the Motorola One Hyper, ForgeWire Android integration, and future ForgeLink / ForgeWire Fabric control surfaces.

This repository is not a finished ROM. It is not a flashing package. It is not a rescue tool.

## Current status

Working:

- Android 15 API 35 generic x86_64 emulator boots on the Windows host
- known-good emulator launch path is committed
- read-only emulator ADB bridge is committed
- bridge contract, operation catalog, protocol, runner, and tests are committed
- governance validation and unit tests pass

Not claimed:

- no finished Motorola One Hyper ROM
- no device-specific ROM boot
- no verified stock boot image yet
- no verified full stock firmware package yet
- no root claim
- no phone flashing workflow

## Safety boundary

The physical Motorola One Hyper is out of scope for destructive actions.

This repository must not be used to flash, erase, wipe, relock, sideload, repair, rescue, or otherwise write to a physical phone without explicit current-session approval from the device owner.

The current bridge work targets the Android Emulator only. It selects emulator serials matching this pattern:

    ^emulator-[0-9]+$

It must not target physical Android device serials.

## Why this exists

ForgeWire needs an Android-side lab for future mobile integration.

The long-term direction is a ForgeWire-aware Android environment that can integrate with ForgeLink and ForgeWire Fabric while preserving strict safety boundaries.

The immediate path is intentionally conservative:

1. collect device facts
2. verify source and firmware viability
3. prove generic emulator boot
4. build read-only emulator inspection surfaces
5. define adapter contracts before integration
6. only consider physical-device mutation after exact stock recovery paths are solved

## Repository structure

- rom_lab/ - emulator, bridge, device profile, source review, and ROM-lab reports
- rom_lab/bridge/ - contract-gated read-only emulator bridge surface
- rom_lab/scripts/ - host and emulator helper scripts
- tests/ - safety, profile, bridge contract, operation, runner, and protocol tests
- scripts/ - governance validation and repo support scripts
- firmware/ - placeholder area for firmware research metadata only
- evidence/, reports/, audits/, decisions/ - evidence-gated project records

## Bridge stack

The current emulator bridge is layered as:

    contract -> operations -> protocol -> runner -> implementation

Key files:

- rom_lab/bridge/emulator_readonly_contract.json
- rom_lab/bridge/emulator_readonly_operations.json
- rom_lab/bridge/emulator_readonly_protocol.json
- rom_lab/bridge/run_readonly_bridge.ps1
- rom_lab/scripts/invoke_emulator_adb_readonly.ps1

The bridge exposes named read-only modes only. It does not expose arbitrary shell execution.

## Validation

Run:

    python scripts/validate_repo.py
    python -m unittest discover -s tests -v

Expected current state: governance validation passes and all tests pass.

## Emulator launch

Known-working emulator launch script:

    powershell -ExecutionPolicy Bypass -File .\rom_lab\scripts\start_api35_working_emulator.ps1

Contract-gated read-only bridge runner:

    powershell -ExecutionPolicy Bypass -File .\rom_lab\bridge\run_readonly_bridge.ps1 -Mode identity

## Public warning

Do not treat this repository as a ready-to-flash Android ROM.

Do not run commands against a physical phone unless you understand the repo safety model and have explicit approval for the exact action.

## License

Apache-2.0, unless otherwise noted.

## Local validation

GitHub Actions is not required for this lab. Run local validation before committing:

```powershell
.\scripts\validate_local.ps1
```

Details:

- [Local validation guide](docs/local-validation.md)
- [Latest local validation status](reports/local_validation_status.md)

## ROM source roadmap

The current ROM path is planning-only and emulator-safe. See:

- [ROM source and device-tree roadmap](reports/rom_source_device_tree_roadmap.md)

## Source candidate inventory

Public device-tree and common-tree leads are tracked as reference-only research inputs:

- [Source candidate inventory](reports/source_candidate_inventory.md)
