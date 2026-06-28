# Cuttlefish Plan

Cuttlefish is the preferred Android virtual-device path for modern AOSP testing
when a Linux host with virtualization support is available.

## Plan

1. Prepare a Linux host with virtualization support.
2. Build or acquire a compatible generic Android image.
3. Launch Cuttlefish.
4. Confirm `adb devices`.
5. Confirm `sys.boot_completed=1`.
6. Collect `logcat` and boot artifacts.

## Limitations

Cuttlefish does not validate Motorola One Hyper hardware HALs, modem, camera,
fingerprint, display panel, or vendor partition compatibility.

