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
| FW-001 | Motorola RSA / Software Fix | unknown | XT2027-1 | def/def_retail | retus | 11 | RPFS31.Q1-21-20-1-7-3 | no | pending | Preferred authoritative route; exact package metadata not captured yet. |
| FW-002 | GetDroidTips public metadata clue | unknown | XT2027-1 | def/def_retail | retus | 11 | RPFS31.Q1-21-20-1-7-3 | no | accepted metadata candidate | Exact model channel and build metadata clue; not a local anchor until package is downloaded outside repo and checksummed. |
| FW-003 | Filewale public metadata clue | Motorola One Hyper XT2027-1 DEF_RETAIL_RPFS31.Q1-21-20-1-7-3_subsidy-DEFAULT_regulatory-DEFAULT_CFC_Filewale.com.xml.zip | XT2027-1 | DEF_RETAIL | retus | 11 | RPFS31.Q1-21-20-1-7-3 | no | accepted metadata candidate | Exact filename-shaped metadata clue; source trust lower than official route; not a local anchor. |
| FW-004 | Lolinet / Lenomola mirror class | unknown | unknown | unknown | unknown | unknown | unknown | no | pending | Useful mirror class; exact XT2027-1 def_retail retus build path not captured yet. |
| FW-005 | StockRom community clue | unknown | XT2027-1 | DEF | retbr | 11 | RPFS31.Q1-21-20-10 | no | historical clue | Wrong channel and different build; retain only for lineage/search expansion. |

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

At least one candidate is marked accepted in local metadata. Verify checksums and extraction evidence before treating it as an anchor.

Next hard-work step: perform metadata-only public search, update the local CSV, and regenerate this report.
