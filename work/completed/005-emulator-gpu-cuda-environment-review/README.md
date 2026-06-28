# 005 - Emulator GPU CUDA environment review

> **Status**: Completed
> **Owners**: governance-owner (lead), tooling-owner (support).
> **Depends on**: 004.

## Intent

Investigate whether the existing ForgeWire CUDA/PyTorch environment can explain
or route around the Android Emulator crash on this Windows laptop. This is a
read-only host evidence pass: no driver install/update/removal, no GPU setting
changes, no ForgeWire mutation, and no physical phone mutation.

## Result

- ForgeWire CUDA venv found at `C:\Projects\forgewire\.venv-torch-cu102`.
- Host evidence captured for Windows, NVIDIA/Intel GPUs, NVIDIA tooling, CUDA
  tooling, Android Emulator, SDK packages, AVD text config, and PyTorch/CUDA.
- CUDA/PyTorch evidence is useful for understanding the fragile NVIDIA stack,
  but it is not a direct fix for Android Emulator Vulkan/OpenGL/gfxstream
  startup.
- The safest next path is to try Intel/software/CPU-style emulator routes and
  Android Studio/lower API images before changing NVIDIA drivers.

## Scope

- `rom_lab/reports/emulator_gpu_cuda_environment_review_20260627.md`
- `rom_lab/reports/gpu_cuda_context_*.txt`
- `rom_lab/emulator/windows_graphics_strategy.md`
- `rom_lab/scripts/capture_gpu_cuda_context.ps1`
- `rom_lab/scripts/start_emulator_intel_or_cpu_safe.ps1`
- `rom_lab/reports/emulator_smoke_test_20260627.md`
- `rom_lab/reports/rom_lab_status_20260627.md`
- this work item and evidence

## Next Actions

1. Try Android Studio managed emulator or a lower API x86_64 image before
   changing the NVIDIA driver.
2. Use the software-renderer launch helper for one controlled emulator attempt
   only when ready to collect a fresh crash/boot result.
3. Treat NVIDIA driver updates as approval-gated because they may disturb the
   working CUDA/PyTorch stack.
4. Keep the real phone path blocked until verified stock firmware/vendor/boot
   inputs and hardware validation gates are solved.
