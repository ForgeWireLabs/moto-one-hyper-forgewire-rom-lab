# Moto One Hyper ROM lab

This lab tracks research, build planning, and emulator-first validation for a
modern Android ROM path for the Motorola One Hyper (`def`).

The lab has three separate tracks:

1. Generic ROM build and emulator test: proves a userspace image can build and
   boot on generic Android test infrastructure.
2. Moto One Hyper device-port work: requires `def` device trees, kernel source,
   vendor blobs, BoardConfig, fstab, partition handling, sepolicy, init files,
   and HAL compatibility.
3. Real-device flash: blocked until Jeremy explicitly approves a specific
   firmware-write action in the current session.

No firmware ZIPs, `.img` files, vendor blobs, serials, IMEIs, unlock keys, or
phone dumps belong in this repository.

