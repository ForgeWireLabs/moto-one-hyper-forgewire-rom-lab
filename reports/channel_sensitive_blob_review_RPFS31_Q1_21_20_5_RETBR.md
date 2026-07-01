# Channel-Sensitive Blob Review - RPFS31.Q1-21-20-5 RETBR

Status: channel-sensitive vendor evidence found; live use still blocked

Date: 2026-07-01

## Safety boundary

This report reviews channel-sensitive evidence from the local-only Route B
package and `vendor_a` inspection. It does not approve blob use, flashing, build
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
| modem / NON-HLOS / radio | present | `radio.img`; modem/FSG versions; `vendor_a` radio directory and radio HAL libraries | channel-sensitive, RETBR not retus |
| qcril | present | `qcrild`, `qcrild.rc`, `libqcrilFramework.so`, `qcrild_librilutils.so`, RIL/QTI radio libraries | channel-sensitive, not compared to retus |
| IMS | present | IMS rc files; `lib-imscmservice.so`, `lib-ims*` libraries; `vendor.qti.hardware.radio.ims@*`; `vendor.qti.ims*` libraries | channel-sensitive, not compared to retus |
| TEE | present | `vendor.qti.hardware.qseecom@1.0-service`, `vendor.qti.hardware.qteeconnector@1.0-service`, `libQSEEComAPI.so` | security-coupled, not compared to retus |
| keymaster | present | keymaster service rc/binaries and `libkeymaster*`, `libqtikeymaster4.so` | security-coupled, not compared to retus |
| gatekeeper | present | `android.hardware.gatekeeper@1.0-service-qti`, rc, and impl library | security-coupled, not compared to retus |
| fingerprint trustlets | present at HAL/library level | Egistec fingerprint service and libraries; QTI fingerprint library | trustlet/version details still need deeper review |
| DSP firmware | present | top-level `dspso.bin`; vendor `dsp`/`firmware` directories; QTI DSP services | signed firmware risk remains |
| camera signed firmware | present at config/library/firmware level | `CAMERA_ICP.elf`, camera provider, QTI CHI libraries, camera/media config | signed firmware risk remains |

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

Channel-sensitive artifacts are present in the RETBR `-5` vendor evidence, but
none have been compared to exact retus `RPFS31.Q1-21-20-1-7-3` firmware. This
does not disqualify `-5` as an offline evidence baseline, but it keeps flashing,
blob import, build use, and live-device use blocked.
