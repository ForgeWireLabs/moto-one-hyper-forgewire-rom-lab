# Source Viability Review

Date checked: 2026-06-27

Scope: lightweight remote/API inspection only. No Android source tree, firmware,
GSI image, vendor blob, or kernel tree was cloned into this repository.

## Ranked recommendation

| Rank | Candidate | Type | Viability | Why | Blocker | Next action |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | AOSP `android-latest-release` generic emulator/Cuttlefish target | Documentation/reference and generic build target | Best first build/test target | Official docs recommend `android-latest-release`; Cuttlefish is designed for high-fidelity framework testing without hardware-specific HALs | Requires large source sync and a Linux/Cuttlefish-capable host | If Jeremy approves a large download, run host check then sync AOSP outside this repo |
| 2 | Android Emulator generic system image | GSI/emulator first-boot candidate | Best low-cost first smoke test | Requires much less setup than a full source build and can validate adb, boot complete, logcat, package manager, and ForgeLink command paths | Not a ROM build and not Motorola hardware | Create AVD and run generic Android boot smoke test outside this repo |
| 3 | `sorenlyulf/android_device_motorola_def` | True def device tree candidate | Strongest def-specific ROM bring-up lead | Fresh `lineage-20` branch, full ROM-tree shape, BoardConfig, device.mk, AndroidProducts.mk, lineage_def.mk, sepolicy, proprietary-files.txt, extract-files.sh | Depends on common tree, kernel, hardware repos, vendor blobs; Lineage 20 is Android 13 era, not latest | Shallow inspect/clone outside repo with dependencies after host/storage approval |
| 4 | `motorola-sm6150-devs/android_device_motorola_sm6150-common` | SM6150 common device tree candidate | Required support tree for the Lineage 20 def candidate | Has BoardConfigCommon.mk, common.mk, fstab, init, sepolicy, proprietary-files.txt, extract-files.sh, configs | Last commit 2023-10-24; blobs listed from Hanoip S2RI32.32-20-7, not def stock | Pair with def tree and verify device compatibility before build |
| 5 | `motorola-sm6150-devs/android_kernel_motorola_sm6150` | Kernel candidate | Likely community kernel dependency for Lineage 20 path | Def tree depends on it; contains SM6150/Hanoip kernel content and `hanoip_defconfig` | No `def_defconfig` seen in top-level path scan; compatibility with def must be proven | Inspect kernel configs and BoardConfig expectations outside repo |
| 6 | MotorolaMobilityLLC `kernel-msm` tag `MMI-RPF31.Q1-21-20` | OEM kernel reference | Best stock-family kernel reference | Official Motorola MSM kernel repo; tag is near the installed `RPFS31.Q1-21-20-1-7-3` family | Not exact full installed build suffix; integration into Lineage tree unknown | Use as reference for stock kernel provenance; compare against community kernel later |
| 7 | LineageOS `android` manifest | Modern ROM base | Best long-term custom-ROM base after hardware inputs exist | Current default branch observed as `lineage-23.2`, with active modern branches including 22.x/23.x | Device tree is Lineage 20; forward-porting to latest branch is a separate project | Keep as long-term base; do not sync until first emulator/GSI path is settled |
| 8 | AndyCGYan `lineage_build_unified` | Community Lineage GSI build scripts/releases | Good GSI research path | Active-ish GSI-oriented project with branches through `lineage-22-light` | Community builds are not device-specific and releases must be hashed/verified | Use only for emulator/GSI lab; no phone flash |
| 9 | `sm6150-motorola/android_device_motorola_def` | Older true def device tree candidate | Useful historical reference | Full Lineage tree shape on `lineage-18.1`; contains BoardConfig, device.mk, product makefiles, sepolicy, proprietary-files.txt, extract-files.sh | Last commit 2021-08-30; Android 11-era and stale | Reference only unless Lineage 18.1 bring-up is selected |
| 10 | `omnirom/android_device_motorola_def` | Older Omni def device tree | Reference / historical bring-up | Has full Omni tree shape, Android 10/11 branches, fstab, sepolicy, proprietary-files, extract script | Stale, Omni-specific, dependencies point to older Android 10 pieces | Reference only for partition/fstab/history |
| 11 | `ixmoe/android_device_motorola_def_twrp` | Recovery-only def candidate | Useful recovery reference only | TWRP tree with recovery fstab and recovery init files | Recovery image target, not full ROM bring-up | Use only to compare recovery/fstab details |
| 12 | `Deivid21/android_device_motorola_def` | Empty/unusable repo candidate | Not viable now | GitHub metadata exists, but tree API returned 409 conflict during inspection | No inspectable source tree | Ignore unless repository gains content |
| 13 | XDA Motorola One Hyper forum | Forum/reference source | Research only | May point to builds, recoveries, and maintainers | Posts are not source of truth; links may be stale | Mine for URLs, then verify upstream repos directly |

## True def device tree candidates

### `sorenlyulf/android_device_motorola_def`

- URL: https://github.com/sorenlyulf/android_device_motorola_def
- Owner: `sorenlyulf`
- Default branch: `lineage-20`
- Last observed commit: `f65a1836d66e`, 2026-06-13, message `Update README.md`
- Android target: Lineage 20 / Android 13 era
- Type: true `def` device tree candidate
- License status: no repository-level license detected by GitHub API; inspected
  source files carry Apache-2.0 headers
- Contains: `BoardConfig.mk`, `device.mk`, `AndroidProducts.mk`,
  `lineage_def.mk`, `lineage.dependencies`, `proprietary-files.txt`,
  `extract-files.sh`, `rootdir/etc/init.mmi.overlay.rc`, vendor sepolicy
- BoardConfig notes: includes `device/motorola/sm6150-common/BoardConfigCommon.mk`
  and sets `TARGET_KERNEL_CONFIG := vendor/def_defconfig`
- Blob notes: `proprietary-files.txt` says unpinned blobs are extracted from
  `def RPFS31.Q1-21-20-5`, which is close but not identical to the installed
  `RPFS31.Q1-21-20-1-7-3`
- Usable for: best current device-specific bring-up lead
- Blocker: common/kernel/vendor dependencies and exact vendor blobs are not
  present

### `sm6150-motorola/android_device_motorola_def`

- URL: https://github.com/sm6150-motorola/android_device_motorola_def
- Owner: `sm6150-motorola`
- Default branch: `lineage-18.1`
- Last observed commit: `df1f85a155a5`, 2021-08-30, message `def: Setup nfc`
- Android target: Lineage 18.1 / Android 11 era
- Type: true `def` device tree candidate
- License status: no repository-level license detected
- Contains: `BoardConfig.mk`, `device.mk`, `AndroidProducts.mk`,
  `lineage_def.mk`, `lineage.dependencies`, `proprietary-files.txt`,
  `extract-files.sh`, `rootdir/etc/init.mmi.overlay.rc`, vendor sepolicy
- Usable for: historical Android 11-era reference
- Blocker: stale and not modern

### `omnirom/android_device_motorola_def`

- URL: https://github.com/omnirom/android_device_motorola_def
- Owner: `omnirom`
- Branches: `android-10`, `android-11`
- Default branch: `android-10`
- Last observed default-branch commit: `05ea21b6c7f2`, 2020-08-29
- Android target: Omni Android 10/11 era
- Type: older def device tree
- License status: no repository-level license detected; source headers observed
- Contains: `BoardConfig.mk`, `BoardConfigGsi.mk`, `device.mk`,
  `AndroidProducts.mk`, `omni_def.mk`, `recovery.fstab`,
  `recovery_dynamic_partition.fstab`, fstab tree, init prebuilts, sepolicy,
  proprietary file lists, `extract-files.sh`
- Usable for: reference only
- Blocker: stale, Omni-specific, and dependencies mostly point at Android 10

## Recovery-only def candidates

### `ixmoe/android_device_motorola_def_twrp`

- URL: https://github.com/ixmoe/android_device_motorola_def_twrp
- Owner: `ixmoe`
- Default branch: `android-10`
- Last observed commit: `a5ad58ff0bd7`, 2021-01-15, message `def: remove loop.max_part for android 11 support`
- Android target: TWRP/Omni recovery tree
- Type: recovery-only def candidate
- License status: README declares GPL-3.0-or-later text
- Contains: `BoardConfig.mk`, `device.mk`, `AndroidProducts.mk`, `omni_def.mk`,
  `recovery/root/system/etc/recovery.fstab`, recovery init files
- Does not contain: full ROM proprietary-files/extract tree
- Usable for: recovery/fstab reference only
- Blocker: not a full ROM device tree

## SM6150 common device tree candidates

### `motorola-sm6150-devs/android_device_motorola_sm6150-common`

- URL: https://github.com/motorola-sm6150-devs/android_device_motorola_sm6150-common
- Owner: `motorola-sm6150-devs`
- Default branch: `lineage-20`
- Last observed commit: `1f893f87a75a`, 2023-10-24, message `fixup! sm6150-common: Drop Snap`
- Android target: Lineage 20 / Android 13 era
- Type: SM6150 common device tree
- License status: no repository-level license detected; source files carry
  Android/Lineage-style headers
- Contains: `BoardConfigCommon.mk`, `common.mk`, `common_dynamic.mk`,
  `rootdir/etc/fstab.qcom`, `rootdir/etc/fstab_dynamic.qcom`, many init
  scripts, sepolicy, configs, `proprietary-files.txt`, `extract-files.sh`
- Blob notes: common proprietary-files list says blobs are extracted from
  Hanoip `S2RI32.32-20-7`, not from `def`
- Usable for: dependency of the Lineage 20 def candidate
- Blocker: must prove common-tree compatibility with `def`

## Kernel candidates

### `motorola-sm6150-devs/android_kernel_motorola_sm6150`

- URL: https://github.com/motorola-sm6150-devs/android_kernel_motorola_sm6150
- Owner: `motorola-sm6150-devs`
- Default branch: `lineage-20`
- Last observed commit: `5b04fac0cb2a`, 2023-10-24, message `hanoip_defconfig: Enable Clang LTO`
- Android target: Lineage 20-era SM6150 kernel
- Type: kernel candidate
- License status: GitHub API reports `NOASSERTION`; Linux kernel `COPYING`
  exists
- Contains: kernel source tree, Motorola SM6150/Hanoip DTS content,
  `arch/arm64/configs/vendor/hanoip_defconfig`
- Not proven: `vendor/def_defconfig`, despite the fresh def tree requesting it
- Usable for: likely dependency/reference kernel
- Blocker: def-specific kernel config mismatch must be resolved

### MotorolaMobilityLLC `kernel-msm`

- URL: https://github.com/MotorolaMobilityLLC/kernel-msm
- Owner: `MotorolaMobilityLLC`
- Default branch observed: `android-13-release-ttz`
- Last observed push: 2026-06-26
- Relevant ref found: `refs/tags/MMI-RPF31.Q1-21-20`
- Type: OEM MSM kernel reference
- License status: GitHub API reports `NOASSERTION`
- Usable for: stock-family reference for the Android 11 build line
- Blocker: no exact `RPFS31.Q1-21-20-1-7-3` ref was found in lightweight ref
  scan; integration with Lineage 20 is unknown

## Vendor/blob acquisition paths

1. Exact stock firmware package for `RPFS31.Q1-21-20-1-7-3`.
2. Verified package close enough to the def tree's blob source
   `RPFS31.Q1-21-20-5`, if a deliberate compatibility decision is made.
3. Approved future device extraction path after root/recovery work exists.

Current status: blocked. No verified stock package, no root, no vendor dump, and
no blobs are committed.

## GSI/emulator first-boot candidates

- AOSP generic emulator/Cuttlefish target: best first controlled build target.
- Android Emulator system image: best low-cost smoke test for adb/logcat/package
  manager/ForgeLink command paths.
- Official AOSP GSI: good compliance-oriented GSI reference.
- AndyCGYan Lineage GSI: good community Lineage-style GSI research path, but
  must be hashed and treated as non-device-specific.

## Documentation/reference sources

- AOSP source setup: https://source.android.com/docs/setup/download
- AOSP GSI docs: https://source.android.com/docs/core/tests/vts/gsi
- Cuttlefish docs: https://source.android.com/docs/devices/cuttlefish
- Android Emulator docs: https://developer.android.com/studio/run/emulator
- XDA forum: https://xdaforums.com/f/motorola-one-hyper-roms-kernels-recoveries-ot.9465/

