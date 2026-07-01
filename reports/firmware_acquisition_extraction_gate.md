# Firmware Acquisition & Extraction Gate

Status: Route B filesystem extraction blocked by missing local tools; use still blocked

Date: 2026-07-01

## Purpose

Make the current human decision explicit. The metadata-only firmware track was
closed at commit `8d0f113` (`reports/stock_firmware_search_matrix.md`), Route B
acquisition was opened and completed on 2026-06-30, Route B offline ZIP
extraction-only was opened and completed on 2026-07-01, and Route B
sparse/super filesystem extraction-only was opened on 2026-07-01 but blocked by
missing local tooling. This document defines the routes, the local-only storage
layout, the extraction rules, and the committed-report shape without authorizing
blob use, build use, or any phone action.

This document is a gate, not a key. Nothing here is self-authorizing beyond the
explicit Route B acquisition-only decision recorded on 2026-06-30, the offline
ZIP extraction-only decision recorded on 2026-07-01, and the sparse/super
filesystem extraction-only attempt recorded on 2026-07-01.

## Safety boundary

Reports and the separately approved Route B local-only package inventory,
offline ZIP extraction, and attempted sparse/super filesystem extraction only.
This document authorizes no blob use, no blob import, no LMSA/RSA Rescue flow,
no device connection, no phone action, no flashing, no build attempt, and no
Route A/Route C side quest. No proprietary artifact is committed. The physical
Motorola One Hyper remains out of scope.

## Current firmware state (input to the decision)

| Candidate | Build / hash | Channel | Provenance | Posture |
|---|---|---|---|---|
| **Exact retus (preferred)** | `RPFS31.Q1-21-20-1-7-3` / `37074e` | retus | UA-string attestation only; not in public/mirror metadata | Likely only obtainable via LMSA / official device-matched tooling; needs a physical-device / official-tooling gate |
| Same-family retus fallback | — | retus | none found | Does not exist in surveyed metadata |
| Provisional `-5` | `RPFS31.Q1-21-20-5` / `1e3de` | **RETBR** | best-corroborated (5-way); sorenlyulf's exact vendor base; local artifact verified and inventoried offline | Best non-retus fallback; wrong-channel caveat; use still blocked |
| Newer `-10` | `RPFS31.Q1-21-20-10` | generic `DEF_RETAIL` | aggregator-only, weaker | Not preferred unless evidence improves |
| Checksums | — | — | none exposed pre-download | Hash verification only possible after a gated download |

## Routes

### Route A — LMSA exact-retus route

- **Purpose:** acquire the exact `RPFS31.Q1-21-20-1-7-3` / retus / XT2027-1
  package if LMSA exposes it.
- **Status:** attempted safely 2026-06-30; **blocked** because Software Fix
  identified the phone but exposed no firmware package metadata before the
  write-coupled `Start Rescue` hard stop.
- **Allowed only after separate approval:**
  - connect / identify the device in LMSA;
  - capture LMSA metadata;
  - download the official package to local-only firmware storage.
- **Required evidence (recorded outside the repo, summarized in reports):**
  package filename; source/tool; build / channel / SKU claims; package size;
  local SHA256; any LMSA metadata/logs safe to record. No phone mutation unless
  separately approved.

### Route B — provisional `-5` RETBR route

- **Purpose:** acquire `RPFS31.Q1-21-20-5` / `1e3de` because it matches
  sorenlyulf's exact vendor base.
- **Status:** acquisition-only opened 2026-06-30 and completed. Offline
  extraction-only opened 2026-07-01 and completed under local-only storage; see
  `reports/firmware_package_inventory_RPFS31_Q1_21_20_5_RETBR.md`.
  Sparse/super filesystem extraction-only opened 2026-07-01 but is blocked by
  missing local `simg2img`/`lpunpack` or equivalent tooling; see
  `reports/firmware_filesystem_extraction_RPFS31_Q1_21_20_5_RETBR.md`.
- **Allowed under the 2026-06-30 approval:**
  - download one selected artifact from the least-bad source;
  - compute local hashes;
  - commit reports only.
- **Allowed under the 2026-07-01 approval:**
  - verify the acquired artifact still exists;
  - recompute SHA256 and compare to the recorded value;
  - extract offline only under
    `C:\Projects\moto-one-hyper-local\extracted`;
  - write local extraction logs under
    `C:\Projects\moto-one-hyper-local\logs`;
  - write local checksum files under
    `C:\Projects\moto-one-hyper-local\checksums`;
  - inspect package structure, filenames, XML, payloads, sparse images,
    partition images, manifests, and accessible build props;
  - commit reports only.
- **Allowed under the later 2026-07-01 sparse/super approval, but blocked by
  missing local tools:**
  - convert sparse images offline if supported by existing local tools;
  - unpack super/dynamic partitions offline if supported by existing local
    tools;
  - inspect vendor/product/odm/system_ext/system filesystem contents offline if
    supported by existing local tools;
  - compute hashes and file lists locally;
  - compare actual filesystem contents against
    `reports/proprietary_files_expectation_map.md`;
  - commit reports only.
- **Still not authorized:**
  - import blobs;
  - install or download random extraction tools;
  - flash or boot anything.
- **Required caveats:** RETBR, not retus; blob compatibility with the phone's
  `-1-7-3` is unproven; no flashing path is implied or authorized.

### Route C — hold route

- **Purpose:** continue the no-artifact posture until an exact retus package
  appears or Jeremy decides to open LMSA.
- **Status:** safest from a device/integrity perspective. This remains the
  fallback posture for any unapproved next step.

## Local-only storage layout (outside the repository)

These paths are outside the repo and must never be committed:

| Use | Path |
|---|---|
| Firmware packages | `C:\Projects\moto-one-hyper-local\firmware` |
| Checksums | `C:\Projects\moto-one-hyper-local\checksums` |
| Extraction root | `C:\Projects\moto-one-hyper-local\extracted` |
| Logs | `C:\Projects\moto-one-hyper-local\logs` |
| Audits | `C:\Projects\moto-one-hyper-local\audits` |

## Extraction rules

Extraction is now approved only for the single acquired Route B artifact and only
as an offline local inspection step. It must obey:

- Offline extraction only.
- No phone extraction by default.
- No root.
- No fastboot.
- No adb mutation.
- No flashing.
- No slot changes.
- No boot/recovery modification.
- No proprietary blob import into the repo.
- No committed firmware / images / blobs / local checksum files.
- Only reports, inventories, hashes, command logs, and conclusions may be
  committed.

Sparse/super filesystem extraction remains blocked until a known safe local
toolchain is approved or provided. Tool absence must be reported rather than
worked around with unapproved downloads.

## Post-extraction committed reports

After the 2026-07-01 approved offline extraction, these metadata-only reports are
committed, named by build:

- `reports/firmware_package_inventory_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/firmware_partition_layout_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/vendor_blob_expectation_gap_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/stock_boot_recovery_anchor_RPFS31_Q1_21_20_5_RETBR.md`

After the later 2026-07-01 sparse/super filesystem extraction attempt, these
metadata-only blocker reports are committed:

- `reports/firmware_filesystem_extraction_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/vendor_blob_coverage_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/channel_sensitive_blob_review_RPFS31_Q1_21_20_5_RETBR.md`

The yardstick for `vendor_blob_expectation_gap_<build>.md` already exists:
`reports/proprietary_files_expectation_map.md` (built 2026-06-30 from the matched
lineage-20 manifests — ~261 def + ~984 common blob paths, def set anchored to
`-5`, with modem/TEE/radio flagged as the channel-sensitive determinants). A
future sparse/super filesystem extraction retry, if an approved local toolchain
is provided, would be diffed against that map at path level.

## Not authorized by this document

This document does **not** authorize:

- additional firmware download beyond the single Route B artifact recorded in
  `reports/firmware_route_b_retbr_acquisition_report.md`
- LMSA execution
- device connection
- phone extraction
- flashing
- fastboot commands
- adb mutation
- root attempts
- proprietary blob import
- sparse/super filesystem extraction without approved local tools
- installing or downloading extraction tools without approval
- build attempt

Any of the above requires a separate, explicit, current-session gate from Jeremy.

## The decision

Current route state after 2026-07-01:

- **A.** LMSA exact-retus gate: attempted safely; blocked by write-coupled
  Rescue flow.
- **B.** provisional `-5` RETBR gate: acquisition-only opened and completed;
  offline ZIP extraction-only opened and completed; sparse/super filesystem
  extraction-only opened and blocked by missing local tools; blob use, build
  use, and all phone actions still blocked.
- **C.** hold route: no longer the current acquisition state, but remains the
  fallback posture for any unapproved next step.

No further artifact action occurs until Jeremy/GPT opens a new gate.
