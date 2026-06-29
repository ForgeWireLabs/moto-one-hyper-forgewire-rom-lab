# Stock Firmware Candidate Inventory

Status: initial metadata-only inventory

Date: 2026-06-28

## Safety boundary

This report is for metadata-only firmware candidate tracking.

No physical phone action is authorized.

No firmware package is accepted by this inventory.

No firmware package should be downloaded into the Git repository.

No firmware image is produced, modified, flashed, booted, unpacked into the repo, or used against the physical phone.

## Target firmware identity

| Field | Target value | Match requirement |
|---|---|---|
| Device | Motorola One Hyper | required |
| Model | XT2027-1 | required |
| Codename | def | required |
| Product | def_retail | required |
| Channel | retus | required or explicitly risk-documented compatible retail US |
| Android version | 11 | required |
| Build | RPFS31.Q1-21-20-1-7-3 | exact preferred |
| Fingerprint | motorola/def_retail/def:11/RPFS31.Q1-21-20-1-7-3/37074e:user/release-keys | exact preferred |

## Candidate table

| ID | Source class | Candidate label | Model | Product/codename | Channel | Android | Build | Status | Notes |
|---|---|---|---|---|---|---|---|---|---|
| FW-001 | Motorola RSA / Software Fix | pending discovery | unknown | unknown | unknown | unknown | unknown | pending | Preferred authoritative route, but do not run opaque tooling blindly. Capture metadata only first. |
| FW-002 | Lolinet / Lenomola | pending discovery | unknown | unknown | unknown | unknown | unknown | pending | Search for exact XT2027-1 / def_retail / retus / RPFS31.Q1-21-20-1-7-3 match. |
| FW-003 | Community forum clue | pending discovery | unknown | unknown | unknown | unknown | unknown | pending | Use only for filename/build clues. Not accepted without corroboration. |
| FW-004 | Random mirror clue | pending discovery | unknown | unknown | unknown | unknown | unknown | pending | High skepticism. Reject unless source and metadata are clear. |

## Candidate status meanings

- pending: not enough metadata yet.
- rejected: mismatch or unsafe/unclear origin.
- historical clue: useful for naming/build lineage but not target firmware.
- near-match: possibly useful, but risks must be documented.
- accepted metadata candidate: metadata looks plausible, but package still must be downloaded outside repo and checksummed before extraction.
- accepted local anchor: only after local checksum and package contents are verified outside repo.

## Required metadata before local download

- source class
- source page or source description
- filename
- model
- product/codename
- channel/region
- Android version
- build ID
- package size if visible
- reason for accepting, rejecting, or quarantining

## Local-only download rule

If a candidate is later downloaded, it must go under:

    C:\Projects\moto-one-hyper-local\firmware

Checksums must go under:

    C:\Projects\moto-one-hyper-local\checksums

Extraction must go under:

    C:\Projects\moto-one-hyper-local\extracted

## Current decision

No firmware candidate is accepted yet.

Next hard-work step: perform metadata-only public firmware search and update this inventory with real candidate rows.
