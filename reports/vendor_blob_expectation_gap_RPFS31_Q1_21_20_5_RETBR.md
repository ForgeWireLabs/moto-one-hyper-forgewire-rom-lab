# Vendor Blob Expectation Gap - RPFS31.Q1-21-20-5 RETBR

Status: visible-package gap analysis; sparse/super contents not mounted

Date: 2026-07-01

## Safety boundary

This report compares visible package structure against
`reports/proprietary_files_expectation_map.md`. It does not import, copy,
mount, unpack, convert, or commit proprietary blobs. It does not approve blob
use. No phone, adb, fastboot, LMSA/RSA, rescue, repair, flashing, root, or build
action was performed.

## Comparison baseline

The expectation map records:

- 261 def-specific expected paths from `sorenlyulf/android_device_motorola_def`,
  whose manifest header says the blobs were extracted from def
  `RPFS31.Q1-21-20-5`.
- 984 sm6150-common expected paths, with common paths expected on a def vendor
  image but originally referenced from related Motorola sm6150 devices.
- priority channel-sensitive families: modem/radio, qcril, IMS, TEE,
  keymaster, gatekeeper, fingerprint trustlets, DSP, camera signed firmware.

## Visible package contents

The ZIP exposes top-level partition/package images and XML metadata. It does not
directly expose filesystem paths such as `vendor/lib64/...` or
`vendor/firmware/...`.

Visible top-level evidence includes:

- `super.img_sparsechunk.0` through `.8`
- `radio.img`
- `dspso.bin`
- `BTFM.bin`
- `boot.img`
- `recovery.img`
- `dtbo.img`
- `vbmeta.img`
- `bootloader.img`
- `flashfile.xml`
- `servicefile.xml`
- package info text with build fingerprint and modem version

## Likely satisfiable def blobs

The def manifest is especially likely to be satisfiable later because the
visible package identifies itself as:

`motorola/def_retail/def:11/RPFS31.Q1-21-20-5/1e3de:user/release-keys`

That is the same build family called out by the expectation map. However, the
actual def-specific blobs are expected to live inside logical partitions within
`super.img_sparsechunk.*`, so this pass can only say "likely present", not prove
individual path coverage.

Likely satisfiable after future approved super/vendor extraction:

- def camera and EEPROM stack
- Cirrus audio and haptics firmware
- pop-up camera HAL
- Egistec fingerprint HAL and related security pieces
- ST21NFC firmware and libraries
- display calibration and panel-adjacent files
- sensors and miscellaneous device firmware

## Likely satisfiable common blobs

The common blob set is also likely to be substantially satisfiable because the
package is a full def_retail Android 11 firmware package with `super` chunks,
radio, DSP, Bluetooth, boot, recovery, DTBO, and AVB images. The top-level
package is consistent with a complete stock baseline rather than a partial OTA.

Likely satisfiable after future approved super/vendor extraction:

- Qualcomm graphics userspace and firmware
- media and DRM libraries
- audio, ADSP, CDSP, sound-trigger, and DSP-related files
- GPS, WiFi, Bluetooth, FM, ANT+, and connectivity libraries
- thermal, charger, alarm, time, perf, and platform services
- Moto permissions/configuration files

## What cannot be checked yet

The following cannot be checked without a separately approved sparse/super
conversion and filesystem extraction or mounting workflow:

- exact presence/absence of individual `vendor/...`, `system_ext/...`,
  `product/...`, and `odm/...` manifest paths
- hashes, versions, and file sizes for manifest blobs
- qcril database contents
- IMS APK/library versions
- TEE, keymaster, gatekeeper, and fingerprint trustlet versions
- camera/DSP signed firmware versions
- duplicate-path resolution for the six overlap libraries named in the
  expectation map
- RETBR-vs-retus compatibility of modem/radio, IMS, and security-coupled blobs

No sparse chunk was mounted or unpacked in this pass.

## Obvious missing families from visible top level

No obvious family is missing from the package top level for a full Motorola XML
firmware package, but several families are not directly visible by design:

- `NON-HLOS.bin` is absent under that name; modem/radio appears as `radio.img`.
- `vendor_boot.img` is absent.
- individual vendor filesystem blobs are not directly visible because they are
  expected inside `super.img_sparsechunk.*`.
- build props are not directly visible at ZIP top level.

Absence from the ZIP top level is not evidence that the corresponding blob
family is absent inside `super`.

## Channel-sensitive files to inspect first later

If a future gate allows sparse/super extraction, inspect these families first:

1. modem/radio and `radio.img` version relationship
2. qcril and `qcril_database`
3. IMS APKs, libraries, and configuration
4. TEE / TrustZone trustlets
5. keymaster
6. gatekeeper
7. fingerprint trustlets
8. DSP and camera signed firmware

These families are the most likely to decide whether the RETBR `-5` package is
usable only as a reference, or whether any subset could be safely compared
against the unavailable retus `-1-7-3` baseline.

## Current decision

The package structure is consistent with the expectation map and likely contains
the def and common blob families inside `super`, but path-level coverage is not
verified. No blob-use approval exists.

## Follow-up filesystem extraction attempt

On 2026-07-01, the next approved slice opened offline sparse/super filesystem
extraction and blob coverage inspection. Tool discovery found no usable local
`simg2img`, `lpunpack`, EROFS, or ext filesystem inspection toolchain, and WSL
did not expose a runnable installed distro/tool surface. The slice stopped
without reconstructing `super.img`, unpacking logical partitions, or inspecting
vendor/product/odm/system_ext paths.

Follow-up reports:

- `reports/firmware_filesystem_extraction_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/vendor_blob_coverage_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/channel_sensitive_blob_review_RPFS31_Q1_21_20_5_RETBR.md`
