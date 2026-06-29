# No Phone Touch Policy

Status: active-policy

Date: 2026-06-28

## Purpose

Define the default safety boundary for the physical Motorola One Hyper device.

The physical phone is out of scope by default.

This project may continue with emulator work, documentation, planning, local validation, source review, firmware metadata review, and no-device tooling.

The project must not touch, mutate, flash, repair, erase, sideload, reboot, or otherwise operate on the physical phone unless a current-session gate review approves one exact action.

## Default rule

No physical phone access is allowed by default.

The default approved target is:

- Android emulator only
- local repository files
- local documentation
- local validation scripts
- public source research
- local-only firmware metadata review

The physical device is not an assumed test target.

## Known physical device

Known physical device context:

- Device: Motorola One Hyper
- Model: XT2027-1
- Product/codename: def / def_retail
- Channel: retus
- Build: RPFS31.Q1-21-20-1-7-3
- Previously observed real-device serial: ZY227JQC67

The serial is documented here only as a safety marker so scripts and future agents know that this is the physical device, not the emulator.

Do not use this serial as an execution target.

## Safe target

The only default execution target is an emulator matching this pattern:

- emulator-*

Examples:

- emulator-5554
- emulator-5556

Bridge scripts must select emulator targets only.

## Forbidden physical-device actions

The following are forbidden on the physical phone unless a written gate review and current-session approval exist:

- adb push
- adb pull from sensitive/private paths
- adb install
- adb uninstall
- adb reboot
- adb reboot bootloader
- adb reboot recovery
- adb sideload
- adb root
- adb remount
- adb shell commands that write device state
- dd to block devices
- mount/remount write operations
- mkfs
- fastboot boot
- fastboot flash
- fastboot erase
- fastboot format
- fastboot update
- fastboot oem
- fastboot flashing lock
- fastboot flashing unlock
- fastboot set_active
- rescue tools
- repair tools
- relocking
- slot switching
- AVB/vbmeta mutation
- bootloader mutation
- partition mutation
- modem/radio mutation
- persist mutation
- EFS-like identity/calibration mutation
- partition-table mutation
- unknown vendor utility execution

## Forbidden partition areas

The following areas are never default-safe:

- modem/radio
- persist
- EFS-like identity/calibration partitions
- bootloader
- partition table/GPT
- FRP
- carrier/security/calibration partitions
- unknown partitions
- vbmeta/AVB state
- dtbo
- super/dynamic partition container

## Allowed without physical-device approval

Allowed work:

- edit repository docs
- edit safety reports
- run repository validation
- run unit tests
- run local validation
- inspect public repositories
- create source audit reports
- create firmware metadata reports
- compute checksums of local firmware archives stored outside the repo
- extract firmware archives stored outside the repo for metadata inventory
- run emulator-only bridge commands
- run emulator-only ForgeLink adapter tests
- create mock/no-op build planning scripts

## Required approval path

Before any physical-device action, all of these must be true:

1. A physical flash gate review exists.
2. The exact command is written in the gate review.
3. The exact target is written in the gate review.
4. The expected effect is written in the gate review.
5. The rollback plan is written in the gate review.
6. Stock firmware recovery anchor exists.
7. Firmware inventory exists.
8. Stock recovery/reflash plan exists.
9. Partition risk matrix is updated.
10. Local validation passes.
11. Jeremy approves the exact command in the current session.

No standing approval carries across sessions.

## Agent behavior requirement

Any agent working in this repository must treat the phone as unavailable unless the current task explicitly says otherwise and cites the completed gate review.

If a user asks for a physical-device action without the full gate, the agent must stop and request completion of the gate review first.

If an agent detects both an emulator and a physical device, it must select the emulator only.

If target selection is ambiguous, the agent must stop.

## Command wording policy

Future instructions must distinguish between:

- emulator action
- local repo action
- local firmware metadata action
- physical phone action

If an instruction says only "device", "phone", "ADB", or "fastboot" without an explicit target, it is considered ambiguous and must not execute.

## Current decision

No physical-phone action is authorized.

The project remains emulator-first and documentation-first.
