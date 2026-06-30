# Firmware Acquisition & Extraction Gate

Status: gate definition (no acquisition authorized)

Date: 2026-06-30

## Purpose

Make the next human decision explicit. The metadata-only firmware track is
complete and closed at commit `8d0f113`
(`reports/stock_firmware_search_matrix.md`). This document does not acquire,
download, extract, or flash anything. It defines the routes, the local-only
storage layout, the extraction rules, and the committed-report shape that a
*future, separately approved* artifact step would follow — so Jeremy can choose a
route with the constraints already written down.

This document is a gate, not a key. Nothing here is self-authorizing.

## Safety boundary

Reports only. This document authorizes no firmware download, no image download,
no extraction, no blob handling, no LMSA execution, no device connection, no
phone action, no flashing, and no mirror artifact acquisition. No proprietary
artifact is committed. The physical Motorola One Hyper remains out of scope.

## Current firmware state (input to the decision)

| Candidate | Build / hash | Channel | Provenance | Posture |
|---|---|---|---|---|
| **Exact retus (preferred)** | `RPFS31.Q1-21-20-1-7-3` / `37074e` | retus | UA-string attestation only; not in public/mirror metadata | Likely only obtainable via LMSA / official device-matched tooling; needs a physical-device / official-tooling gate |
| Same-family retus fallback | — | retus | none found | Does not exist in surveyed metadata |
| Provisional `-5` | `RPFS31.Q1-21-20-5` / `1e3de` | **RETBR** | best-corroborated (5-way); sorenlyulf's exact vendor base | Best non-retus fallback; wrong-channel caveat; needs artifact-acquisition approval |
| Newer `-10` | `RPFS31.Q1-21-20-10` | generic `DEF_RETAIL` | aggregator-only, weaker | Not preferred unless evidence improves |
| Checksums | — | — | none exposed pre-download | Hash verification only possible after a gated download |

## Routes

### Route A — LMSA exact-retus route

- **Purpose:** acquire the exact `RPFS31.Q1-21-20-1-7-3` / retus / XT2027-1
  package if LMSA exposes it.
- **Status:** **preferred** route, but **blocked** until Jeremy explicitly opens a
  physical-device / official-tooling gate.
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
- **Status:** best-corroborated non-retus fallback; **not preferred** over the
  exact retus package.
- **Allowed only after separate approval:**
  - download one selected artifact from the least-bad source;
  - compute local hashes;
  - inspect package structure offline.
- **Required caveats:** RETBR, not retus; blob compatibility with the phone's
  `-1-7-3` is unproven; no flashing path is implied or authorized.

### Route C — hold route

- **Purpose:** continue the no-artifact posture until an exact retus package
  appears or Jeremy decides to open LMSA.
- **Status:** safest from a device/integrity perspective. This is the current
  default until a route is chosen.

## Local-only storage layout (outside the repository)

These paths are outside the repo and must never be committed:

| Use | Path |
|---|---|
| Firmware packages | `C:\Projects\moto-one-hyper-local\firmware` |
| Checksums | `C:\Projects\moto-one-hyper-local\checksums` |
| Extraction root | `C:\Projects\moto-one-hyper-local\extracted` |
| Logs | `C:\Projects\moto-one-hyper-local\logs` |
| Audits | `C:\Projects\moto-one-hyper-local\audits` |

## Extraction rules (for a future approved artifact)

If — and only if — a route is approved and an artifact is acquired under that
approval, extraction must obey:

- Offline extraction only.
- No phone extraction by default.
- No root.
- No fastboot.
- No adb mutation.
- No flashing.
- No slot changes.
- No boot/recovery modification.
- No proprietary blob import into the repo.
- No committed firmware / images / blobs.
- Only reports, inventories, hashes, command logs, and conclusions may be
  committed.

## Future post-extraction committed reports

After a future approved extraction, these report shapes (metadata only) would be
committed, named by build:

- `reports/firmware_package_inventory_<build>.md`
- `reports/firmware_partition_layout_<build>.md`
- `reports/vendor_blob_expectation_gap_<build>.md`
- `reports/stock_boot_recovery_anchor_<build>.md`

The yardstick for `vendor_blob_expectation_gap_<build>.md` already exists:
`reports/proprietary_files_expectation_map.md` (built 2026-06-30 from the matched
lineage-20 manifests — ~261 def + ~984 common blob paths, def set anchored to
`-5`, with modem/TEE/radio flagged as the channel-sensitive determinants). A
future extraction is diffed against that map.

## Not authorized by this document

This document does **not** authorize:

- firmware download
- LMSA execution
- device connection
- phone extraction
- flashing
- fastboot commands
- adb mutation
- root attempts
- proprietary blob import
- build attempt

Any of the above requires a separate, explicit, current-session gate from Jeremy.

## The decision

Jeremy chooses one:

- **A.** open the LMSA exact-retus gate (Route A)
- **B.** approve the provisional `-5` RETBR acquisition gate (Route B)
- **C.** hold artifact acquisition (Route C — current default)

Until a choice is made, Route C (hold) is in effect and no artifact action occurs.
