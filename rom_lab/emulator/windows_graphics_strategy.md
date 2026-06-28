# Windows Graphics Strategy

This strategy keeps the emulator/GSI-first path alive while protecting the
current laptop setup and the physical Motorola One Hyper.

## A. Quadro M1200 Current Driver Path

The emulator crash evidence showed NVIDIA Quadro M1200 driver version `528.79.0`
and an emulator warning that the NVIDIA Vulkan path wanted at least `553.35.0`.
The same host also reported unsupported Vulkan behavior and failed while loading
the OpenGL/SwiftShader fallback path.

Updating the NVIDIA driver could improve emulator Vulkan/gfxstream behavior, but
it also risks breaking Jeremy's fragile working CUDA/PyTorch stack. Do not update
or replace this driver without explicit approval.

## B. CUDA Venv Path

The ForgeWire CUDA environment is useful evidence, not a direct emulator fix.
PyTorch CUDA success proves the NVIDIA compute stack can work for a specific
runtime, CUDA version, and driver combination. Android Emulator graphics uses a
separate path: Vulkan/OpenGL/gfxstream/SwiftShader and Windows graphics driver
capabilities.

Use `rom_lab/scripts/capture_gpu_cuda_context.ps1` to preserve this distinction
before changing anything.

Current captured result:

- ForgeWire venv: `C:\Projects\forgewire\.venv-torch-cu102`
- PyTorch: `1.12.1+cu116`
- `torch.cuda.is_available()`: `True`
- PyTorch CUDA runtime: `11.6`
- CUDA device: Quadro M1200
- `nvidia-smi`: driver `528.79`, CUDA report `12.0`
- `nvcc`: not found on PATH
- Vulkan/GPU environment variables: none found

## C. Intel Graphics / CPU Path

The safer first route is to avoid changing the NVIDIA driver and instead try a
controlled software-renderer or non-NVIDIA emulator path.

Preferred attempts:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File rom_lab\scripts\start_emulator_intel_or_cpu_safe.ps1
```

Manual one-at-a-time alternatives, only after collecting logs from the previous
attempt:

```powershell
C:\Android\Sdk\emulator\emulator.exe -avd forge_moto_one_hyper_lab_api35 -no-snapshot -no-boot-anim -no-audio -gpu off -no-metrics -verbose
C:\Android\Sdk\emulator\emulator.exe -avd forge_moto_one_hyper_lab_api35 -no-window -no-snapshot -no-boot-anim -no-audio -gpu swiftshader_indirect -no-metrics -verbose
C:\Android\Sdk\emulator\emulator.exe -avd forge_moto_one_hyper_lab_api35 -no-snapshot -no-boot-anim -no-audio -gpu swiftshader_indirect -feature -Vulkan -no-metrics -verbose
C:\Android\Sdk\emulator\emulator.exe -avd forge_moto_one_hyper_lab_api35 -no-snapshot -no-boot-anim -no-audio -gpu swiftshader_indirect -accel off -no-metrics -verbose
```

Also try Android Studio's managed emulator/device manager path and a lower API
x86_64 image before changing the NVIDIA driver.

## D. Better-Host Path

If this laptop remains blocked, use it as the repo/control host and move emulator
boot to a machine with a cleaner graphics stack. Linux with KVM or a future
Cuttlefish-capable setup is a better long-term route for generic Android boot
evidence.

The physical phone remains out of scope for firmware-write or destructive
actions unless Jeremy explicitly approves the exact action in the current
session.
