# Stock-Derived def Source Candidate Comparison

Status: generated comparison

Date: 2026-06-28

## Safety boundary

This report compares two stock-derived Motorola def source candidate audits.

No physical phone action is authorized.

No source tree is accepted as a build input by this comparison.

No firmware, boot image, recovery image, vbmeta image, dtbo image, or partition image is produced or flashed.

## Compared reports

| Candidate | Report |
|---|---|
| AndroidBlobs def | reports\source_audit_androidblobs_def.md |
| ludevjhon def | reports\source_audit_ludevjhon_def.md |

## Term signal comparison

| Term | AndroidBlobs report hits | ludevjhon report hits | Initial reading |
|---|---:|---:|---|
| `BOARD_` | 4 | 62 | present in both reports |
| `TARGET_` | 116 | 143 | present in both reports |
| `PRODUCT_` | 48 | 46 | present in both reports |
| `def` | 65 | 68 | present in both reports |
| `sm6150` | 18 | 22 | present in both reports |
| `recovery` | 21 | 21 | present in both reports |
| `fstab` | 19 | 19 | present in both reports |
| `vendor_boot` | 2 | 2 | present in both reports |
| `boot` | 55 | 65 | present in both reports |
| `dtbo` | 3 | 3 | present in both reports |
| `vbmeta` | 6 | 6 | present in both reports |
| `super` | 2 | 2 | present in both reports |
| `dynamic` | 22 | 22 | present in both reports |
| `qcom` | 85 | 84 | present in both reports |
| `motorola` | 41 | 46 | present in both reports |
| `proprietary` | 42 | 42 | present in both reports |
| `vendor` | 84 | 99 | present in both reports |
| `odm` | 1 | 1 | present in both reports |
| `product` | 25 | 26 | present in both reports |
| `system_ext` | 0 | 0 | not established |
| `kernel` | 4 | 8 | present in both reports |

## Shared provisional signals

The following should be treated as provisional until confirmed against exact stock firmware:

- Both candidates are Motorola `def` source metadata references.
- Both candidates may help identify device makefiles, BoardConfig assumptions, product naming, proprietary-file mapping, and vendor dependency shape.
- Neither candidate proves compatibility with target build `RPFS31.Q1-21-20-1-7-3`.
- Neither candidate provides a verified stock boot image, stock recovery anchor, full firmware package, or safe physical-device path.

## Evidence classes

### Stronger evidence

A clue is stronger when it appears in both stock-derived def candidates and also agrees with the TWRP comparison evidence:

- Motorola One Hyper
- Codename/product family `def`
- Qualcomm/sm6150 family references
- dynamic/super/vbmeta/fstab references
- proprietary-files or vendor blob mapping
- device/product makefile naming

### Weak evidence

A clue is weak when it appears in only one stock-derived candidate, appears only in generated report text, or is not tied to a concrete file excerpt.

### Not evidence yet

The following are not established by these source candidates alone:

- verified stock partition layout
- verified Android 11 image layout
- verified boot/vendor_boot/dtbo/vbmeta behavior for the specific target build
- verified proprietary blob completeness
- verified kernel source or prebuilt kernel compatibility
- full custom ROM build readiness

## Current decision

Keep both stock-derived def candidates as metadata and dependency evidence only.

Do not accept either tree as a build input.

Do not use either tree for physical-device boot or flash attempts.

Next recommended step: audit the shared SoC/common candidate, `Fraaxius_device_motorola_sm6150-common`.
