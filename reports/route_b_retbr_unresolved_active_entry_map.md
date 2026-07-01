# Route B RETBR Unresolved Active Entry Map

Status: residual blocker map; no import/build/device action authorized

## Scope

This report summarizes the remaining active proprietary-file entries that were
not directly observed after the Route B RETBR vendor-side and non-vendor
line-coverage passes.

This is a blocker map only. It does not authorize:

- RETBR substitution for exact retus firmware;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- adb/fastboot;
- LMSA/RSA rescue or repair;
- flashing;
- bootloader actions;
- physical device interaction.

WI-004 remains blocked.

## Input

Local-only residual input:

- `C:\Projects\moto-one-hyper-local\audits\route_b_retbr_combined_unresolved_active_entries_20260701.csv`

Local-only CSV SHA256:

- `899BFA98026B9597408AE0C15FB8238C0B64EC65E49218846E5C2C6497176031`

The CSV remains local-only and must not be committed.

## Summary

After the Route B RETBR line-coverage evidence phase:

| Metric | Count |
|---|---:|
| Active expected proprietary entries | 1,213 |
| Combined direct matches | 1,090 |
| Combined direct observed coverage | approximately 89.9% |
| Remaining active unresolved entries | 123 |
| Disabled/optional entries | 32 |

This report maps the 123 remaining active unresolved entries.

## Residual groups

| Residual group | Count |
|---|---:|
| `non_vendor_unresolved` | 50 |
| `wfd_wifi_display_hdcp` | 32 |
| `qcril_database_upgrade_tail` | 13 |
| `qti_data_cne_latency` | 9 |
| `misc_config_gap` | 6 |
| `radio_ims_version_gap` | 4 |
| `display_panel_calibration` | 4 |
| `bluetooth_audio_version_gap` | 2 |
| `other` | 2 |
| `keymaster_version_gap` | 1 |

## Tree and family distribution

| Tree/family | Count |
|---|---:|
| `sm6150-common`, `vendor/lib` | 27 |
| `sm6150-common`, `system_ext/lib` | 20 |
| `sm6150-common`, `system_ext/lib64` | 17 |
| `sm6150-common`, `vendor/etc` | 16 |
| `sm6150-common`, `vendor/radio` | 13 |
| `sm6150-common`, `vendor/lib64` | 10 |
| `sm6150-common`, `system_ext/etc` | 5 |
| `def`, `vendor/etc` | 4 |
| `sm6150-common`, `system_ext/framework` | 3 |
| `sm6150-common`, `vendor/bin` | 3 |
| `sm6150-common`, `product/framework` | 2 |
| `sm6150-common`, `product/etc` | 2 |
| `sm6150-common`, `system_ext/bin` | 1 |

## Category distribution

| Category | Count |
|---|---:|
| `uncategorized` | 85 |
| `radio_ims_qcril` | 23 |
| `display_graphics|wifi_bluetooth` | 7 |
| `display_graphics` | 3 |
| `audio|wifi_bluetooth` | 2 |
| `camera` | 1 |
| `drm_widevine` | 1 |
| `keymaster_gatekeeper_qsee` | 1 |

## Interpretation by residual family

### WFD / Wi-Fi Display / HDCP

WFD and Wi-Fi Display are the largest named residual family.

Observed unresolved examples include:

- `vendor/bin/wfdvndservice`
- `vendor/bin/wifidisplayhalservice`
- `vendor/bin/wfdhdcphalservice`
- WFD init RC files
- WFD seccomp policy files
- WFD vendor libraries
- WFD system_ext service and library entries

Interpretation:

Route B RETBR shows partial HDCP-related support elsewhere, but the broader
expected WFD/Wi-Fi Display stack is not fully observed at the expected paths.
This is a coherent feature-family gap, not random coverage failure.

### QCRIL database upgrade tail

The unresolved QCRIL tail consists of expected later upgrade SQL files under:

- `vendor/radio/qcril_database/upgrade`

Interpretation:

Route B RETBR observed the QCRIL database upgrade directory and earlier upgrade
files, but not the expected later tail. This is likely a version or source-list
drift gap between the expected common tree and this Android 11 RETBR payload.

### QTI data / CNE / latency

The QTI data/CNE/latency group includes CNE config and QTI data/latency
libraries across `vendor/etc`, `vendor/lib`, and `vendor/lib64`.

Interpretation:

This looks like a version-sensitive Qualcomm data stack gap. It should be treated
as unresolved until exact retus evidence or a deliberate source-list decision is
available.

### Radio / IMS version gaps

The radio/IMS version gaps include newer expected IMS/radio libraries not
observed at the expected paths.

Interpretation:

This aligns with the non-vendor IMS/RCS/UCE residuals and should be treated as a
radio stack version gap, not as an import-ready missing-file exception.

### Display panel calibration

The `def` tree has four unresolved display/panel calibration entries under
`vendor/etc`, including HDR/qdcm/vhw-style configuration files.

Interpretation:

These are device-specific display calibration/config entries. Because they are
`def`-specific, they remain important blockers until exact retus evidence proves
presence, absence, or source-list drift.

### Bluetooth audio version gaps

The Bluetooth audio residuals appear to be versioned Qualcomm Bluetooth audio
HAL/library expectations.

Interpretation:

This is likely version-sensitive and should not be silently ignored.

### Keymaster version gap

The keymaster residual is a single expected keymaster init entry.

Interpretation:

Because this touches keymaster/gatekeeper/QSEE-adjacent startup behavior, it
should remain blocked until exact source evidence or source-list correction.

### Non-vendor unresolved

The non-vendor unresolved group contains remaining `system_ext` and `product`
entries not observed in Route B `system_a.img` or `product_a.img`.

The group includes:

- WFD/Wi-Fi Display system_ext stack entries;
- IMS/RCS framework and library version entries;
- UCE service 2.3 entries;
- UIM GBA product permission/framework entries;
- one Motorola AndroidX camera permission entry.

Interpretation:

This reinforces the same pattern: most residuals are concentrated in coherent
feature/version families rather than broad missing partition evidence.

## Decision

The unresolved active entries remain blockers.

They do not invalidate Route B as strong offline comparison evidence, but they do
prevent any responsible import/build authorization from Route B alone.

WI-004 remains blocked.

## Next required evidence

The clean next evidence source remains exact retus firmware for:

- `RPFS31.Q1-21-20-1-7-3 / 37074e`
- XT2027-1
- `def_retail`
- retus channel

If exact retus cannot be reacquired, any alternative path requires a separate
explicit decision gate documenting:

- why the substitute source is acceptable;
- which unresolved families are waived, corrected, or intentionally excluded;
- whether source lists must be revised;
- why the decision is safe before import/build work.

## Still blocked

The following remain blocked:

- exact retus substitution decision;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
