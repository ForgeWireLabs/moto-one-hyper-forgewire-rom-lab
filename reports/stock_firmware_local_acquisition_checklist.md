# Stock Firmware Local Acquisition Checklist

Status: generated local-only acquisition checklist

Date: 2026-06-28

## Safety boundary

This checklist governs local-only firmware acquisition and metadata handling.

No physical phone action is authorized.

No firmware package is accepted by this checklist alone.

No firmware package may be downloaded into the Git repository.

No firmware image may be flashed, booted, patched, repacked, or used against the physical phone.

## Local-only allowed paths

| Purpose | Path |
|---|---|
| Firmware downloads | C:\Projects\moto-one-hyper-local\firmware |
| Checksums | C:\Projects\moto-one-hyper-local\checksums |
| Extraction workspace | C:\Projects\moto-one-hyper-local\extracted |
| Local audits | C:\Projects\moto-one-hyper-local\audits |
| Logs | C:\Projects\moto-one-hyper-local\logs |

## Candidate currently worth investigating

| Candidate | Status | Why |
|---|---|---|
| FW-002 GetDroidTips metadata clue | accepted metadata candidate | Exact XT2027-1 / RETUS / Android 11 / RPFS31.Q1-21-20-1-7-3 metadata clue. |
| FW-003 Filewale metadata clue | accepted metadata candidate | Filename-shaped DEF_RETAIL RPFS31.Q1-21-20-1-7-3 XML package clue with visible size. |
| FW-001 Motorola RSA / Software Fix | pending | Preferred official route, but exact package metadata has not been captured yet. |

## Pre-download requirements

Before any package is downloaded locally, record:

- candidate ID
- source class
- source description
- filename
- visible size
- model
- product/codename
- channel/region
- Android version
- build ID
- reason this candidate is worth local-only acquisition
- reason it is still not accepted as a local anchor

## Download rule

If a package is downloaded later, it must be saved only under:

    C:\Projects\moto-one-hyper-local\firmware

Do not download into:

- the Git repository
- Desktop
- Downloads, unless immediately moved and documented
- any phone-mounted storage

## Immediate post-download requirements

Immediately after local-only download:

- record exact filename
- record file size
- compute SHA256
- save checksum text under C:\Projects\moto-one-hyper-local\checksums
- do not extract yet unless the checksum and filename are recorded
- do not run any flash script
- do not connect the physical phone for any action

## Extraction boundary

Extraction, if later performed, must go only under:

    C:\Projects\moto-one-hyper-local\extracted

Only metadata from extraction may be committed, such as:

- manifest file list
- partition image names
- image sizes
- checksum manifest
- package XML names
- payload metadata

Never commit:

- firmware ZIPs
- boot.img
- recovery.img
- vendor_boot.img
- dtbo.img
- vbmeta.img
- super.img
- modem/radio images
- extracted proprietary blobs
- payload.bin
- sparse images

## Acceptance ladder

| Stage | Meaning | Physical phone allowed? |
|---|---|---|
| metadata clue | Public page or filename suggests relevance | no |
| accepted metadata candidate | Metadata appears to match target identity | no |
| local package candidate | Package downloaded outside repo | no |
| checksummed local package | SHA256 and size recorded | no |
| extracted metadata candidate | Package contents inventoried outside repo | no |
| recovery anchor candidate | Exact stock image relationship understood | no, still requires separate explicit gate |
| physical-device action | Any boot/flash/write operation | only with a new exact current-session approval |

## Current decision

No stock firmware package is accepted as a local anchor yet.

Next hard-work step: prepare a checksum-and-inventory script for local firmware packages.
