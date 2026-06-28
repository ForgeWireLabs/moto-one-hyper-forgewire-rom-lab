# Firmware source candidates

Date checked: 2026-06-27

Target:

- Device: Motorola One Hyper
- SKU: XT2027-1
- Product/device: `def`
- Build target/name: `def_retail`
- Channel: `retus`
- Installed build: `RPFS31.Q1-21-20-1-7-3`

## First-party RSA / Software Fix

Status: not acquired.

Findings:

- `C:\ProgramData\LMSA` and `C:\ProgramData\RSA` were checked for firmware
  package indicators.
- No files over 10 MB or matching `RomFiles`, `XT2027`, `DEF`, `def`,
  `RPFS31`, `boot`, `.zip`, `.img`, `.xml`, `.bin`, or `.gz` appeared during
  the checks.
- Software Fix was launched while the phone was in fastboot mode.
- No matching LMSA/RSA firmware artifacts appeared during a 90-second watch.

Executable found:

- `C:\Program Files\Software Fix\Software Fix.exe`

## HalabTech candidate

Status: exact metadata candidate; package not downloaded; contents not verified.

URL:

- `https://support.halabtech.com/index.php?a=downloads&b=file&id=583378`

Observed metadata:

- Title: `(XT2027-1-DS) (PAGR0029US) (Carrier Retail - USA - UMTS_LTE) (Android 11) DEF_RETAIL_RPFS31.Q1-21-20-1-7-3_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip`
- Published: `2022-02-08T18:29:49+00:00`
- Content size: `2.26 GB`

Download status:

- Direct download endpoint probe returned HTTP 403 with Cloudflare challenge
  headers.
- No ZIP was downloaded.
- No `boot.img`, XML, or hash verification has been performed.

## Filewale candidate

Status: exact metadata candidate; package not downloaded; contents not verified.

URL:

- `https://filewale.com/files/motorola-one-hyper-xt2027-1-def-retail-rpfs31-q1-21-20-1-7-3-subsidy-default-regulatory-default-cfc-filewale-com-xml-zip/48750`

Observed metadata:

- Title: `Motorola One Hyper XT2027-1 DEF_RETAIL_RPFS31.Q1-21-20-1-7-3_subsidy-DEFAULT_regulatory-DEFAULT_CFC_Filewale.com.xml.zip`
- Folder ancestry includes `Motorola One Hyper XT2027-1` -> `retus`
- File item id: `48750`
- Size: `2426656522` bytes
- Description: `Download Motorola One Hyper XT2027-1 Flash File/Stock ROM`

Download status:

- The page is publicly readable, but the client bundle gates downloads through
  `/api/v1/subscriptions/request-download`.
- No ZIP was downloaded.
- No `boot.img`, XML, or hash verification has been performed.

## Verification requirement before use

Do not patch or flash any image from these candidates until a package is
downloaded and verified:

1. Filename/build matches `RPFS31.Q1-21-20-1-7-3`.
2. Package contains `boot.img`.
3. `flashfile.xml` or `servicefile.xml` references expected Motorola partitions.
4. Package metadata is consistent with `XT2027-1 / def_retail / retus`.
5. Package SHA256 is recorded locally.
6. Extracted stock `boot.img` SHA256 is recorded locally.
