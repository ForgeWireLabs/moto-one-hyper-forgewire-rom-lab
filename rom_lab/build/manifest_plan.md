# Manifest Plan

## Generic-first manifest

Use official AOSP or LineageOS manifests for a generic emulator/GSI build before
attempting a device-specific `def` manifest.

## Device-specific manifest later

A future local manifest would likely include:

- `device/motorola/def`
- `device/motorola/sm6150-common`
- `kernel/motorola/sm6150`
- `vendor/motorola/def`
- any hardware compatibility repos required by the selected ROM base

No local manifest has been selected yet.

