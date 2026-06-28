# Android Emulator Smoke Test

Date: 2026-06-27

## Summary

The emulator-first ROM lab path progressed far enough to install the Android
toolchain and create a generic AVD, but boot testing is currently blocked by a
Windows host emulator crash. This appears to be a graphics/Vulkan/OpenGL backend
or driver issue on the host, not a Moto One Hyper ROM architecture failure.

No physical phone mutation was performed.

## Installed Tooling

- Android command-line tools:
  `C:\Android\Sdk\cmdline-tools\latest`
- Java:
  `C:\Program Files\Eclipse Adoptium\jdk-17.0.19.10-hotspot`
- `sdkmanager --version`: `20.0`
- Android SDK components:
  - `emulator` `36.6.11`
  - `platform-tools` `37.0.0`
  - `system-images;android-35;default;x86_64` revision `2`
- ADB:
  `C:\Android\Sdk\platform-tools\adb.exe`
  - Android Debug Bridge version `1.0.41`
  - Version `37.0.0-14910828`

## AVD

- Name: `forge_moto_one_hyper_lab_api35`
- Device: `pixel_6`
- Path: `C:\Users\jerem\.android\avd\forge_moto_one_hyper_lab_api35.avd`
- Target: Android 15.0 VanillaIceCream
- Tag/ABI: `default/x86_64`
- SD card: 512 MB

## Launch Commands Attempted

Initial launch:

```powershell
C:\Android\Sdk\emulator\emulator.exe -avd forge_moto_one_hyper_lab_api35 -no-snapshot -no-boot-anim
```

Conservative retries also crashed with combinations of:

- `-gpu swiftshader_indirect`
- `-no-window`
- `-no-audio`
- `-gpu off`
- `-feature -Vulkan`
- `-accel off`

## Observed Failure

- Emulator version `36.6.11` started.
- System path was found:
  `C:\Android\Sdk\system-images\android-35\default\x86_64\`
- WHPX on Windows `10.0.19045` was detected and reported operational.
- Host GPU inventory included NVIDIA Quadro M1200 and Intel HD Graphics 530.
- The emulator warned that NVIDIA driver version `528.79.0` is unsupported;
  minimum required version reported by the emulator was `553.35.0`.
- Host Vulkan driver was not supported.
- Emulator selected lavapipe / SwiftShader fallback paths.
- Console log included:
  `Critical: Failed to load opengl32sw (The specified module could not be found.)`
- The emulator initialized gfxstream/Vulkan/SwiftShader paths before crashing.

## What Succeeded

- Android SDK command-line tools installed.
- Java 17 installed.
- `sdkmanager` works.
- Required SDK packages installed.
- ADB works.
- AVD creation succeeded.

## What Failed

- Emulator boot did not reach a usable Android userspace.
- The generic API 35 AVD crashed before ADB boot-complete checks could run.

## Probable Cause

The most likely blocker is the Windows host emulator graphics path: NVIDIA
driver age, unsupported Vulkan driver path, and OpenGL/SwiftShader fallback
loading failure. This does not change the ROM lab conclusion: emulator/GSI-first
testing is still the correct non-device-write path, but this host currently needs
driver/tooling changes or a different emulator host.

## Recommended Next Action

1. Preserve host evidence with `rom_lab/scripts/capture_emulator_host_evidence.ps1`.
2. Preserve GPU/CUDA evidence with
   `rom_lab/scripts/capture_gpu_cuda_context.ps1` before changing the graphics
   stack.
3. Install Android Studio and try the managed emulator/device manager path.
4. Try a lower API x86_64 system image.
5. Try one controlled Intel/software-renderer style launch before changing the
   NVIDIA driver.
6. Update the NVIDIA Quadro M1200 driver only with explicit approval because the
   existing ForgeWire CUDA/PyTorch stack may depend on the current fragile driver
   setup.
7. Try another machine for emulator boot.
8. Keep the physical Moto One Hyper path blocked until verified stock firmware,
   vendor blobs, exact boot image, device tree/kernel/common integration,
   BoardConfig, dynamic partitions, sepolicy, and hardware gates are solved.

## CUDA / M1200 Follow-up

Jeremy noted that the Quadro M1200 required prior CUDA/PyTorch-specific setup in
ForgeWire. That CUDA success is useful evidence, but it is not proof that Android
Emulator Vulkan/OpenGL/gfxstream paths should work. Treat the CUDA stack as
fragile and avoid NVIDIA driver mutation until Intel/software renderer, Android
Studio managed emulator, lower API image, or better-host options have been tried.
