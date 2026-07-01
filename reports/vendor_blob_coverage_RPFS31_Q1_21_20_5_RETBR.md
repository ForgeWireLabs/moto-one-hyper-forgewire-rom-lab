# Vendor Blob Coverage - RPFS31.Q1-21-20-5 RETBR

Status: path-level coverage blocked by missing filesystem extraction tools

Date: 2026-07-01

## Safety boundary

This report compares the current evidence state against
`reports/proprietary_files_expectation_map.md`. It does not import, copy,
mount, unpack, convert, or commit proprietary blobs. It does not approve blob
use. No phone, adb, fastboot, LMSA/RSA, rescue, repair, flashing, root, or build
action was performed.

## Baseline

The expectation map records:

| Manifest family | Expected entries |
|---|---:|
| def-specific | 261 entries, 259 unique |
| sm6150-common | 984 entries, 952 unique |

The Route B ZIP package is structurally consistent with a full stock package,
but the actual vendor/product/odm/system_ext filesystem contents are expected
inside `super.img_sparsechunk.*`.

## Coverage result

| Question | Answer |
|---|---|
| How many expected def-specific blobs were found? | `0` verified at path level in this pass. This means not extracted/checkable, not absent. |
| How many expected sm6150-common blobs were found? | `0` verified at path level in this pass. This means not extracted/checkable, not absent. |
| Which blob families appear covered? | Top-level package structure suggests `super`, radio/modem, DSP, Bluetooth, boot/recovery, DTBO, and AVB coverage, but no manifest path family is proven. |
| Which expected files are missing? | All manifest paths remain unverified because logical partitions were not unpacked. No per-file absence conclusion is valid. |
| Which missing files may be generated, renamed, symlinked, or path-transformed by extract scripts? | Not checkable until the logical filesystems can be listed. The known overlap and extract-script transform question remains open. |
| Are there duplicates/conflicts? | Not checkable at path level. The expectation map's six overlap libraries remain the only known duplicate candidates. |
| Does the `-5` RETBR artifact appear sufficient as a source for the matched sorenlyulf manifests? | Not proven. It remains plausible because the package fingerprint matches `RPFS31.Q1-21-20-5/1e3de`, but sufficiency requires path-level filesystem extraction. |

## Families still likely but unverified

The package still appears likely to contain the expected def/common families
inside `super`, but none are path-confirmed:

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

The current environment lacks a usable local `simg2img` or equivalent sparse
converter and `lpunpack` or equivalent dynamic-partition unpacker. Without those
tools, the approved slice cannot produce a vendor/product/odm/system_ext file
list and cannot compute coverage against the manifests.

## Current decision

Blob coverage remains unresolved. The next safe step is continued hold until
Jeremy approves a known local toolchain or provides approved tools for a
no-import extraction script dry run. No blob import is authorized.
