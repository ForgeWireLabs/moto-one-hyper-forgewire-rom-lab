# 004 - Emulator smoke test host blocked

> **Status**: Completed
> **Owners**: governance-owner (lead), tooling-owner (support).
> **Depends on**: 003.

## Intent

Record the Android Emulator smoke-test attempt after the Moto One Hyper ROM lab
source viability pass. The goal of this item is not to force another emulator
launch; it is to preserve the current host evidence, document the crash blocker,
and keep the next ROM-lab steps honest.

## Result

- Android SDK command-line tooling installed and working.
- Java 17 installed.
- Android SDK emulator, platform-tools, and API 35 default x86_64 system image
  installed.
- AVD `forge_moto_one_hyper_lab_api35` created successfully.
- Emulator launch blocked by a repeatable Windows host crash, probably in the
  graphics/Vulkan/OpenGL driver/backend path.
- No physical phone mutation was performed.

## Scope

- `rom_lab/reports/emulator_smoke_test_20260627.md`
- `rom_lab/reports/emulator_crash_logs/README.md`
- `rom_lab/reports/emulator_host_evidence_*.txt`
- `rom_lab/scripts/capture_emulator_host_evidence.ps1`
- `rom_lab/scripts/start_emulator_safe.ps1`
- `rom_lab/emulator/android_emulator_plan.md`
- `rom_lab/reports/rom_lab_status_20260627.md`
- this work item and evidence

## Next Actions

1. Capture host evidence with the read-only script when the emulator stack
   changes.
2. Update the NVIDIA Quadro M1200 driver if a compatible newer driver is
   available.
3. Try Android Studio managed emulator/device manager or a lower API x86_64
   system image.
4. Move emulator boot to another host if the Windows graphics/backend blocker
   remains.
5. Keep the real phone path blocked until verified stock boot, firmware/vendor,
   and device bring-up inputs are solved.
