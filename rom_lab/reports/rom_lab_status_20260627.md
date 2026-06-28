# ROM Lab Status

Date: 2026-06-27

## Can we build a true Moto One Hyper custom ROM tonight?

Unlikely. A true `def` build is blocked by missing verified stock firmware,
vendor blobs, a verified def-specific device tree, selected SM6150 kernel source,
BoardConfig, dynamic partition metadata, sepolicy, init/fstab integration, and
hardware validation gates.

## Can we build or acquire a modern GSI-style ROM tonight?

Likely yes for acquisition and generic lab testing, assuming a trusted GSI
release is selected, downloaded outside git, hashed, and booted only in an
emulated or generic test environment. That still does not prove physical Motorola
One Hyper compatibility.

## Can we test a modern Android image in emulator tonight?

Yes, if the host has a working Android Emulator or a Linux/Cuttlefish-capable
environment. A generic emulator image can validate boot, adb shell, logcat,
package manager, and ForgeLink command-path behavior.

## What is blocked by missing stock firmware or vendor blobs?

- exact stock boot image verification
- proprietary blob extraction
- vendor HAL compatibility
- rollback image confidence
- dynamic partition metadata confidence
- safe real-device test planning

## What is blocked by missing device tree?

- `def` product build target
- BoardConfig
- fstab/init integration
- recovery/fastbootd integration
- sepolicy
- device-specific kernel and DTBO integration

## What can be done safely without touching the phone?

- maintain this ROM lab
- research source candidates
- build a generic AOSP or LineageOS image
- test generic Android images in emulator or Cuttlefish
- acquire and hash GSI packages outside git
- inspect public device tree/kernel candidates
- draft device bring-up files
- validate RepoPact and ROM lab safety rules

## Recommended modern ROM base

Use a GSI-first strategy for the next practical boot test. For source builds,
prefer a current LineageOS branch for custom-ROM ergonomics or official AOSP
`android-latest-release` for generic emulator/Cuttlefish validation. A device
specific `def` Lineage build should wait until tree, kernel, and vendor inputs
are verified.

## Current decision

Proceed with emulator/GSI lab work first. Do not flash the physical phone.

## Source viability pass

Date checked: 2026-06-27

### Best first target for tonight

Best first target is a generic Android Emulator or Cuttlefish boot, with ADB,
boot-complete, logcat, package-manager, terminal bridge, and ForgeLink command
interface checks. This is the fastest way to prove the lab can test Android
userspace without pretending it validates Motorola One Hyper hardware.

If Jeremy approves a large source download, the best source-built first target
is official AOSP `android-latest-release` for a generic emulator/Cuttlefish
product, synced outside this repository.

### Best longer-term ROM base

Longer term, use LineageOS for the phone-facing custom ROM path because the
strongest discovered `def` tree is Lineage 20 based. Current LineageOS manifest
metadata shows active modern branches, but a latest-branch Motorola One Hyper
port would require forward-porting from Lineage 20.

### Is def-specific Lineage bring-up realistic?

Yes, but not as a same-night build. `sorenlyulf/android_device_motorola_def` is
a real and fresh `lineage-20` def device tree with BoardConfig, product makefiles,
sepolicy, proprietary-files, and extract scripts. It depends on the SM6150 common
tree and kernel, and it still needs verified vendor blobs. The common tree and
kernel are older and Hanoip-oriented in places, so they must be audited before
claiming compatibility.

### Does GSI-first remain recommended?

Yes. GSI/emulator-first remains the recommended path because it gives useful
boot/test evidence without device writes. Official GSI docs also make the limit
clear: a GSI is a generic system image used to exercise vendor-interface
compatibility, not proof that the Motorola kernel, vendor blobs, display, modem,
camera, fingerprint, or pop-up camera work.

### What exact source would be downloaded first with approval?

For a large source download: AOSP `android-latest-release` via the official
manifest, outside this repository, for a generic emulator/Cuttlefish target.

For a smaller device-source inspection after that: shallow clone
`https://github.com/sorenlyulf/android_device_motorola_def` branch `lineage-20`
outside this repository, then its declared dependencies:

- `motorola-sm6150-devs/android_device_motorola_sm6150-common`
- `motorola-sm6150-devs/android_kernel_motorola_sm6150`
- Lineage-compatible `android_hardware_motorola`
- Lineage-compatible `android_system_qcom`

### Estimated disk and time before huge download

- Android Emulator smoke test: roughly 16 GB free disk minimum for emulator use,
  more for multiple system images; time is usually under an hour if Android
  Studio/SDK pieces are already installed.
- AOSP generic source sync: plan for 300 GB or more free disk, fast SSD, and a
  little over an hour for sync under good network conditions, plus build time.
- Lineage full source plus device dependencies: plan for 300-500 GB free disk
  and a Linux build host with 32 GB RAM minimum, 64 GB preferred.
- Cuttlefish: use Linux x86/ARM64 with virtualization/KVM support; Windows alone
  is not the ideal host.

Host checker snapshot from this pass:

- Windows: Microsoft Windows 10 Pro `10.0.19045`
- C: free space: about 276.59 GB of 476.4 GB
- RAM: about 31.54 GB
- CPU: 8 logical cores, 4 physical cores
- WSL binary: present
- WSL distro: not available
- Docker: not installed
- Existing `C:\aosp` / `C:\lineage` style build directories: none found

This machine is suitable for documentation, lightweight source inspection, and
possibly Android Emulator smoke tests. It is below the preferred disk/RAM margin
for a comfortable full AOSP/Lineage build.

### Current ranked conclusion

1. Android Emulator smoke test or Cuttlefish generic boot.
2. AOSP `android-latest-release` generic build if large download is approved.
3. `sorenlyulf/android_device_motorola_def` Lineage 20 source inspection.
4. Only after vendor blobs and kernel config questions are resolved, attempt a
   `lineage_def-userdebug` build.

## Emulator smoke-test attempt

Date attempted: 2026-06-27

Verdict:

- Toolchain install: success.
- AVD creation: success.
- Emulator boot: blocked/crashed.
- Physical phone mutation: none.
- Next recommended path: capture host evidence, update the GPU driver or try the
  Android Studio managed emulator path, then move emulator boot to a better host
  if the Windows graphics/backend crash remains.

The failed boot attempt used the generic AVD
`forge_moto_one_hyper_lab_api35`. Console output showed emulator `36.6.11`,
WHPX available on Windows `10.0.19045`, NVIDIA Quadro M1200 / Intel HD Graphics
530 host GPUs, an unsupported NVIDIA driver version `528.79.0`, unsupported
host Vulkan, SwiftShader/lavapipe fallback paths, and
`Failed to load opengl32sw`. Treat this as a host emulator graphics/backend
blocker, not as evidence against the emulator/GSI-first ROM lab path.

The physical Motorola One Hyper remains blocked for any firmware-write or
destructive action unless Jeremy explicitly approves the exact action in the
current session.

## CUDA / M1200 investigation

Date recorded: 2026-06-28

The Quadro M1200 laptop has a ForgeWire CUDA/PyTorch environment at
`C:\Projects\forgewire\.venv-torch-cu102`. That environment is useful evidence
for the current NVIDIA compute stack, but it does not directly solve the Android
Emulator blocker because the emulator is failing around graphics backend behavior
rather than CUDA compute.

Driver-update caution is now explicit: do not update the NVIDIA driver as the
first fix, because the current driver setup may be part of Jeremy's working CUDA
stack. The safer next path is Android Studio managed emulator, lower API x86_64
image, or one controlled Intel/software-renderer attempt before any NVIDIA
driver mutation.
