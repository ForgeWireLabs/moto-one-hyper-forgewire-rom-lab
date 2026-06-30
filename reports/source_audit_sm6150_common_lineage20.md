# Source Audit — sm6150-common (lineage-20, matched to sorenlyulf def)

Status: completed read-only audit

Date: 2026-06-30

## Safety boundary

Read-only source audit. No firmware download, no image download, no extraction,
no blobs, no phone, no flashing, no LMSA, no artifact acquisition. The candidate
was cloned outside the repository under the local-only sources area and is **not**
committed; only this report is committed. No source tree is accepted as a build
input. The firmware acquisition/extraction gate remains held at Route C
(`reports/firmware_acquisition_extraction_gate.md`); this audit is source-side
only and does not touch it.

## Goal 1 — exact matched source/branch

The rank-1 device tree `sorenlyulf/android_device_motorola_def` declares its
common dependency as `android_device_motorola_sm6150-common` at `lineage-20`
(`lineage.dependencies`). Branch-head comparison across candidates:

| Repo | lineage-20 HEAD | Relationship |
|---|---|---|
| LineageOS/android_device_motorola_sm6150-common | `47c9e585…` | upstream official |
| Fraaxius/device_motorola_sm6150-common (lineage-20) | `47c9e585…` | identical to LineageOS (clean fork) |
| motorola-sm6150-devs/android_device_motorola_sm6150-common | `1f893f87…` | separate lineage-20 line |
| **sorenlyulf/android_device_motorola_sm6150-common** | **`a5206c5f…`** | **divergent author fork — matched to the def tree** |

Matched tree selected: **`sorenlyulf/android_device_motorola_sm6150-common`,
branch `lineage-20`, HEAD `a5206c5fa76b0d27465cd05a3580ca8b3a0cfcd3`** (dated
2026-06-12, same author/day as the def tree; 562 files; latest commit "Delete
Droidian directory"). It is downstream of LineageOS official lineage-20 with
author-specific commits, so it is the coherent same-author counterpart to the
rank-1 def tree — not the lineage-21 Fraaxius fork that was previously audited.

## Goal 2 — sm6150 board contract (`BoardConfigCommon.mk`)

| Area | Value |
|---|---|
| Platform / GPU | `TARGET_BOARD_PLATFORM := sm6150`, `TARGET_BOARD_PLATFORM_GPU := qcom-adreno620` |
| Arch | `arm64` / `armv8-2a` / `cortex-a76` (2nd arch `arm`) |
| QCOM hardware | `BOARD_USES_QCOM_HARDWARE := true`, `QCOM_BOARD_PLATFORMS += sm6150` |
| Boot header | `BOARD_BOOT_HEADER_VERSION := 2` |
| DTBO strategy | `BOARD_KERNEL_SEPARATED_DTBO := true`, `BOARD_INCLUDE_DTB_IN_BOOTIMG := true`, `BOARD_INCLUDE_RECOVERY_DTBO := true` |
| Kernel build flags | `TARGET_KERNEL_ADDITIONAL_FLAGS := LLVM=1 LLVM_IAS=1` (clang/LLVM) |
| Kernel source | `TARGET_KERNEL_SOURCE := kernel/motorola/sm6150` |
| AVB | `BOARD_AVB_ENABLE := true`, vbmeta `--flags 3` |
| Partition sizes | boot 64 MB, dtbo 24 MB, recovery 64 MB; system/vendor/product ext4; userimages ext4 + f2fs |
| sepolicy | `TARGET_SEPOLICY_DIR := msmsteppe`; includes `device/qcom/sepolicy_vndr-legacy-um/SEPolicy.mk` |
| Vendor security patch | `2022-05-01` (Lineage-set string; not the blob image date) |

### Dynamic partition assumptions (gated on `PRODUCT_USE_DYNAMIC_PARTITIONS`)

The def tree sets `PRODUCT_USE_DYNAMIC_PARTITIONS := true`, activating:

- `BOARD_SUPER_PARTITION_GROUPS := mot_dp_group`
- `BOARD_SUPER_PARTITION_SIZE := 9729736704` (~9.06 GB)
- `BOARD_MOT_DP_GROUP_PARTITION_LIST := product system vendor`
- `BOARD_MOT_DP_GROUP_SIZE := 4864868352`
- `BOARD_USES_METADATA_PARTITION := true`
- `common_dynamic.mk`: `AB_OTA_PARTITIONS += recovery product`; dm-default-key
  metadata crypto; `fastbootd` + `overlay-lineage-fastbootd`;
  `fstab_dynamic.qcom` to ramdisk.

This matches the device profile (`rom_lab/device_def/device_profile.json`): A/B
slots + dynamic `super`, with `product system vendor` as the logical group.

## Goal 3 — comparison vs the previously audited Fraaxius lineage-21

The **core board contract is identical** across the two: same
`TARGET_BOARD_PLATFORM := sm6150`, adreno620, arm64/cortex-a76, boot header v2,
separated DTBO, `LLVM=1`, the full audio + WLAN DLKM alias map, and the same
`kernel/motorola/sm6150` pointer. The SoC/board contract is therefore **stable
across lineage-20 and lineage-21** — Fraaxius lineage-21 remains a valid
board-contract reference.

The meaningful difference is **branch/era match to the rank-1 device tree**:
sorenlyulf's def tree depends on `sm6150-common` at **lineage-20**, and
sorenlyulf maintains a divergent **lineage-20** fork (`a5206c5f`) of it. Fraaxius
lineage-20 is byte-identical to LineageOS official; Fraaxius lineage-21 is a newer
framework era. For a coherent matched source set, the **lineage-20** common tree
is the one to pair with the def tree; lineage-21 is reference-only.

## Goal 4 — kernel pointer consistency

`TARGET_KERNEL_SOURCE := kernel/motorola/sm6150` here is **consistent** with the
def tree's `lineage.dependencies` (`android_kernel_motorola_sm6150` →
`kernel/motorola/sm6150`) and with `BoardConfig.mk`'s
`TARGET_KERNEL_CONFIG := vendor/def_defconfig`. All three layers agree on the
kernel. No conflict.

## Goal 5 — vendor/blob expectations vs sorenlyulf `proprietary-files.txt`

- Common tree `proprietary-files.txt`: **984** entries (SoC-shared HALs/libs),
  pulled at build-prep via `inherit-product-if-exists
  vendor/motorola/sm6150-common/sm6150-common-vendor.mk` (the generated common
  vendor makefile).
- Def tree `proprietary-files.txt`: **261** entries (device-specific: camera,
  EEPROM, Cirrus audio, pop-up HAL), via `vendor/motorola/def/def-vendor.mk`.

These are **complementary, not conflicting**: ~984 common SoC blobs + ~261
device-specific blobs ≈ ~1245 total expectation. The split is the standard
common/device boundary, and no overlap contradiction was observed. Both are
extract-driven manifests — no blobs are present in either tree, and none were
acquired by this audit.

## Goal 6 — dependency set surfaced

Combining this common tree with the def tree's `lineage.dependencies`, the matched
source set requires:

| Path | Source | Role |
|---|---|---|
| `device/motorola/def` | sorenlyulf/android_device_motorola_def (lineage-20) | rank-1 device tree |
| `device/motorola/sm6150-common` | **sorenlyulf/android_device_motorola_sm6150-common (lineage-20)** | **matched common tree (this audit)** |
| `kernel/motorola/sm6150` | android_kernel_motorola_sm6150 | kernel (defconfig `vendor/def_defconfig`) |
| `hardware/motorola` | android_hardware_motorola | device HALs |
| `system/qcom` | android_system_qcom | qcom system bits |
| `device/qcom/sepolicy_vndr-legacy-um` | (qcom legacy sepolicy) | **newly surfaced** — required by common `BoardConfigCommon.mk` |
| `hardware/google/pixel`, `hardware/google/interfaces` | AOSP/Pixel | **newly surfaced** — power-libperfmgr (Pixel power HAL) |
| `vendor/motorola/sm6150-common`, `vendor/motorola/def` | generated by extract | blob makefiles (not source; require a gated artifact) |

## Goal 7 — ranked-recommendation impact

The matched **lineage-20** `sm6150-common` (sorenlyulf fork) becomes the rank-2
common tree, replacing the Fraaxius lineage-21 fork in that slot. Fraaxius
lineage-21 is retained as a board-contract reference (its core is identical).
Updated in `reports/rom_source_bringup_ranked_recommendation.md` and
`reports/source_candidate_evidence_matrix.md`.

## What this does not change

- Still no verified firmware and no blobs — the common tree's `sm6150-common-vendor.mk`
  and the def tree's `def-vendor.mk` both require a gated artifact to populate.
  The firmware master blocker is unchanged.
- Still reference-only: no tree is accepted as a build input.
- Kernel still unselected/unbuilt; `kernel/motorola/sm6150` remains a pointer.

## Current decision

Adopt `sorenlyulf/android_device_motorola_sm6150-common @ lineage-20`
(`a5206c5f`) as the matched rank-2 common tree for the rank-1 sorenlyulf def
tree. The source-side matched set (device + common + kernel pointer, with the
sepolicy/pixel/hardware/system deps enumerated) is now **internally coherent on
lineage-20**. Reference-only; no build input accepted; firmware gate stays at
Route C.
