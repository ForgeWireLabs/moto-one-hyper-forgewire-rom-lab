# Stock Partition / Image Relationship Report

Status: generated evidence relationship report

Date: 2026-06-28

## Safety boundary

This report summarizes metadata evidence only.

No physical phone action is authorized.

No firmware package is downloaded by this script.

No firmware package is extracted by this script.

No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script.

No stock image is accepted as safe by this report.

## Inputs checked

| Input report | Status |
|---|---|
| reports\local_firmware_checksum_inventory.md | present |
| reports\local_firmware_extraction_inventory.md | present |
| reports\local_firmware_zip_listing_inventory.md | present |
| reports\local_firmware_artifact_role_matrix.md | present |
| reports\local_firmware_xml_metadata_inventory.md | present |
| reports\stock_firmware_candidate_inventory_workflow.md | present |
| reports\stock_firmware_local_acquisition_checklist.md | present |

## Evidence summary

| Evidence target | State | Meaning |
|---|---|---|
| Local firmware package | not proven yet | A package must exist locally and be checksummed before image relationships can be trusted. |
| ZIP listing | not proven yet | A top-level package listing is needed before extraction planning. |
| boot.img | not proven yet | Needed for stock boot anchor analysis. |
| recovery.img | not proven yet | Needed if device/package exposes a standalone recovery image. |
| vendor_boot.img | not proven yet | Needed to understand Android 11 boot/recovery layout if present. |
| dtbo.img | not proven yet | Needed for device tree overlay evidence. |
| vbmeta images | evidence present | Needed for AVB relationship evidence. |
| super/sparsechunk artifacts | not proven yet | Needed for dynamic partition evidence. |
| XML entries in package/listings | evidence present | Needed for Motorola package operation metadata. |
| Extracted XML metadata | not proven yet | Needed before relationship parsing from XML can happen. |

## Relationship model

| Relationship | Required evidence | Current status | Physical action allowed? |
|---|---|---|---|
| Stock firmware package -> target device identity | candidate metadata + checksum + package listing | not accepted yet | no |
| Package XML -> partition/image map | flashfile/servicefile XML visible and locally inventoried | not proven yet | no |
| boot.img -> stock boot anchor | boot image present + checksum + package identity | not proven yet | no |
| recovery.img -> stock recovery anchor | recovery image present + checksum + package identity | not proven yet | no |
| vendor_boot.img -> boot/recovery layout evidence | vendor_boot image present + package identity | not proven yet | no |
| vbmeta.img -> AVB evidence | vbmeta image present + package identity | not proven yet | no |
| super artifacts -> dynamic partition layout | super/sparsechunk artifacts + XML metadata | not proven yet | no |

## Missing evidence gate

No local firmware package is checksummed yet, so no stock image relationship can be accepted.

## Current decision

No partition image, stock boot image, stock recovery image, AVB image, modem/radio image, or dynamic partition artifact is accepted for use against a physical device.

Next hard-work step: create a recovery-anchor readiness report that explicitly states what is required before any recovery/boot image can be trusted.
