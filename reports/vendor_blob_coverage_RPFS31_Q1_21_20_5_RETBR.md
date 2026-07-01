# Vendor Blob Coverage - RPFS31.Q1-21-20-5 RETBR

Status: representative vendor coverage confirmed; full manifest count pending

Date: 2026-07-01

## Safety boundary

This report compares the current evidence state against
`reports/proprietary_files_expectation_map.md`. It does not import, copy,
mount, convert, or commit proprietary blobs. It does not approve blob use. No
phone, adb, fastboot, LMSA/RSA, rescue, repair, flashing, root, or build action
was performed.

## Baseline

The expectation map records:

| Manifest family | Expected entries |
|---|---:|
| def-specific | 261 entries, 259 unique |
| sm6150-common | 984 entries, 952 unique |

The Route B ZIP package has now been reconstructed locally through `super` and
`vendor_a` was inspected with report-safe summaries. A complete manifest-to-
filesystem comparator has not yet been run.

## Coverage result

| Question | Answer |
|---|---|
| How many expected def-specific blobs were found? | Not fully counted yet. Report-safe `vendor_a` evidence confirms multiple def-specific families, including pop-up, fingerprint, NFC, camera/media config, Cirrus audio/haptics firmware, and device firmware. |
| How many expected sm6150-common blobs were found? | Not fully counted yet. Report-safe `vendor_a` evidence confirms radio/IMS/QCRIL, keymaster/gatekeeper/QSEE/Soter, graphics, media/DRM, WiFi/Bluetooth, DSP, sensors, thermal, GNSS, and platform service families. |
| Which blob families appear covered? | def hardware families and major sm6150 common families appear represented in `vendor_a`; see family summary below. |
| Which expected files are missing? | No high-confidence per-file missing list is available yet because no full manifest comparator has been run against extracted logical filesystems. |
| Which missing files may be generated, renamed, symlinked, or path-transformed by extract scripts? | Still open. Some manifest paths may be source-path transforms or copied from product/system images rather than visible in selected `vendor_a` summaries. |
| Are there duplicates/conflicts? | No new conflict is proven. The expectation map's six overlap libraries remain the known duplicate candidates. |
| Does the `-5` RETBR artifact appear sufficient as a source for the matched sorenlyulf manifests? | It now appears plausible as an offline evidence source for the matched `-5` manifests, but import/build sufficiency is not approved until a full comparator and risk review are complete. |

## Families still likely but unverified

The report-safe `vendor_a` inventory confirms representative coverage for:

- def camera and EEPROM stack
- Cirrus audio and haptics firmware
- pop-up camera HAL
- Egistec fingerprint HAL and trustlets
- ST21NFC firmware and libraries
- display, sensor, and device firmware
- Qualcomm graphics, media, DRM, audio, ADSP/CDSP, GPS, WiFi, Bluetooth, FM,
  thermal, time, perf, and platform services
- qcril, IMS, TEE, keymaster, gatekeeper, and related channel-sensitive files

## Blocker

The main blocker has moved from "filesystem not inspectable" to "full
manifest-to-filesystem comparison not yet run." The Git repo has report-safe
evidence only; full local inventories and filesystem trees remain local-only.

## Current decision

Blob coverage is partially confirmed at the family/category level, but not yet
complete at manifest path level. No blob import is authorized. The next no-phone
step is a report-safe comparator or concise coverage summary that uses the local
filesystem evidence without committing raw listings or proprietary payloads.
