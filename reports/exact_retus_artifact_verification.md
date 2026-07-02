# Exact RETUS Artifact Verification

Status: exact RETUS artifact verified as local-only evidence; no flashing, import, or build authorized

## Artifact

Local-only firmware ZIP:

- `C:\Projects\moto-one-hyper-local\firmware\XT2027-1_DEF_RETUS_11_RPFS31.Q1-21-20-1-7-3_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip`

This artifact is not committed and must remain outside Git.

## File verification

| Field | Value |
|---|---|
| Size | `2,427,793,578 bytes` |
| SHA256 | `907E380CF26758F9B5E4B2E05AC663123A526FEEFFB40A9E28D72D4568ADD7B8` |
| ZIP entry count | `24` |
| XML entries | `flashfile.xml`, `servicefile.xml` |
| Sparse super chunks | `super.img_sparsechunk.0` through `super.img_sparsechunk.8` |
| Info file | `DEF_RETAIL_RPFS31.Q1-21-20-1-7-3_subsidy-DEFAULT_regulatory-DEFAULT_CFC.info.txt` |

## Metadata confirmation

The package metadata confirms the required Route A target.

From the package info file:

| Field | Value |
|---|---|
| SW Version | `def_retail-user 11 RPFS31.Q1-21-20-1-7-3 37074e release-keysM6150_09.297.01.68R` |
| Modem Version | `M6150_09.297.01.68R` |
| FSG Version | `FSG-6150-10.15` |
| MBM Version | `MBM-3.0-def_retail-ddf947084-220105` |
| Build Fingerprint | `motorola/def_retail/def:11/RPFS31.Q1-21-20-1-7-3/37074e:user/release-keys` |
| System Version | `30.201.3.def_retail.retail.en.US` |
| Android Version | `11` |
| Build Id | `RPFS31.Q1-21-20-1-7-3` |
| SW Display Build ID | `RPFS31.Q1-21-20-1-7-3` |
| Build Date | `Wed Jan 5 07:58:51 CST 2022` |
| Blur Version | `Blur_Version.30.201.3.def_retail.retail.en.US` |
| CPV Version | `def_retail-user 11 RPFS31.Q1-21-20-1-7-3 37074e release-keys` |

## XML confirmation

Both `flashfile.xml` and `servicefile.xml` declare:

| Field | Value |
|---|---|
| phone_model | `def_retail` |
| software_version | `def_retail-user 11 RPFS31.Q1-21-20-1-7-3 37074e release-keysM6150_09.297.01.68R` |
| sparsing | `enabled=true`, `max-sparse-size=536870912` |
| interface | `AP` |

Both XML files list flash steps for:

- `gpt.bin`
- `bootloader.img`
- `vbmeta.img`
- `radio.img`
- `BTFM.bin`
- `dspso.bin`
- `logo.bin`
- `boot.img`
- `dtbo.img`
- `recovery.img`
- `super.img_sparsechunk.0` through `super.img_sparsechunk.8`

## Safety observation

The XML files contain destructive or device-affecting steps.

`flashfile.xml` includes erase steps for:

- `carrier`
- `userdata`
- `metadata`
- `ddr`

`servicefile.xml` includes erase steps for:

- `carrier`
- `ddr`

These XML files are evidence only. They must not be executed by this project.

## Decision

The exact RETUS Route A firmware artifact is now locally available and verified
as matching:

| Required target field | Verified value |
|---|---|
| Product | `def_retail` |
| Codename | `def` |
| Android | `11` |
| Build | `RPFS31.Q1-21-20-1-7-3` |
| Fingerprint tail | `37074e` |
| Region/channel evidence | `retail.en.US` / `RETUS filename and path` |

Route A is now the authoritative firmware evidence path for offline comparison.

Route B RETBR remains useful comparison evidence only and must not be treated as
substitution authority.

## Next evidence step

The next safe step is offline reconstruction and inventory of the exact RETUS
`super` image from the local-only sparse chunks, followed by exact RETUS
vendor/non-vendor line coverage comparison.

This must occur under the local-only workspace:

- `C:\Projects\moto-one-hyper-local\extracted`

No extracted images, sparse chunks, filesystem trees, blobs, generated vendor
trees, or raw CSV inventories may be committed.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- RETBR substitution;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
