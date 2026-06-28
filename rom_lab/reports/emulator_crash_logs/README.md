# Emulator Crash Log Evidence

This folder indexes Android Emulator crash evidence without committing local
binary crash databases or large host-specific files.

## Local Evidence Locations

- `%TEMP%\AndroidEmulator`
- `%USERPROFILE%\.android\avd\forge_moto_one_hyper_lab_api35.avd`

## Safe Collection

Use:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File rom_lab\scripts\capture_emulator_host_evidence.ps1
```

The script writes a text report to:

```text
rom_lab\reports\emulator_host_evidence_YYYYMMDD-HHMMSS.txt
```

It records tool versions, installed SDK package names, AVD inventory, Windows
version, GPU/driver metadata, and recent file indexes from the local emulator
log/crash locations.

## Do Not Commit

- Emulator crash databases
- AVD disk images
- Firmware packages
- Extracted Android images
- ZIPs, payloads, blobs, or binary dumps
- Serial numbers, UIDs, IMEIs, unlock keys, or other private device identifiers

If a crash log includes private identifiers, redact it before copying any text
into a repo report.
