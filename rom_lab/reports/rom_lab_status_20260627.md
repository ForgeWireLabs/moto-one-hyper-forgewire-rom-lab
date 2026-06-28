# ROM Lab Status

Date: 2026-06-27

## Can we build a true Moto One Hyper custom ROM tonight?

Unlikely. A true `def` build is blocked by missing verified stock firmware,
vendor blobs, a verified def-specific device tree, selected SM6150 kernel source,
BoardConfig, dynamic partition metadata, sepolicy, init/fstab integration, and
hardware validation gates.

## Can we build or acquire a modern GSI-style ROM tonight?

Likely yes for acquisition and generic lab testing, assuming a trusted GSI
release is selected, downloaded outside git, hashed, and booted only in an
emulated or generic test environment. That still does not prove physical Motorola
One Hyper compatibility.

## Can we test a modern Android image in emulator tonight?

Yes, if the host has a working Android Emulator or a Linux/Cuttlefish-capable
environment. A generic emulator image can validate boot, adb shell, logcat,
package manager, and ForgeLink command-path behavior.

## What is blocked by missing stock firmware or vendor blobs?

- exact stock boot image verification
- proprietary blob extraction
- vendor HAL compatibility
- rollback image confidence
- dynamic partition metadata confidence
- safe real-device test planning

## What is blocked by missing device tree?

- `def` product build target
- BoardConfig
- fstab/init integration
- recovery/fastbootd integration
- sepolicy
- device-specific kernel and DTBO integration

## What can be done safely without touching the phone?

- maintain this ROM lab
- research source candidates
- build a generic AOSP or LineageOS image
- test generic Android images in emulator or Cuttlefish
- acquire and hash GSI packages outside git
- inspect public device tree/kernel candidates
- draft device bring-up files
- validate RepoPact and ROM lab safety rules

## Recommended modern ROM base

Use a GSI-first strategy for the next practical boot test. For source builds,
prefer a current LineageOS branch for custom-ROM ergonomics or official AOSP
`android-latest-release` for generic emulator/Cuttlefish validation. A device
specific `def` Lineage build should wait until tree, kernel, and vendor inputs
are verified.

## Current decision

Proceed with emulator/GSI lab work first. Do not flash the physical phone.

