# Source Candidate Inventory

Status: reference-only

Date: 2026-06-28

## Purpose

Inventory public Moto One Hyper / Motorola `def` source candidates for future review.

This file does not approve any source tree for building.

This file does not authorize physical-device testing.

This file does not authorize flashing, booting custom images, partition writes, sideloading, or firmware mutation.

## Current project boundary

The project is currently safe because it is limited to:

- emulator-only bridge work
- documentation
- local validation
- source research
- planning reports
- no physical-device mutation

The physical Motorola One Hyper remains out of scope unless Jeremy explicitly approves the exact current-session action.

## Candidate summary

| Candidate | Type | Branch / base | Status | Initial risk | Current use |
|---|---|---:|---|---|---|
| ixmoe/android_device_motorola_def_twrp | recovery/device tree | android-10 | public lead | medium/high | reference-only |
| Nandru86/android_device_motorola_def_twrp | recovery/device tree | android-10 | public lead | medium/high | reference-only |
| AndroidBlobs/device_motorola_def | stock-derived device files | def_retail Android 10 build lineage | public lead | high | reference-only |
| ludevjhon/device_motorola_def | stock-derived device files / mirror-like lead | def_retail Android 10 build lineage | public lead | high | reference-only |
| Fraaxius/device_motorola_sm6150-common | common tree | lineage-21 | public lead | medium/high | reference-only |

## Candidate: ixmoe/android_device_motorola_def_twrp

Repository:

- ixmoe/android_device_motorola_def_twrp

Observed type:

- TWRP/recovery-oriented device tree for Motorola `def`

Observed branch/base:

- android-10

Potential value:

- BoardConfig reference
- recovery partition assumptions
- device naming conventions
- possible fstab/recovery flags
- def-specific recovery layout clues

Risks:

- recovery-only tree, not a full ROM device tree
- Android 10 era, while target observed stock build is Android 11
- may not match retus build RPFS31.Q1-21-20-1-7-3
- may have assumptions that are wrong for current stock state
- not sufficient for ROM bring-up

Current classification:

- reference-only

Before trusting:

- inspect BoardConfig
- inspect fstab
- inspect recovery flags
- inspect partition assumptions
- compare with verified stock metadata
- confirm no physical-device action is required

## Candidate: Nandru86/android_device_motorola_def_twrp

Repository:

- Nandru86/android_device_motorola_def_twrp

Observed type:

- TWRP/recovery-oriented device tree for Motorola `def`

Observed branch/base:

- android-10

Potential value:

- secondary recovery-tree reference
- comparison point against ixmoe tree
- useful for detecting copied, forked, or divergent assumptions

Risks:

- may be a fork or stale copy
- recovery-only scope
- Android 10 era
- may not map cleanly to Android 11 retus target state

Current classification:

- reference-only

Before trusting:

- compare commit history with ixmoe candidate
- compare BoardConfig and fstab content
- identify whether it adds unique evidence or only duplicates another source
- do not use as a primary source without verification

## Candidate: AndroidBlobs/device_motorola_def

Repository:

- AndroidBlobs/device_motorola_def

Observed type:

- stock-derived device files / extracted reference tree

Observed branch/base:

- def_retail-user-10-QPF30.104-b456f-release-keys

Potential value:

- possible stock-derived structure
- possible Android 10 def_retail partition and property references
- may help identify vendor/property naming

Risks:

- Android 10 build lineage, not target Android 11 build
- extracted/generated content may not be complete
- may not be suitable for ROM building
- may include stale vendor assumptions
- cannot substitute for verified firmware matching RPFS31.Q1-21-20-1-7-3

Current classification:

- reference-only

Before trusting:

- identify contents and source provenance
- compare against target build metadata
- verify whether files are generated from stock images
- avoid committing proprietary blobs
- avoid relying on it for build decisions without stock verification

## Candidate: ludevjhon/device_motorola_def

Repository:

- ludevjhon/device_motorola_def

Observed type:

- stock-derived device files / similar lead to AndroidBlobs candidate

Observed branch/base:

- def_retail-user-10-QPF30.104-b456f-release-keys

Potential value:

- comparison source for AndroidBlobs tree
- may confirm whether Android 10 def_retail extracted files are widely mirrored
- useful for diffing candidate assumptions

Risks:

- may be duplicate or fork-like content
- Android 10 base
- not verified against target Android 11 retus build
- cannot be trusted as a build source yet

Current classification:

- reference-only

Before trusting:

- compare to AndroidBlobs/device_motorola_def
- determine whether it has independent provenance
- mark duplicate assumptions clearly
- do not treat duplicate mirrors as independent evidence

## Candidate: Fraaxius/device_motorola_sm6150-common

Repository:

- Fraaxius/device_motorola_sm6150-common

Observed type:

- Motorola sm6150 common tree

Observed branch/base:

- lineage-21

Potential value:

- modern Lineage-style common tree reference
- may show current Android/Lineage conventions for sm6150 Motorola devices
- useful for understanding commonization boundaries
- may inform future source layout

Risks:

- common tree is not a device tree
- may not include Motorola One Hyper / def specifics
- lineage-21 assumptions may not fit this target
- may depend on device trees not yet identified
- cannot be treated as compatible without audit

Current classification:

- reference-only

Before trusting:

- identify supported device list
- inspect inherited makefiles
- inspect sepolicy/common init assumptions
- identify kernel/common dependencies
- determine whether `def` is actually represented elsewhere
- compare against verified stock metadata

## Trust model

A candidate becomes more trusted only after it passes a documented audit.

Trust levels:

- reference-only: useful for reading and comparison only
- candidate: worth deeper audit
- partial: one component may be useful, but not enough for build
- build-input: accepted as part of a reproducible build plan
- blocked: cannot be used safely

All current candidates are reference-only.

## Required audit fields

Every source candidate should be reviewed for:

- repository URL
- owner
- license
- default branch
- latest commit date
- Android base
- ROM/recovery target
- supported devices
- dependency graph
- kernel assumptions
- vendor blob assumptions
- BoardConfig content
- fstab content
- sepolicy content
- init scripts
- proprietary-files map
- partition assumptions
- dynamic partition assumptions
- A/B assumptions
- recovery/boot image assumptions
- known issues
- whether it requires physical-device testing

## Hard blockers

A candidate must not become a build input until these are solved:

- verified stock firmware baseline
- verified boot image
- verified stock recovery path
- verified target build compatibility
- no private identifiers committed
- no proprietary blobs committed
- local validation still passes
- explicit gate review before any real-device operation

## Near-term next actions

Safe next actions:

1. Create `reports/device_tree_audit_checklist.md`.
2. Create `reports/firmware_acquisition_checklist.md`.
3. Add a source-candidate review template.
4. Optionally clone candidates outside the repo for inspection only.
5. Record findings as reports, not as trusted build inputs.

Do not place external source trees directly inside this repository.

Do not commit downloaded firmware, images, blobs, generated build outputs, or private identifiers.
