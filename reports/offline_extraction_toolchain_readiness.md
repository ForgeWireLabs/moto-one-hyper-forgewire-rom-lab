# Offline Extraction Toolchain Readiness

Status: superseded by local WSL handoff; see extraction report

Date: 2026-07-01

## Safety boundary

This is the pre-handoff repository/environment re-anchor and toolchain discovery
report. No tool was installed or downloaded by Codex in this pass. A later
local-only WSL handoff produced extraction evidence summarized in
`reports/firmware_filesystem_extraction_RPFS31_Q1_21_20_5_RETBR.md`.

## Phase 1 re-anchor

| Check | Result |
|---|---|
| Latest relevant commit | `073823b Document offline extraction toolchain gate` |
| Working tree at start | clean |
| Core reports present | yes |
| Route B artifact exists | yes |
| Artifact size | `2426597680` bytes |
| Artifact SHA256 | `BD781F671497ED3E34A6EBD38D4C7C82FF1B27312FDCBE9878B962348566163D` |
| SHA256 expected match | yes |

Artifact checked:

`C:\Projects\moto-one-hyper-local\firmware\stockrom.net_RETBR_DEF_RETAIL_RPFS31.Q1-21-20-5_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip`

## Current required tool status

| Category | Tool | Status | Reading |
|---|---|---|---|
| ZIP/archive | 7-Zip | present | usable for archive listing/extraction; already used in prior ZIP inventory |
| ZIP/archive | PowerShell / `tar` | present | available as fallback archive tooling |
| Checksum/logging | `Get-FileHash` | present | usable |
| Checksum/logging | Python 3.12.4 | present | usable for repo-local helpers if later approved |
| Android sparse conversion | `simg2img` | missing | required before `super.img_sparsechunk.*` can be reconstructed |
| Dynamic partition unpacking | `lpunpack` | missing | required before logical partitions can be listed/unpacked |
| OTA payload dumping | `payload-dumper-go` / `payload_dumper` | missing | not required for current ZIP because no `payload.bin` is present |
| EROFS inspection | `dump.erofs` / `fsck.erofs` / `extract.erofs` | missing | required if logical partitions use EROFS |
| ext inspection | read-only ext listing/extraction support | incomplete | Android SDK has `mke2fs`/`e2fsck`, but not a sufficient read-only extraction/listing workflow by itself |

## Already present and usable

| Tool | Version evidence | Source/path |
|---|---|---|
| 7-Zip | `7-Zip 26.00 (x64)` | `C:\Users\jerem\scoop\shims\7z.exe` |
| Python | `Python 3.12.4` | `C:\Program Files\Python312\python.exe` |
| tar | `bsdtar 3.5.2 - libarchive 3.5.2` | `C:\WINDOWS\system32\tar.exe` |
| Get-FileHash | PowerShell cmdlet | `Microsoft.PowerShell.Utility` |

## Present but not sufficient for the required extraction

| Tool | Version evidence | Source/path | Why insufficient |
|---|---|---|---|
| WSL executable | present, but `wsl --status` / `wsl --list --verbose` returned WSL usage text | `C:\WINDOWS\system32\wsl.exe` | no runnable distro/tool surface was available |
| `mke2fs` | `mke2fs 1.47.2`; Android platform ext library | `C:\Android\platform-tools\mke2fs.exe` | filesystem creation tool, not a sparse/super unpacker or safe blob listing solution |
| `e2fsck` | `e2fsck 1.42.12` | `C:\Android\Sdk\emulator\bin64\e2fsck.exe` | filesystem checker, not enough to extract/list logical partitions after super unpack |
| `resize2fs` / `tune2fs` | found in Android SDK emulator path | `C:\Android\Sdk\emulator\bin64` | not sparse conversion, dynamic partition unpacking, or EROFS support |

## Missing tools

- `simg2img` or trusted equivalent.
- `lpunpack` or trusted equivalent.
- EROFS read-only inspection/extraction tools.
- A complete read-only ext filesystem extraction/listing path.
- A usable WSL distro package environment.

No existing Android SDK/platform/system tool found in the searched locations can
satisfy `simg2img` or `lpunpack`.

## WSL status

`wsl.exe` is present, but both requested WSL probes returned WSL usage/help text
instead of distro status/list output. This is treated as **no runnable WSL
distro available for the lab**. Therefore standard distro packages cannot be
used until Jeremy separately approves and prepares a usable WSL distro route.

## Android SDK / platform tool discovery

Read-only discovery searched:

- `C:\Android`
- `C:\Users\jerem\AppData\Local\Android`
- `C:\Program Files`
- `C:\Program Files (x86)`

Matches found:

- `C:\Android\platform-tools\mke2fs.exe`
- `C:\Android\platform-tools\mke2fs.conf`
- `C:\Android\Sdk\platform-tools\mke2fs.exe`
- `C:\Android\Sdk\platform-tools\mke2fs.conf`
- `C:\Android\Sdk\emulator\bin64\e2fsck.exe`
- `C:\Android\Sdk\emulator\bin64\resize2fs.exe`
- `C:\Android\Sdk\emulator\bin64\tune2fs.exe`

No `simg2img`, `lpunpack`, `lpadd`, `lpmake`, EROFS tool, or payload dumper was
found in those locations.

## Local tools staging directory

`C:\Projects\moto-one-hyper-local\tools` exists and was empty during this pass.
No tool was staged.

## Recommended approved acquisition path

| Missing capability | Recommended path | Approval requirement |
|---|---|---|
| `simg2img` | Android/AOSP-built sparse image tool with clear source/build provenance, staged under `C:\Projects\moto-one-hyper-local\tools` | Jeremy approval required before acquisition/install/use |
| `lpunpack` | Android `system/extras/partition_tools` / platform system tooling with clear provenance, staged locally | Jeremy approval required before acquisition/install/use |
| EROFS tools | standard package from a usable pre-approved WSL distro, or clear-provenance reproducible build staged locally | Jeremy approval required before acquisition/install/use |
| ext read-only listing/extraction | standard package from a usable pre-approved WSL distro, or clear-provenance reproducible build staged locally | Jeremy approval required before acquisition/install/use |
| Repo-local helpers | Python stdlib scripts committed to this repo after review/tests | allowed in a future slice, but Phase 3 did not start because Phase 2 stopped |

Random EXEs, opaque GitHub release binaries, firmware repair bundles, downloader
installers, and any tool that invokes adb/fastboot/device enumeration remain
rejected.

## Integrity plan

Any future approved tool acquisition must record:

- exact source/provenance;
- local staged path under `C:\Projects\moto-one-hyper-local\tools`;
- version command output;
- SHA256 under `C:\Projects\moto-one-hyper-local\checksums\tools`;
- offline usability after acquisition;
- explicit evidence that the tool does not invoke adb, fastboot, flashing
  helpers, or device enumeration.

For present local binaries, SHA256 records were written under:

`C:\Projects\moto-one-hyper-local\checksums\tools`

These checksum files are local-only and are not committed.

## Stop conditions

The task stops at Phase 2 because required tools are missing and tool acquisition
requires Jeremy approval. Phase 3 helper scripts and Phase 4 extraction were not
started.

Stop conditions that remain active:

- no approved `simg2img`;
- no approved `lpunpack`;
- no approved EROFS inspection/extraction;
- no complete approved read-only ext listing/extraction path;
- no usable WSL distro package source;
- no approved acquisition/install plan for missing tools.

## Current decision

This readiness report is retained as provenance for the pre-handoff blocker.
The current extraction evidence state is now tracked in
`reports/firmware_filesystem_extraction_RPFS31_Q1_21_20_5_RETBR.md`; blob
import, build, flashing, and live use remain blocked.
