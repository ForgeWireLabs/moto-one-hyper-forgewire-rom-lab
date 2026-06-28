# ROM Lab Emulator Bridge

This directory defines the safety contract for the Moto One Hyper ROM lab emulator bridge.

The bridge is not a flashing tool. It is not a phone-management tool. It is a constrained, read-only inspection surface for the generic Android API 35 emulator used by this repository.

## Current target

- AVD: forge_moto_one_hyper_lab_api35
- Android image: system-images;android-35;default;x86_64
- Runtime hardware: ranchu
- ABI: x86_64
- Device class: Android Emulator

This target is not Motorola One Hyper hardware emulation.

## Entrypoints

Start the known-working emulator path:

    powershell -ExecutionPolicy Bypass -File .\rom_lab\scripts\start_api35_working_emulator.ps1

Run the read-only bridge:

    powershell -ExecutionPolicy Bypass -File .\rom_lab\scripts\invoke_emulator_adb_readonly.ps1 -Mode identity

## Allowed bridge modes

The bridge exposes named read-only modes only:

- devices
- boot
- identity
- packages
- logcat-tail
- prop-read
- settings-read
- activity-list
- storage-read
- network-read
- process-list
- all

These modes are intended to give ForgeLink or another future adapter a narrow, auditable control surface.

## Targeting rule

The bridge must select a serial matching:

    ^emulator-[0-9]+$

The bridge must not target a physical Android device serial.

This matters because the physical Motorola One Hyper can appear beside the emulator in adb devices. The bridge is allowed to inspect the emulator only.

## Forbidden operations

The bridge must not expose or call:

- arbitrary adb shell commands
- adb push
- adb pull
- adb install
- adb uninstall
- adb reboot
- adb reboot bootloader
- adb reboot recovery
- adb remount
- adb root
- adb sideload
- fastboot flash
- fastboot erase
- fastboot format
- fastboot update
- fastboot boot
- fastboot oem
- bootloader relock or unlock operations
- rescue or repair flows
- wipe or factory reset flows
- dd writes to block devices
- filesystem creation or formatting commands
- remounting partitions read-write

## Safety invariant

The physical Motorola One Hyper must not be flashed, erased, wiped, relocked, sideloaded, repaired, rescued, or otherwise written to without explicit current-session approval from Jeremy.

Current emulator evidence is generic emulator evidence only. It does not prove a Moto One Hyper device-specific ROM boot.

## Contract file

Machine-readable contract:

    rom_lab/bridge/emulator_readonly_contract.json

Future ForgeLink integration should consume the contract before invoking bridge actions.

## Contract-gated runner

The preferred adapter entrypoint is:

    powershell -ExecutionPolicy Bypass -File .\rom_lab\bridge\run_readonly_bridge.ps1 -Mode identity

The runner loads emulator_readonly_contract.json before invoking the lower-level bridge script.
It refuses to run if the contract no longer requires emulator-only targeting.
