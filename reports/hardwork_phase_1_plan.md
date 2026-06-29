# Hard Work Phase 1 Plan

Status: active-planning

Date: 2026-06-28

## Purpose

Move from documentation-only safety work into evidence acquisition and real source/firmware analysis while preserving the no-phone-touch boundary.

This phase begins the hard work without mutating the physical phone.

## Phase boundary

Allowed in this phase:

- create local-only workspace outside the repository
- clone public source candidates outside the repository
- inspect actual source files
- audit BoardConfig, fstab, init, sepolicy, kernel references, and proprietary file maps
- search firmware sources deeply
- record firmware candidate metadata
- download firmware only outside the repository if a candidate is selected
- compute checksums
- extract firmware outside the repository
- inventory extracted images
- produce reports and metadata in the repository

Forbidden in this phase:

- touching the physical phone
- flashing
- fastboot boot
- fastboot flash
- fastboot erase
- fastboot format
- sideloading
- slot switching
- AVB/vbmeta mutation
- committing firmware archives
- committing extracted images
- committing vendor blobs
- committing proprietary binaries
- committing private identifiers

## Local workspace

The local-only workspace is:

C:\Projects\moto-one-hyper-local

Expected layout:

- firmware
- extracted
- sources
- audits
- tools
- checksums
- logs

The workspace is created by:

scripts/init_local_hardwork_workspace.ps1

## Evidence acquisition sequence

### Step 1 - Initialize local workspace

Run:

.\scripts\init_local_hardwork_workspace.ps1

Expected result:

- local-only directories exist
- README exists in local workspace
- no repo-tracked firmware or blobs are created

### Step 2 - Clone source candidates outside repo

Clone public source candidates into:

C:\Projects\moto-one-hyper-local\sources

Initial candidates:

- ixmoe/android_device_motorola_def_twrp
- Nandru86/android_device_motorola_def_twrp
- AndroidBlobs/device_motorola_def
- ludevjhon/device_motorola_def
- Fraaxius/device_motorola_sm6150-common

These clones are not build inputs.

They are audit inputs only.

### Step 3 - Source audit reports

For each candidate, create a report in the repository:

- reports/source_audit_ixmoe_def_twrp.md
- reports/source_audit_nandru86_def_twrp.md
- reports/source_audit_androidblobs_def.md
- reports/source_audit_ludevjhon_def.md
- reports/source_audit_fraaxius_sm6150_common.md

Each report must classify the source as:

- reference-only
- candidate
- partial
- blocked

No source may become build-input during this phase.

### Step 4 - Firmware metadata search

Search for exact or compatible firmware metadata for:

- XT2027-1
- def_retail
- retus
- Android 11
- RPFS31.Q1-21-20-1-7-3

Record only metadata first.

If a candidate package is selected, download it outside the repository only.

### Step 5 - Firmware verification

For any downloaded firmware package:

- store outside repository
- compute SHA256
- record filename and size
- extract outside repository
- inventory images
- create firmware inventory report
- keep all firmware/images/blobs out of Git

### Step 6 - Partition evidence

After verified firmware extraction:

- identify boot-related images
- identify super/dynamic partition metadata
- identify vbmeta artifacts
- identify modem/radio/bootloader areas
- update partition risk matrix with evidence
- do not flash anything

## Practical hard-work definition

This phase counts as hard work because it produces evidence from real artifacts:

- real cloned source files
- real BoardConfig values
- real fstab entries
- real source dependencies
- real firmware candidate metadata
- real checksums if firmware is obtained
- real extraction inventory if firmware is obtained
- real partition-risk evidence

## Current decision

No physical-phone action is authorized.

Hard work starts with local-only evidence acquisition and source audits.
