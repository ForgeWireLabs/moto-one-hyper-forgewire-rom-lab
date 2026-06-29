# Stock Firmware Candidate Inventory Workflow

Status: generated workflow report

Date: 2026-06-28

## Safety boundary

This workflow manages firmware candidate metadata only.

No physical phone action is authorized.

No firmware package is downloaded by this script.

No firmware package is accepted by this script.

No firmware, boot, recovery, vendor_boot, dtbo, vbmeta, super, modem, radio, persist, or EFS-like image is produced, modified, flashed, booted, or committed.

## Local metadata source

Candidate metadata is tracked outside the Git repository at:

    C:\Projects\moto-one-hyper-local\audits\stock_firmware_candidates.csv

The CSV is local-only and should not be committed unless explicitly sanitized into a report.

## Target identity

| Field | Target value |
|---|---|
| Device | Motorola One Hyper |
| Model | XT2027-1 |
| Codename | def |
| Product | def_retail |
| Channel | retus |
| Android | 11 |
| Build | RPFS31.Q1-21-20-1-7-3 |

## Current local candidate rows

| ID | Source class | Filename | Model | Product/codename | Channel | Android | Build | Hash recorded | Status | Notes |
|---|---|---|---|---|---|---|---|---|---|---|
| FW-001 | Motorola RSA / Software Fix | unknown | unknown | unknown | unknown | unknown | unknown | no | pending | Preferred authoritative route; metadata only. |
| FW-002 | Lolinet / Lenomola | unknown | unknown | unknown | unknown | unknown | unknown | no | pending | Search exact XT2027-1 def_retail retus build match. |
| FW-003 | Community forum clue | unknown | unknown | unknown | unknown | unknown | unknown | no | pending | Filename/build clue only until corroborated. |
| FW-004 | Random mirror clue | unknown | unknown | unknown | unknown | unknown | unknown | no | pending | High skepticism; reject unless metadata is clear. |

## Update procedure

1. Search public firmware metadata sources using the committed stock firmware search matrix.
2. Record candidate metadata in the local CSV only.
3. Do not download firmware until a candidate has enough metadata to justify local-only acquisition.
4. Do not place firmware packages, extracted images, payload files, or blobs in Git.
5. Re-run this script after updating the local CSV.
6. Commit only the generated workflow/report if it contains safe metadata.

## Candidate status rules

- pending: discovery row or incomplete metadata.
- rejected: clear mismatch, unclear source, unsafe origin, or wrong build/channel/model.
- historical clue: useful naming or lineage clue, not a target package.
- near-match: close enough to retain for comparison, but not accepted.
- accepted metadata candidate: metadata looks plausible, but package must still be downloaded outside repo and checksummed.
- accepted local anchor: only after local checksum and package contents are verified outside repo.

## Current decision

No firmware candidate is accepted yet.

Next hard-work step: perform metadata-only public search, update the local CSV, and regenerate this report.
