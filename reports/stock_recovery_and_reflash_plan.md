# Stock Recovery and Reflash Plan

Status: blocked-pending-verified-firmware

Date: 2026-06-28

## Purpose

Define what must be true before this project can claim that the Moto One Hyper can be restored after a failed experiment.

This is a plan template.

It is not authorization to flash.

It does not contain executable device commands.

## Current recovery status

Current status:

- verified stock firmware: not available
- verified stock boot image: not available
- verified stock recovery image: not available
- verified vendor image: not available
- verified full reflash procedure: not available
- physical flash authorization: not granted

Conclusion:

Physical flash work is blocked.

## Required stock firmware identity

The preferred firmware target must match:

- Device: Motorola One Hyper XT2027-1
- Product: def_retail
- Channel: retus
- Android generation: Android 11
- Observed build: RPFS31.Q1-21-20-1-7-3

If exact firmware cannot be found, compatibility must be reviewed before use.

No firmware is considered trusted until:

- source is recorded
- filename is recorded
- checksum is recorded
- archive contents are inventoried
- extraction is reproducible
- private identifiers are absent from committed files

## Firmware evidence table

| Field | Value | Status |
|---|---|---|
| Source URL or origin | TBD | blocked |
| Filename | TBD | blocked |
| SHA256 | TBD | blocked |
| Size | TBD | blocked |
| Android version | TBD | blocked |
| Build ID | TBD | blocked |
| Channel | TBD | blocked |
| Product | TBD | blocked |
| Model compatibility | TBD | blocked |
| Extraction tool/process | TBD | blocked |

## Required image inventory

A verified firmware package should be inventoried for images such as:

- boot
- recovery or recovery equivalent
- vendor_boot, if present
- dtbo
- vbmeta
- vbmeta_system, if present
- super or dynamic partition payload
- product
- system
- system_ext
- vendor
- odm
- modem/radio images, if present
- bootloader-related images, if present

Inventory does not imply permission to flash any listed image.

## Restore-path requirements

Before any custom test:

- know how to restore stock boot-related images
- know whether the device uses A/B slots for the relevant image
- know whether dynamic partitions are involved
- know whether vbmeta must remain untouched
- know what must never be flashed
- know whether the phone can enter bootloader reliably
- know whether the host detects the phone reliably
- know the exact stock image expected for the current build/channel

## Never-touch categories

The reflash plan must avoid:

- modem/radio unless specifically required by official stock restore procedure
- persist
- EFS-like identity/calibration partitions
- bootloader
- partition table
- FRP
- carrier/security/calibration partitions
- any unknown partition

## Failure response

If a test fails:

1. Stop.
2. Do not improvise.
3. Do not run random rescue/repair tools.
4. Do not relock the bootloader.
5. Do not erase unknown partitions.
6. Return to the documented stock recovery path only.
7. Record the failure in a report.

## Current decision

No physical flash, boot-image test, recovery-image test, sideload, restore, or rescue operation is allowed until this plan is completed with verified firmware evidence.
