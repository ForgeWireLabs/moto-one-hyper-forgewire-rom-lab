# Exact RETUS Unresolved Classification Report

Status: exact RETUS Route A unresolved-entry classification; no source-list edits or waivers authorized

## Scope

This report classifies the `123` active proprietary-file entries that remain
unresolved after exact RETUS adjusted line coverage.

This report is based on the committed exact RETUS Route A evidence path:

- `reports/exact_retus_artifact_verification.md`
- `reports/exact_retus_super_reconstruction_summary.md`
- `reports/exact_retus_line_coverage_result.md`

This classification replaces the earlier Route B RETBR unresolved posture for
current decision-making. Route B remains comparison-only evidence.

## Inputs

Committed input report:

- `reports/exact_retus_line_coverage_result.md`

Local-only adjusted coverage input:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_combined_line_coverage_adjusted_v2_20260702.csv`

Local-only generated classification artifacts:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_unresolved_classification_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_unresolved_classification_summary_20260702.txt`

These local-only CSV and text artifacts must not be committed.

## Prior coverage result

Exact RETUS adjusted line coverage produced:

| Metric | Count |
|---|---:|
| Active expected proprietary entries | `1,213` |
| Direct vendor matches | `957` |
| Direct non-vendor matches | `133` |
| Combined direct matches | `1,090` |
| Remaining active unresolved entries | `123` |
| Disabled/optional entries | `32` |
| Coverage over active expected entries | `89.8599%` |

The unresolved set classified here is exactly the `123` active entries not
directly proven by the adjusted exact RETUS line-coverage pass.

## Unresolved classes

| Unresolved class | Count |
|---|---:|
| `not-visible-in-vendor-combined-targeted-inventory` | `73` |
| `not-visible-in-non-vendor-targeted-inventory` | `50` |

## Decision posture summary

| Decision posture | Count |
|---|---:|
| `source-list-drift-candidate` | `69` |
| `do-not-waive` | `30` |
| `exact-retus-needed-deeper-vendor-review` | `12` |
| `renamed-or-version-shifted` | `11` |
| `deeper-targeted-inventory-needed` | `1` |

## Risk summary

| Risk | Count |
|---|---:|
| `critical` | `30` |
| `high` | `84` |
| `medium` | `9` |

## Residual family summary

| Residual family | Count |
|---|---:|
| `wfd_wifi_display_hdcp` | `69` |
| `radio_ims_qcril` | `29` |
| `uncategorized` | `12` |
| `manifest_permissions_config` | `4` |
| `qti_data_cne_latency` | `3` |
| `bluetooth_audio` | `2` |
| `display_graphics` | `2` |
| `camera` | `1` |
| `keymaster_gatekeeper_qsee` | `1` |

## Tree distribution

| Tree | Count |
|---|---:|
| `def` | `4` |
| `sm6150-common` | `119` |

The unresolved surface is overwhelmingly concentrated in `sm6150-common`.

## Partition-family distribution

| Partition family | Count |
|---|---:|
| `vendor` | `73` |
| `system_ext` | `46` |
| `product` | `4` |

## Decision posture by residual family

| Decision posture | Residual family | Count |
|---|---|---:|
| `source-list-drift-candidate` | `wfd_wifi_display_hdcp` | `69` |
| `do-not-waive` | `radio_ims_qcril` | `29` |
| `do-not-waive` | `keymaster_gatekeeper_qsee` | `1` |
| `exact-retus-needed-deeper-vendor-review` | `uncategorized` | `12` |
| `renamed-or-version-shifted` | `manifest_permissions_config` | `4` |
| `renamed-or-version-shifted` | `qti_data_cne_latency` | `3` |
| `renamed-or-version-shifted` | `bluetooth_audio` | `2` |
| `renamed-or-version-shifted` | `display_graphics` | `2` |
| `deeper-targeted-inventory-needed` | `camera` | `1` |

## Interpretation

The remaining exact RETUS gap is not evenly distributed.

The largest block is `wfd_wifi_display_hdcp`, with `69` entries. These are
classified as `source-list-drift-candidate`, not as immediate absence claims.
They should be reviewed against source provenance, branch lineage, and whether
the inherited common-tree expectations represent a real requirement for this
exact `def_retail` RETUS build.

The critical block is `radio_ims_qcril`, with `29` entries, plus one
`keymaster_gatekeeper_qsee` entry. These are classified as `do-not-waive`.
Radio, IMS, QCRIL, telephony, and security/TEE-related surfaces are
channel-sensitive and must not be papered over by source-list cleanup.

The `renamed-or-version-shifted` group contains `11` entries across manifest,
permissions, CNE/latency, Bluetooth audio, and display/graphics families. These
need exact equivalence review rather than simple removal.

The `exact-retus-needed-deeper-vendor-review` group contains `12`
uncategorized vendor-side entries. These are not safe to classify as drift yet;
they need deeper directory-specific exact RETUS review.

The `deeper-targeted-inventory-needed` group contains one camera-related entry.
It may require more specific path enumeration before any decision.

## Decision

Exact RETUS Route A evidence supports this classification posture:

1. `69` WFD/Wi-Fi Display/HDCP entries may proceed to source-list drift review.
2. `30` radio/security-sensitive entries remain hard blocked and must not be waived.
3. `11` renamed/version-shifted entries require equivalence review.
4. `12` vendor-side uncategorized entries require deeper exact RETUS vendor review.
5. `1` camera entry requires deeper targeted inventory.

No source-list edits are authorized by this classification report.

No source-list waivers are authorized by this classification report.

No blob import, generated vendor tree creation, or build use is authorized by
this classification report.

## Recommended next evidence step

Create a narrow exact RETUS drift-review report for the `69`
`wfd_wifi_display_hdcp` entries.

That review should answer:

- whether the WFD/Wi-Fi Display/HDCP entries are inherited common-tree drift;
- whether exact RETUS contains an equivalent but differently named stack;
- whether the entries belong to another device lineage or branch;
- whether any entries are generated/source-side expectations rather than stock
  firmware blobs;
- whether the safest action is source-list retention, removal proposal, or
  additional inventory.

The review must not edit source lists directly.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- RETBR substitution;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
