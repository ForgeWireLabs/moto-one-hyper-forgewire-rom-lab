# ROM Source and Device-Tree Roadmap

Status: planning

Date: 2026-06-28

## Purpose

Define the safe path from the current emulator-only ROM lab toward a possible Moto One Hyper custom ROM research track.

This is not a flashing plan.

This is not a device mutation plan.

This is not a claim that a bootable ROM exists.

The physical Motorola One Hyper remains out of scope until explicit approval is given for an exact current-session action.

## Known device baseline

Device:

- Motorola One Hyper XT2027-1
- Codename/product: def / def_retail
- Channel: retus
- Android build: RPFS31.Q1-21-20-1-7-3
- Active slot observed previously: _a
- Bootloader state observed previously: unlocked / orange AVB state

Current constraints:

- no verified stock boot image
- no verified full stock firmware package
- no verified vendor partition extraction
- no verified device-specific kernel source checkout
- no physical-device write actions permitted

## Current safe foundation

Already working:

- API 35 x86_64 emulator launch path
- emulator-only ADB bridge
- bridge contract
- operation catalog
- protocol definition
- contract-gated runner
- JSON wrapper
- ForgeLink adapter stub
- local validation script
- repository governance validation
- 50 unit tests passing

This means the lab currently has a safe control plane and validation substrate, but not a ROM build substrate.

## Source tree target options

### Option A - Recovery/TWRP-first research

Goal:

Use existing public `def` recovery/device-tree material as a reference to understand partition layout, board config conventions, and device naming.

Possible public leads:

- ixmoe/android_device_motorola_def_twrp
- Nandru86/android_device_motorola_def_twrp

Use only as reference until reviewed.

Pros:

- smaller surface than full ROM
- useful for BoardConfig and recovery partition assumptions
- helps identify def-specific naming and partition expectations

Cons:

- Android 10 era material may be stale
- recovery tree is not a full ROM device tree
- may not match Android 11 retus build state

### Option B - Stock-derived tree reconstruction

Goal:

Build a device understanding from verified stock firmware, extracted metadata, and public kernel/source leads.

Required before active work:

- verified firmware package matching or safely compatible with RPFS31.Q1-21-20-1-7-3 retus
- verified boot image
- verified vendor image or extracted vendor blobs
- extracted partition metadata
- reproducible extraction script
- redaction of serial/IMEI/private identifiers

Pros:

- safest basis for a real device-specific roadmap
- avoids guessing from stale public trees
- preserves stock recovery path

Cons:

- currently blocked by lack of verified firmware
- cannot proceed to real build work yet

### Option C - Lineage/common-tree research

Goal:

Investigate whether `def` can align with broader Motorola `sm6150-common` work.

Possible public lead:

- Fraaxius/device_motorola_sm6150-common, lineage-21 branch

Use only as reference until reviewed.

Pros:

- may expose current Android/Lineage conventions
- useful for common device abstractions
- may inform future source layout

Cons:

- common tree alone is not device support
- may target different devices
- cannot be treated as compatible without diff/audit

## Required source components for a real ROM track

A real ROM build track would need:

- device tree
- common tree, if applicable
- kernel source and defconfig
- vendor blobs
- proprietary-files.txt or equivalent extraction map
- sepolicy
- init files
- fstab
- partition map
- BoardConfig
- product makefiles
- verified firmware baseline
- build target definition
- recovery and boot image strategy
- rollback/safety plan

None of these are currently complete.

## Emulator-only work allowed now

Allowed:

- document source candidates
- inspect public repositories
- compare tree structures
- create source-audit checklists
- create extraction scripts that operate only on already-downloaded local firmware files
- create redaction tests
- create metadata parsers
- create build-environment notes
- create no-op/mock build orchestration
- create emulator bridge tests
- create ForgeLink integration tests against emulator-only bridge

Not allowed without explicit approval:

- touching the physical phone
- flashing
- booting custom images on the phone
- erasing partitions
- formatting partitions
- sideloading
- relocking or unlocking bootloader
- rescue/repair operations
- pushing files to device partitions
- using dd against block devices

## Blocked work

Blocked until verified firmware exists:

- boot image patching
- vendor blob extraction from physical device
- device-specific kernel build validation
- ROM image build targeting physical def
- recovery image build for physical def
- fastboot test flow
- sideload test flow
- partition write testing

Blocked until explicit operator approval:

- any physical-device command that mutates state
- any firmware write operation
- any boot/recovery image test on real hardware

## Near-term plan

### Step 1 - Source candidate inventory

Create a source inventory report containing:

- repository name
- repository type
- branch
- apparent Android base
- freshness
- relevance to def
- risk
- whether it is reference-only or potentially usable

### Step 2 - Firmware acquisition checklist

Create a checklist for matching stock firmware:

- model XT2027-1
- product def_retail
- channel retus
- build RPFS31.Q1-21-20-1-7-3
- Android 11
- checksum captured
- source captured
- extraction reproducible
- no private identifiers committed

### Step 3 - Device-tree audit checklist

Create an audit checklist for any candidate tree:

- BoardConfig sanity
- partition names
- dynamic partition handling
- A/B assumptions
- kernel path
- vendor dependencies
- proprietary files
- sepolicy age
- init scripts
- fstab
- recovery flags
- product makefiles

### Step 4 - Mock build lane

Create a no-device, no-flash build planning lane:

- source sync documentation
- dependency list
- expected directory layout
- local disk-space requirements
- no-op validation script
- artifacts ignored by git
- no generated images committed

### Step 5 - Gate review

Before any physical-device operation, require a written gate review:

- exact command
- exact target
- expected effect
- rollback plan
- evidence that stock recovery path exists
- explicit approval from Jeremy in the current session

## Recommendation

Stay on the emulator/control-plane path until firmware verification is solved.

The next safe engineering artifact should be:

- reports/source_candidate_inventory.md

After that:

- reports/firmware_acquisition_checklist.md
- reports/device_tree_audit_checklist.md

Only after those exist should the project consider a build-environment setup.
