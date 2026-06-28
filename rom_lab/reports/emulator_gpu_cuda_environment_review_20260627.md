# Emulator GPU and CUDA Environment Review

Date: 2026-06-28

## Purpose

Review whether the existing ForgeWire CUDA/PyTorch environment can explain or
route around the Android Emulator crash on the Quadro M1200 laptop.

This was a read-only evidence pass. No driver, system graphics setting,
ForgeWire, Android SDK, AVD, or physical phone mutation was performed.

## Current Emulator Blocker

The Android SDK, Java, platform-tools, emulator package, Android 15 default
x86_64 system image, and AVD creation all succeeded. Emulator boot remains
blocked by a Windows host crash around the graphics backend:

- NVIDIA Quadro M1200 driver reported as `528.79.0`.
- Emulator reported a minimum NVIDIA driver of `553.35.0` for its NVIDIA Vulkan
  path.
- Host Vulkan was not usable for the emulator.
- Emulator fell through lavapipe / SwiftShader paths and logged
  `Failed to load opengl32sw`.

## CUDA Environment

The ForgeWire CUDA environment was found at:

```text
C:\Projects\forgewire\.venv-torch-cu102
```

The captured PyTorch probe is preserved in:

```text
rom_lab/reports/gpu_cuda_context_20260628-095826.txt
```

Probe result:

- `torch_version=1.12.1+cu116`
- `cuda_available=True`
- `torch_cuda=11.6`
- `cuda_device=Quadro M1200`

## Host GPU Evidence

- Windows: Microsoft Windows 10 Pro `10.0.19045`
- NVIDIA GPU: Quadro M1200
- NVIDIA CIM driver: `31.0.15.2879`, dated 2023-03-08
- `nvidia-smi`: driver `528.79`, CUDA capability/runtime report `12.0`
- Intel GPU: Intel HD Graphics 530, driver `27.20.100.9664`, dated 2021-05-31
- `nvcc`: not found on PATH
- Vulkan/GPU environment variables: none found by the capture script
- Selected PATH entries only showed NVIDIA PhysX, not CUDA toolkit or Vulkan SDK

AVD text config showed the created API 35 AVD is using an x86_64 Pixel 6 profile.
The generated hardware config reports SwiftShader in the runtime hardware file,
while prior launch logs still crashed in the graphics fallback path.

## Relevance

CUDA success is useful because it confirms this laptop has a historically
delicate but working NVIDIA compute setup. It does not prove Android Emulator
graphics compatibility. PyTorch CUDA and Android Emulator graphics exercise
different driver surfaces: CUDA runtime and compute APIs versus
Vulkan/OpenGL/gfxstream/SwiftShader.

The result argues against treating the emulator failure as "the GPU is broken."
It instead supports a narrower diagnosis: the current driver/runtime combination
can support PyTorch CUDA, but the Android Emulator graphics backend remains
blocked.

## Intel / CPU Fallback

Intel or software-renderer fallback is more realistic than changing the NVIDIA
driver as the next safe experiment. Try Android Studio's managed emulator path,
a lower API x86_64 image, or one controlled software-renderer launch before any
driver mutation.

## Recommended Next Action

1. Preserve current evidence with `rom_lab/scripts/capture_gpu_cuda_context.ps1`.
2. Try Android Studio managed emulator/device manager or a lower API x86_64
   image.
3. Try one controlled software-renderer launch with
   `rom_lab/scripts/start_emulator_intel_or_cpu_safe.ps1`.
4. Avoid NVIDIA driver changes unless Jeremy explicitly approves the risk to the
   existing CUDA stack.
5. Move emulator boot to a better host if this laptop remains blocked.
