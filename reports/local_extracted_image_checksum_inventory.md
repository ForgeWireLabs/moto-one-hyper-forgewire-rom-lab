# Local Extracted Image Checksum Inventory

Status: generated local-only extracted image checksum inventory

Date: 2026-06-28

## Safety boundary

This report inventories checksums for image-like files that already exist in the local extraction workspace.

No physical phone action is authorized.

No firmware package is downloaded by this script.

No firmware package is extracted by this script.

No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script.

No firmware file or extracted binary is copied into the Git repository.

## Local paths

| Purpose | Path |
|---|---|
| Extracted firmware search directory | C:\Projects\moto-one-hyper-local\extracted |
| Local checksum output directory | C:\Projects\moto-one-hyper-local\checksums |
| Committed metadata report | reports\local_extracted_image_checksum_inventory.md |

## Extracted image checksum inventory

| File | Relative path | Size bytes | Size MiB | SHA256 | Role | Physical action allowed? |
|---|---|---:|---:|---|---|---|
| none | none | 0 | 0 | none | no extracted image-like files found | no |

## Interpretation

An extracted image checksum proves only that a local file exists and has been hashed.

It does not prove authenticity, compatibility, flash safety, boot safety, recovery suitability, or physical-device readiness.

## Current decision

No extracted image-like files are present yet.

Next hard-work step: acquire and extract metadata locally only after candidate package checksums exist.
