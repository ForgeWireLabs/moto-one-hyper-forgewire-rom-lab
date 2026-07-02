# Exact RETUS Deeper Vendor Review

Status: deeper vendor-side exact RETUS review; no source-list edits or waivers authorized

## Scope

This report reviews the `12` unresolved exact RETUS entries previously classified as:

- decision posture: `exact-retus-needed-deeper-vendor-review`
- partition family: `vendor`
- residual family: `uncategorized`

This is a follow-up to:

- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`

The purpose is to determine whether these entries represent absent vendor
directories, random missing firmware, or same-directory variant/version drift.

## Inputs

Committed reports:

- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`

Local-only input artifacts:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_unresolved_classification_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_vendor_a_combined_targeted_observed_paths_20260702.csv`

Local-only generated review artifacts:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_deeper_vendor_review_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_deeper_vendor_review_summary_20260702.txt`

These local-only CSV and text artifacts must not be committed.

## Review method

The review isolated unresolved entries where:

- `decision_posture == exact-retus-needed-deeper-vendor-review`

For each entry, the review checked exact RETUS vendor observed paths for:

- exact basename hits;
- same-parent-directory evidence;
- token-related vendor hits.

The review did not modify source lists.

The review did not import blobs.

The review did not create a generated vendor tree.

## Summary

| Metric | Count |
|---|---:|
| Vendor entries reviewed | `12` |
| Review posture `same-directory-variant-review` | `12` |
| Risk `high` | `12` |
| Source tree `sm6150-common` | `12` |

## Vendor review family distribution

| Vendor review family | Count |
|---|---:|
| `uncategorized_vendor` | `7` |
| `data_dpm` | `5` |

## Example entries

Representative entries from the review:

| Tree | Line | Expected path | Exact basename hits | Same-parent hits | Token hits |
|---|---:|---|---:|---:|---:|
| `sm6150-common` | `153` | `vendor/lib/vendor.qti.data.factory@2.2.so` | `0` | `674` | `529` |
| `sm6150-common` | `154` | `vendor/lib/vendor.qti.data.factory@2.3.so` | `0` | `674` | `529` |
| `sm6150-common` | `168` | `vendor/lib64/vendor.qti.data.factory@2.2.so` | `0` | `690` | `529` |
| `sm6150-common` | `169` | `vendor/lib64/vendor.qti.data.factory@2.3.so` | `0` | `690` | `529` |
| `sm6150-common` | `180` | `vendor/lib64/vendor.qti.hardware.data.lce@1.0.so` | `0` | `690` | `677` |
| `sm6150-common` | `182` | `vendor/lib64/vendor.qti.hardware.mwqemadapter@1.0.so` | `0` | `690` | `676` |
| `sm6150-common` | `198` | `vendor/etc/charger_fstab.qti` | `0` | `305` | `447` |
| `sm6150-common` | `315` | `vendor/etc/cacert_location.pem` | `0` | `305` | `3` |
| `sm6150-common` | `316` | `vendor/etc/xtra_root_cert.pem` | `0` | `305` | `1` |
| `sm6150-common` | `696` | `vendor/lib64/vendor.qti.hardware.radio.lpa@1.2.so` | `0` | `690` | `676` |

## Interpretation

The deeper vendor review did not find exact basename matches for the `12`
entries.

However, every entry had same-parent-directory evidence in exact RETUS vendor
inventories. This means the relevant vendor directories are present and heavily
populated.

The result supports this interpretation:

- these are not missing-directory cases;
- these are not random firmware-acquisition failures;
- they are same-directory variant/version mismatches against exact RETUS;
- they remain high-risk because several entries touch data, DPM, LPA, certificates,
  charger fstab, and QTI vendor interfaces.

## Decision

The `12` entries are reclassified from:

- `exact-retus-needed-deeper-vendor-review`

to:

- `same-directory-variant-review`

The risk remains:

- `high`

No entry in this bucket is approved for removal.

No entry in this bucket is approved for waiver.

No source-list edit is authorized.

## Recommended next evidence step

Create a focused same-directory variant/equivalence review for these `12`
entries.

That review should inspect nearby exact RETUS vendor observed files and answer:

1. whether an equivalent versioned interface exists;
2. whether the expected interface version is absent because exact RETUS uses a
   different HAL version;
3. whether the entry is inherited common-tree drift;
4. whether the entry is build-critical, radio/data-critical, or safe to leave blocked;
5. whether any line should move into a future source-list proposal.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- direct removal proposals for this bucket;
- RETBR substitution;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
