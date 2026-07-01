# Firmware Route B RETBR Acquisition Report

Status: acquisition complete; extraction/use still blocked

Date: 2026-06-30

## Safety boundary

This was artifact acquisition only.

No extraction was performed.
No firmware images were inspected.
No phone was touched.
No LMSA/RSA Rescue flow was started.
No adb or fastboot command was run.
No root action was attempted.
No blob import was performed.
No build attempt was started.
No firmware/image/blob artifact was committed to Git.

## Why Route B was opened

Route A was attempted safely and stopped at the approved boundary. Software Fix /
LMSA-RSA identified the phone as `XT2027-1` on Android `11` with current version
`RPFS31.Q1-21-20-1-7-3`, but it did not expose firmware package metadata before
the hard stop. The visible firmware-relevant path was `Start Rescue`, making the
official tool path write-coupled for this workflow.

Because exact retus `RPFS31.Q1-21-20-1-7-3` remains unavailable without crossing
that Rescue boundary, Jeremy/GPT opened Route B for acquisition only: the
provisional `RPFS31.Q1-21-20-5` / `1e3de` / RETBR package.

## Candidate chosen

Chosen artifact:

`stockrom.net_RETBR_DEF_RETAIL_RPFS31.Q1-21-20-5_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip`

Why this candidate:

- It is the best-corroborated same-family metadata candidate.
- It matches sorenlyulf's `BUILD_FINGERPRINT` base exactly:
  `def:11/RPFS31.Q1-21-20-5/1e3de`.
- The def proprietary-files manifest was extracted from this `-5` base.
- The known risk is localized to channel-sensitive modem/radio and
  TEE/keymaster families.
- It is RETBR, not retus, so it is not a flashing or blob-use approval.

## Source classification

| Source | Classification | Result |
|---|---|---|
| Motorola / LMSA / RSA | official | Route A attempted; metadata unavailable before write-coupled `Start Rescue` hard stop |
| Android Dumps | dump metadata | Corroborates `def_retail-user-11-RPFS31.Q1-21-20-5-1e3de`; not a flashable package source for this gate |
| Rom Stock BR / StockRom page | aggregator / mirror metadata | Exposes exact filename, build, tag, device/channel claims, size, and Google Drive mirror |
| Android File Host mirror | mirror | Target file id was checked, but the page returned HTTP 522 during this pass |
| Google Drive mirror linked from Rom Stock BR / StockRom | mirror | Selected because it exposed the exact target filename and size via a direct virus-scan-warning download form, without an installer executable |
| Opaque downloader EXEs / alternate builds | rejected | Not used |

The selected source is not official. It is a documented mirror path for the
provisional RETBR artifact.

## Claimed build, channel, and device

Claimed by source filename and source page metadata:

- Device/model family: `XT2027-1` / Motorola One Hyper / `def`
- Product/channel label: `RETBR_DEF_RETAIL`
- Build: `RPFS31.Q1-21-20-5`
- Build tag/hash: `1e3de`
- Android: `11`
- Package type: full firmware/XML ZIP claim
- Source-stated size: approximately `2.3G`

## Local artifact

Local-only path:

`C:\Projects\moto-one-hyper-local\firmware\stockrom.net_RETBR_DEF_RETAIL_RPFS31.Q1-21-20-5_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip`

The artifact was not copied into the Git repository.

## File size

- Size: `2426597680` bytes
- Approximate size: `2.26 GiB`

## Local hashes

Hashes were computed locally after download:

| Algorithm | Hash |
|---|---|
| SHA256 | `BD781F671497ED3E34A6EBD38D4C7C82FF1B27312FDCBE9878B962348566163D` |
| SHA1 | `E6AE4A227926983CFF4DE0583061186FB7E9E59E` |
| MD5 | `466AA767542D92453371122577D76E42` |

Local-only checksum record:

`C:\Projects\moto-one-hyper-local\checksums\stockrom.net_RETBR_DEF_RETAIL_RPFS31.Q1-21-20-5_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip.hashes.txt`

## Acquisition commands

Local-only directories were prepared:

```powershell
New-Item -ItemType Directory -Force `
  'C:\Projects\moto-one-hyper-local\firmware',
  'C:\Projects\moto-one-hyper-local\checksums',
  'C:\Projects\moto-one-hyper-local\logs',
  'C:\Projects\moto-one-hyper-local\audits'
```

The Google Drive warning page was fetched read-only and saved outside Git to
document the visible filename and size:

```powershell
Invoke-WebRequest -Uri 'https://drive.usercontent.google.com/download?id=1RT8EMMbD10XoTK-IWfClW_-5vCN-pajI&export=download'
```

The exact selected artifact was then downloaded to the local-only firmware
directory:

```powershell
curl.exe -L --fail --retry 3 --retry-delay 5 `
  --output 'C:\Projects\moto-one-hyper-local\firmware\stockrom.net_RETBR_DEF_RETAIL_RPFS31.Q1-21-20-5_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip' `
  'https://drive.usercontent.google.com/download?id=1RT8EMMbD10XoTK-IWfClW_-5vCN-pajI&export=download&confirm=t&uuid=81803575-58bd-454b-80e2-e0e234f0a2ce'
```

Hashes were computed with:

```powershell
Get-FileHash -Algorithm SHA256 <local zip>
Get-FileHash -Algorithm SHA1 <local zip>
Get-FileHash -Algorithm MD5 <local zip>
```

## Evidence that no extraction occurred

No extraction commands were run.

The local extraction root was checked after acquisition and no extracted firmware
contents were produced by this pass:

`C:\Projects\moto-one-hyper-local\extracted`

The committed repository contains only report changes. No ZIP, payload, image,
blob, or extracted firmware content was added to Git.

## Evidence that no phone/device action occurred

No phone was connected or touched for Route B.
No LMSA/RSA Rescue flow was used for Route B.
No adb command was run.
No fastboot command was run.
No root action was attempted.
No flashing or write action occurred.

## Caveats

- This package is RETBR, not retus.
- It is not the phone's current retus `RPFS31.Q1-21-20-1-7-3` build.
- It is not approved for flashing.
- It is not approved for blob import.
- It is not approved for extraction.
- Offline extraction still requires separate Jeremy/GPT approval.
- Any future inspection must keep proprietary artifacts local-only and must not
  imply compatibility with the phone's retus modem/radio/TEE/keymaster stack
  without evidence.
