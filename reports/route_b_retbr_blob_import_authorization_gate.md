# Route B RETBR Blob Import Authorization Gate

Status: blocked; authorization gate only

Date: 2026-07-01

## Purpose

Define what would have to be true before any Route B RETBR blob extraction or
import could occur.

This report is a decision boundary, not an import decision. It does not extract,
copy, import, transform, generate, or stage proprietary blobs. It does not create
`vendor/motorola` trees, run extract scripts, build Lineage, use adb, use
fastboot, touch a phone, or flash anything.

WI-004 remains blocked. Exact retus `RPFS31.Q1-21-20-1-7-3` firmware remains
unavailable. Route B RETBR `RPFS31.Q1-21-20-5 / 1e3de` remains useful only as
offline comparison evidence unless a later explicit gate says otherwise.

## Inputs

This gate is based on committed report-safe evidence:

- `reports/proprietary_files_expectation_map.md`
- `reports/route_b_retbr_vendor_coverage_delta_plan.md`
- `reports/route_b_retbr_proprietary_files_line_coverage_review.md`
- `reports/vendor_blob_coverage_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/channel_sensitive_blob_review_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/firmware_filesystem_extraction_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/firmware_acquisition_extraction_gate.md`
- `work/blocked/WI-004-firmware-acquisition-and-verification.md`

No local-only firmware artifact, extracted filesystem, raw inventory, checksum
file, blob, or helper script was inspected or modified for this report.

## Can RETBR blobs be used at all for a retus target?

Not authorized now.

The current evidence supports only this narrower conclusion:

- RETBR `RPFS31.Q1-21-20-5 / 1e3de` is the same vendor-base family used by the
  matched `sorenlyulf/android_device_motorola_def` lineage-20 manifests.
- The report-safe `vendor_a` evidence confirms a coherent def/sm6150 Android 11
  vendor payload.
- The physical target remains retus `RPFS31.Q1-21-20-1-7-3`.
- Exact retus firmware has not been acquired.
- No byte-level or version-level retus-vs-RETBR compatibility comparison exists.

Therefore RETBR blobs may be considered only as a planning/reference source.
Using RETBR-derived blobs for a retus target would require a separate explicit
authorization after the blockers in this report are resolved or consciously
accepted in writing.

## Channel-neutral candidates

The following families appear channel-neutral enough to consider in a future
authorization discussion, subject to exact path enumeration and validation:

| Family | Why it may be lower-risk | Current state |
|---|---|---|
| Motorola pop-up camera HAL/service | def-specific hardware feature, less likely carrier-channel dependent | family confirmed by report-safe evidence |
| ArcSoft/QTI camera userspace and EEPROM support | def camera hardware stack, anchored to `-5` manifest provenance | family confirmed, exact paths not fully enumerated |
| Cirrus speaker amp and haptics firmware | board hardware support tied to def audio/haptics parts | family confirmed, exact filenames still need safer enumeration |
| ST21NFC firmware and libraries | def NFC hardware support | family confirmed |
| display/panel calibration and sensor firmware | board hardware support, likely less carrier dependent | likely present, not fully enumerated |
| graphics/media userspace | SoC common stack likely present across sm6150 builds | family confirmed, still needs exact path coverage |
| WiFi/Bluetooth/GNSS/platform services | common SoC/device services, likely present across def builds | families confirmed or likely, not full path coverage |

Lower-risk does not mean approved. These families still require an explicit
future import gate, exact path grouping, provenance recording, and validation.

## Channel-sensitive or too risky

The following families are too channel-sensitive or security-coupled to approve
from RETBR evidence alone:

| Family | Reason blocked |
|---|---|
| modem/radio firmware and `radio.img` | carrier/channel/baseband coupled; RETBR is not retus |
| qcril database and RIL policy | carrier provisioning and radio behavior can vary by channel |
| IMS stack | VoLTE/IMS/carrier configuration can vary by region and operator |
| CNE / telephony carrier policy | data/voice policy can be channel-specific |
| TEE / TrustZone / QSEE / QTEE | security-version and AVB-coupled |
| keymaster / keystore / gatekeeper | security and verified-boot coupled |
| fingerprint trustlets | pairs with TEE/keymaster/gatekeeper security stack |
| DRM/Widevine security behavior | may depend on security stack and provisioning |
| DSP/CDSP signed firmware | kernel/security-patch coupled risk |
| camera signed firmware | firmware-version coupling risk even if camera userspace is hardware-common |

These families require exact retus comparison or a later explicit decision that
they remain excluded from any import attempt.

## Exact retus blockers

Import remains blocked while these are unresolved:

- no exact retus `RPFS31.Q1-21-20-1-7-3` flashable package;
- no exact retus `vendor_a` or equivalent filesystem inventory;
- no retus-vs-RETBR comparison for radio, IMS, qcril, TEE, keymaster,
  gatekeeper, fingerprint trustlets, DSP, or camera signed firmware;
- no verified retus stock boot/recovery rollback anchor;
- no approved physical-device path;
- no import-specific manifest line map with every def/common expected path
  classified as importable, excluded, generated, missing, or blocked;
- no written operator decision accepting any use of RETBR blobs for a retus
  target.

## Import paths if later approved

If a later explicit gate authorizes import, allowed paths must be narrow and
predeclared. A future import gate may allow only:

| Future path | Required limit |
|---|---|
| local-only source dump | read from approved local-only Route B extraction outputs only |
| destination vendor tree | write only to a declared generated vendor tree such as `vendor/motorola/def` and/or `vendor/motorola/sm6150-common` after approval |
| generated makefiles | generate only `*-vendor.mk`, Android make fragments, and related extractor outputs needed by the matched source trees |
| import scope | start with channel-neutral candidate families only unless exact retus comparison clears sensitive families |
| excluded families | omit radio/IMS/qcril/TEE/keymaster/gatekeeper/fingerprint trustlets/DSP-camera signed firmware unless separately approved |
| commit content | commit only source-controlled vendor makefiles/manifests if license/governance permits; do not commit proprietary blob binaries without explicit approval |

Any future command must be reviewed before execution. No script may enumerate a
phone, call adb/fastboot, run LMSA/RSA, flash, mount, or write outside approved
paths.

## Required validation before import

Before any import command could run, a future gate must record:

- exact firmware source and build/channel identity;
- exact local-only input path;
- SHA256 for the firmware artifact and any derived source images used;
- manifest family/path classification for def and sm6150-common;
- explicit include/exclude list for channel-sensitive families;
- destination paths and generated files;
- dry-run command shape;
- rollback plan for Git changes;
- confirmation that no phone, adb, fastboot, LMSA/RSA, rescue, repair, flashing,
  or build action is part of the import step.

Validation before import must include:

```powershell
python scripts\validate_repo.py
python -m unittest discover -s tests -v
.\scripts\validate_local.ps1
git status --short
```

## Required validation after import

If import is ever approved and performed, the post-import validation must include
at least:

```powershell
python scripts\validate_repo.py
python -m unittest discover -s tests -v
.\scripts\validate_local.ps1
git status --short
```

A future import report would also need to record:

- exact files generated or changed;
- which expected proprietary-files families were imported, excluded, generated,
  or still blocked;
- proof that no local-only firmware/images/logs/full inventories were committed;
- proof that no phone/device command ran;
- a clear statement that import is not build approval and not flash approval.

## Stop conditions

Stop before import if any of the following are true:

- the operator has not explicitly approved blob import in the current phase;
- exact input artifact/build/channel is unclear;
- RETBR is being treated as retus without a written decision;
- the command would touch a phone, adb, fastboot, LMSA/RSA, rescue, repair,
  flashing, erase, wipe, unlock, relock, sideload, or boot operations;
- the command would mount filesystems or extract new payloads without a separate
  gate;
- the command would write outside the approved vendor destination tree;
- the command would commit proprietary binaries without explicit approval;
- channel-sensitive families are included without exact retus comparison or a
  written exclusion/acceptance decision;
- generated files cannot be explained from the matched source manifests;
- validation fails before or after import;
- the worktree contains unrelated changes that would make review ambiguous.

## Current decision

Open the Route B blob import authorization gate as blocked. Do not import.
Do not extract. Do not build. Do not touch a device. Do not flash.

The next safe output, if requested, is an import-gate checklist or command-shape
review that still performs no import.
