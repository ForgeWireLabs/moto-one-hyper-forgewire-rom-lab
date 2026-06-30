# Source Audit — kernel/motorola/sm6150 (lineage-20, matched to sorenlyulf def)

Status: completed read-only audit

Date: 2026-06-30

## Safety boundary

Read-only source audit. No firmware download, no image download, no extraction,
no blobs, no phone, no fastboot, no adb mutation, no flashing, no LMSA, no build
attempt. The kernel was shallow-cloned (`--depth 1`) outside the repository under
the local-only sources area and is **not** committed; only this report is
committed. No source tree is accepted as a build input. The firmware
acquisition/extraction gate remains held at Route C
(`reports/firmware_acquisition_extraction_gate.md`).

Note on method: the Linux kernel tree cannot fully check out on Windows (case/
reserved-name collisions), so the working-tree checkout failed. The object store
downloaded intact; all inspection below was done read-only via
`git show HEAD:<path>` / `git ls-tree` against the fetched objects — no working
tree, no build.

## Goal 1 — exact matched source

The matched device + common set is all by author `sorenlyulf` on `lineage-20`.
Kernel branch-head comparison:

| Repo | lineage-20 HEAD | Relationship |
|---|---|---|
| LineageOS/android_kernel_motorola_sm6150 | `112b525a…` | upstream official |
| motorola-sm6150-devs/android_kernel_motorola_sm6150 | `5b04fac0…` | separate line |
| **sorenlyulf/android_kernel_motorola_sm6150** | **`cded7d10…`** | **divergent author fork — matched** |

Matched kernel: **`sorenlyulf/android_kernel_motorola_sm6150`, branch
`lineage-20`, HEAD `cded7d1085e39d69375de27226b5802761f8effc`** (dated 2026-06-12,
same author/window as the def + common trees; 72,396 files; latest commit
"Kernel files for Motorola SM6150 devices"). This completes the all-`sorenlyulf`
lineage-20 matched set (device + common + kernel).

## Goal 4 — kernel version / era

- **Linux 4.14.326** (`Makefile`: VERSION 4, PATCHLEVEL 14, SUBLEVEL 326).
- Qualcomm CAF/`techpack` style kernel; `CONFIG_ARCH_QCOM=y`,
  `CONFIG_ARCH_SM6150=y`.
- 4.14 is the SM6150 launch kernel; it is carried forward across Android 10→13
  (LineageOS 20) because the vendor blobs are 4.14-based. So a modern LineageOS-20
  userspace on a 4.14 vendor kernel is expected here, consistent with the def
  tree's A11 `RPFS31` vendor base.

## Goal 3 — sm6150 / def / One Hyper relevance

Overwhelming and device-specific:

- `CONFIG_ARCH_SM6150=y` (base `vendor/sdmsteppe_defconfig`; sdmsteppe = SM6150).
- A complete **def** DTS family under `arch/arm64/boot/dts/qcom/`:
  `sm6150-def-base.dts`, `sm6150-def-evt1-overlay.dts`,
  `sm6150-def-pvt-overlay.dts`, and `sm6150-def-{common,audio,charger,fps,touch}-overlay`,
  `sm6150-camera-sensor-mot-def-overlay.dtsi`, plus `defender-panel.dtsi`.
- def-specific config fragment `vendor/ext_config/moto-sdmsteppe-def.config` with
  `CONFIG_DEF_DTB=y`.

## Goal 2 — `vendor/def_defconfig` (naming nuance, build-time resolved)

The device tree sets `TARGET_KERNEL_CONFIG := vendor/def_defconfig`, but there is
**no literal `arch/arm64/configs/vendor/def_defconfig`** in this kernel. Instead
the def configuration is assembled by the kernel's `defconfig.mk` merge:

- base: `vendor/sdmsteppe_defconfig` (present; `-perf` variant too);
- + device fragment: `vendor/ext_config/moto-sdmsteppe-def.config` (present);
- + optional `lineage-moto-sdmsteppe.config`, debug fragments;
- merged into a generated `mapphone_defconfig` (`TARGET_DEFCONFIG`).

So the def config **exists as a fragment layered on the sdmsteppe base**, not as a
standalone `def_defconfig`. This is normal for Motorola CAF kernels, but the
device tree's literal `vendor/def_defconfig` path does not resolve to a file by
static inspection — it is produced by the build glue. **Caveat:** the exact
mapping of `TARGET_KERNEL_CONFIG := vendor/def_defconfig` → base
`sdmsteppe` + `moto-sdmsteppe-def.config` should be confirmed at build time (out
of scope here; no build performed).

## Goal 5 — DTB/DTBO strategy vs the common tree

Fully coherent with `reports/source_audit_sm6150_common_lineage20.md`
(`BOARD_BOOT_HEADER_VERSION := 2`, `BOARD_KERNEL_SEPARATED_DTBO := true`,
`BOARD_INCLUDE_DTB_IN_BOOTIMG := true`). The DTS `Makefile` builds **separated
DTBO** overlays on a base DTB:

```make
dtbo-$(CONFIG_DEF_DTB) += sm6150-def-evt1-overlay.dtbo sm6150-def-pvt-overlay.dtbo
sm6150-def-evt1-overlay.dtbo-base := sm6150-def-base.dtb
sm6150-def-pvt-overlay.dtbo-base := sm6150-def-base.dtb
```

The base DTB (`sm6150-def-base.dtb`) is built for inclusion in boot.img and the
EVT1/PVT hardware-revision overlays become separate `.dtbo` artifacts for the
dtbo partition — exactly the strategy the common tree's BoardConfig declares.

## Goal 6 — def-specific hardware coverage

From `moto-sdmsteppe-def.config` and the def DTS overlays:

| Subsystem | Evidence | Matches device tree? |
|---|---|---|
| Display panel | `CONFIG_DRM_MSM_DSI_MOT_EXT=y`; `defender-panel.dtsi` | Moto DSI ext; def panel |
| Touch | `sm6150-def-touch-overlay.dtsi` (other vendors' touch disabled) | def-specific controller |
| Fingerprint | `sm6150-def-fps-overlay.dtsi` | matches def `hal_fingerprint_default.te` |
| Camera | `CONFIG_SPECTRA_CAMERA=y`, `CONFIG_OIS_BM24218=y`, flash LED; `sm6150-camera-sensor-mot-def-overlay.dtsi` | matches def camera blobs/EEPROM |
| NFC | `CONFIG_NFC_NQ is not set` → **ST NFC** | matches def `st21nfc` configs |
| SAR sensor | `CONFIG_SENSORS_SX933X=y`, `CONFIG_CAPSENSE_USB_CAL=y` | def sensor |
| Audio | `sm6150-def-audio-overlay.dtsi`; CAF audio DLKM (`techpack/audio`) | def audio overlay |

Honest gaps: the **Cirrus cs35l41** audio amp and the **pop-up camera** are not
named in the def config *fragment*. Cirrus is expected via the common tree's
audio DLKM module aliases (built as modules, possibly enabled in the base
defconfig); the pop-up mechanism is primarily the userspace HIDL HAL
`motorola.hardware.popup` (def `compatibility_matrix.xml` / `hal_motpopup`), with
kernel support via the camera/actuator/OIS path rather than a distinct "popup"
config. Neither was contradicted; both are consistent with a module/HAL-side
implementation. The Moto Mods stack is explicitly **disabled**
(`CONFIG_HID_MOTOROLA_MODS`/`MODS_*` off), correct for def (not a Moto Z device).

## Goal 7 — build-system expectations

- Clang/LLVM: the common tree sets `TARGET_KERNEL_ADDITIONAL_FLAGS := LLVM=1
  LLVM_IAS=1`; the kernel ships `build.config.aarch64` / `build.config.common`
  and `Androidbp`, consistent with an LLVM build.
- Defconfig: merge-based (`defconfig.mk` → `mapphone_defconfig`) from base +
  `moto-sdmsteppe-def.config`.
- Modules: CAF `techpack/` DLKM layout (audio, wlan `qca_cld3` → `wlan.ko`),
  matching the common tree's `TARGET_MODULE_ALIASES`.
- vendor_dlkm/odm_dlkm: 4.14 predates the separate `vendor_dlkm` partition;
  modules land under the vendor image/ramdisk rather than a dedicated dlkm
  partition. No odm_dlkm assumption observed. (Build-time detail; not blocking.)

## Goal 8 — comparison against the matched set

| Layer | This kernel | Agreement |
|---|---|---|
| `reports/source_audit_sorenlyulf_def.md` | `TARGET_KERNEL_CONFIG := vendor/def_defconfig`; ST NFC; fingerprint/camera HALs | config provided via fragment; NFC/fp/camera all present in kernel ✔ (defconfig naming caveat) |
| `reports/source_audit_sm6150_common_lineage20.md` | `TARGET_KERNEL_SOURCE := kernel/motorola/sm6150`; separated DTBO; header v2 | kernel is that source; DTBO strategy matches ✔ |
| `reports/rom_source_bringup_ranked_recommendation.md` | kernel rank-3 pointer | now an audited, present, def-capable source ✔ |

## Goal 9 — verdict

**Coherent matched kernel candidate** (with one build-time-resolution caveat).
This is the Motorola SM6150 Linux 4.14 kernel, same-author lineage-20 fork as the
matched device and common trees, with a complete def DTS family, def config
fragment, ST-NFC/fingerprint/camera/display/SAR coverage that matches the device
tree, and a separated-DTBO build that matches the common tree's board contract.
The only caveat is the defconfig **naming** indirection: the device tree's literal
`vendor/def_defconfig` is assembled from the sdmsteppe base + `moto-sdmsteppe-def.config`
rather than existing as a standalone file, which should be confirmed at build time.

## What this does not change

- Still reference-only; no tree accepted as a build input; no build attempted.
- The firmware master blocker is unchanged: the kernel is source, but a bootable
  def kernel cannot be claimed until it builds and boots in the right context, and
  vendor blobs remain gated (Route C).
- No new external dependency beyond those already enumerated (this kernel is the
  `kernel/motorola/sm6150` node itself).

## Current decision

Adopt `sorenlyulf/android_kernel_motorola_sm6150 @ lineage-20` (`cded7d10`) as the
audited, confirmed matched kernel for the rank-1 def tree and rank-2 common tree.
With this, the **full source-side matched set (device + common + kernel) is
internally coherent on lineage-20**. Reference-only; firmware gate stays at Route
C; the remaining gaps are artifact (vendor blobs) and a future build verification,
not source identification.
