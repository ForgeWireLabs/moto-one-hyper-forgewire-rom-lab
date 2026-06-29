# Flash Safety and Recovery Strategy

Status: required-before-physical-flash

Date: 2026-06-28

## Purpose

Define the safety model that must exist before this project performs any physical-device flashing or mutation.

The goal is not to make flashing risk-free. That is impossible.

The goal is to make every future physical-device action:

- deliberate
- documented
- reversible when possible
- bounded to one exact operation
- blocked unless a recovery path exists
- approved explicitly by Jeremy in the current session

## Core position

The Android emulator is not a hardware-perfect Moto One Hyper emulator.

The emulator is useful for:

- control-plane testing
- bridge testing
- JSON/protocol validation
- ForgeLink adapter testing
- local validation
- no-device automation work

The emulator is not sufficient for proving:

- bootloader behavior
- kernel compatibility
- vendor HAL compatibility
- modem behavior
- display behavior
- camera behavior
- fingerprint behavior
- sensor behavior
- real partition layout behavior
- AVB/vbmeta interactions
- slot switching behavior
- recovery from a failed boot image

Therefore, the safety plan must be based on verified recovery capability, not on confidence from emulation alone.

## Required invariant

No physical flash work begins until a verified stock recovery path exists.

This means:

- matching or safely compatible stock firmware has been acquired
- checksums are recorded
- archive/extraction process is reproducible
- stock boot/recovery/vendor images are available locally if applicable
- the restore path is documented
- partition risk is understood
- the exact physical command is approved in the current session

## Hard rule

A custom image is never flashed first.

Before any custom physical-device image is flashed, the project must prove it can reason about returning to stock.

## Gate model

### Gate 0 - State capture

Required before any physical-device mutation:

- exact model recorded
- exact build recorded
- channel recorded
- product/codename recorded
- bootloader state recorded
- active slot recorded
- host tooling version recorded
- no serial, IMEI, UID, or private identifiers committed

Current known baseline:

- Motorola One Hyper XT2027-1
- product/codename: def / def_retail
- channel: retus
- build: RPFS31.Q1-21-20-1-7-3
- bootloader: previously observed unlocked / orange AVB state
- active slot: previously observed _a

### Gate 1 - Stock recovery anchor

Required before any physical flash:

- verified stock firmware package
- source captured
- checksums captured
- extraction procedure documented
- images inventoried
- forbidden partitions identified
- recovery/reflash plan written
- local validation passing

Blocked until complete.

### Gate 2 - Partition risk matrix

Required before any physical flash:

- partition names known
- risk category assigned
- safe/unsafe restore behavior documented
- never-touch partitions marked
- slot behavior documented
- dynamic partition behavior documented

Blocked until complete.

### Gate 3 - Non-destructive rehearsal

Required before any physical flash:

- all local validation passes
- command is written before execution
- expected effect is written before execution
- rollback plan is written before execution
- no unknown command flags
- no wildcard partition operations
- no multi-command mutation batch

Blocked until complete.

### Gate 4 - First physical mutation

Required before execution:

- exact command written
- exact target written
- exact expected effect written
- rollback command written
- stock recovery path available
- Jeremy explicitly approves that exact command in the current session

No standing approval carries across sessions.

## Allowed now

Allowed before firmware/recovery gate:

- emulator-only bridge work
- public source research
- reports and checklists
- local validation
- no-device scripts
- parsing already-downloaded local firmware archives
- checksum recording
- source inventory
- partition risk planning
- mock build orchestration
- documentation of commands without executing them

## Forbidden now

Forbidden until all gates pass and Jeremy approves the exact action:

- flashing
- erasing
- formatting
- sideloading
- fastboot boot
- fastboot flash
- fastboot erase
- fastboot format
- fastboot update
- fastboot oem
- fastboot flashing lock
- fastboot flashing unlock
- adb sideload
- adb remount
- adb root
- dd to block devices
- writing to partitions
- rescue/repair tools
- relocking bootloader
- changing AVB/vbmeta state
- changing slots as part of testing
- touching modem, persist, EFS-like, calibration, identity, bootloader, or partition-table areas

## Reverse engineering position

Full reverse engineering of every device driver is not a realistic prerequisite.

The safer path is:

- use OEM kernel/source where available
- use legally and technically appropriate stock vendor blobs
- audit public device trees as hypotheses only
- verify stock firmware before building
- avoid modem/calibration/identity partitions
- avoid committing proprietary blobs
- preserve a stock recovery path

## Brick-risk classes

### Soft failure

Examples:

- custom boot image does not boot
- recovery still accessible
- fastboot still accessible

Expected response:

- return to stock image
- do not continue testing
- document failure
- update risk matrix

### Semi-hard failure

Examples:

- bootloop
- slot confusion
- recovery unavailable but fastboot works

Expected response:

- stop
- use documented stock reflash path only
- do not improvise
- do not relock
- do not erase unknown partitions

### Hard failure

Examples:

- no fastboot
- no recovery
- no visible bootloader
- only Qualcomm emergency state, if exposed

Expected response:

- stop immediately
- no random repair tools
- reassess whether device-specific unbrick tooling exists
- do not use untrusted firmware packages
- do not attempt paid/opaque rescue tools without separate review

## Required documents before physical flash

The following reports must exist before any physical flash path:

- reports/flash_safety_and_recovery_strategy.md
- reports/stock_recovery_and_reflash_plan.md
- reports/partition_risk_matrix.md
- reports/firmware_acquisition_checklist.md
- reports/device_tree_audit_checklist.md

## Recommendation

The project should continue in this sequence:

1. Finish safety and recovery documents.
2. Acquire verified stock firmware.
3. Inventory stock firmware contents.
4. Build partition risk matrix.
5. Audit source candidates.
6. Only then consider build-environment setup.
7. Only after that consider a physical-device gate review.
