# Source-List Drift Classification Report

Status: classification summary; no source-list changes, waivers, import, build, or device action authorized

## Scope

This report classifies the 123 active proprietary-file entries that remain
unresolved after the Route B RETBR vendor-side and non-vendor line-coverage
passes.

The classification uses the committed method in:

- `reports/source_list_drift_classification_method.md`

The raw unresolved CSV remains local-only and is not committed.

## Input verification

Local-only unresolved CSV:

- `C:\Projects\moto-one-hyper-local\audits\route_b_retbr_combined_unresolved_active_entries_20260701.csv`

Verified SHA256:

- `899BFA98026B9597408AE0C15FB8238C0B64EC65E49218846E5C2C6497176031`

Verified unresolved row count:

- `123`

## Decision boundary

This report does not authorize:

- source-list edits;
- source-list waivers;
- RETBR substitution;
- exact RETUS substitution decision;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.

WI-004 remains blocked.

## Summary

| Metric | Count |
|---|---:|
| Active unresolved entries classified | 123 |
| Source-list edits authorized | 0 |
| Waivers authorized | 0 |
| Import/build actions authorized | 0 |

## Residual group distribution

| Residual group | Count |
|---|---:|
| `display_panel_calibration` | 40 |
| `wfd_wifi_display_hdcp` | 33 |
| `qti_data_cne_latency` | 26 |
| `qcril_database_upgrade_tail` | 13 |
| `non_vendor_unresolved` | 5 |
| `other` | 5 |
| `keymaster_version_gap` | 1 |

## Classification distribution

| Classification | Count |
|---|---:|
| `do-not-waive` | 41 |
| `exact-retus-needed` | 36 |
| `source-list-drift-candidate` | 33 |
| `renamed-or-version-shifted` | 13 |

## Risk distribution

| Risk | Count |
|---|---:|
| `high` | 43 |
| `critical` | 41 |
| `medium` | 34 |
| `unknown` | 5 |

## Decision posture distribution

| Decision posture | Count |
|---|---:|
| `hard-blocked` | 41 |
| `blocked-exact-retus` | 36 |
| `blocked-drift-review` | 33 |
| `blocked-equivalence-review` | 13 |

## Classification by residual family

### `keymaster_version_gap`

Count: 1

Classification mix:

| Classification | Count |
|---|---:|
| `do-not-waive` | 1 |

Risk mix:

| Risk | Count |
|---|---:|
| `critical` | 1 |

Decision posture mix:

| Decision posture | Count |
|---|---:|
| `hard-blocked` | 1 |

Representative entries:

| Expected path / family | Source tree | Category | Classification | Risk | Decision posture |
|---|---|---|---|---|---|
| `sm6150-common` | `sm6150-common` | `keymaster_gatekeeper_qsee` | `do-not-waive` | `critical` | `hard-blocked` |

Evidence summary:

- Security/QSEE-adjacent startup behavior requires exact proof. (1)

### `display_panel_calibration`

Count: 40

Classification mix:

| Classification | Count |
|---|---:|
| `do-not-waive` | 40 |

Risk mix:

| Risk | Count |
|---|---:|
| `critical` | 40 |

Decision posture mix:

| Decision posture | Count |
|---|---:|
| `hard-blocked` | 40 |

Representative entries:

| Expected path / family | Source tree | Category | Classification | Risk | Decision posture |
|---|---|---|---|---|---|
| `def` | `def` | `uncategorized` | `do-not-waive` | `critical` | `hard-blocked` |
| `def` | `def` | `uncategorized` | `do-not-waive` | `critical` | `hard-blocked` |
| `def` | `def` | `uncategorized` | `do-not-waive` | `critical` | `hard-blocked` |
| `def` | `def` | `uncategorized` | `do-not-waive` | `critical` | `hard-blocked` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `do-not-waive` | `critical` | `hard-blocked` |
| `sm6150-common` | `sm6150-common` | `display_graphics|wifi_bluetooth` | `do-not-waive` | `critical` | `hard-blocked` |
| `sm6150-common` | `sm6150-common` | `display_graphics|wifi_bluetooth` | `do-not-waive` | `critical` | `hard-blocked` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `do-not-waive` | `critical` | `hard-blocked` |
| ... 32 additional entries in this group ... |  |  |  |  |  |

Evidence summary:

- Device-specific display calibration/configuration must not be waived. (40)

### `qcril_database_upgrade_tail`

Count: 13

Classification mix:

| Classification | Count |
|---|---:|
| `renamed-or-version-shifted` | 13 |

Risk mix:

| Risk | Count |
|---|---:|
| `high` | 13 |

Decision posture mix:

| Decision posture | Count |
|---|---:|
| `blocked-equivalence-review` | 13 |

Representative entries:

| Expected path / family | Source tree | Category | Classification | Risk | Decision posture |
|---|---|---|---|---|---|
| `sm6150-common` | `sm6150-common` | `radio_ims_qcril` | `renamed-or-version-shifted` | `high` | `blocked-equivalence-review` |
| `sm6150-common` | `sm6150-common` | `radio_ims_qcril` | `renamed-or-version-shifted` | `high` | `blocked-equivalence-review` |
| `sm6150-common` | `sm6150-common` | `radio_ims_qcril` | `renamed-or-version-shifted` | `high` | `blocked-equivalence-review` |
| `sm6150-common` | `sm6150-common` | `radio_ims_qcril` | `renamed-or-version-shifted` | `high` | `blocked-equivalence-review` |
| `sm6150-common` | `sm6150-common` | `radio_ims_qcril` | `renamed-or-version-shifted` | `high` | `blocked-equivalence-review` |
| `sm6150-common` | `sm6150-common` | `radio_ims_qcril` | `renamed-or-version-shifted` | `high` | `blocked-equivalence-review` |
| `sm6150-common` | `sm6150-common` | `radio_ims_qcril` | `renamed-or-version-shifted` | `high` | `blocked-equivalence-review` |
| `sm6150-common` | `sm6150-common` | `radio_ims_qcril` | `renamed-or-version-shifted` | `high` | `blocked-equivalence-review` |
| ... 5 additional entries in this group ... |  |  |  |  |  |

Evidence summary:

- QCRIL upgrade-tail entries look version-sensitive and require exact or equivalence proof. (13)

### `qti_data_cne_latency`

Count: 26

Classification mix:

| Classification | Count |
|---|---:|
| `exact-retus-needed` | 26 |

Risk mix:

| Risk | Count |
|---|---:|
| `high` | 26 |

Decision posture mix:

| Decision posture | Count |
|---|---:|
| `blocked-exact-retus` | 26 |

Representative entries:

| Expected path / family | Source tree | Category | Classification | Risk | Decision posture |
|---|---|---|---|---|---|
| `sm6150-common` | `sm6150-common` | `audio|wifi_bluetooth` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `audio|wifi_bluetooth` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| ... 18 additional entries in this group ... |  |  |  |  |  |

Evidence summary:

- QTI data/CNE/latency stack is version-sensitive and needs target firmware evidence. (26)

### `wfd_wifi_display_hdcp`

Count: 33

Classification mix:

| Classification | Count |
|---|---:|
| `source-list-drift-candidate` | 33 |

Risk mix:

| Risk | Count |
|---|---:|
| `medium` | 33 |

Decision posture mix:

| Decision posture | Count |
|---|---:|
| `blocked-drift-review` | 33 |

Representative entries:

| Expected path / family | Source tree | Category | Classification | Risk | Decision posture |
|---|---|---|---|---|---|
| `sm6150-common` | `sm6150-common` | `uncategorized` | `source-list-drift-candidate` | `medium` | `blocked-drift-review` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `source-list-drift-candidate` | `medium` | `blocked-drift-review` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `source-list-drift-candidate` | `medium` | `blocked-drift-review` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `source-list-drift-candidate` | `medium` | `blocked-drift-review` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `source-list-drift-candidate` | `medium` | `blocked-drift-review` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `source-list-drift-candidate` | `medium` | `blocked-drift-review` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `source-list-drift-candidate` | `medium` | `blocked-drift-review` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `source-list-drift-candidate` | `medium` | `blocked-drift-review` |
| ... 25 additional entries in this group ... |  |  |  |  |  |

Evidence summary:

- WFD/Wi-Fi Display/HDCP appears feature-family concentrated and needs drift review, not waiver. (33)

### `non_vendor_unresolved`

Count: 5

Classification mix:

| Classification | Count |
|---|---:|
| `exact-retus-needed` | 5 |

Risk mix:

| Risk | Count |
|---|---:|
| `high` | 4 |
| `medium` | 1 |

Decision posture mix:

| Decision posture | Count |
|---|---:|
| `blocked-exact-retus` | 5 |

Representative entries:

| Expected path / family | Source tree | Category | Classification | Risk | Decision posture |
|---|---|---|---|---|---|
| `sm6150-common` | `sm6150-common` | `camera` | `exact-retus-needed` | `medium` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `high` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `high` | `blocked-exact-retus` |

Evidence summary:

- Non-vendor IMS/RCS/UCE/UIM entries need exact target evidence. (4)
- Camera permission/config entry needs target evidence. (1)

### `other`

Count: 5

Classification mix:

| Classification | Count |
|---|---:|
| `exact-retus-needed` | 5 |

Risk mix:

| Risk | Count |
|---|---:|
| `unknown` | 5 |

Decision posture mix:

| Decision posture | Count |
|---|---:|
| `blocked-exact-retus` | 5 |

Representative entries:

| Expected path / family | Source tree | Category | Classification | Risk | Decision posture |
|---|---|---|---|---|---|
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `unknown` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `unknown` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `unknown` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `unknown` | `blocked-exact-retus` |
| `sm6150-common` | `sm6150-common` | `uncategorized` | `exact-retus-needed` | `unknown` | `blocked-exact-retus` |

Evidence summary:

- Uncategorized unresolved entry remains blocked pending exact evidence. (5)


## Interpretation

The unresolved set remains concentrated in coherent feature/version families.
The classifications do not support moving directly from Route B evidence to
import/build work.

The strongest blockers are:

- keymaster/QSEE-adjacent startup behavior;
- device-specific display calibration/configuration;
- radio/IMS version gaps;
- QTI data/CNE/latency stack gaps;
- Bluetooth audio version gaps;
- non-vendor IMS/RCS/UCE/UIM framework and permission gaps.

WFD/Wi-Fi Display/HDCP appears more feature-family concentrated and may include
source-list drift candidates, but those entries are still blocked pending proof.
No WFD/HDCP entry is waived by this report.

## Required next evidence

The cleanest next evidence source remains exact RETUS firmware for:

- `XT2027-1`;
- `def_retail`;
- `retus`;
- `RPFS31.Q1-21-20-1-7-3 / 37074e`.

If exact RETUS cannot be reacquired, the next safe report should be a
source-list drift decision report for only the entries classified as
`source-list-drift-candidate` or `renamed-or-version-shifted`.

## Decision

All 123 unresolved active entries remain blocked.

This report improves the blocker map but does not reduce the unresolved count,
waive entries, authorize substitution, or authorize import/build work.

WI-004 remains blocked.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- RETBR substitution;
- exact RETUS substitution decision;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
