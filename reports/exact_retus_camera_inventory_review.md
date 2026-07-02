# Exact RETUS Camera Inventory Review

Status: focused camera inventory review; no source-list edits or waivers authorized

## Scope

This report reviews the single unresolved exact RETUS entry previously classified as:

- decision posture: `deeper-targeted-inventory-needed`
- residual family: `camera`

This is a follow-up to:

- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`

The purpose is to determine whether this entry represents a missing camera stack,
a missing camera extension permission/config entry, or a possible inventory-depth
issue.

## Entry reviewed

| Tree | Line | Expected path |
|---|---:|---|
| `sm6150-common` | `526` | `system_ext/etc/permissions/com.motorola.androidx.camera.extensions.xml` |

## Inputs

Committed reports:

- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`

Local-only input artifacts:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_unresolved_classification_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_vendor_a_combined_targeted_observed_paths_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\vendor_a_deep_targeted_inventory_RPFS31_Q1_21_20_1_7_3_RETUS.txt`
- `C:\Projects\moto-one-hyper-local\audits\vendor_a_unresolved_deep_inventory_RPFS31_Q1_21_20_1_7_3_RETUS.txt`

Local-only generated review artifacts:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_camera_inventory_review_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_camera_inventory_review_summary_20260702.txt`

These local-only CSV and text artifacts must not be committed.

## Review method

The review isolated unresolved entries where:

- `decision_posture == deeper-targeted-inventory-needed`

For the camera entry, the review checked exact RETUS vendor inventories for:

- exact basename hits;
- same-parent-directory evidence;
- camera-stack path evidence;
- token-related evidence;
- deeper exact path/basename evidence;
- deeper camera-stack inventory evidence.

The review did not modify source lists.

The review did not import blobs.

The review did not create a generated vendor tree.

## Summary

| Metric | Count |
|---|---:|
| Camera entries reviewed | `1` |
| Review posture `camera-related-token-review` | `1` |
| Risk `high` | `1` |
| Source tree `sm6150-common` | `1` |

## Evidence counters

| Evidence type | Count |
|---|---:|
| Exact basename hits | `0` |
| Same-parent hits | `0` |
| Camera path hits | `143` |
| Token-related hits | `467` |
| Deep exact hits | `0` |
| Unresolved deep exact hits | `0` |
| Deep camera hits | `71` |

## Interpretation

The expected exact file was not observed:

- `system_ext/etc/permissions/com.motorola.androidx.camera.extensions.xml`

The review did not find an exact basename hit or a same-parent hit for the
expected path in the current targeted inventories.

However, exact RETUS camera-stack evidence is present:

- `143` camera-related observed path hits;
- `467` token-related observed path hits;
- `71` deeper camera inventory hits.

This supports the following interpretation:

- the exact RETUS camera stack is not absent;
- this is not evidence of a missing camera partition or missing camera extraction;
- the specific expected camera extension permissions/config entry is absent from
  current exact RETUS targeted evidence;
- the entry remains high-risk because permission/config XML can affect framework
  feature exposure and camera-extension behavior.

## Decision

The entry is reclassified from:

- `deeper-targeted-inventory-needed`

to:

- `camera-related-token-review`

The risk remains:

- `high`

The entry is not approved for removal.

The entry is not approved for waiver.

No source-list edit is authorized.

## Recommended next evidence step

Keep this entry blocked until a future manual camera permissions/config review.

That review should determine whether exact `def_retail` RETUS exposes equivalent
camera extension permissions/config elsewhere, whether the feature is absent from
the stock build, or whether the common-tree source list inherited an expectation
that does not apply to this target.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- direct removal of this camera entry;
- equivalence claims for this camera entry;
- RETBR substitution;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
