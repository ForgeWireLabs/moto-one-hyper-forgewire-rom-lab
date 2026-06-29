# Firmware Inventory Template

Status: template

Date: 2026-06-28

## Purpose

Template for recording a downloaded stock firmware package after checksum and extraction.

This template must not contain proprietary payloads.

Do not commit firmware archives or extracted images.

## Candidate identity

| Field | Value |
|---|---|
| Firmware candidate ID | TBD |
| Source name | TBD |
| Source URL or origin | TBD |
| Download date | TBD |
| Filename | TBD |
| File size | TBD |
| SHA256 | TBD |
| Archive type | TBD |
| Password required | TBD |
| Payment/login required | TBD |
| Claimed model | TBD |
| Claimed product/codename | TBD |
| Claimed channel | TBD |
| Claimed build | TBD |
| Claimed Android version | TBD |

## Target comparison

| Field | Target | Candidate | Match |
|---|---|---|---|
| Model | XT2027-1 | TBD | TBD |
| Product/codename | def / def_retail | TBD | TBD |
| Channel | retus | TBD | TBD |
| Android generation | Android 11 | TBD | TBD |
| Build | RPFS31.Q1-21-20-1-7-3 | TBD | TBD |

## Source trust level

- [ ] unknown
- [ ] weak
- [ ] moderate
- [ ] strong
- [ ] verified-local

Rationale:

TBD

## Checksum evidence

Checksum command used:

TBD

Checksum result:

TBD

## Extraction evidence

| Field | Value |
|---|---|
| Extraction tool | TBD |
| Tool version | TBD |
| Command used | TBD |
| Output directory | local-only / not committed |
| Extracted file count | TBD |
| Warnings/errors | TBD |
| payload.bin present | TBD |
| sparse images present | TBD |
| dynamic partition metadata present | TBD |

## Image inventory

| Artifact | Present | Size | SHA256 | Risk category | Notes |
|---|---|---:|---|---|---|
| boot | TBD | TBD | TBD | Yellow | TBD |
| recovery/recovery equivalent | TBD | TBD | TBD | Yellow | TBD |
| vendor_boot | TBD | TBD | TBD | Yellow | TBD |
| dtbo | TBD | TBD | TBD | Red | TBD |
| vbmeta | TBD | TBD | TBD | Red | TBD |
| vbmeta_system | TBD | TBD | TBD | Red | TBD |
| super / dynamic payload | TBD | TBD | TBD | Red | TBD |
| system | TBD | TBD | TBD | Yellow/Red | TBD |
| system_ext | TBD | TBD | TBD | Yellow/Red | TBD |
| product | TBD | TBD | TBD | Yellow/Red | TBD |
| vendor | TBD | TBD | TBD | Red | TBD |
| odm | TBD | TBD | TBD | Red | TBD |
| modem/radio | TBD | TBD | TBD | Black | never touch |
| bootloader-related | TBD | TBD | TBD | Black | never touch |
| partition metadata | TBD | TBD | TBD | Reference | TBD |
| XML/flash scripts | TBD | TBD | TBD | Reference only | TBD |

## Forbidden commit check

Confirm:

- [ ] Firmware archive not committed.
- [ ] Extracted images not committed.
- [ ] Vendor blobs not committed.
- [ ] Proprietary binaries not committed.
- [ ] Serial/IMEI/UID/private identifiers not committed.
- [ ] Only this metadata report is committed.

## Recovery usefulness

Can this firmware support the stock recovery/reflash plan?

- [ ] yes
- [ ] no
- [ ] unclear

Explanation:

TBD

## Compatibility review needed?

- [ ] no, exact match
- [ ] yes, differences exist
- [ ] yes, unclear metadata

Required compatibility review report:

- reports/firmware_compatibility_review_candidate_id.md

## Decision

Final status:

- [ ] rejected
- [ ] reference-only
- [ ] candidate
- [ ] verified-local
- [ ] recovery-anchor

Decision rationale:

TBD

## Safety conclusion

This inventory does not authorize physical-device flashing or mutation.
