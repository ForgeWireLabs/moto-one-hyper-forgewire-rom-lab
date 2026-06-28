# Kernel Candidates

## Target

- SoC family: Qualcomm SM6150 / Snapdragon 675 family
- Device codename: `def`
- Stock build: `RPFS31.Q1-21-20-1-7-3`

## Candidate leads

- MotorolaMobilityLLC `kernel-msm`
- `motorola-sm6150-devs/android_kernel_motorola_sm6150`
- Any def-specific fork referenced by a maintained device tree

## Selection criteria

- def or SM6150 support is explicit
- branch/tag lines up with Android 11 stock lineage or later compatible bring-up
- kernel config includes required panels, touchscreen, camera, fingerprint,
  audio, modem, and storage support
- source license is compatible and complete enough for builds
- defconfig and DTB/DTBO strategy are clear

## Current status

No kernel source has been selected. A kernel source can be researched safely, but
a bootable phone kernel cannot be claimed until it builds and boots in the right
device context.

