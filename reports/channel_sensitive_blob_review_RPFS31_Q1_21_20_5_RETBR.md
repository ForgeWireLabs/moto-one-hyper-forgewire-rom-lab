# Channel-Sensitive Blob Review - RPFS31.Q1-21-20-5 RETBR

Status: top-level channel-sensitive evidence only; filesystem coverage blocked

Date: 2026-07-01

## Safety boundary

This report reviews channel-sensitive evidence from already extracted local
Route B package metadata only. It does not approve blob use, flashing, build
use, or live-device use. No phone, adb, fastboot, LMSA/RSA, rescue, repair,
root, new firmware download, blob import, or build action was performed.

## Package identity

Visible package metadata remains internally consistent with:

- build: `RPFS31.Q1-21-20-5`
- build tag: `1e3de`
- fingerprint: `motorola/def_retail/def:11/RPFS31.Q1-21-20-5/1e3de:user/release-keys`
- modem version: `M6150_09.297.01.61R`
- FSG version: `FSG-6150-10.14`
- MBM version: `MBM-3.0-def_retail-ddf947084-210707`
- package route: Route B provisional RETBR mirror artifact

The embedded package metadata says `def_retail` and
`def_retail.retail.en.US`; it does not prove retus compatibility.

## Channel-sensitive artifacts

| Family | Present? | Evidence | Review state |
|---|---|---|---|
| modem / NON-HLOS / radio | partial | `radio.img`; modem and FSG versions in info text | present as radio package image; no `NON-HLOS.bin` by that name |
| qcril | unknown | expected inside logical partitions | blocked by missing super/filesystem extraction tools |
| IMS | unknown | expected inside logical partitions | blocked by missing super/filesystem extraction tools |
| TEE | unknown | expected inside logical partitions or firmware paths | blocked by missing super/filesystem extraction tools |
| keymaster | unknown | expected inside logical partitions | blocked by missing super/filesystem extraction tools |
| gatekeeper | unknown | expected inside logical partitions | blocked by missing super/filesystem extraction tools |
| fingerprint trustlets | unknown | expected inside logical partitions or firmware paths | blocked by missing super/filesystem extraction tools |
| DSP firmware | partial | `dspso.bin`; expected additional files inside logical partitions | top-level DSP image present; path-level coverage blocked |
| camera signed firmware | unknown | expected inside logical partitions | blocked by missing super/filesystem extraction tools |

## RETBR-vs-retus comparison limit

The package is the sorenlyulf-matched `-5` baseline, but the physical phone's
known build remains retus `RPFS31.Q1-21-20-1-7-3`. Without exact retus firmware,
the following cannot be compared:

- radio/modem firmware versions and carrier policy
- qcril database contents
- IMS APKs, libraries, and carrier configuration
- TEE, keymaster, gatekeeper, and fingerprint trustlets
- DSP and camera signed firmware versions
- any security-patch or AVB-coupled file deltas

## Disqualification check

Nothing visible at the ZIP/XML/package-info layer obviously disqualifies `-5`
as an offline reference baseline. The package is coherent for `def_retail`,
Android 11, `RPFS31.Q1-21-20-5`, and `1e3de`.

That is not a compatibility verdict. The main unresolved risk remains exactly
where expected: RETBR-vs-retus radio, IMS/qcril, and security-coupled TEE /
keymaster / gatekeeper / fingerprint families.

## Still unsafe for live use

The following remain unsafe and unauthorized:

- flashing `radio.img`, `boot.img`, `recovery.img`, `dtbo.img`, `vbmeta.img`,
  `super` chunks, bootloader, or any partition image
- importing blobs into `vendor/motorola`
- building against these blobs
- treating RETBR `-5` as equivalent to retus `-1-7-3`
- using any file as a rollback or recovery asset for the physical phone

## Current decision

Channel-sensitive review remains metadata-only. The next step should be
continued hold until a known safe local sparse/super extraction toolchain is
approved or provided for a no-import extraction script dry run. The approval
criteria are defined in `reports/offline_extraction_toolchain_gate.md`.

The Phase 2 readiness pass in
`reports/offline_extraction_toolchain_readiness.md` confirmed the missing
toolchain, so qcril, IMS, TEE, keymaster, gatekeeper, fingerprint trustlets, DSP
filesystem payloads, and camera signed firmware remain uninspected.
