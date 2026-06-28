# Android Emulator Plan

Use Android Emulator for a lightweight generic userspace smoke test.

## Checks

- emulator starts
- `adb devices` lists the virtual device
- `adb shell getprop sys.boot_completed` returns `1`
- `adb shell pm list packages` works
- `adb logcat -d` works
- terminal bridge commands can run
- ForgeLink command interface can be exercised against a generic Android target

## Boundary

This test is not equivalent to booting on Motorola One Hyper hardware.

## Windows Host Crash Result, 2026-06-27

The first generic Android Emulator smoke-test pass advanced the lab without
touching the physical phone:

- Android command-line tools installed under `C:\Android\Sdk\cmdline-tools\latest`.
- Java 17 installed under
  `C:\Program Files\Eclipse Adoptium\jdk-17.0.19.10-hotspot`.
- `sdkmanager --version` returned `20.0`.
- Installed SDK components included emulator `36.6.11`, platform-tools `37.0.0`,
  and `system-images;android-35;default;x86_64` revision `2`.
- AVD `forge_moto_one_hyper_lab_api35` was created successfully at
  `C:\Users\jerem\.android\avd\forge_moto_one_hyper_lab_api35.avd`.
- Emulator launch crashed before Android userspace boot checks could run.
- The likely blocker is the Windows host graphics/driver backend path:
  unsupported NVIDIA Quadro M1200 driver version `528.79.0`, unsupported host
  Vulkan path, SwiftShader/lavapipe fallback selection, and
  `Failed to load opengl32sw`.

Recommended next attempts:

1. Update the NVIDIA Quadro M1200 driver if a compatible driver newer than the
   emulator-reported minimum `553.35.0` is available for this host.
2. Install Android Studio and try its managed emulator/device manager path.
3. Try a lower API x86_64 emulator image.
4. Try WSL/Linux/Cuttlefish later if virtualization support is available.
5. Try another machine for emulator boot.
6. Keep the real phone path blocked until verified firmware/vendor/boot-image,
   device-tree/kernel/common integration, BoardConfig, dynamic partitions,
   sepolicy, and hardware validation gates are solved.
