# Local Firmware Checksum Inventory

Status: generated local-only checksum inventory

Date: 2026-06-28

## Safety boundary

This report inventories local firmware files by filename, size, and checksum only.

No physical phone action is authorized.

No firmware package is downloaded by this script.

No firmware package is extracted by this script.

No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script.

No firmware file is copied into the Git repository.

## Local paths

| Purpose | Path |
|---|---|
| Firmware input directory | C:\Projects\moto-one-hyper-local\firmware |
| Local checksum output directory | C:\Projects\moto-one-hyper-local\checksums |
| Committed metadata report | reports\local_firmware_checksum_inventory.md |

## Inventory

| Filename | Size bytes | Size MiB | SHA256 | Local checksum file | Status |
|---|---:|---:|---|---|---|
| none | 0 | 0 | none | none | no local firmware files found |

## Interpretation

A checksum entry means only that a local file exists and has been hashed.

It does not mean the package is accepted, safe, complete, authentic, compatible, extractable, or suitable for any phone action.

## Current decision

No local firmware package is present yet.

Next hard-work step: acquire a candidate package outside the repo only after metadata review.
