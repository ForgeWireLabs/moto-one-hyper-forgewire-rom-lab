# Firmware Package Inventory - RPFS31.Q1-21-20-5 RETBR

Status: Route B offline extraction inventory complete; use still blocked

Date: 2026-07-01

## Safety boundary

This report records an offline local package inventory only.

No phone was touched. No adb, fastboot, LMSA/RSA, rescue, repair, flashing,
root, blob import, or build action was performed. Firmware and extracted images
remain outside Git under `C:\Projects\moto-one-hyper-local`.

## Artifact

| Field | Value |
|---|---|
| Filename | `stockrom.net_RETBR_DEF_RETAIL_RPFS31.Q1-21-20-5_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip` |
| Local path | `C:\Projects\moto-one-hyper-local\firmware\stockrom.net_RETBR_DEF_RETAIL_RPFS31.Q1-21-20-5_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip` |
| Size | `2426597680` bytes |
| Expected SHA256 | `BD781F671497ED3E34A6EBD38D4C7C82FF1B27312FDCBE9878B962348566163D` |
| Recomputed SHA256 | `BD781F671497ED3E34A6EBD38D4C7C82FF1B27312FDCBE9878B962348566163D` |
| Verification result | match |
| Local checksum record | `C:\Projects\moto-one-hyper-local\checksums\RPFS31.Q1-21-20-5_RETBR.zip.sha256` |
| Local ZIP listing log | `C:\Projects\moto-one-hyper-local\logs\route_b_retbr_zip_listing_slt.log` |
| Local extraction root | `C:\Projects\moto-one-hyper-local\extracted\RPFS31.Q1-21-20-5_RETBR` |

## ZIP top-level contents

The ZIP has 25 top-level entries and no nested directories.

| Entry | Size bytes | Role |
|---|---:|---|
| `boot.img` | 67108864 | boot image |
| `recovery.img` | 67108864 | standalone recovery image |
| `dtbo.img` | 25165824 | DTBO image |
| `vbmeta.img` | 4096 | AVB vbmeta image |
| `radio.img` | 94938880 | modem/radio package image |
| `BTFM.bin` | 766028 | Bluetooth firmware package |
| `dspso.bin` | 33554432 | DSP image |
| `bootloader.img` | 14136064 | bootloader package image |
| `gpt.bin` | 211712 | partition table image |
| `logo.bin` | 6098944 | logo image |
| `super.img_sparsechunk.0` through `.8` | 4071248380 total | sparse super chunks |
| `flashfile.xml` | 3122 | Motorola flash script metadata |
| `servicefile.xml` | 2811 | Motorola service flash script metadata |
| `DEF_RETAIL_RPFS31.Q1-21-20-5_subsidy-DEFAULT_regulatory-DEFAULT_CFC.info.txt` | 945 | package build metadata |
| `slcf_rev_d_default_v1.0.nvm` | 0 | subsidy-lock config placeholder |
| `regulatory_info_default.png` | 0 | eLabel placeholder |
| `_ stockrom.net INSTALACAO - INSTALL FOR MOTOROLA.url` | 164 | mirror shortcut |

No `payload.bin` is present. No monolithic `super.img` is present; the package
uses `super.img_sparsechunk.0` through `super.img_sparsechunk.8`.

## XML and servicefile metadata

Both `flashfile.xml` and `servicefile.xml` report:

| XML field | Value |
|---|---|
| `phone_model` | `def_retail` |
| `software_version` | `def_retail-user 11 RPFS31.Q1-21-20-5 1e3de release-keysM6150_09.297.01.61R` |
| `sparsing enabled` | `true` |
| `max-sparse-size` | `536870912` |
| interface | `AP` |

`flashfile.xml` additionally names `slcf_rev_d_default_v1.0.nvm` and
`regulatory_info_default.png`, both zero-byte placeholders in the ZIP.

## Package build/channel claims

The package info file reports:

| Field | Value |
|---|---|
| SW Version | `def_retail-user 11 RPFS31.Q1-21-20-5 1e3de release-keysM6150_09.297.01.61R` |
| Modem Version | `M6150_09.297.01.61R` |
| FSG Version | `FSG-6150-10.14` |
| MBM Version | `MBM-3.0-def_retail-ddf947084-210707` |
| Build Fingerprint | `motorola/def_retail/def:11/RPFS31.Q1-21-20-5/1e3de:user/release-keys` |
| System Version | `30.201.5.def_retail.retail.en.US` |
| Android Version | `11` |
| Build Id | `RPFS31.Q1-21-20-5` |
| Build Date | `Wed Jul 7 05:04:22 CDT 2021` |
| AB Update Enabled | `False` |
| Full Treble Enabled | `False` |

The artifact filename and acquisition report classify the mirror package as
RETBR. The embedded package metadata says `def_retail` and
`def_retail.retail.en.US`; it does not by itself prove retus compatibility.

## Presence checks

| Artifact family | Observed result |
|---|---|
| `payload.bin` | absent |
| Sparse chunks | present: `super.img_sparsechunk.0` through `.8` |
| Image files | present |
| `boot.img` | present |
| `recovery.img` | present |
| `vendor_boot.img` | absent |
| `dtbo.img` | present |
| `vbmeta.img` | present |
| `super.img` | absent as monolithic image |
| `super.img_sparsechunk.*` | present |
| `NON-HLOS.bin` | absent under that name |
| Modem/radio files | present as `radio.img`; modem version reported in info text |
| XML flash scripts | present: `flashfile.xml`, `servicefile.xml` |

## Local extraction result

Offline extraction completed under:

`C:\Projects\moto-one-hyper-local\extracted\RPFS31.Q1-21-20-5_RETBR`

Local-only extraction log:

`C:\Projects\moto-one-hyper-local\logs\route_b_retbr_extract.log`

Local-only extracted-file checksums:

`C:\Projects\moto-one-hyper-local\checksums\RPFS31.Q1-21-20-5_RETBR_extracted_files.sha256`

No extracted firmware, image, sparse chunk, binary, blob, or checksum file is
committed to Git by this report.
