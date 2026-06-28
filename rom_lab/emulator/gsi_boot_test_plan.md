# GSI Boot Test Plan

## Test ladder

1. Prepare Cuttlefish or Android Emulator generic target.
2. Boot a generic AOSP or Lineage-style image.
3. Validate boot complete.
4. Validate `adb shell`.
5. Validate `logcat`.
6. Validate package manager with `pm list packages`.
7. Validate terminal bridge commands.
8. Validate ForgeLink command interface against the generic Android target.
9. Record commands, hashes, image provenance, and logs as evidence.

## Known limitations

- no pop-up camera test
- no exact display panel test
- no modem/radio test
- no fingerprint validation
- no physical sensor validation
- no exact Motorola kernel validation
- no exact vendor HAL validation
- no AVB/vbmeta hardware validation

## Hardware boundary

This ladder is allowed because it does not write firmware to the physical phone.
Any real-device flash remains blocked.

