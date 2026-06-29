# Local Firmware Extraction Inventory

Status: generated metadata-only extraction inventory

Date: 2026-06-28

## Safety boundary

This report inventories local firmware package structure and extraction readiness only.

No physical phone action is authorized.

No firmware package is downloaded by this script.

No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script.

No firmware file or extracted binary is copied into the Git repository.

## Local paths

| Purpose | Path |
|---|---|
| Firmware input directory | C:\Projects\moto-one-hyper-local\firmware |
| Extraction workspace | C:\Projects\moto-one-hyper-local\extracted |
| Committed metadata report | reports\local_firmware_extraction_inventory.md |

## Local firmware packages

| Filename | Size bytes | Size MiB | Extension | Extraction status |
|---|---:|---:|---|---|
| none | 0 | 0 | none | no local firmware package found |

## Extraction policy

Extraction, if later performed, must occur only under:

    C:\Projects\moto-one-hyper-local\extracted

Extraction output must not be committed.

Only metadata may be committed, such as:

- package filename
- package size
- checksum
- top-level file list
- image names
- image sizes
- XML file names
- payload file names
- partition name clues

## Important image names to look for later

| Artifact | Why it matters | Physical action allowed? |
|---|---|---|
| boot.img | possible stock boot/recovery anchor depending device layout | no |
| vendor_boot.img | confirms vendor_boot presence if present | no |
| recovery.img | direct recovery anchor if present | no |
| dtbo.img | device tree overlay evidence | no |
| vbmeta.img | AVB evidence | no |
| super.img / super_sparsechunk files | dynamic partition evidence | no |
| gpt / partition XML | partition layout evidence | no |
| flashfile.xml / servicefile.xml | Motorola package flashing metadata | no |
| payload.bin | OTA-style payload evidence | no |
| modem/radio images | radio partition evidence; do not touch | no |

## Current decision

No local firmware package is present yet.

Next hard-work step: acquire an accepted metadata candidate outside the repo, then rerun checksum and extraction inventory scripts.
