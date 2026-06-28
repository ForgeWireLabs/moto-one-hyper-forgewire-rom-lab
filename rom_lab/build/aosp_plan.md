# AOSP Build Plan

Use official AOSP docs for source sync and branch selection. Current Android
source docs recommend `android-latest-release` for building and contributing to
AOSP.

## Generic target

Start with a generic emulator or Cuttlefish target, not `def`.

## Why

AOSP generic boot proves the host and lab can build and run Android. It does not
prove Motorola One Hyper hardware support.

## Blocked for device target

- no verified stock firmware package
- no vendor blobs
- no selected `def` device tree
- no selected kernel
- no AVB/vbmeta plan for hardware

