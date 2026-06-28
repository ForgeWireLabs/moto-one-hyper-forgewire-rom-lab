# Motorola One Hyper firmware acquisition context

Date recorded: 2026-06-27

## Device target

- Device: Motorola One Hyper
- SKU: XT2027-1
- Product/device: `def`
- Build target/name: `def_retail`
- Carrier/channel: `retus`
- Customer ID: `retail`
- Platform: Qualcomm SM6150
- Android: 11
- SDK: 30
- Security patch: 2022-01-01
- Build fingerprint: `motorola/def_retail/def:11/RPFS31.Q1-21-20-1-7-3/37074e:user/release-keys`
- Build description: `def_retail-user 11 RPFS31.Q1-21-20-1-7-3 37074e release-keys`

## Local tools and folders

- ADB/Fastboot: `C:\Android\platform-tools`
- Working folders:
  - `firmware/`
  - `images/`
  - `patched/`
  - `reports/`

## Bootloader state already established

- Motorola unlock succeeded.
- Bootloader reports `securestate: flashing_unlocked`.
- Bootloader reports `iswarrantyvoid: yes`.
- Android reports `ro.boot.verifiedbootstate = orange`.
- Android reports `ro.boot.flash.locked = 0`.
- Android reports `ro.boot.vbmeta.device_state = unlocked`.
- Android reports `ro.boot.slot_suffix = _a`.

## Known partition highlights

- `boot_a` -> `/dev/block/sde21`
- `boot_b` -> `/dev/block/sdf21`
- `recovery_a` -> `/dev/block/sde22`
- `recovery_b` -> `/dev/block/sdf22`
- `dtbo_a` -> `/dev/block/sde23`
- `dtbo_b` -> `/dev/block/sdf23`
- `vbmeta_a` -> `/dev/block/sde15`
- `vbmeta_b` -> `/dev/block/sdf15`
- `super` -> `/dev/block/sdb23`
- `userdata` -> `/dev/block/sdb24`

## Current objective

Acquire the exact matching stock firmware or exact matching stock `boot.img` for:

`XT2027-1 / def_retail / retus / RPFS31.Q1-21-20-1-7-3`

The root path is to patch a matching stock `boot.img` with Magisk later. Do not
flash anything until the boot image source is verified.

## RSA / Software Fix status

- Motorola Software Fix / RSA was installed.
- Relevant folders found:
  - `C:\ProgramData\LMSA`
  - `C:\ProgramData\RSA`
- `C:\ProgramData\LMSA\Download` appeared empty.
- `C:\ProgramData\LMSA\Temp` appeared empty.
- Prior search found no files over 100 MB under LMSA/RSA.
- Prior search found only app files, drivers, and NOTICE files.
- User reported RSA/Software Fix showed "no records."

## Safety rule

Do not run any command or GUI action that rescues, repairs, flashes, erases,
relocks, wipes, or otherwise writes firmware to the phone unless Jeremy
explicitly approves that exact action.

Do not print or persist IMEI values in public logs. Redact serial, uid, imei,
and imei2 when capturing `fastboot getvar all`.
