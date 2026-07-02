# Exact RETUS Same-Directory Vendor Variant Proposal

Status: proposal only; no source-list edits applied

## Scope

This report proposes the future review posture for the `12` entries classified
as:

- `same-directory-variant-review`

during the exact RETUS deeper vendor review.

This proposal concerns only the `12` deeper vendor entries.

This proposal does not concern:

- WFD / Wi-Fi Display / HDCP;
- the 2 probable version-shift entries;
- the 7 possible rename/stack-shift entries;
- the 2 same-directory absences from the renamed/version-shifted review;
- the camera permissions/config singleton;
- the 30 radio/security do-not-waive entries.

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
- `reports/exact_retus_deeper_vendor_review.md`
- `reports/exact_retus_unresolved_status_rollup.md`

Local-only evidence source:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_deeper_vendor_review_20260702.csv`

The local-only CSV must not be committed.

## Entries under proposal

| Tree | Line | Expected path | Family | Risk |
|---|---:|---|---|---|
| `sm6150-common` | `153` | `vendor/lib/vendor.qti.data.factory@2.2.so` | `data_dpm` | `high` |
| `sm6150-common` | `154` | `vendor/lib/vendor.qti.data.factory@2.3.so` | `data_dpm` | `high` |
| `sm6150-common` | `168` | `vendor/lib64/vendor.qti.data.factory@2.2.so` | `data_dpm` | `high` |
| `sm6150-common` | `169` | `vendor/lib64/vendor.qti.data.factory@2.3.so` | `data_dpm` | `high` |
| `sm6150-common` | `180` | `vendor/lib64/vendor.qti.hardware.data.lce@1.0.so` | `data_dpm` | `high` |
| `sm6150-common` | `182` | `vendor/lib64/vendor.qti.hardware.mwqemadapter@1.0.so` | `uncategorized_vendor` | `high` |
| `sm6150-common` | `198` | `vendor/etc/charger_fstab.qti` | `uncategorized_vendor` | `high` |
| `sm6150-common` | `315` | `vendor/etc/cacert_location.pem` | `uncategorized_vendor` | `high` |
| `sm6150-common` | `316` | `vendor/etc/xtra_root_cert.pem` | `uncategorized_vendor` | `high` |
| `sm6150-common` | `696` | `vendor/lib64/vendor.qti.hardware.radio.lpa@1.2.so` | `uncategorized_vendor` | `high` |
| `sm6150-common` | `697` | `vendor/lib64/vendor.qti.hardware.radio.lpa@1.3.so` | `uncategorized_vendor` | `high` |
| `sm6150-common` | `698` | `vendor/lib64/vendor.qti.hardware.radio.lpa@1.4.so` | `uncategorized_vendor` | `high` |

## Evidence summary

The deeper vendor review found:

| Metric | Count |
|---|---:|
| Entries reviewed | `12` |
| Review posture `same-directory-variant-review` | `12` |
| Risk `high` | `12` |
| Source tree `sm6150-common` | `12` |

Family split:

| Family | Count |
|---|---:|
| `data_dpm` | `5` |
| `uncategorized_vendor` | `7` |

Every entry had exact RETUS same-parent-directory evidence.

No entry had an exact basename hit.

This means the relevant exact RETUS vendor directories exist and are populated,
but the expected exact files were not observed.

## Interpretation

This bucket is not a missing-directory problem.

This bucket is not evidence that exact RETUS vendor extraction failed.

This bucket is not safe to waive.

This bucket is best understood as a high-risk same-directory variant bucket.

The source list expects specific QTI/vendor files that are absent by exact
basename, while neighboring exact RETUS vendor contents exist.

Several entries touch sensitive behavior areas:

- QTI data factory libraries;
- DPM/data/LCE-related interfaces;
- MWQEM adapter behavior;
- charger fstab configuration;
- certificate/root certificate material;
- radio LPA interfaces.

Because these entries may affect data, radio-adjacent behavior, provisioning,
certificates, charging, or vendor service compatibility, source-list edits must
remain gated.

## Proposal

The proposed future handling is:

1. keep all 12 entries blocked for now;
2. do not waive any entry in this bucket;
3. do not remove any entry in this bucket;
4. perform a manual per-entry neighboring-file review against exact RETUS vendor
   observed paths;
5. split the bucket into lower-risk drift candidates and hard blockers only after
   manual review;
6. require explicit approval before any source-list edit.

## Recommended future review groups

### Group A: QTI data / DPM interfaces

Entries:

- `vendor/lib/vendor.qti.data.factory@2.2.so`
- `vendor/lib/vendor.qti.data.factory@2.3.so`
- `vendor/lib64/vendor.qti.data.factory@2.2.so`
- `vendor/lib64/vendor.qti.data.factory@2.3.so`
- `vendor/lib64/vendor.qti.hardware.data.lce@1.0.so`

Recommended posture:

- high-risk manual equivalence review;
- do not waive;
- do not remove;
- check exact RETUS neighboring QTI data/interface versions before any decision.

### Group B: MWQEM / CNE-adjacent behavior

Entry:

- `vendor/lib64/vendor.qti.hardware.mwqemadapter@1.0.so`

Recommended posture:

- high-risk manual equivalence review;
- do not waive;
- review with CNE/data stack entries, not as an isolated library.

### Group C: charger fstab

Entry:

- `vendor/etc/charger_fstab.qti`

Recommended posture:

- high-risk config review;
- do not waive;
- do not remove;
- verify whether exact RETUS has an equivalent charger fstab or uses a different
  charging/recovery/vendor mount configuration.

### Group D: certificate material

Entries:

- `vendor/etc/cacert_location.pem`
- `vendor/etc/xtra_root_cert.pem`

Recommended posture:

- high-risk config/certificate review;
- do not waive;
- determine whether exact RETUS stores equivalent certificate material elsewhere
  or whether the inherited common-tree expectation does not apply.

### Group E: radio LPA interfaces

Entries:

- `vendor/lib64/vendor.qti.hardware.radio.lpa@1.2.so`
- `vendor/lib64/vendor.qti.hardware.radio.lpa@1.3.so`
- `vendor/lib64/vendor.qti.hardware.radio.lpa@1.4.so`

Recommended posture:

- hard-block adjacent;
- do not waive;
- treat conservatively with radio/security evidence planning;
- do not separate from radio behavior without stronger exact RETUS evidence.

## Recommended option

Recommended next step:

- create a manual per-entry same-directory evidence report.

That report should include, for each of the 12 entries:

- expected path;
- exact RETUS same-parent observed files;
- likely neighboring version/interface candidates;
- whether the entry is inherited common-tree drift;
- whether the entry is radio/data/security-adjacent;
- whether the entry should remain blocked or move into a future annotation-only proposal.

## Required approval gate before editing

Before any source-list edit, a separate approval marker must exist in a committed
report or work item.

For annotation-only, the approval marker must state:

- `APPROVED_FOR_SOURCE_LIST_EDIT: SAME_DIRECTORY_VENDOR_ANNOTATION_ONLY`

For any path adjustment, the approval marker must state:

- `APPROVED_FOR_SOURCE_LIST_EDIT: SAME_DIRECTORY_VENDOR_PATH_ADJUSTMENT`

The approval marker must include:

- the exact file to edit;
- the exact source-list entries to edit;
- the old expected path;
- the proposed new path or annotation;
- the evidence reports supporting the change;
- the rollback plan;
- confirmation that no blob import or build is authorized.

Without that marker, no source-list edit is authorized.

## Explicit non-goals

This proposal does not claim equivalence for any of the 12 entries.

This proposal does not authorize changing any path.

This proposal does not authorize removing any path.

This proposal does not authorize adding replacement paths.

This proposal does not authorize waiving any entry.

This proposal does not authorize blob import or build use.

This proposal does not reduce the 30 radio/security do-not-waive hard block.

## Current decision

The 12 same-directory vendor variant entries remain:

- unresolved;
- high risk;
- same-directory variant review candidates;
- blocked from removal;
- blocked from waiver;
- blocked from source-list edit;
- blocked from blob import/build use.

## Still blocked

The following remain blocked:

- source-list edits without explicit approval marker;
- same-directory vendor path adjustment;
- same-directory vendor waiver;
- same-directory vendor removal;
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

The 12-entry same-directory vendor bucket is ready for manual neighboring-file
evidence review.

It is not ready for source-list edits.

No edit is authorized by this report.
