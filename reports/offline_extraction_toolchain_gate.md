# Offline Extraction Toolchain Gate

Status: hold; toolchain approval required before retry

Date: 2026-07-01

## Purpose

Define the local offline toolchain required before retrying Route B RETBR
`RPFS31.Q1-21-20-5` sparse/super filesystem extraction and blob coverage
inspection.

This is a gate document only. It does not install tools, download tools,
extract firmware, convert sparse chunks, unpack `super`, mount filesystems,
touch a phone, import blobs, or start a build.

## Safety boundary

Reports only. No phone, adb, fastboot, LMSA/RSA, Rescue/Repair, flashing, root,
new firmware download, firmware extraction, sparse conversion, super unpacking,
mounting, blob import, or build attempt is authorized by this document.

The next extraction attempt remains on hold until Jeremy approves a specific
toolchain source and acquisition/install plan.

## Scope of any future tool-assisted retry

If later approved, tools may operate only on:

`C:\Projects\moto-one-hyper-local\firmware\stockrom.net_RETBR_DEF_RETAIL_RPFS31.Q1-21-20-5_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip`

and/or the already extracted local-only firmware contents under:

`C:\Projects\moto-one-hyper-local\extracted\RPFS31.Q1-21-20-5_RETBR`

No future tool-assisted retry may read from, write into, or import blobs into
`vendor/motorola` or any other Git-tracked source/vendor tree.

## Local-only paths

| Purpose | Path |
|---|---|
| Tool staging | `C:\Projects\moto-one-hyper-local\tools` |
| Tool checksums | `C:\Projects\moto-one-hyper-local\checksums\tools` |
| Filesystem extraction root | `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_5_RETBR_filesystems` |
| Logs | `C:\Projects\moto-one-hyper-local\logs` |
| Audits | `C:\Projects\moto-one-hyper-local\audits` |

These paths are outside the repository. Tool binaries, local logs, converted
images, unpacked partitions, extracted filesystems, full file lists, checksums,
and proprietary payloads must stay outside Git.

## Required tools

| Category | Required tool | Purpose | Current state |
|---|---|---|---|
| ZIP/archive | 7-Zip or PowerShell `Expand-Archive` | list or extract package archives | 7-Zip is already available; no new action needed if unchanged |
| Android sparse conversion | `simg2img` or trusted equivalent | convert `super.img_sparsechunk.*` to a raw `super.img` | missing |
| Dynamic partition unpacking | `lpunpack` or trusted equivalent | unpack logical partitions from raw `super.img` | missing |
| Filesystem inspection | ext4 read-only inspection/extraction support | list/extract ext-family logical partitions without mutation | missing |
| Filesystem inspection | EROFS read-only inspection/extraction support | list/extract EROFS logical partitions if encountered | missing |
| Checksum/logging | `Get-FileHash` | hash tools, inputs, generated local artifacts | available |
| Checksum/logging | Python hashing/listing helpers | deterministic summaries when shell tooling is awkward | Python available |

## Preferred sources

| Tool family | Preferred source | Acceptability |
|---|---|---|
| `simg2img` | Android source/platform/system-built tool with clear provenance, or a packaged distro/AOSP build whose source and build path are documented | acceptable after Jeremy approval and checksum capture |
| `lpunpack` | Android `system/extras/partition_tools` / platform system tooling with clear provenance, or a packaged distro/AOSP build whose source and build path are documented | acceptable after Jeremy approval and checksum capture |
| ext4 tools | standard WSL distro repository package if a distro is already installed and package source is standard; otherwise a documented reproducible package source | acceptable after Jeremy approval |
| EROFS tools | standard WSL distro repository package if a distro is already installed and package source is standard; otherwise a documented reproducible package source | acceptable after Jeremy approval |
| ZIP tooling | already installed 7-Zip or built-in Windows archive tooling | acceptable if version/source is recorded |
| Python helpers | repo-local helper scripts written/reviewed in this repo, using Python stdlib where possible | acceptable if scripts are committed and validated before use |

Avoid random EXEs, opaque GitHub release binaries, bundled firmware repair
toolkits, downloader installers, malware-prone phone flashing tools, and any
package whose provenance cannot be explained in a committed report.

## Trust and integrity requirements

Before any new tool is used, a future approval report must record:

- exact tool name and version;
- source URL or package source;
- source/project provenance;
- local storage path under `C:\Projects\moto-one-hyper-local\tools`;
- SHA256 in `C:\Projects\moto-one-hyper-local\checksums\tools`;
- acquisition/install command, if approved;
- whether the tool can run without network access after acquisition;
- a dry-run or version command that does not touch firmware;
- confirmation that it does not invoke adb, fastboot, flashing helpers, or
  device enumeration.

If provenance or checksums cannot be recorded, stop.

## Expected future commands

The exact commands must be reviewed before use, but a future approved run should
look like this shape:

```powershell
# Tool/version discovery only
Get-Command 7z, simg2img, lpunpack, Get-FileHash, python -ErrorAction SilentlyContinue
<tool> --version

# Local-only sparse reconstruction, if simg2img-equivalent is approved
simg2img `
  C:\Projects\moto-one-hyper-local\extracted\RPFS31.Q1-21-20-5_RETBR\super.img_sparsechunk.0 `
  ... `
  C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_5_RETBR_filesystems\super.raw.img

# Local-only dynamic partition unpacking, if lpunpack-equivalent is approved
lpunpack `
  C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_5_RETBR_filesystems\super.raw.img `
  C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_5_RETBR_filesystems\logical

# Read-only filesystem listing/extraction, tool-specific after filesystem type is known
<readonly-ext-or-erofs-tool> <logical-partition-image> <local-output-root>
```

No command above is approved for execution yet. The command shape is recorded so
the next gate can review inputs, outputs, and stop conditions before running.

## What each tool may touch

| Tool | May read | May write |
|---|---|---|
| Archive tool | the approved Route B ZIP or existing extraction root | local-only logs or extraction root, if a future gate explicitly reopens ZIP extraction |
| `simg2img` equivalent | `super.img_sparsechunk.*` under the approved local extraction root | local-only raw `super` image under the filesystem extraction root |
| `lpunpack` equivalent | local-only raw `super` image | local-only logical partition images under the filesystem extraction root |
| ext4/EROFS tools | local-only logical partition images | local-only extracted/listed filesystem summaries under the filesystem extraction root, logs, audits, or checksums roots |
| `Get-FileHash` / Python helpers | local-only tools, images, generated artifacts, and report-safe summaries | local-only checksum/log/audit outputs |

No tool may enumerate or interact with attached devices.

## Allowed outputs

Allowed outside Git:

- raw reconstructed `super` image;
- logical partition images;
- extracted read-only filesystem trees;
- full filesystem listings;
- hashes of generated local artifacts;
- tool logs, audit JSON/text, and working notes;
- temporary command output under local-only logs/audits.

Allowed in Git:

- concise report summaries;
- counts of files found/missing;
- report-safe path examples needed to explain coverage;
- tool names, versions, sources, checksums, and local-only output locations;
- validation status and blocker notes.

## Outputs that must stay out of Git

- firmware ZIPs;
- sparse chunks;
- raw `super` images;
- logical partition images;
- mounted or extracted filesystem trees;
- proprietary blobs;
- generated full file listings if they expose proprietary payloads beyond
  report-safe summaries;
- local tool binaries;
- local checksum files;
- local logs/audits containing proprietary payload details.

## Forbidden tool behavior

Any tool, script, package, or command is rejected if it:

- touches a phone;
- invokes adb;
- invokes fastboot;
- enumerates attached devices;
- contains flashing, rescue, repair, wipe, erase, unlock, relock, or boot helper
  behavior;
- automatically imports blobs;
- writes into `vendor/motorola` inside the repo;
- extracts into the Git repository;
- downloads firmware or tool dependencies during extraction;
- requires an opaque downloader installer;
- hides what it reads or writes.

## Stop conditions

Stop before extraction if:

- any required tool is missing;
- a tool source is not approved by Jeremy;
- a tool checksum cannot be recorded;
- a tool wants network access during extraction;
- a tool or wrapper invokes adb, fastboot, device enumeration, flashing, rescue,
  repair, erase, wipe, unlock, relock, or boot actions;
- any output path resolves inside the Git repository;
- filesystem type cannot be inspected safely;
- a command would modify source images rather than writing derived local-only
  work products;
- local disk space is insufficient;
- validation would require committing binaries, blobs, images, full filesystem
  dumps, or private payload details.

## Future validation and reports

After a future approved tool-assisted extraction, commit report updates only:

- `reports/firmware_filesystem_extraction_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/vendor_blob_coverage_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/channel_sensitive_blob_review_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/vendor_blob_expectation_gap_RPFS31_Q1_21_20_5_RETBR.md`

The future report set should answer:

- which tools and versions were used;
- which images/chunks were converted or unpacked;
- which logical partitions were found;
- which filesystems were encountered;
- which def-specific and sm6150-common expected paths were found/missing;
- which channel-sensitive families were present and what remains incomparable
  without exact retus `RPFS31.Q1-21-20-1-7-3` firmware;
- confirmation that all extraction outputs stayed local-only;
- confirmation that no phone, adb, fastboot, flashing, blob import, or build
  action occurred.

Then run:

```powershell
python scripts\validate_repo.py
python -m unittest discover -s tests -v
.\scripts\validate_local.ps1
git status --short
```

## Current decision

Continue hold on extraction. The next extraction attempt can proceed only after
Jeremy approves or provides a known safe local toolchain and its integrity
record. This document supports future planning; it is not tool acquisition,
installation, extraction, blob import, build, or flashing approval.
