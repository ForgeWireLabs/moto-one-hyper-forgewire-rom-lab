# Exact RETUS Reacquisition and Source Drift Plan

Status: planning only; no import/build/device action authorized

## Scope

This report defines the next evidence path after the Route B RETBR line-coverage
closeout and unresolved active entry map.

Route B RETBR is useful offline comparison evidence, but it is not exact target
firmware and does not authorize substitute-source import or build work.

This plan separates three possible paths:

1. Reacquire exact RETUS firmware.
2. Determine whether the current proprietary source lists drift beyond the
   Android 11 RETBR payload.
3. If exact RETUS cannot be reacquired, create a formal substitute-source
   decision gate.

This report does not authorize:

- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- adb/fastboot;
- LMSA/RSA rescue or repair;
- flashing;
- bootloader actions;
- physical device interaction.

WI-004 remains blocked.

## Current evidence state

Target device and build:

| Field | Value |
|---|---|
| Device | Motorola One Hyper |
| Model | XT2027-1 |
| Product/codename | `def` / `def_retail` |
| Target channel | `retus` |
| Target build | `RPFS31.Q1-21-20-1-7-3 / 37074e` |
| Android | 11 |

Route B comparison source:

| Field | Value |
|---|---|
| Channel/source | RETBR |
| Build | `RPFS31.Q1-21-20-5 / 1e3de` |
| Use status | offline comparison evidence only |

Route B line-coverage closeout:

| Metric | Count |
|---|---:|
| Active expected proprietary entries | 1,213 |
| Direct vendor matches | 956 |
| Direct non-vendor matches | 134 |
| Combined direct matches | 1,090 |
| Combined direct observed coverage | approximately 89.9% |
| Remaining active unresolved entries | 123 |
| Disabled/optional entries | 32 |

Committed Route B evidence chain:

| Commit | Purpose |
|---|---|
| `0815984` | Document Route B vendor-side line coverage result |
| `142458c` | Document Route B non-vendor line coverage result |
| `a800ab9` | Close Route B line coverage evidence phase |
| `513cb35` | Map Route B unresolved active entries |

## Why Route B is not enough

Route B RETBR is close enough to be useful as comparison evidence, but it differs
from the target on at least these axes:

- channel/source differs: RETBR versus RETUS;
- build differs: `RPFS31.Q1-21-20-5 / 1e3de` versus
  `RPFS31.Q1-21-20-1-7-3 / 37074e`;
- unresolved entries remain after direct vendor and non-vendor coverage;
- several unresolved entries cluster in version-sensitive or feature-sensitive
  families.

The remaining unresolved active entries are not broad random absence. They
cluster around:

- WFD / Wi-Fi Display / HDCP;
- QCRIL database upgrade tail;
- QTI data / CNE / latency;
- radio / IMS version gaps;
- display panel calibration;
- Bluetooth audio version gaps;
- keymaster startup/versioning;
- remaining system_ext and product non-vendor entries.

Because these families can affect hardware bring-up, radio behavior, display
configuration, DRM/HDCP behavior, keymaster/QSEE behavior, and framework/product
permissions, Route B cannot be treated as import authority by itself.

## Path A - Reacquire exact RETUS firmware

Goal: acquire exact firmware evidence for:

- `XT2027-1`;
- `def_retail`;
- `retus`;
- `RPFS31.Q1-21-20-1-7-3 / 37074e`.

Path A succeeds only when the exact target firmware package is available offline
in the local-only workspace and has been verified by checksum and metadata.

The firmware must remain outside Git.

Expected local-only storage pattern:

- `C:\Projects\moto-one-hyper-local\firmware`
- `C:\Projects\moto-one-hyper-local\checksums`
- `C:\Projects\moto-one-hyper-local\extracted`
- `C:\Projects\moto-one-hyper-local\audits`
- `C:\Projects\moto-one-hyper-local\logs`

A future exact RETUS acquisition report should record:

| Evidence item | Required |
|---|---|
| Firmware package name | yes |
| Source URL or acquisition method | yes, if available |
| Build string | yes |
| Channel | yes |
| Product/codename metadata | yes |
| Android version | yes |
| Package SHA256 | yes |
| Extraction location | yes |
| Image inventory | yes |
| Explicit statement that firmware remains local-only | yes |

If exact RETUS is reacquired, the next evidence steps should be:

1. Verify package checksum and metadata.
2. Extract images locally.
3. Reconstruct `super.raw.img` if necessary.
4. Carve logical partitions.
5. Repeat vendor-side line coverage.
6. Repeat non-vendor line coverage.
7. Generate an exact RETUS unresolved map.
8. Compare exact RETUS residuals against Route B residuals.
9. Only then decide whether WI-004 can move from blocked to evidence-ready.

Even with exact RETUS firmware acquired, blob import, generated vendor tree
creation, build attempt, device interaction, flashing, and bootloader actions
remain blocked until a separate explicit decision.

## Path B - Source-list drift analysis

Goal: determine whether some unresolved entries reflect source-list drift rather
than true firmware absence.

Current source baseline:

- `sorenlyulf_android_device_motorola_def`
- `lineage20_android_device_motorola_sm6150-common`
- `kernel_motorola_sm6150_lineage20`

Relevant proprietary lists:

- `sorenlyulf_android_device_motorola_def/proprietary-files.txt`
- `lineage20_android_device_motorola_sm6150-common/proprietary-files.txt`

Current parsed proprietary-file surface:

| Source | Active entries |
|---|---:|
| `def` | 261 |
| `sm6150-common` | 952 |
| Combined | 1,213 |

The source-list drift analysis should answer whether unresolved entries are:

1. required for another build/channel/version;
2. inherited from a broader common baseline;
3. expected under different filenames or versioned names;
4. replaced by newer or older equivalents;
5. truly missing from firmware evidence;
6. optional, obsolete, or product-specific;
7. generated, symlinked, packed, or missed by inventory.

A future source-list drift report should classify unresolved entries as:

- `still-required`;
- `exact-retus-needed`;
- `source-list-drift-candidate`;
- `renamed-or-version-shifted`;
- `optional-candidate`;
- `parser-or-inventory-gap`;
- `do-not-waive`.

Source-list drift analysis must not silently remove or waive entries.

Any source-list change requires a separate documented decision with original
entry, observed evidence, replacement or absence evidence, rationale, risk
level, and target/common-tree scope.

## Path C - Substitute-source decision gate

Goal: define what would be required if exact RETUS cannot be reacquired and the
project must decide whether any non-exact source can be used.

Current non-exact candidate:

| Field | Value |
|---|---|
| Candidate | Route B RETBR |
| Build | `RPFS31.Q1-21-20-5 / 1e3de` |
| Direct active coverage | `1,090 / 1,213` |
| Remaining unresolved active entries | 123 |
| Current authorization status | not authorized for import/build |

A substitute-source decision must include why exact RETUS cannot be obtained,
why the substitute source is closest available evidence, remaining
build/channel/product differences, complete coverage numbers, complete
unresolved map, risk assessment by residual family, explicit treatment for each
unresolved family, source-list drift assessment, hard blockers, proposed waivers
or corrections if any, rationale for every waiver or correction, rollback plan,
and a statement of what remains blocked.

Decision outcomes:

| Outcome | Meaning |
|---|---|
| `rejected` | Substitute source cannot be used |
| `evidence-only` | Substitute remains useful but does not authorize import |
| `limited-source-list-correction` | Some source-list drift may be corrected, but import remains blocked |
| `conditional-import-ready` | Import may be prepared only under explicitly documented constraints |

The current Route B state remains evidence-only.

## Recommended next action

The cleanest next action is still Path A: reacquire exact RETUS firmware for
`RPFS31.Q1-21-20-1-7-3 / 37074e`.

If exact RETUS is not available, proceed to Path B before any substitute-source
decision.

Path C should only happen after Path B has produced a source-list drift report.

## Decision

This project should not proceed directly from Route B evidence to import/build.

The correct sequence is:

1. exact RETUS reacquisition attempt;
2. source-list drift analysis if exact RETUS remains unavailable;
3. substitute-source decision gate only if necessary;
4. import/build authorization only after a separate explicit decision.

## Still blocked

The following remain blocked:

- exact RETUS substitution decision;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
