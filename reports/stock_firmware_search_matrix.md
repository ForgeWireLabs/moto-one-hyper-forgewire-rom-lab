# Stock Firmware Search Matrix

Status: generated firmware acquisition search matrix

Date: 2026-06-28

## Safety boundary

This report defines firmware search and metadata review only.

No physical phone action is authorized.

No firmware package is accepted by this report.

No firmware package should be downloaded into the Git repository.

No boot, recovery, vbmeta, dtbo, super, modem, radio, persist, EFS-like, or partition image is produced, modified, flashed, or booted.

Firmware packages, if later downloaded, must stay outside the repo under:

    C:\Projects\moto-one-hyper-local\firmware

Extracted firmware metadata, if later produced, must stay outside the repo under:

    C:\Projects\moto-one-hyper-local\extracted

Only scripts, manifests, checksums, and metadata reports may be committed.

## Known target identity

| Field | Current known value | Search importance |
|---|---|---|
| Device | Motorola One Hyper | high |
| Model | XT2027-1 | critical |
| Codename | def | critical |
| Product | def_retail | critical |
| Channel | retus | critical |
| Android version | 11 | high |
| Build | RPFS31.Q1-21-20-1-7-3 | critical |
| Fingerprint | motorola/def_retail/def:11/RPFS31.Q1-21-20-1-7-3/37074e:user/release-keys | critical |
| Active slot previously observed | _a | informational only; not used for action |
| Bootloader state previously observed | unlocked / AVB orange | informational only; not used for action |

## Search strings

| Priority | Query | Purpose |
|---:|---|---|
| 1 | XT2027-1 RPFS31.Q1-21-20-1-7-3 | exact model/build search |
| 2 | def_retail RPFS31.Q1-21-20-1-7-3 | exact product/build search |
| 3 | RPFS31.Q1-21-20-1-7-3 retus | exact build/channel search |
| 4 | Motorola One Hyper retus Android 11 firmware | broad channel/version search |
| 5 | XT2027-1 retus firmware | model/channel search |
| 6 | def_retail retus firmware | product/channel search |
| 7 | Motorola One Hyper stock ROM retus | stock ROM mirror search |
| 8 | XT2027-1 def_retail Android 11 stock firmware | broad model/product/version search |

## Candidate source classes

| Source class | Use | Acceptance posture |
|---|---|---|
| Motorola RSA / Software Fix route | authoritative recovery path and package discovery clue | preferred metadata source; do not run opaque tools blindly |
| Lolinet / Lenomola Motorola firmware paths | firmware package discovery and filename metadata | useful if exact model/product/channel/build match is found |
| Community forum posts | filename and version clues only | not accepted without independent package verification |
| Random firmware mirrors | last-resort metadata clues | high skepticism; require checksum/source corroboration |
| GitHub source trees | source metadata only | not firmware evidence |

## Acceptance requirements

A firmware package is not accepted unless the metadata strongly supports:

- Motorola One Hyper / XT2027-1.
- def or def_retail.
- retus channel, or a clearly compatible retail US package.
- Android 11.
- Build RPFS31.Q1-21-20-1-7-3 exactly, or a consciously documented near-match with risks.
- Package contents suitable for metadata extraction.
- Checksums recorded outside the repo before extraction.

## Rejection rules

Reject or quarantine firmware candidates when:

- Model does not match XT2027-1.
- Product/codename does not match def / def_retail.
- Channel is not retus or clearly compatible.
- Android generation is not Android 11 unless explicitly being retained as historical evidence.
- Build is older/newer and no risk note is written.
- Package origin is unclear.
- Package requires an opaque downloader or executable with no metadata visibility.
- Package includes files that cannot be safely identified.

## Metadata to capture per candidate

| Field | Required | Notes |
|---|---|---|
| Source URL or source description | yes | raw URLs may stay in local notes if needed; committed reports should avoid unsafe direct download instructions |
| Filename | yes | important for Motorola package matching |
| Model | yes | must be checked against XT2027-1 |
| Product/codename | yes | must be checked against def/def_retail |
| Channel/region | yes | must be checked against retus |
| Android version | yes | target is Android 11 |
| Build ID | yes | target is RPFS31.Q1-21-20-1-7-3 |
| Size | yes | metadata sanity check |
| Hash/checksum | yes, once downloaded outside repo | never skip for accepted local artifacts |
| Package contents | later | requires local extraction outside repo |
| Acceptance status | yes | accepted / rejected / pending / historical clue |

## Local artifact policy

Permitted local-only paths:

    C:\Projects\moto-one-hyper-local\firmware
    C:\Projects\moto-one-hyper-local\extracted
    C:\Projects\moto-one-hyper-local\checksums
    C:\Projects\moto-one-hyper-local\audits
    C:\Projects\moto-one-hyper-local\logs

Forbidden Git artifacts:

- firmware ZIPs
- payload BIN files
- boot/recovery/vendor_boot/dtbo/vbmeta images
- sparse images
- super images
- modem/radio images
- extracted proprietary blobs
- large binaries

## Current decision

No stock firmware package is accepted yet.

The next hard-work task is metadata-only firmware candidate discovery.

Recommended next artifact: reports/stock_firmware_candidate_inventory.md
