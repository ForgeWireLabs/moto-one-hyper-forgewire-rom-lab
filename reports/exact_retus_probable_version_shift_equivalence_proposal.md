# Exact RETUS Probable Version-Shift Equivalence Proposal

Status: proposal only; no source-list edits applied

## Scope

This report proposes a narrow future equivalence review for the `2` entries
classified as:

- `probable-version-shift`

during the exact RETUS renamed/version-shifted review.

This proposal concerns only these two entries:

1. `vendor/lib/hw/vendor.qti.hardware.bluetooth_audio@2.1-impl.so`
2. `vendor/lib64/vendor.qti.latency@2.1.so`

This proposal does not concern:

- WFD / Wi-Fi Display / HDCP;
- radio / IMS / QCRIL hard blockers;
- keymaster / gatekeeper / QSEE hard blockers;
- camera permissions/config;
- the 7 possible rename/stack-shift entries;
- the 2 same-directory absences;
- the 12 same-directory vendor variant entries.

This is a proposal report only.

This is not a source-list edit.

This is not a waiver.

This is not blob import authorization.

This is not generated vendor tree authorization.

This is not build authorization.

## Supporting evidence

This proposal depends on the committed exact RETUS evidence chain:

- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`
- `reports/exact_retus_renamed_version_shifted_review.md`
- `reports/exact_retus_unresolved_status_rollup.md`

Local-only evidence source:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_renamed_version_shifted_review_20260702.csv`

The local-only CSV must not be committed.

## Entries under proposal

| Tree | Line | Expected path | Family | Risk |
|---|---:|---|---|---|
| `sm6150-common` | `87` | `vendor/lib/hw/vendor.qti.hardware.bluetooth_audio@2.1-impl.so` | `bluetooth_audio` | `medium` |
| `sm6150-common` | `185` | `vendor/lib64/vendor.qti.latency@2.1.so` | `qti_data_cne_latency` | `medium` |

## Exact RETUS related hits

### Bluetooth audio HAL implementation

Expected source-list path:

- `vendor/lib/hw/vendor.qti.hardware.bluetooth_audio@2.1-impl.so`

Exact RETUS version-related observed paths:

- `vendor/lib/hw/vendor.qti.hardware.bluetooth_audio@2.0-impl.so`
- `vendor/lib64/hw/vendor.qti.hardware.bluetooth_audio@2.0-impl.so`

Review result:

| Evidence type | Value |
|---|---|
| Exact expected basename found | No |
| Version-related hits found | Yes |
| Version-related hit count | 2 |
| Expected version | 2.1 |
| Observed exact RETUS version | 2.0 |

### QTI latency library

Expected source-list path:

- `vendor/lib64/vendor.qti.latency@2.1.so`

Exact RETUS version-related observed paths:

- `system_ext/lib/vendor.qti.latency@2.0.so`
- `system_ext/lib64/vendor.qti.latency@2.0.so`
- `vendor/lib/vendor.qti.latency@2.0.so`
- `vendor/lib64/vendor.qti.latency@2.0.so`

Review result:

| Evidence type | Value |
|---|---|
| Exact expected basename found | No |
| Version-related hits found | Yes |
| Version-related hit count | 4 |
| Expected version | 2.1 |
| Observed exact RETUS version | 2.0 |

## Interpretation

Both entries appear to be version shifts rather than missing-directory or
failed-extraction cases.

The source list expects `2.1` interface/library variants.

Exact RETUS observed inventories show `2.0` variants.

This supports a probable version-shift interpretation, but it does not prove
safe equivalence.

Version differences can be meaningful. A lower observed interface version may
affect:

- ABI compatibility;
- HAL registration;
- service expectations;
- framework/vendor linkage;
- Bluetooth audio behavior;
- QTI data/CNE/latency behavior;
- build-time dependency resolution.

## Proposal

The proposed future handling is:

1. keep both entries blocked for now;
2. create a separate manual equivalence decision before any source-list edit;
3. compare source-list expectations against exact RETUS observed `2.0` variants;
4. decide whether the source list should retain `2.1`, annotate drift, or adjust
   to exact RETUS `2.0` paths;
5. require explicit human approval before any edit.

## Recommended future decision options

A future human-approved decision should choose exactly one option per entry.

### Option A: retain expected 2.1 path

Keep the current expected path unchanged.

Use this if the source tree or build system requires the `2.1` path even though
exact RETUS shows `2.0` variants.

### Option B: annotate probable version drift only

Add a comment noting that exact RETUS shows `2.0` variants while the inherited
source list expects `2.1`.

Use this if evidence is not strong enough to modify the entry.

### Option C: adjust expected path to exact RETUS 2.0 variant

Change the source-list path from the expected `2.1` variant to the exact RETUS
`2.0` variant.

This option is not approved by this report.

It requires a separate approval marker and rollback plan.

### Option D: split behind build/equivalence gate

Keep the `2.1` expectation visible while adding exact RETUS `2.0` candidates in a
clearly gated/pending section, if the source-list format and project policy allow
that treatment.

This option is not approved by this report.

## Recommended option

Recommended next step:

- Option B: annotation/provenance only, pending manual equivalence review.

Rationale:

- the exact RETUS evidence is strong enough to identify version drift;
- it is not strong enough to prove ABI/runtime equivalence;
- source-list path changes can affect build behavior;
- the project has not attempted a build;
- the project has not validated runtime behavior;
- both entries touch behavior-sensitive vendor surfaces.

## Required approval gate before editing

Before any source-list edit, a separate approval marker must exist in a committed
report or work item.

For annotation-only, the approval marker must state:

- `APPROVED_FOR_SOURCE_LIST_EDIT: VERSION_SHIFT_ANNOTATION_ONLY`

For path adjustment, the approval marker must state:

- `APPROVED_FOR_SOURCE_LIST_EDIT: VERSION_SHIFT_PATH_ADJUSTMENT`

The approval marker must include:

- the exact file to edit;
- the exact line or section to edit;
- the old expected path;
- the proposed new path or annotation;
- the evidence reports supporting the change;
- the rollback plan;
- confirmation that no blob import or build is authorized.

Without that marker, no source-list edit is authorized.

## Candidate annotation text

If annotation-only is approved later, candidate text could be:

    # Exact RETUS def_retail review note:
    # Source list expects 2.1, but exact Motorola One Hyper def_retail RETUS
    # RPFS31.Q1-21-20-1-7-3 observed 2.0 version-related paths.
    # Keep pending manual ABI/build equivalence review before path adjustment.

This proposed text is not applied by this report.

## Rollback plan for a future annotation edit

If a future annotation-only edit is approved and applied, rollback is:

1. remove only the added annotation lines;
2. leave original source-list entries unchanged;
3. rerun validation;
4. commit the rollback with a message referencing version-shift annotation rollback.

## Explicit non-goals

This proposal does not claim that `2.0` and `2.1` are equivalent.

This proposal does not authorize changing either path.

This proposal does not authorize removing either path.

This proposal does not authorize adding replacement paths.

This proposal does not authorize blob import or build use.

This proposal does not reduce the radio/security do-not-waive block.

## Current decision

The two probable version-shift entries remain:

- unresolved;
- medium risk;
- eligible for future narrow equivalence review;
- blocked from removal;
- blocked from waiver;
- blocked from source-list edit;
- blocked from blob import/build use.

## Still blocked

The following remain blocked:

- source-list edits without explicit approval marker;
- version-shift path adjustment;
- version-shift waiver;
- version-shift removal;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- RETBR substitution;
- device interaction;
- adb;
- fastboot;
- LMSA/RSA rescue or repair;
- flashing;
- bootloader unlock/relock;
- wipe/erase operations.

## Operator conclusion

The two probable version-shift entries are ready for a narrow human equivalence
decision.

The recommended next action is annotation-only pending manual ABI/build review.

No edit is authorized by this report.
