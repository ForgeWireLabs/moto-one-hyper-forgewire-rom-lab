# Firmware Filesystem Extraction - RPFS31.Q1-21-20-5 RETBR

Status: local-only WSL filesystem inspection complete; use still blocked

Date: 2026-07-01

## Safety boundary

This report now includes the local-only WSL extraction evidence handed off under
`C:\Projects\moto-one-hyper-local\audits`. The work inspected only the already
acquired and extracted Route B RETBR `-5` artifact.

No phone was touched. No adb, fastboot, LMSA/RSA, rescue, repair, flashing,
root, new firmware download, blob import, or build action was performed. No
firmware image, sparse chunk, filesystem tree, checksum, blob, or log file is
committed to Git.

## Local inputs

| Input | Path | State |
|---|---|---|
| Existing extraction root | `C:\Projects\moto-one-hyper-local\extracted\RPFS31.Q1-21-20-5_RETBR` | present |
| Derived filesystem extraction root | `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_5_RETBR_filesystems` | present locally; not committed |
| Logs root | `C:\Projects\moto-one-hyper-local\logs` | available |
| Checksums root | `C:\Projects\moto-one-hyper-local\checksums` | available |
| Audits root | `C:\Projects\moto-one-hyper-local\audits` | available |

The existing extraction root contains the known `super.img_sparsechunk.0`
through `.8` files plus top-level package images and XML metadata.

## Toolchain used in local-only pass

The local handoff summary reports WSL/Debian tooling:

- `simg2img` / `img2simg` from `android-sdk-libsparse-utils`
- `file`
- `debugfs` / `fsck.ext4` from `e2fsprogs`
- `erofs-utils`
- `7zip`

The pass also confirms these remained absent during the WSL run:

- `adb`
- `fastboot`
- `lpunpack`
- `lpdump`
- `lpmake`

Dynamic partition metadata was parsed with a local stdlib Python helper, not
with `lpunpack`.

## Tool discovery

| Tool | Result | Notes |
|---|---|---|
| `python` | found | `C:\Program Files\Python312\python.exe` |
| `7z` | found | `C:\Users\jerem\scoop\shims\7z.exe` |
| `tar` | found | `C:\WINDOWS\system32\tar.exe` |
| `simg2img` | missing | required to reconstruct Android sparse chunks to raw image |
| `lpunpack` | missing | required to unpack Android dynamic partitions from raw super image |
| `payload-dumper-go` | missing | not needed for this ZIP because no `payload.bin` exists |
| `payload_dumper` | missing | not needed for this ZIP because no `payload.bin` exists |
| `fsck.erofs` / `dump.erofs` / `extract.erofs` | missing | needed if logical partitions are EROFS |
| `debugfs` | missing | useful for ext-family filesystem inspection without mounting |
| `wsl` | present but not usable | command returns WSL usage/help; no runnable distro/tool surface was available |

Additional focused checks through `where.exe`, the repo, Scoop, common Android
locations, and local project paths found no bundled `simg2img`, `lpunpack`,
payload dumper, EROFS, or ext inspection tool.

## Extraction questions

| Question | Answer |
|---|---|
| Which images/chunks were unpacked successfully? | `super.img_sparsechunk.0` through `.8` were reconstructed into local-only `super.raw.img`; logical images `system_a.img`, `system_b.img`, `vendor_a.img`, and `product_a.img` were carved. |
| Was `super.img` or super sparse chunks reconstructed? | Yes. Local-only `super.raw.img` is `9730785280` bytes with SHA256 `E8212B7EF8CBCC68D079268E287725A5E3C31AE9DD068B0534BD6925EC009C46`. |
| Which logical partitions were found? | `system_a`, `system_b`, `vendor_a`, `vendor_b`, `product_a`, `product_b`. `vendor_b` and `product_b` are zero-size and were skipped. |
| Were `vendor`, `product`, `odm`, `system_ext`, `system`, `vendor_dlkm`, or `odm_dlkm` found? | Found logical images for `vendor_a`, `product_a`, `system_a`, and `system_b`. No `odm`, `system_ext`, `vendor_dlkm`, or `odm_dlkm` logical partition appeared in the parsed metadata. |
| Which filesystems were encountered? | The carved logical images were ext-family filesystems. `vendor_a` volume name is `vendor`; `product_a` volume name is `product`; `system_b` volume name is `system`. |
| Which tools were used? | WSL/Debian `simg2img`, `file`, `debugfs`/`fsck.ext4`, `erofs-utils`, `7zip`, and a local stdlib Python helper for liblp metadata/carving. |
| Which steps failed or were blocked? | `lpunpack`/`lpdump` were absent, so dynamic metadata parsing/carving used a local helper. No full manifest coverage comparator was run in this handoff. |
| Did inspection stay local-only and offline? | Yes. No phone, adb, fastboot, LMSA/RSA, flashing, mounting, build, or blob import occurred. |

## Dynamic partition metadata

Local-only metadata summary:

| Field | Value |
|---|---|
| Super raw path | `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_5_RETBR_filesystems\super.raw.img` |
| Super raw size | `9730785280` bytes |
| Super raw SHA256 | `E8212B7EF8CBCC68D079268E287725A5E3C31AE9DD068B0534BD6925EC009C46` |
| Metadata header offset | `12288` |
| Block device | `super` |
| Groups | `default`, `mot_dp_group_a`, `mot_dp_group_b` |

Logical images:

| Image | Size bytes | SHA256 | Status |
|---|---:|---|---|
| `system_a.img` | 1383415808 | `F633EEE72B3C1C82963A732535182A0CC9F15AD9A383ABA2DA072CCB4082669A` | carved |
| `system_b.img` | 173801472 | `9FD1C7F186C100BEFE5B66145FBB5B2EF38D40F34547FB1208E805A419A22B78` | carved |
| `vendor_a.img` | 616878080 | `5D6D04D5CFB45D159AD25535D94E60811191F1E1E5193069E53EFF8D7D84F375` | carved |
| `product_a.img` | 2414997504 | `9E669D00C122B91EB491CB01EDA5763878646A924E7F5E61FE97EBE6ED49EC98` | carved |
| `vendor_b` | 0 | n/a | skipped zero-size |
| `product_b` | 0 | n/a | skipped zero-size |

## Local-only evidence paths

Report-safe local inputs used for this update:

- `C:\Projects\moto-one-hyper-local\audits\retbr_wsl_extraction_summary_20260701.md`
- `C:\Projects\moto-one-hyper-local\audits\super_liblp_metadata_RPFS31_Q1_21_20_5_RETBR.json`
- `C:\Projects\moto-one-hyper-local\audits\super_liblp_carve_summary_RPFS31_Q1_21_20_5_RETBR.json`
- `C:\Projects\moto-one-hyper-local\audits\vendor_a_report_safe_inventory_RPFS31_Q1_21_20_5_RETBR.txt`

## Current decision

Offline filesystem inspection is complete enough to prove the RETBR `-5`
package is a valid local evidence source for `def` / `sm6150` vendor analysis.
It is not flashing approval, blob import approval, or build approval.

The remaining safe no-phone work is a report-safe manifest coverage comparator
or another concise evidence summary. Full filesystem trees, images, blobs,
checksums, logs, and raw inventories stay out of Git.
