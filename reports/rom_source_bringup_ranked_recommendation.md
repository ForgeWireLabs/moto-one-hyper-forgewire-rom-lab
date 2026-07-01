# def / XT2027-1 ROM Bring-Up — Ranked Source Recommendation

Status: synthesis (reference-only; Route B offline inventory added)

Date: 2026-06-30

Update 2026-06-30: revised after the read-only audit of
`sorenlyulf/android_device_motorola_def`
(`reports/source_audit_sorenlyulf_def.md`). sorenlyulf replaces ludevjhon as the
rank-1 device tree; the common tree is re-pointed to the lineage-20 branch.

Update 2026-07-01: Route B offline extraction-only was opened for the already
acquired RETBR `RPFS31.Q1-21-20-5` package. The package was verified by SHA256,
extracted outside Git, and inventoried in reports only. This improves structural
evidence for the provisional `-5` baseline, but it does not approve blob use,
build use, or any physical-device action.

Update 2026-07-01 later: offline sparse/super filesystem extraction and blob
coverage inspection were approved as the next slice, but local tool discovery
found no usable `simg2img`, `lpunpack`, EROFS, or ext inspection toolchain. The
slice stopped with blocker reports; no logical partitions were unpacked.

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
| sorenlyulf/device_motorola_def | device tree | lineage-20 / **A11 RPFS31.Q1-21-20 vendor base** | 46 (key files) | `reports/source_audit_sorenlyulf_def.md` |
| sorenlyulf/…_sm6150-common (lineage-20) | common tree (**matched**) | lineage-20 (HEAD `a5206c5f`) | 562 | `reports/source_audit_sm6150_common_lineage20.md` |
| sorenlyulf/…_kernel_…_sm6150 (lineage-20) | kernel (**matched**) | lineage-20 (HEAD `cded7d10`, Linux 4.14.326) | 72,396 | `reports/source_audit_kernel_motorola_sm6150_lineage20.md` |
| Fraaxius/device_motorola_sm6150-common | common tree (board-contract ref) | lineage-21 (~A14) | 563 (157) | `reports/source_audit_fraaxius_sm6150_common.md` |
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

### 1. Device tree → `sorenlyulf/device_motorola_def` (lineage-20, A11 vendor base)

Preferred def device tree after the 2026-06-30 audit
(`reports/source_audit_sorenlyulf_def.md`). It is the only audited tree that is
both def-specific and anchored to the phone's A11 stock family:
`lineage_def.mk` sets
`BUILD_FINGERPRINT := motorola/def_retail/def:11/RPFS31.Q1-21-20-5/1e3de:user/release-keys`
(same `RPFS31.Q1-21-20` base as the phone's `RPFS31.Q1-21-20-1-7-3`). It is
structurally complete — `BoardConfig.mk` (consumes `sm6150-common`,
`TARGET_KERNEL_CONFIG := vendor/def_defconfig`), `device.mk`
(`PRODUCT_USE_DYNAMIC_PARTITIONS := true`, inherits `sm6150-common/common.mk` +
`vendor/motorola/def/def-vendor.mk`), 10 `sepolicy/vendor` files incl.
`hal_motpopup`, a 261-entry `proprietary-files.txt` (manifest only), extract
scripts, and Treble manifests (`manifest.xml`, `compatibility_matrix.xml`).

Caveat: it is a **LineageOS 20 (A13 framework)** tree on an **A11 vendor base** —
not a stock-A11 ROM. "Era resolved" means the vendor/blob base matches the phone,
not that a stock-A11 build exists. Blob compatibility across the `-5` vs
`-1-7-3` patch suffix is likely but unproven without exact firmware.

Fallback: `ludevjhon/device_motorola_def` (A10 `QPF30.104`; AndroidBlobs mirror)
remains a useful A10-era cross-reference for device structure and vendor-config
shape, but is demoted below sorenlyulf because of its older vendor base.

### 2. Common tree → `sorenlyulf/android_device_motorola_sm6150-common` (lineage-20, matched)

Matched common tree after the 2026-06-30 audit
(`reports/source_audit_sm6150_common_lineage20.md`): the **lineage-20** branch
(HEAD `a5206c5f`, a divergent author fork of LineageOS official lineage-20
`47c9e585`) — the same-author counterpart to the rank-1 def tree, which depends
on `sm6150-common` at lineage-20. `BoardConfigCommon.mk` pins the SoC contract:

- `TARGET_BOARD_PLATFORM := sm6150`, `TARGET_BOARD_PLATFORM_GPU := qcom-adreno620`
- `TARGET_KERNEL_SOURCE := kernel/motorola/sm6150` (see kernel rank)
- `BOARD_BOOT_HEADER_VERSION := 2`, `BOARD_KERNEL_SEPARATED_DTBO := true`,
  `BOARD_INCLUDE_DTB_IN_BOOTIMG := true`, `BOARD_AVB_ENABLE := true`
- `TARGET_ARCH := arm64`, `cortex-a76`, `BOARD_USES_QCOM_HARDWARE := true`,
  `LLVM=1 LLVM_IAS=1`
- dynamic-partition sizing (`super` ~9.06 GB, group `product system vendor`),
  `AB_OTA_PARTITIONS += recovery product`, 984 common blob expectations
  (complementing the def tree's 261)

Board-contract reference: the previously audited **Fraaxius lineage-21** fork has
an **identical core** board contract (same platform/GPU/header/DTBO/LLVM/kernel
pointer), so it stays useful as a board-contract reference — but the matched
branch for the rank-1 def tree is **lineage-20**, not lineage-21. (Fraaxius
lineage-20 is byte-identical to LineageOS official; only sorenlyulf's lineage-20
fork carries the matched author-specific commits.)

### 3. Kernel → `sorenlyulf/android_kernel_motorola_sm6150` (lineage-20, matched & audited)

Audited 2026-06-30 (`reports/source_audit_kernel_motorola_sm6150_lineage20.md`):
the matched kernel is `sorenlyulf/android_kernel_motorola_sm6150 @ lineage-20`
(HEAD `cded7d10`, a divergent author fork — completing the all-sorenlyulf
lineage-20 set). It is **Linux 4.14.326**, `CONFIG_ARCH_SM6150=y`, with a complete
**def** DTS family (`sm6150-def-base.dts` + EVT1/PVT overlays; audio/charger/fps/
touch/camera overlays; `defender-panel`), a def config fragment
(`moto-sdmsteppe-def.config`, `CONFIG_DEF_DTB=y`), and a **separated-DTBO** build
that matches the common tree's board contract. Hardware coverage matches the
device tree (ST NFC, fingerprint, camera/OIS, Moto DSI display, SAR).

Caveat: the device tree's literal `TARGET_KERNEL_CONFIG := vendor/def_defconfig`
is **assembled** from the `sdmsteppe` base + `moto-sdmsteppe-def.config` rather
than existing as a standalone file (build-time resolution; not verified by a
build). Also surfaced from the def tree's `lineage.dependencies`:
`android_hardware_motorola` (`hardware/motorola`) and `android_system_qcom`
(`system/qcom`). The kernel is now an audited, present, def-capable source — but
not built/booted; a bootable def kernel cannot be claimed until it builds in
context.

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
   source. This is the master blocker. **Update (2026-06-30,
   `reports/stock_firmware_search_matrix.md`):** the `RPFS31.Q1-21-20` family and
   the exact `-1-7-3` retus build are confirmed real, and a reputable Android
   Dumps filesystem dump exists for the `-5` (1e3de) base sorenlyulf targets — but
   no reputable, checksum-verified **retus** flashable package is yet pinned, and
   no firmware was downloaded. Blocker stands; it is now scoped, not unknown.
2. **Android-era alignment — substantially narrowed (2026-06-30).** The rank-1
   sorenlyulf tree is anchored to the phone's **A11 `RPFS31.Q1-21-20` vendor
   base**, so the def device tree now matches the phone's stock family. Residual
   gap: sorenlyulf is an A13/LineageOS-20 framework on that A11 base (not a
   stock-A11 ROM), and the `-5` vs `-1-7-3` patch suffix is unverified. The
   ludevjhon (A10) and Fraaxius (~A14) era spread only matters for those
   fallback/reference trees now.
3. **Kernel identified & audited, not built** (2026-06-30). The matched kernel
   `sorenlyulf/android_kernel_motorola_sm6150 @ lineage-20` (Linux 4.14.326) is a
   present, def-capable source with the full def DTS family and matching DTBO
   strategy — but it has not been built or booted, and the `vendor/def_defconfig`
   assembly is unverified at build time. No longer just a pointer; still not a
   proven bootable kernel.
4. **No approved vendor blob use.** Route B offline extraction now shows a full
   `-5` package with `super.img_sparsechunk.*`, `radio.img`, `boot.img`,
   `recovery.img`, `dtbo.img`, and `vbmeta.img`, but path-level vendor coverage
   is still unverified because sparse/super filesystem extraction is blocked by
   missing local tools. Blob import and build use remain blocked.
5. **No verified retus stock boot image / recovery anchor.** The RETBR `-5`
   package contains `boot.img` and standalone `recovery.img`, so it can serve as
   an offline reference anchor for that package only. It is not the phone's
   exact retus `-1-7-3` build and does not make any physical path eligible.
   `stock_boot_verified` stays `false`.

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
- Do not commit or import vendor blobs. Route B package extraction has occurred
  only as approved local offline inventory; sparse/super extraction was approved
  for a tool-discovery/filesystem slice but is blocked by missing local tools.
  Blob use and builds remain unapproved.
- Do not consider any physical-device, fastboot, or flash action — out of scope
  until a written gate review and verified stock recovery path exist
  (`reports/rom_source_device_tree_roadmap.md`, step 5).

## Next safe read-only actions

1. **Done (2026-06-30): audit the A11-aligned `def` tree.** sorenlyulf was cloned
   read-only and audited (`reports/source_audit_sorenlyulf_def.md`); it is now the
   rank-1 device tree and confirmed the kernel pointer. The era question is
   resolved enough to proceed.
2. **Done (2026-06-30): stock firmware metadata track.**
   `reports/stock_firmware_search_matrix.md` was refreshed (discovery + lolinet
   enumeration + mirror triangulation); no reputable checksum-verified retus
   package was found. The next decision is now a human gate — see
   `reports/firmware_acquisition_extraction_gate.md` (Route A LMSA exact-retus /
   Route B provisional `-5` RETBR / Route C hold). Blocker unchanged; no artifact
   action until Jeremy chooses a route.
3. **Done (2026-06-30): audit the lineage-20 `sm6150-common`** (the matched
   common tree). `reports/source_audit_sm6150_common_lineage20.md` adopts
   `sorenlyulf/…_sm6150-common @ lineage-20` (`a5206c5f`) as rank-2.
4. **Done (2026-06-30): audit the lineage-20 kernel.**
   `reports/source_audit_kernel_motorola_sm6150_lineage20.md` adopts
   `sorenlyulf/…_kernel_…_sm6150 @ lineage-20` (`cded7d10`, Linux 4.14.326) as the
   matched kernel. **The full source-side matched set (device + common + kernel)
   is now coherent on lineage-20.** The remaining gaps are artifact (vendor blobs,
   gated at Route C) and a future build verification — not source identification.
5. **Done (2026-06-30): draft the `proprietary-files` expectation map.**
   `reports/proprietary_files_expectation_map.md` writes down the blob contract
   (~261 def + ~984 common paths, 6 trivial overlaps, def set anchored to `-5`,
   modem/TEE/radio as the channel-sensitive determinants) — the yardstick a future
   extraction is judged against. Manifest-only; no blobs.
6. **Done (2026-07-01): Route B package inventory and offline extraction-only
   reports.** The acquired RETBR package was verified and extracted under
   `C:\Projects\moto-one-hyper-local\extracted\RPFS31.Q1-21-20-5_RETBR`.
   Reports now cover package inventory, partition layout, vendor expectation
   gap, and boot/recovery anchors. No blobs were imported; no sparse/super
   filesystem extraction, mount, build, or phone action occurred.
7. **Blocked (2026-07-01): sparse/super filesystem extraction and blob coverage
   inspection.** The slice was approved but stopped after tool discovery because
   no local `simg2img`, `lpunpack`, EROFS, or ext inspection toolchain was
   available, and WSL did not expose a runnable distro/tool surface. See
   `reports/firmware_filesystem_extraction_RPFS31_Q1_21_20_5_RETBR.md`.
8. Keep the emulator/control-plane lane green (it already is) as the safe
   substrate; only add a new read-only inspection mode if a specific blocker
   above demands evidence the current modes cannot provide.

## Disposition

Reference-only synthesis. No candidate is accepted as a build input; no firmware
is trusted; the physical phone stays out of scope. ForgeLink remains stood down
and unaffected by this ROM-lab work.
