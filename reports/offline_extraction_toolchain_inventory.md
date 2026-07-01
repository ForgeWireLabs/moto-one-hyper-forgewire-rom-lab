# Offline Extraction Toolchain Inventory

Status: partial inventory plus local WSL handoff summary

Date: 2026-07-01

## Safety boundary

Inventory only for the Codex pre-handoff pass, plus summary of the later
local-only WSL handoff. No phone action, adb, fastboot, LMSA/RSA, flashing, blob
import, or build attempt occurred.

Tool checksum records were written only under:

`C:\Projects\moto-one-hyper-local\checksums\tools`

## Inventory

| Tool | Version command output | Source/provenance | Local path | SHA256 | Offline runnable? | Invokes adb/fastboot/device enumeration? | Approved use in this lab |
|---|---|---|---|---|---|---|---|
| 7-Zip | `7-Zip 26.00 (x64)` | existing Scoop shim / local install | `C:\Users\jerem\scoop\shims\7z.exe` | `140E3801D8ADEDA639A21B14E62B93A4C7D26B7A758421F43C82BE59753BE49B` | yes | no evidence from version/listing command | archive listing/extraction only |
| Python | `Python 3.12.4` | existing local Python install | `C:\Program Files\Python312\python.exe` | `FD5C46D73D29BA21B04C844BBAF9096066136526911230645A2A040D23FB612B` | yes | no | repo-local stdlib helper scripts only |
| tar | `bsdtar 3.5.2 - libarchive 3.5.2` | Windows system tool | `C:\WINDOWS\system32\tar.exe` | `DFEF7A04A700B8C9A1D6249DC995C2E91A4BE7583D5B534ED4C9AEC546616478` | yes | no evidence from version command | fallback archive inspection only |
| Get-FileHash | PowerShell cmdlet | `Microsoft.PowerShell.Utility` | PowerShell built-in cmdlet | not applicable | yes | no | hashing local tools/artifacts |
| WSL executable | `wsl --status` returned WSL usage/help text | Windows system executable | `C:\WINDOWS\system32\wsl.exe` | `4E589E3883229B7A74A4ACDB878689DCEC94E2539FCAD1C194F415B149C337A9` | no usable distro surface observed | not used | not approved for extraction until a runnable distro route is approved |
| mke2fs | `mke2fs 1.47.2`; Android platform ext library | existing Android platform-tools | `C:\Android\platform-tools\mke2fs.exe` | `BE42ABB5D1651C8766E230E7AF834BD8E0F2085857CCB483463F58BA5AD65E1A` | yes | no evidence from version command | not approved for extraction; creation/check tooling only |
| e2fsck | `e2fsck 1.42.12` | existing Android SDK emulator tools | `C:\Android\Sdk\emulator\bin64\e2fsck.exe` | `1D73BDE638CBE2D19DC950A109ACCC5D47301060D5700631F77F950F0F281B32` | yes | no evidence from version command | not sufficient for extraction; possible future read-only filesystem check only after review |
| simg2img | missing | none found | none | none | no | unknown | required, not available |
| lpunpack | missing | none found | none | none | no | unknown | required, not available |
| EROFS tools | missing | none found | none | none | no | unknown | required if partitions use EROFS |
| payload dumper | missing | none found | none | none | no | unknown | not required for current ZIP; no `payload.bin` present |

## Local checksum files

Local-only checksum files created:

- `C:\Projects\moto-one-hyper-local\checksums\tools\7z.sha256`
- `C:\Projects\moto-one-hyper-local\checksums\tools\python312.sha256`
- `C:\Projects\moto-one-hyper-local\checksums\tools\tar.sha256`
- `C:\Projects\moto-one-hyper-local\checksums\tools\wsl.sha256`
- `C:\Projects\moto-one-hyper-local\checksums\tools\android-platform-tools-mke2fs.sha256`
- `C:\Projects\moto-one-hyper-local\checksums\tools\android-sdk-emulator-e2fsck.sha256`

No local checksum file is committed to Git.

## Current decision

The original Windows-side inventory was insufficient for filesystem extraction.
The later WSL handoff reports `simg2img` / `img2simg`, `file`,
`debugfs` / `fsck.ext4`, `erofs-utils`, and `7zip` were available; `adb`,
`fastboot`, `lpunpack`, `lpdump`, and `lpmake` were absent. The successful local
pass used `simg2img` plus a local stdlib Python liblp helper, not `lpunpack`.
