# Source Candidate Evidence Matrix

Status: generated cross-layer evidence matrix

Date: 2026-06-28

## Safety boundary

This report summarizes source-candidate evidence only.

No physical phone action is authorized.

No source tree is accepted as a build input by this report.

No firmware, boot image, recovery image, vbmeta image, dtbo image, or partition image is produced or flashed.

## Inputs

| Layer | Report |
|---|---|
| Recovery/TWRP | reports\twrp_source_candidate_comparison.md |
| Stock-derived def | reports\stock_def_source_candidate_comparison.md |
| sm6150 common | reports\source_audit_fraaxius_sm6150_common.md |

## Known target identity

| Field | Current known value | Confidence |
|---|---|---|
| Device | Motorola One Hyper XT2027-1 | previously observed from real phone; not re-touched here |
| Codename/product family | def / def_retail | previously observed from real phone; supported by source-candidate naming |
| Channel | retus | previously observed from real phone; not verified by firmware package yet |
| Android build | RPFS31.Q1-21-20-1-7-3 | previously observed from real phone; exact stock firmware still missing |
| SoC family | Qualcomm sm6150 family | source-candidate supported; still needs stock firmware confirmation |

## Signal matrix

| Signal | TWRP layer hits | Stock def layer hits | sm6150-common layer hits | Classification |
|---|---:|---:|---:|---|
| `def` | 9 | 11 | 34 | cross-layer signal |
| `sm6150` | 2 | 3 | 47 | cross-layer signal |
| `BOARD_` | 1 | 1 | 97 | cross-layer signal |
| `TARGET_` | 1 | 1 | 96 | cross-layer signal |
| `PRODUCT_` | 1 | 1 | 30 | cross-layer signal |
| `recovery` | 9 | 3 | 24 | cross-layer signal |
| `fstab` | 3 | 2 | 42 | cross-layer signal |
| `boot` | 8 | 7 | 60 | cross-layer signal |
| `vendor_boot` | 2 | 2 | 2 | cross-layer signal |
| `dtbo` | 3 | 3 | 4 | cross-layer signal |
| `vbmeta` | 3 | 4 | 5 | cross-layer signal |
| `super` | 1 | 2 | 22 | cross-layer signal |
| `dynamic` | 1 | 2 | 40 | cross-layer signal |
| `qcom` | 1 | 1 | 71 | cross-layer signal |
| `motorola` | 2 | 2 | 31 | cross-layer signal |
| `proprietary` | 1 | 4 | 50 | cross-layer signal |
| `vendor` | 2 | 5 | 114 | cross-layer signal |
| `odm` | 0 | 1 | 1 | two-layer signal |
| `product` | 1 | 4 | 16 | cross-layer signal |
| `system_ext` | 0 | 1 | 6 | two-layer signal |
| `kernel` | 0 | 3 | 6 | two-layer signal |

## Evidence interpretation

### Stronger source evidence

A signal is stronger when it appears across recovery/TWRP evidence, stock-derived device metadata, and shared sm6150-common evidence.

Strong source evidence can guide the next audit questions, but it still does not authorize build input acceptance or physical-device actions.

### Weaker source evidence

A signal is weaker when it appears in only one layer or only inside generated report prose.

Weak signals should not be used to make partition, boot, recovery, AVB, or vendor-blob assumptions.

### Still blocked by missing stock firmware

The following remain blocked until an exact or safely compatible stock firmware package is identified and extracted outside the repo:

- verified partition map
- verified boot image layout
- verified vendor_boot presence or absence
- verified dtbo/vbmeta behavior
- verified dynamic partition/super layout
- verified proprietary blob source
- verified recovery or boot image packing assumptions
- any physical-device boot or flash pathway

## Current decision

All source candidates remain audit inputs only.

No candidate is accepted as a build input.

The next hard-work phase should shift from source candidate audit to stock firmware acquisition and metadata-only firmware inventory.

Recommended next artifact: `reports/stock_firmware_search_matrix.md`.
