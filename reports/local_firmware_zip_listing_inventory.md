# Local Firmware ZIP Listing Inventory

Status: generated metadata-only ZIP listing inventory

Date: 2026-06-28

## Safety boundary

This report lists local firmware ZIP contents metadata only.

No physical phone action is authorized.

No firmware package is downloaded by this script.

No firmware package is fully extracted by this script.

No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script.

No firmware file or extracted binary is copied into the Git repository.

## Local paths

| Purpose | Path |
|---|---|
| Firmware ZIP input directory | C:\Projects\moto-one-hyper-local\firmware |
| Local ZIP listing output directory | C:\Projects\moto-one-hyper-local\audits |
| Committed metadata report | reports\local_firmware_zip_listing_inventory.md |

## ZIP package summary

| ZIP filename | Size bytes | Size MiB | Entry count | Local listing file | Status |
|---|---:|---:|---:|---|---|
| none | 0 | 0 | 0 | none | no local ZIP firmware package found |

## Key artifact names to check in local listings

- flashfile.xml
- servicefile.xml
- boot.img
- recovery.img
- vendor_boot.img
- dtbo.img
- vbmeta.img
- super.img
- super_sparsechunk files
- gpt or partition XML files
- modem/radio images
- payload.bin

## Current decision

No local firmware ZIP is present yet.

Next hard-work step: after a local-only candidate ZIP exists, rerun checksum and ZIP listing inventories.
