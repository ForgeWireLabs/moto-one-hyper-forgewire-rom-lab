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

