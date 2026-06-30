# WI-006 - ROM Source and Device Tree Roadmap

Status: proposed

## Goal

Define the staged path from ROM lab to possible Moto One Hyper ForgeWire Android ROM work.

## Why

The project needs a realistic roadmap before attempting device-specific ROM work. The roadmap should separate generic emulator integration from actual Motorola One Hyper build requirements.

## Scope

In scope:

- source viability review
- kernel/source availability notes
- LineageOS/AOSP device tree research
- vendor blob requirements
- build host requirements
- staged roadmap for emulator, GSI, device tree, and device-specific work
- clear gates before any phone mutation

Out of scope:

- building a flashable ROM
- flashing a phone
- root workflows
- bypassing firmware recovery requirements

## Deliverables

- ROM roadmap document
- source/device tree gap list
- staged gate checklist
- risk notes

## Acceptance

- roadmap distinguishes emulator, GSI, and device-specific ROM work
- blockers are explicit
- required artifacts are listed
- no physical-device write action is recommended without recovery proof

## Safety

Planning only.
