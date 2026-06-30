# def / XT2027-1 ROM Bring-Up — Ranked Source Recommendation

Status: synthesis (reference-only)

Date: 2026-06-30

## Purpose

Roll the existing committed source audits and the cross-layer evidence matrix
into a single ranked bring-up recommendation for the Motorola One Hyper
(`def` / XT2027-1). This consolidates work already done so the next move is a
decision, not another open-ended audit.

This report uses only source-audit docs and evidence already committed to this
repository. It performs no new downloads, adds no new bridge modes, and touches
no physical device.

## Safety boundary

No physical phone action is authorized.

No source tree is accepted as a build input by this report. A ranking here means
"audit/pursue in this order," not "build from this." Every candidate remains
`reference-only` per `reports/source_candidate_inventory.md`.

No firmware, boot, recovery, vbmeta, dtbo, or partition image is produced or
flashed. Firmware trust remains blocked.

## Target baseline (from rom_lab/device_def/device_profile.json)

| Field | Value |
|---|---|
| Model / SKU | Motorola One Hyper / XT2027-1 |
| Codename / target | `def` / `def_retail` |
| Carrier channel | retus |
| SoC | Qualcomm sm6150 (Snapdragon 675 family) |
| RAM / storage | 4 GB / 128 GB UFS |
| Stock Android | 11, build `RPFS31.Q1-21-20-1-7-3` |
| Active slot (prior obs.) | `_a`, bootloader unlocked |
| Partition shape | A/B slots + dynamic `super` (boot/recovery/dtbo/vbmeta a/b, super, userdata) |
| stock_boot_verified | `false` |
| root_available | `false` |

## Candidate inputs (all committed, all reference-only)

| Candidate | Layer | Branch / era | Files (inspected) | Audit |
|---|---|---|---:|---|
| Fraaxius/device_motorola_sm6150-common | common tree | lineage-21 (~A14) | 563 (157) | `reports/source_audit_fraaxius_sm6150_common.md` |
| ludevjhon/device_motorola_def | device tree (stock-derived) | def_retail Android 10 QPF30.104 | 135 (107) | `reports/source_audit_ludevjhon_def.md` |
| AndroidBlobs/device_motorola_def | device tree (stock-derived) | def_retail Android 10 QPF30.104 | — | `reports/source_audit_androidblobs_def.md` |
| ixmoe/android_device_motorola_def_twrp | recovery/TWRP tree | android-10 | 74 (14) | `reports/source_audit_ixmoe_def_twrp.md` |
| Nandru86/android_device_motorola_def_twrp | recovery/TWRP tree | android-10 | — | `reports/source_audit_nandru86_def_twrp.md` |

Duplication note: ludevjhon and AndroidBlobs share the same Android 10
`def_retail` QPF30.104 lineage and near-identical term-hit profiles
(`reports/stock_def_source_candidate_comparison.md`); the two TWRP trees are
structurally identical. Treat each pair as **one** source plus a corroborating
mirror, not two independent data points.

## Ranked bring-up path

### 1. Device tree → `ludevjhon/device_motorola_def` (with AndroidBlobs as mirror)

Best available `def`-specific device tree in the committed set. `lineage_def.mk`
declares the real product identity — `PRODUCT_DEVICE := def`,
`PRODUCT_MODEL := motorola one hyper`,
`BUILD_FINGERPRINT := motorola/def_retail/def:10/QPF30.104/b456f:user/release-keys`
— and `device.mk` carries the concrete vendor config surface (audio, GPS, media,
keylayout, sepolicy inputs). It inherits the standard Lineage stack
(`core_64_bit`, `full_base_telephony`, `vendor/lineage/.../common_full_phone`)
plus the device's own `device.mk`.

Caveat (decisive): it is **Android 10 (QPF30.104)**, while the phone runs
**Android 11 (RPFS31…)**. Use it for device structure, naming, partition and
vendor-config shape — not as a turnkey A11 tree.

### 2. Common tree → `Fraaxius/device_motorola_sm6150-common`

The richest and most load-bearing input. `BoardConfigCommon.mk` pins the SoC
contract directly:

- `TARGET_BOARD_PLATFORM := sm6150`, `TARGET_BOARD_PLATFORM_GPU := qcom-adreno620`
- `TARGET_KERNEL_SOURCE := kernel/motorola/sm6150` (see kernel rank)
- `BOARD_BOOT_HEADER_VERSION := 2`, `BOARD_KERNEL_SEPARATED_DTBO := true`
- `TARGET_ARCH := arm64`, `cortex-a76`, `BOARD_USES_QCOM_HARDWARE := true`
- `TARGET_KERNEL_ADDITIONAL_FLAGS := LLVM=1 LLVM_IAS=1` (clang/LLVM build)
- a large audio + WLAN kernel-module alias map (DLKM dependency surface)

The evidence matrix (`reports/source_candidate_evidence_matrix.md`) shows this
tree dominates every cross-layer signal (e.g. vendor 114, BOARD_ 97, TARGET_ 96,
qcom 71, kernel 6), which is why it anchors the SoC/board contract.

Caveat: it is **lineage-21 (~A14)** — a *different* era from the A10 device tree
in rank 1 and the A11 phone. It defines the sm6150 board contract well, but the
era mismatch must be reconciled before any of the three can be treated as one
coherent set.

### 3. Kernel → `kernel/motorola/sm6150` (per the common-tree contract)

The common tree's `TARGET_KERNEL_SOURCE := kernel/motorola/sm6150` is the
authoritative pointer. The matching upstream lead recorded in
`rom_lab/research/kernel_candidates.md` is
`motorola-sm6150-devs/android_kernel_motorola_sm6150` (with
MotorolaMobilityLLC `kernel-msm` as the OEM-source fallback). No kernel source
is selected or verified; selection criteria (def/sm6150 explicit support, panel/
touch/camera/fingerprint/audio/modem/storage configs, DTB/DTBO strategy) are in
that doc and remain unmet.

### 4. Vendor / blobs → blocked; derive expectations, do not acquire

Per `rom_lab/research/vendor_blob_plan.md`, real bring-up needs vendor blobs from
the exact `RPFS31.Q1-21-20-1-7-3` firmware package or a verified device dump —
neither of which exists, and no root/extraction path is approved. The committed
trees give a useful *expectation map* only: the ludevjhon `device.mk`
`PRODUCT_COPY_FILES` enumerate the vendor config files the port will need, and
the Fraaxius DLKM alias map enumerates the kernel modules the vendor image must
supply. Use these to draft `proprietary-files` expectations; do not commit blobs.

## Blockers that remain (gating, in priority order)

1. **No verified stock firmware** for `RPFS31.Q1-21-20-1-7-3` retus → no verified
   partition map, boot/vendor_boot/dtbo/vbmeta layout, super layout, or blob
   source. This is the master blocker (`source_candidate_evidence_matrix.md`).
2. **Android-era mismatch across the set**: device tree A10, common tree ~A14,
   phone A11. No committed candidate matches A11; the A10 tree and ~A14 common
   tree are not a coherent pair.
3. **No selected/verified kernel** (`kernel/motorola/sm6150` is a pointer, not a
   checked-out, building source).
4. **No vendor blobs and no approved extraction path** (root unavailable).
5. **No verified stock boot image / recovery anchor** → `stock_boot_verified`
   stays `false`; no rollback safety, so no physical path is eligible regardless.

## Evidence supporting the ranking

- Device identity and A10 lineage: `lineage_def.mk` / `device.mk` excerpts in
  `reports/source_audit_ludevjhon_def.md` (mirror:
  `reports/source_audit_androidblobs_def.md`).
- SoC/board/kernel contract: `BoardConfigCommon.mk` excerpt in
  `reports/source_audit_fraaxius_sm6150_common.md`.
- Cross-layer signal strength and "still blocked" set:
  `reports/source_candidate_evidence_matrix.md`.
- Duplicate-vs-independent reading:
  `reports/stock_def_source_candidate_comparison.md`.
- Target facts: `rom_lab/device_def/device_profile.json`,
  `reports/rom_source_device_tree_roadmap.md`.

## What not to pursue yet

- Do not treat the A10 def tree or the ~A14 common tree as build-ready for the
  A11 phone; the era gap is unresolved.
- Do not deep-audit the two mirror candidates (AndroidBlobs, Nandru86) as if they
  were independent — they corroborate, they do not add coverage.
- Do not select or build a kernel before firmware verification fixes the board
  assumptions it must satisfy.
- Do not acquire, extract, or commit vendor blobs; no firmware baseline, no root,
  no approval.
- Do not consider any physical-device, fastboot, or flash action — out of scope
  until a written gate review and verified stock recovery path exist
  (`reports/rom_source_device_tree_roadmap.md`, step 5).

## Next safe read-only actions

1. **Resolve the era gap first.** The strongest path forward is an A11-aligned
   `def` tree. `rom_lab/reports/rom_lab_status_20260627.md` names
   `sorenlyulf/android_device_motorola_def` (lineage-20, with BoardConfig,
   product makefiles, sepolicy, proprietary-files, and extract scripts,
   depending on `motorola-sm6150-devs` common + kernel) as a fresher def lead —
   but it is **not yet in the audited candidate set**. Auditing it (read-only,
   outside the repo) is the highest-value next slice and would also validate the
   rank-3 kernel pointer.
2. Pivot the hard-work track from source audit to **stock firmware acquisition**:
   produce/refresh `reports/stock_firmware_search_matrix.md` for the exact
   `RPFS31.Q1-21-20-1-7-3` retus package (metadata only; no images committed).
3. Draft a `proprietary-files` expectation list from the ludevjhon `device.mk`
   copy-files and the Fraaxius DLKM alias map — expectations only, no blobs.
4. Keep the emulator/control-plane lane green (it already is) as the safe
   substrate; only add a new read-only inspection mode if a specific blocker
   above demands evidence the current modes cannot provide.

## Disposition

Reference-only synthesis. No candidate is accepted as a build input; no firmware
is trusted; the physical phone stays out of scope. ForgeLink remains stood down
and unaffected by this ROM-lab work.
