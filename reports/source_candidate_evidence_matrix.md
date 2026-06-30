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
| def device tree (A11 base) | reports\source_audit_sorenlyulf_def.md |
| sm6150 common (lineage-20, matched) | reports\source_audit_sm6150_common_lineage20.md |
| kernel sm6150 (lineage-20, matched) | reports\source_audit_kernel_motorola_sm6150_lineage20.md |

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

## Update 2026-06-30 — sorenlyulf def tree audited (era gap narrowed)

A sixth candidate, `sorenlyulf/android_device_motorola_def` (lineage-20), was
audited read-only (`reports/source_audit_sorenlyulf_def.md`). Unlike the A10
def trees and the ~A14 common tree, its `BUILD_FINGERPRINT` anchors it to the
**Android 11 `RPFS31.Q1-21-20` vendor base** — the same stock family as the
phone (`RPFS31.Q1-21-20-1-7-3`). It is def-specific, structurally complete
(BoardConfig, makefiles, 10 sepolicy files incl. `hal_motpopup`, 261-entry
`proprietary-files.txt`, extract scripts, Treble manifests) and confirms the
`kernel/motorola/sm6150` pointer (defconfig `vendor/def_defconfig`). It is now
the preferred def-specific device-tree candidate; the common tree should be
re-pointed to the **lineage-20** branch of `sm6150-common`.

## Update 2026-06-30 — lineage-20 sm6150-common audited (matched set coherent)

The matched common tree was audited read-only
(`reports/source_audit_sm6150_common_lineage20.md`):
`sorenlyulf/android_device_motorola_sm6150-common @ lineage-20` (HEAD
`a5206c5f`, a divergent author fork of LineageOS official lineage-20
`47c9e585`; Fraaxius lineage-20 is byte-identical to LineageOS). Its board
contract is identical-core to the previously audited Fraaxius lineage-21
(sm6150 / adreno620 / boot header v2 / separated DTBO / LLVM / same
`kernel/motorola/sm6150` pointer), confirming the SoC contract is era-stable.
It supplies dynamic-partition sizing (super ~9.06 GB, group `product system
vendor`), A/B OTA, AVB, and 984 common blob expectations complementing the def
tree's 261. New deps surfaced: `device/qcom/sepolicy_vndr-legacy-um`,
`hardware/google/pixel`(+`interfaces`), plus the def tree's
`hardware/motorola` and `system/qcom`. The lineage-20 common tree is now the
matched rank-2; Fraaxius lineage-21 is retained as a board-contract reference.
The source-side matched set (device + common + kernel pointer) is internally
coherent on lineage-20.

## Update 2026-06-30 — lineage-20 kernel audited (matched set complete)

The matched kernel was audited read-only
(`reports/source_audit_kernel_motorola_sm6150_lineage20.md`):
`sorenlyulf/android_kernel_motorola_sm6150 @ lineage-20` (HEAD `cded7d10`, a
divergent author fork; Linux **4.14.326**, `CONFIG_ARCH_SM6150=y`). It carries a
complete **def** DTS family (`sm6150-def-base.dts` + EVT1/PVT overlays, audio/
charger/fps/touch/camera overlays, `defender-panel`), a def config fragment
(`moto-sdmsteppe-def.config`, `CONFIG_DEF_DTB=y`), and a **separated-DTBO** build
matching the common tree's board contract. Hardware coverage matches the device
tree (ST NFC, fingerprint, camera/OIS, Moto DSI display, SAR). One caveat: the
device tree's literal `vendor/def_defconfig` is **assembled** from the sdmsteppe
base + the def fragment, not a standalone file (build-time resolution). Verdict:
coherent matched kernel. With this, the **full source-side matched set (device +
common + kernel) is coherent on lineage-20**; remaining gaps are artifact (vendor
blobs, gated at Route C) and a future build verification.

## Current decision

All source candidates remain audit inputs only.

No candidate is accepted as a build input.

With the def device-tree question now resolved in favor of sorenlyulf (A11
vendor base), the next hard-work phase shifts to stock firmware acquisition and
metadata-only firmware inventory — confirming an exact or
`RPFS31.Q1-21-20`-compatible package so the A11 vendor base can be populated.

Recommended next artifact: `reports/stock_firmware_search_matrix.md`.
