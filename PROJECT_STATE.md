# Project State

## Project

Moto One Hyper ForgeWire ROM Lab

## Public repository

https://github.com/ForgeWireLabs/moto-one-hyper-forgewire-rom-lab

## Current branch

main

## Current public checkpoint

v0.1.0-public-lab

## Purpose

This repository is an evidence-gated Android ROM research lab for the Motorola One Hyper, ForgeWire Android integration, and future ForgeLink / ForgeWire Fabric control surfaces.

It is not a finished ROM, not a flashing package, and not a rescue tool.

## Current status

Working:

- Android 15 API 35 generic x86_64 emulator boot validated on the Windows host
- known-good emulator launch path committed
- read-only emulator ADB bridge committed
- bridge contract committed
- operation catalog committed
- adapter protocol committed
- contract-gated runner committed
- governance validation passes
- unit tests pass

Not claimed:

- no finished Motorola One Hyper ROM
- no device-specific ROM boot
- no verified stock boot image yet
- no verified full stock firmware package yet
- no root claim
- no physical-phone flashing workflow

## Safety boundary

The physical Motorola One Hyper is out of scope for destructive actions.

Do not run any command or GUI action that rescues, repairs, flashes, erases, relocks, wipes, sideloads, or otherwise writes firmware to an attached phone unless Jeremy explicitly approves that exact action in the current session.

Bridge work remains emulator-only unless a later work item explicitly changes scope and passes review.

## Current architecture

The emulator bridge is layered as:

    contract -> operations -> protocol -> runner -> implementation

Key files:

- rom_lab/bridge/emulator_readonly_contract.json
- rom_lab/bridge/emulator_readonly_operations.json
- rom_lab/bridge/emulator_readonly_protocol.json
- rom_lab/bridge/run_readonly_bridge.ps1
- rom_lab/scripts/invoke_emulator_adb_readonly.ps1

## Near-term direction

1. Make work state explicit and durable.
2. Add a JSON response wrapper for the emulator bridge.
3. Add a thin ForgeLink-facing adapter stub.
4. Continue firmware/source viability work without phone mutation.
5. Define the ForgeWire Android ROM direction as a staged roadmap.
6. Keep all physical-device write actions blocked until exact stock recovery paths are verified.

## Agent instructions

Read this file after AGENTS.md and README.md.

Treat work items in work/ as the active planning surface.

Do not rely on chat history for critical state. Record meaningful project state in versioned files.
