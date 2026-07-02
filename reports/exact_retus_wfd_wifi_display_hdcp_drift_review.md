# Exact RETUS WFD / Wi-Fi Display / HDCP Drift Review

Status: narrow exact RETUS Route A drift review; no source-list edits or waivers authorized

## Scope

This report reviews the `69` unresolved exact RETUS entries classified as:

- residual family: `wfd_wifi_display_hdcp`
- decision posture: `source-list-drift-candidate`

This is a narrow follow-up to:

- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`

The purpose is to determine whether the WFD/Wi-Fi Display/HDCP residual block
appears to be random missing firmware, a hard blocker, or a concentrated
common-tree/source-list drift candidate.

## Inputs

Committed input reports:

- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`

Local-only input artifacts:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_unresolved_classification_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_vendor_a_combined_targeted_observed_paths_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_non_vendor_targeted_observed_paths_20260702.csv`

Local-only generated review artifacts:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_wfd_wifi_display_hdcp_drift_review_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_wfd_wifi_display_hdcp_drift_review_summary_20260702.txt`

These local-only CSV and text artifacts must not be committed.

## Review method

The review isolated unresolved entries where:

- `residual_family == wfd_wifi_display_hdcp`

For each isolated entry, the review compared the expected path against exact
RETUS observed vendor and non-vendor path inventories.

The review recorded:

- exact basename hits;
- related WFD/Wi-Fi Display/HDCP observed hits;
- source tree;
- partition family;
- unresolved class;
- review posture.

The review did not modify source lists.

The review did not import blobs.

The review did not create a generated vendor tree.

## Summary

| Metric | Count |
|---|---:|
| WFD/Wi-Fi Display/HDCP residual entries reviewed | `69` |
| Review posture: `source-list-drift-candidate` | `69` |

## WFD hint distribution

| Hint | Count |
|---|---:|
| `wfd` | `56` |
| `wifi_display` | `7` |
| `hdcp` | `6` |

## Source tree distribution

| Tree | Count |
|---|---:|
| `sm6150-common` | `69` |

No `def` device-tree entries were part of this residual block. The entire WFD
residual block is inherited from the common tree.

## Partition-family distribution

| Partition family | Count |
|---|---:|
| `system_ext` | `37` |
| `vendor` | `32` |

## Unresolved class distribution

| Unresolved class | Count |
|---|---:|
| `not-visible-in-non-vendor-targeted-inventory` | `37` |
| `not-visible-in-vendor-combined-targeted-inventory` | `32` |

## Example entries

Representative examples from the review:

| Tree | Line | Expected path | Exact basename hits | Related observed hits |
|---|---:|---|---:|---:|
| `sm6150-common` | `984` | `system_ext/bin/wfdservice` | `0` | `3` |
| `sm6150-common` | `985` | `system_ext/etc/init/wfdservice.rc` | `0` | `3` |
| `sm6150-common` | `986` | `system_ext/etc/seccomp_policy/wfdservice.policy` | `0` | `3` |
| `sm6150-common` | `987` | `system_ext/etc/wfdconfigsink.xml` | `0` | `3` |
| `sm6150-common` | `992` | `system_ext/lib/libwfdavenhancements.so` | `0` | `3` |
| `sm6150-common` | `993` | `system_ext/lib/libwfdclient.so` | `0` | `3` |
| `sm6150-common` | `994` | `system_ext/lib/libwfdcommonutils.so` | `0` | `3` |
| `sm6150-common` | `995` | `system_ext/lib/libwfdconfigutils.so` | `0` | `3` |

## Interpretation

The WFD/Wi-Fi Display/HDCP residual block is highly concentrated:

- all `69` entries come from `sm6150-common`;
- none come from the device-specific `def` tree;
- the block spans only `system_ext` and `vendor`;
- each reviewed example had no exact basename hit;
- each reviewed example had related observed WFD/HDCP stack evidence.

This supports a source-list drift interpretation.

It does not prove that the WFD stack can be removed.

It does not prove that the entries are unnecessary.

It does not authorize a waiver.

It does show that the residual block is not random missing firmware from exact
RETUS. It is a coherent inherited common-tree WFD/Wi-Fi Display/HDCP expectation
that does not directly match the exact RETUS observed path surface.

## Decision

The `69` WFD/Wi-Fi Display/HDCP entries remain classified as:

- `source-list-drift-candidate`
- risk: `high`

They should move to source-list provenance review.

They should not be treated as radio/security hard blockers.

They should not be silently waived.

They should not be removed without a separate source-list decision report.

## Recommended next evidence step

Create a source-list provenance review for the WFD/Wi-Fi Display/HDCP block.

That review should inspect the common-tree source lineage and answer:

1. Which commit or branch introduced the WFD/Wi-Fi Display/HDCP entries?
2. Were the entries inherited from another Motorola SM6150 device?
3. Were the entries validated against `def_retail` exact RETUS, or only against a related device/build?
4. Are any entries generated/source-side expectations rather than stock firmware blobs?
5. Are exact RETUS observed WFD/HDCP paths equivalent under renamed or consolidated stack layout?
6. Should the source list retain, annotate, split, or propose removal for this block?

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- direct removal proposals without provenance review;
- RETBR substitution;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
