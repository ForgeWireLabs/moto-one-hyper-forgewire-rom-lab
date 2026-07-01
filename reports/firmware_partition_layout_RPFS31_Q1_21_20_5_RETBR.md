# Firmware Partition Layout - RPFS31.Q1-21-20-5 RETBR

Status: observed package layout; no script execution

Date: 2026-07-01

## Safety boundary

This is a metadata report from ZIP listing, offline extraction, XML reading, and
file-header inspection only. No XML script was executed. No phone, adb,
fastboot, LMSA/RSA, rescue, repair, root, flash, erase, wipe, mount, blob import,
or build action was performed.

## Observed image and chunk files

| File | Size bytes | Header evidence |
|---|---:|---|
| `gpt.bin` | 211712 | package partition table image |
| `bootloader.img` | 14136064 | begins `SINGLE_N_LONELY` |
| `vbmeta.img` | 4096 | begins `AVB0` |
| `radio.img` | 94938880 | begins `SINGLE_N_LONELY` |
| `BTFM.bin` | 766028 | Bluetooth firmware package |
| `dspso.bin` | 33554432 | DSP image |
| `logo.bin` | 6098944 | logo image |
| `boot.img` | 67108864 | begins `ANDROID!` |
| `dtbo.img` | 25165824 | DTBO header evidence observed |
| `recovery.img` | 67108864 | begins `ANDROID!` |
| `super.img_sparsechunk.0` through `.8` | 4071248380 total | sparse magic observed on chunk 0 |

## A/B partition evidence

The extracted package does not expose `_a` or `_b` image filenames and the XML
flash targets are unsuffixed (`boot`, `dtbo`, `recovery`, `vbmeta`, `super`,
etc.).

The package info text reports `AB Update Enabled: False`, while earlier device
profile evidence for the physical phone still records A/B-style partition
observations. This package should therefore be treated as XML-flash layout
evidence, not as proof that the phone's active-slot state is safe or irrelevant.

## Dynamic super evidence

Dynamic/super evidence is strong:

- `super.img_sparsechunk.0` through `super.img_sparsechunk.8` are present.
- XML `sparsing enabled` is `true`.
- XML `max-sparse-size` is `536870912`.
- All sparse chunks target partition `super`.

No monolithic `super.img` was present and no sparse/super image was mounted,
converted, or unpacked in this pass.

## Boot, recovery, vendor_boot, dtbo, and vbmeta evidence

| Artifact | Evidence |
|---|---|
| `boot.img` | present, Android boot-image header observed |
| `recovery.img` | present, Android boot-image header observed |
| `vendor_boot.img` | absent |
| `dtbo.img` | present, DTBO header evidence observed |
| `vbmeta.img` | present, AVB `AVB0` header observed |

Because `recovery.img` is present as a standalone file and `vendor_boot.img` is
absent, this package appears to use a standalone recovery partition rather than
a vendor_boot-mediated recovery layout. It does not prove that boot-as-recovery
is impossible on other related builds; it only describes this package.

## Modem and NON-HLOS evidence

No `NON-HLOS.bin` file is present. Radio/modem evidence appears as:

- `radio.img` targeting partition `radio`.
- package info `Modem Version: M6150_09.297.01.61R`.
- package info `FSG Version: FSG-6150-10.14`.
- XML target `bluetooth` for `BTFM.bin`.
- XML target `dsp` for `dspso.bin`.

The radio family is channel-sensitive and remains the first RETBR-vs-retus risk
area for any later analysis.

## XML flash order

The XML metadata orders flash targets as follows:

1. `getvar max-sparse-size`
2. `oem fb_mode_set`
3. `partition` from `gpt.bin`
4. `bootloader` from `bootloader.img`
5. `vbmeta` from `vbmeta.img`
6. `radio` from `radio.img`
7. `bluetooth` from `BTFM.bin`
8. `dsp` from `dspso.bin`
9. `logo` from `logo.bin`
10. `boot` from `boot.img`
11. `dtbo` from `dtbo.img`
12. `recovery` from `recovery.img`
13. `super` from `super.img_sparsechunk.0` through `.8`
14. `oem fb_mode_clear`

`flashfile.xml` also contains erase steps for `carrier`, `userdata`,
`metadata`, and `ddr`. `servicefile.xml` contains erase steps for `carrier` and
`ddr`. These erase steps were observed only as text metadata and were not
executed.

## Current decision

This package is useful as an offline structural reference for the `-5` RETBR
baseline. It is not accepted for flashing, blob import, or build use. No XML
script execution is authorized.
