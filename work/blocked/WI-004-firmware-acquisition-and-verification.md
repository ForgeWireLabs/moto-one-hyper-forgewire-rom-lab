# WI-004 - Firmware Acquisition and Verification

Status: blocked

## Goal

Find and verify exact stock firmware or recovery material for the Motorola One Hyper XT2027-1 retus build lineage.

## Why

No physical-device ROM work should proceed until exact recovery paths are understood. Firmware verification is the gate before any later device-specific ROM work.

## Known device facts

- Device: Motorola One Hyper XT2027-1
- Codename/product: def / def_retail
- Channel: retus
- Android build: RPFS31.Q1-21-20-1-7-3
- Bootloader: unlocked
- Active slot observed: _a
- Verified stock boot image: not yet available

## Scope

In scope:

- source research
- firmware metadata collection
- hash capture
- package provenance notes
- extraction into non-public local workspace when necessary
- verification reports that do not expose private identifiers

Out of scope:

- flashing
- rescue or repair GUI actions
- erasing
- relocking
- wiping
- sideloading
- writing partitions
- publishing proprietary firmware blobs directly in the repo

## Deliverables

- updated source matrix
- firmware candidate report
- verification checklist
- blocked/unblocked decision note

## Acceptance

- exact firmware candidate identified or clearly marked unavailable
- provenance recorded
- hashes recorded for any local package
- no IMEI or private serial values in public files
- next action is clearly marked safe or blocked

## Safety

Blocked for physical device mutation. Research and verification only.
