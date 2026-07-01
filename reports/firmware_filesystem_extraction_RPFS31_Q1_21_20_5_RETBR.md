# Firmware Filesystem Extraction - RPFS31.Q1-21-20-5 RETBR

Status: blocked by missing local sparse/super filesystem tools

Date: 2026-07-01

## Safety boundary

This was an offline tool and environment discovery pass for the already acquired
and extracted Route B RETBR `-5` artifact only.

No phone was touched. No adb, fastboot, LMSA/RSA, rescue, repair, flashing,
root, new firmware download, blob import, or build action was performed. No
firmware image, sparse chunk, filesystem, checksum, blob, or log file is
committed to Git.

## Local inputs

| Input | Path | State |
|---|---|---|
| Existing extraction root | `C:\Projects\moto-one-hyper-local\extracted\RPFS31.Q1-21-20-5_RETBR` | present |
| Derived filesystem extraction root | `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_5_RETBR_filesystems` | not created by this pass |
| Logs root | `C:\Projects\moto-one-hyper-local\logs` | available |
| Checksums root | `C:\Projects\moto-one-hyper-local\checksums` | available |
| Audits root | `C:\Projects\moto-one-hyper-local\audits` | available |

The existing extraction root contains the known `super.img_sparsechunk.0`
through `.8` files plus top-level package images and XML metadata.

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
| Which images/chunks were unpacked successfully? | None in this pass. Prior ZIP extraction remains complete; sparse/super filesystem extraction did not start. |
| Was `super.img` or super sparse chunks reconstructed? | No. `simg2img` or equivalent is missing. |
| Which logical partitions were found? | None could be enumerated. `lpunpack` or equivalent is missing. |
| Were `vendor`, `product`, `odm`, `system_ext`, `system`, `vendor_dlkm`, or `odm_dlkm` found? | Not checkable in this environment. |
| Which filesystems were encountered? | Not checkable because logical partitions were not unpacked. |
| Which tools were used? | PowerShell, `python` availability check, `7z` availability check, `tar` availability check, `where.exe`, repo/local file discovery. |
| Which steps failed or were blocked? | Sparse reconstruction, dynamic partition unpacking, and filesystem inspection are blocked by missing local tools. |
| Did inspection stay local-only and offline? | Yes. Only existing local files and local tool availability were inspected. |

## Current decision

The approved sparse/super filesystem extraction slice is blocked by missing
local tooling. Per the gate instruction, no random tools were installed or
downloaded, and no unsafe workaround was attempted.
