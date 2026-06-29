# Device Tree Audit Checklist

Status: required-before-source-promotion

Date: 2026-06-28

## Purpose

Define the audit gate for any Moto One Hyper / Motorola `def` device tree, recovery tree, common tree, or stock-derived source candidate.

A public source candidate must pass this audit before it can move beyond `reference-only`.

This checklist does not approve building.

This checklist does not approve flashing.

This checklist does not approve physical-device testing.

## Current rule

All public source candidates remain reference-only until reviewed.

A candidate may not become a build input until:

- source identity is recorded
- license/provenance is reviewed
- target compatibility is reviewed
- stock firmware baseline exists
- partition assumptions are checked
- recovery path exists
- local validation passes
- physical-device mutation remains blocked unless separately approved

## Candidate identity

Record:

| Field | Value |
|---|---|
| Candidate ID | TBD |
| Repository | TBD |
| Owner | TBD |
| URL | TBD |
| Default branch | TBD |
| Reviewed branch/commit | TBD |
| Latest commit date | TBD |
| License | TBD |
| Android base | TBD |
| ROM/recovery target | TBD |
| Device codename(s) | TBD |
| Chipset/common family | TBD |
| Review date | TBD |
| Reviewer | TBD |

## Candidate type

Classify the candidate:

- full device tree
- recovery/TWRP tree
- common tree
- vendor tree
- kernel tree
- stock-derived dump
- proprietary-files map
- mixed/unknown

Current accepted use before audit:

- reference-only reading
- comparison against other candidates
- checklist-driven review
- no build usage
- no phone usage

## Initial compatibility checks

Verify:

- does it mention `def`
- does it mention `def_retail`
- does it target Moto One Hyper
- does it target XT2027-1 or compatible variant
- does it target Android 11 or explain Android-base mismatch
- does it target the correct chipset/common family
- does it depend on a common tree
- does it depend on a vendor tree
- does it depend on a kernel tree
- does it assume A/B slots
- does it assume dynamic partitions
- does it assume a recovery partition layout

## BoardConfig audit

Check for:

- TARGET_BOARD_PLATFORM
- TARGET_BOOTLOADER_BOARD_NAME
- TARGET_DEVICE
- TARGET_PRODUCT
- TARGET_KERNEL_SOURCE
- TARGET_KERNEL_CONFIG
- BOARD_BOOTIMG_HEADER_VERSION
- BOARD_KERNEL_CMDLINE
- BOARD_KERNEL_BASE
- BOARD_KERNEL_PAGESIZE
- BOARD_MKBOOTIMG_ARGS
- BOARD_DTBOIMG_PARTITION_SIZE
- BOARD_BOOTIMAGE_PARTITION_SIZE
- BOARD_RECOVERYIMAGE_PARTITION_SIZE
- BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE
- BOARD_SUPER_PARTITION_SIZE
- BOARD_DYNAMIC_PARTITION_LIST
- BOARD_*_PARTITION_SIZE values
- AVB/vbmeta flags
- recovery flags
- filesystem assumptions

Questions:

- Are partition sizes present?
- Do sizes match verified stock metadata?
- Are dynamic partitions represented correctly?
- Are A/B assumptions explicit?
- Are boot image header assumptions compatible?
- Are kernel paths real?
- Are device names consistent?

## Product/makefile audit

Check for:

- AndroidProducts.mk
- device.mk
- lineage_*.mk or product makefiles
- inherit-product calls
- common tree inheritance
- vendor tree inheritance
- product name
- product device
- product brand
- product model
- build fingerprint assumptions
- shipping API level
- VNDK assumptions
- dynamic partition packages
- recovery packages
- init scripts
- overlays
- permissions XML

Questions:

- Does the product target match Moto One Hyper?
- Does the tree inherit from unknown or missing repos?
- Does it rely on proprietary files not present?
- Does it hardcode fingerprints from another build?
- Does it imply another regional variant?

## Fstab and partition audit

Check for:

- fstab files
- recovery fstab
- vendor fstab
- first_stage_mount entries
- logical partition names
- slotselect flags
- avb flags
- encryptable/fileencryption flags
- metadata partition references
- dynamic partition mapping
- super partition references
- filesystem types

Questions:

- Does fstab match stock partition naming?
- Does it assume partitions that do not exist?
- Does it omit partitions required by stock?
- Does it touch risky partitions?
- Does it define mount behavior that could break boot?

## Init and services audit

Check for:

- init*.rc files
- device-specific init scripts
- vendor init scripts
- ueventd files
- permissions files
- power HAL/service assumptions
- display service assumptions
- camera service assumptions
- fingerprint service assumptions
- sensor service assumptions

Questions:

- Are services stock-compatible?
- Are vendor services referenced but missing?
- Are device paths hardcoded?
- Are permissions overly broad?
- Are there references to another device?

## SELinux/sepolicy audit

Check for:

- sepolicy directories
- file_contexts
- genfs_contexts
- property_contexts
- service_contexts
- hwservice_contexts
- vendor policy
- private/public policy split
- permissive domains
- neverallow workarounds

Questions:

- Does the policy look current for target Android base?
- Does it depend on missing vendor policy?
- Does it mark dangerous domains permissive?
- Does it appear copied from another device?
- Does it conflict with target stock vendor behavior?

## Kernel audit

Check for:

- kernel source reference
- kernel branch
- defconfig
- prebuilt kernel usage
- modules
- dtb/dtbo handling
- clang/gcc assumptions
- Android kernel version
- kernel header expectations

Questions:

- Is kernel source available?
- Is defconfig identified?
- Does kernel base match target device?
- Are modules expected from vendor?
- Is dtbo generated or stock-provided?
- Is the tree using stale prebuilts?

## Vendor/proprietary audit

Check for:

- proprietary-files.txt
- extract-files.sh
- setup-makefiles.sh
- vendor makefiles
- blob lists
- pinned blob paths
- pinned sha1 values
- firmware expectations
- odm/vendor/product blob split

Questions:

- Does it require blobs from a stock build?
- Which stock build?
- Are blobs committed improperly?
- Does it assume Android 10 blobs for Android 11 target?
- Does it rely on inaccessible proprietary files?
- Does it include anything that should not be committed?

## AVB/vbmeta audit

Check for:

- vbmeta flags
- AVB enable/disable assumptions
- chained vbmeta references
- hashtree assumptions
- verity assumptions
- rollback index assumptions
- userdebug/test-keys assumptions

Questions:

- Does the candidate require disabling verification?
- Does it require flashing vbmeta?
- Does it require blank vbmeta?
- Does it assume AVB state changes?
- Is rollback behavior understood?

## Slot/A-B audit

Check for:

- AB_OTA_UPDATER
- slotselect fstab flags
- boot_a/boot_b assumptions
- system_a/system_b assumptions
- dynamic partition slot behavior
- update_engine assumptions
- payload generation assumptions

Questions:

- Does the tree clearly support A/B?
- Does it assume non-A/B behavior?
- Does it require slot switching?
- Is rollback slot behavior understood?

## Dynamic partition audit

Check for:

- super partition values
- dynamic partition group names
- logical partition list
- product/system/system_ext/vendor/odm assumptions
- lpmake assumptions
- sparse image generation
- retrofit dynamic partition assumptions

Questions:

- Does dynamic layout match verified stock metadata?
- Are group sizes accurate?
- Are logical partition names accurate?
- Are image sizes plausible?
- Is super mutation avoidable?

## Recovery/TWRP-specific audit

For recovery trees, check:

- recovery fstab
- crypto/decryption support
- touchscreen/display assumptions
- vendor_boot/recovery architecture
- boot-as-recovery assumptions
- dynamic partition handling
- backup/restore partition list
- excluded dangerous partitions
- mount behavior

Questions:

- Is it a recovery tree only?
- Does it incorrectly imply full ROM support?
- Does it support Android 11 encryption?
- Does it risk backing up/restoring forbidden partitions?
- Does it require flashing recovery before stock recovery path exists?

## Red flags

Mark candidate as blocked if:

- it targets a different device
- it targets a different chipset without explanation
- it lacks license/provenance
- it requires committed proprietary blobs
- it requires flashing vbmeta without review
- it requires modem/radio changes
- it requires bootloader changes
- it references unknown partitions
- it contains dangerous scripts
- it assumes a stock build that is not available
- it cannot be mapped to verified firmware metadata
- it requires physical testing before recovery path exists

## Promotion criteria

A candidate can move from `reference-only` to `candidate` only if:

- identity is recorded
- license/provenance is acceptable
- it plausibly targets `def`
- it does not require immediate physical-device mutation
- dependencies are known
- risk areas are documented
- missing pieces are explicit
- local validation passes after report update

A candidate can move from `candidate` to `partial` only if:

- at least one component is useful
- that component is bounded
- compatibility is documented
- it does not require unsafe assumptions
- it is tied to verified stock metadata

A candidate can move to `build-input` only after:

- stock firmware baseline exists
- recovery path exists
- partition matrix is updated
- firmware inventory exists
- source audit is complete
- build environment is reproducible
- no proprietary payloads are committed
- physical-device testing remains separately gated

## Required output report

For each audited source, create:

- reports/source_audit_<candidate-id>.md

The report must include:

- final classification
- useful components
- rejected components
- unresolved questions
- risk summary
- dependency list
- evidence reviewed
- next action

## Current decision

No source candidate is currently approved as a build input.

All public source candidates remain reference-only.
