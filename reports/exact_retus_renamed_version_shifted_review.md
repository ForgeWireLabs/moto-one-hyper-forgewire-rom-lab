# Exact RETUS Renamed / Version-Shifted Equivalence Review

Status: equivalence review; no source-list edits or waivers authorized

## Scope

This report reviews the `11` unresolved exact RETUS entries previously classified as:

- decision posture: `renamed-or-version-shifted`
- partition family: `vendor`

This is a follow-up to:

- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`

The purpose is to determine whether these entries appear to be probable version
shifts, possible renamed stack changes, same-directory absences, or unproven
requirements.

## Inputs

Committed reports:

- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`

Local-only input artifacts:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_unresolved_classification_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_vendor_a_combined_targeted_observed_paths_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_non_vendor_targeted_observed_paths_20260702.csv`

Local-only generated review artifacts:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_renamed_version_shifted_review_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_renamed_version_shifted_review_summary_20260702.txt`

These local-only CSV and text artifacts must not be committed.

## Review method

The review isolated unresolved entries where:

- `decision_posture == renamed-or-version-shifted`

For each entry, the review checked exact RETUS observed vendor and non-vendor
paths for:

- exact basename hits;
- version-normalized related hits;
- token-related hits;
- same-parent-directory evidence.

The review did not modify source lists.

The review did not import blobs.

The review did not create a generated vendor tree.

## Summary

| Metric | Count |
|---|---:|
| Entries reviewed | `11` |
| Partition family `vendor` | `11` |

## Equivalence posture distribution

| Equivalence posture | Count |
|---|---:|
| `possible-rename-or-stack-shift` | `7` |
| `probable-version-shift` | `2` |
| `same-directory-absence` | `2` |

## Family distribution

| Family | Count |
|---|---:|
| `manifest_permissions_config` | `4` |
| `qti_data_cne_latency` | `3` |
| `bluetooth_audio` | `2` |
| `display_graphics` | `2` |

## Risk distribution

| Risk | Count |
|---|---:|
| `high` | `9` |
| `medium` | `2` |

## Tree distribution

| Tree | Count |
|---|---:|
| `sm6150-common` | `7` |
| `def` | `4` |

## Example entries

Representative entries from the review:

| Posture | Tree | Line | Expected path | Exact hits | Version hits | Token hits | Parent hits |
|---|---|---:|---|---:|---:|---:|---:|
| `possible-rename-or-stack-shift` | `def` | `128` | `vendor/etc/hdr_tm_config.xml` | `0` | `0` | `52` | `305` |
| `possible-rename-or-stack-shift` | `def` | `198` | `vendor/etc/qdcm_calib_data_mipi_mot_vid_focal_1080p_653.xml` | `0` | `0` | `106` | `305` |
| `possible-rename-or-stack-shift` | `def` | `199` | `vendor/etc/qdcm_calib_data_mipi_mot_vid_nova_1080p_653.xml` | `0` | `0` | `106` | `305` |
| `possible-rename-or-stack-shift` | `sm6150-common` | `90` | `vendor/lib/libbluetooth_audio_session_qti_2_1.so` | `0` | `0` | `822` | `674` |
| `possible-rename-or-stack-shift` | `sm6150-common` | `141` | `vendor/etc/cne/mwqem.conf` | `0` | `0` | `5` | `29` |
| `possible-rename-or-stack-shift` | `sm6150-common` | `248` | `vendor/etc/gpfspath_oem_config.xml` | `0` | `0` | `55` | `305` |
| `possible-rename-or-stack-shift` | `sm6150-common` | `457` | `vendor/etc/system_properties.xml` | `0` | `0` | `50` | `305` |
| `probable-version-shift` | `sm6150-common` | `87` | `vendor/lib/hw/vendor.qti.hardware.bluetooth_audio@2.1-impl.so` | `0` | `2` | `1302` | `56` |
| `probable-version-shift` | `sm6150-common` | `185` | `vendor/lib64/vendor.qti.latency@2.1.so` | `0` | `4` | `865` | `690` |
| `same-directory-absence` | `def` | `229` | `vendor/etc/vhw.xml` | `0` | `0` | `0` | `305` |
| `same-directory-absence` | `sm6150-common` | `142` | `vendor/etc/cne/profileMwqem.xml` | `0` | `0` | `0` | `29` |

## Interpretation

The renamed/version-shifted bucket is mixed.

Two entries have probable version-shift evidence:

- `vendor/lib/hw/vendor.qti.hardware.bluetooth_audio@2.1-impl.so`
- `vendor/lib64/vendor.qti.latency@2.1.so`

These had version-normalized related hits in exact RETUS observed paths. They are
not approved for removal, but they are lower risk than entries with only weak
token evidence.

Seven entries have possible rename or stack-shift evidence. They had token and
parent-directory evidence, but no exact basename or version-normalized match.
These remain high risk and need manual equivalence review.

Two entries had same-parent-directory evidence only:

- `vendor/etc/vhw.xml`
- `vendor/etc/cne/profileMwqem.xml`

These remain blocked. The current evidence does not support treating them as
equivalent to an observed exact RETUS path.

## Decision

The `11` entries remain unresolved but are now split into three review postures:

| Review posture | Count | Decision |
|---|---:|---|
| `probable-version-shift` | `2` | eligible for future equivalence proposal |
| `possible-rename-or-stack-shift` | `7` | requires manual equivalence review |
| `same-directory-absence` | `2` | remains blocked |

No entry in this bucket is approved for removal.

No entry in this bucket is approved for waiver.

No source-list edit is authorized.

## Recommended next evidence step

Create a narrow equivalence proposal only for the `2` probable-version-shift
entries.

That proposal should identify the observed exact RETUS version-related paths and
decide whether the source-list expectation should be retained, annotated,
version-adjusted, or left blocked.

The `7` possible rename/stack-shift entries and `2` same-directory absences
should not be changed without deeper manual review.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- direct removal proposals for this bucket;
- equivalence claims for the `7` possible rename/stack-shift entries;
- equivalence claims for the `2` same-directory absences;
- RETBR substitution;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
