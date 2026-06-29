# Local Firmware Artifact Role Matrix

Status: generated metadata-only artifact role matrix

Date: 2026-06-28

## Safety boundary

This report classifies local firmware ZIP listing entries by likely artifact role.

No physical phone action is authorized.

No firmware package is downloaded, extracted, flashed, booted, patched, repacked, mounted, or modified by this script.

No firmware file or extracted binary is copied into the Git repository.

## Inputs

| Input type | Path |
|---|---|
| Local ZIP listing directory | C:\Projects\moto-one-hyper-local\audits |
| Committed metadata report | reports\local_firmware_artifact_role_matrix.md |

## Artifact role summary

| Role | Count |
|---|---:|
| none | 0 |

## Artifact entries

| Listing | Entry | Size bytes | Role | Physical action allowed? |
|---|---|---:|---|---|
| none | none | 0 | no local ZIP listing entries found | no |

## Interpretation

This matrix is classification metadata only.

A role classification does not prove authenticity, compatibility, flash safety, or recovery suitability.

The most important next evidence targets are:

- whether boot.img exists
- whether recovery.img exists
- whether vendor_boot.img exists
- whether vbmeta images exist
- whether dtbo exists
- whether dynamic super/sparsechunk artifacts exist
- whether flashfile.xml or servicefile.xml describes partition operations

## Current decision

No ZIP listing metadata is available yet.

Next hard-work step: place a candidate firmware ZIP outside the repo and rerun checksum and ZIP listing scripts.
