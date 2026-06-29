# TWRP Source Candidate Comparison

Status: generated comparison

Date: 2026-06-28

## Safety boundary

This report compares two public TWRP/recovery source candidate audits.

No physical phone action is authorized.

No source tree is accepted as a build input by this comparison.

No firmware, boot image, recovery image, vbmeta image, dtbo image, or partition image is produced or flashed.

## Compared reports

| Candidate | Report |
|---|---|
| ixmoe TWRP def | reports\source_audit_ixmoe_def_twrp.md |
| Nandru86 TWRP def | reports\source_audit_nandru86_def_twrp.md |

## Term signal comparison

| Term | ixmoe report hits | Nandru86 report hits | Initial reading |
|---|---:|---:|---|
| `BOARD_` | 125 | 125 | present in both reports |
| `TARGET_` | 94 | 94 | present in both reports |
| `PRODUCT_` | 54 | 54 | present in both reports |
| `def` | 59 | 59 | present in both reports |
| `sm6150` | 18 | 18 | present in both reports |
| `recovery` | 81 | 81 | present in both reports |
| `fstab` | 14 | 14 | present in both reports |
| `vendor_boot` | 2 | 2 | present in both reports |
| `boot` | 50 | 50 | present in both reports |
| `dtbo` | 8 | 8 | present in both reports |
| `vbmeta` | 6 | 6 | present in both reports |
| `super` | 2 | 2 | present in both reports |
| `dynamic` | 13 | 13 | present in both reports |
| `qcom` | 34 | 34 | present in both reports |
| `motorola` | 30 | 30 | present in both reports |
| `proprietary` | 1 | 1 | present in both reports |

## Shared provisional signals

The following should be treated as provisional until confirmed against stock firmware:

- Both candidates are recovery/TWRP-oriented evidence sources, not full ROM build trees.
- Both candidates may help identify recovery layout, fstab behavior, BoardConfig assumptions, and Motorola `def` naming.
- Neither candidate proves compatibility with the target phone build `RPFS31.Q1-21-20-1-7-3`.
- Neither candidate provides a verified stock boot image, stock recovery anchor, full firmware package, or safe physical-device path.

## Evidence classes

### Stronger evidence

A clue is stronger when it appears in both independently cloned TWRP candidates and aligns with the known target identity:

- Motorola One Hyper
- Codename/product family `def`
- Qualcomm/sm6150 family references
- recovery/fstab/BoardConfig references

### Weak evidence

A clue is weak when it appears in only one candidate, appears only in generated report text, or is not tied to a concrete file excerpt.

### Not evidence yet

The following are not established by TWRP source candidates alone:

- verified stock partition layout
- verified Android 11 image layout
- verified boot/vendor_boot/dtbo/vbmeta behavior for the specific target build
- verified recovery bootability
- full custom ROM build readiness

## Current decision

Keep both TWRP candidates as recovery/partition clue sources only.

Do not accept either tree as a build input.

Do not use either tree for physical-device boot or flash attempts.

Next recommended step: audit the first stock-derived def candidate, `AndroidBlobs_device_motorola_def`.
