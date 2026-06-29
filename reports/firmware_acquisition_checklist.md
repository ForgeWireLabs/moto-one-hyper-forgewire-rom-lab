# Firmware Acquisition Checklist

Status: blocked-pending-verified-firmware

Date: 2026-06-28

## Purpose

Define the requirements for accepting a stock firmware package as the recovery anchor for the Moto One Hyper ROM lab.

No firmware package is trusted until identity, provenance, checksum, contents, and extraction have been recorded.

## Safety position

Physical flashing remains blocked.

This checklist does not authorize flashing, erasing, formatting, sideloading, fastboot boot, fastboot flash, rescue/repair tools, bootloader relocking, partition mutation, or phone write operations.

## Target identity

The preferred firmware must match:

- Motorola One Hyper
- XT2027-1
- def / def_retail
- retus
- Android 11
- RPFS31.Q1-21-20-1-7-3

A close-looking build is not enough.

## Required acquisition record

Each candidate firmware package must record:

- candidate ID
- source name
- source URL or origin
- download date
- filename
- file size
- SHA256
- archive type
- password requirement
- payment/login requirement
- claimed model
- claimed channel
- claimed build
- claimed Android version
- notes

## Trust levels

- unknown: source has not been reviewed
- weak: unofficial mirror, incomplete metadata, or unclear provenance
- moderate: public source with consistent metadata and downloadable package
- strong: official or highly trusted source with matching metadata
- verified-local: downloaded, checksummed, extracted, and inventoried locally

No firmware may be used as a recovery anchor until it reaches verified-local.

## Rejection criteria

Reject or quarantine a firmware candidate if:

- model does not match
- product/codename does not match
- channel conflicts with target
- Android generation conflicts unexpectedly
- build is older/newer without compatibility review
- archive contents are incomplete
- checksum cannot be recorded
- archive cannot be extracted reproducibly
- package source is opaque
- package requires suspicious executable tooling
- package includes unknown scripts that must be run
- package asks for device identifiers
- package appears modified or repacked
- package contents do not match claimed metadata

## Local storage policy

Firmware archives and extracted images must not be committed to this repository.

Use local-only storage such as:

- C:\Projects\moto-one-hyper-local\firmware
- C:\Projects\moto-one-hyper-local\extracted

Commit metadata and reports only.

Do not commit firmware archives, extracted images, vendor blobs, proprietary binaries, serials, IMEI values, UID values, or private identifiers.

## Safe checksum command

For a local firmware archive, compute SHA256 with:

Get-FileHash .\FIRMWARE_FILE.zip -Algorithm SHA256

This reads a local file only.

## Extraction requirements

Extraction must be reproducible.

Record:

- extraction tool
- tool version
- command used
- output directory
- extracted file count
- warnings/errors
- whether payload.bin exists
- whether sparse images exist
- whether dynamic partition images exist

Do not run unknown executable tools included in firmware packages.

## Image inventory requirements

After extraction, inventory major artifacts such as:

- boot
- recovery or recovery equivalent
- vendor_boot, if present
- dtbo
- vbmeta
- vbmeta_system, if present
- super or dynamic partition payload
- system
- system_ext
- product
- vendor
- odm
- modem/radio images
- bootloader-related images
- XML/flashfile/script metadata
- partition metadata
- sparse images
- payload.bin

Inventory does not authorize flashing.

## Required follow-up report

Once a package is extracted, create:

- reports/firmware_inventory_candidate_id.md

The report must include:

- package identity
- checksum
- extraction result
- image list
- image sizes
- image hashes
- partition relevance
- risk category
- whether the package can support stock recovery planning

## Acceptance criteria

A firmware package may become the recovery anchor only if:

- target identity matches or compatibility is reviewed
- archive checksum is recorded
- extraction is reproducible
- stock boot-related images are identified
- partition layout clues are identified
- dangerous partitions are marked
- restore path can be written without guesswork
- local validation passes after metadata is committed
- no private or proprietary payloads are committed

## Current status

No firmware is currently accepted as a recovery anchor.

Physical flash work remains blocked.
