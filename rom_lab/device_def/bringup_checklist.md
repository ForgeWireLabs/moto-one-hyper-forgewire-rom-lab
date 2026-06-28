# Bring-Up Checklist

## Firmware acquisition

- Acquire exact stock package for `RPFS31.Q1-21-20-1-7-3`.
- Verify package provenance.
- Record package SHA256 outside committed binaries.
- Extract and hash `boot.img`.

## Vendor blob extraction

- Select source: exact firmware package or approved non-destructive dump path.
- Build proprietary-files list.
- Keep blobs out of git.

## Kernel source selection

- Identify Motorola or community SM6150 kernel source.
- Match branch/tag to stock or chosen ROM base.
- Verify defconfig and DTBO strategy.

## Device tree creation

- Verify or create `device/motorola/def`.
- Link to `sm6150-common` only after compatibility review.
- Define products, overlays, init, fstab, recovery, and sepolicy.

## BoardConfig

- Define architecture, partitions, boot image settings, AVB flags, dynamic
  partitions, kernel image handling, and recovery/fastbootd settings.

## Dynamic partitions

- Map `super` layout.
- Confirm logical partition names and sizes.
- Avoid assuming generic dynamic layout equals Motorola layout.

## AVB/vbmeta

- Record verified boot state.
- Draft test strategy for vbmeta only after image provenance is verified.
- No vbmeta flashing without explicit approval.

## Sepolicy

- Start from common policy only after source audit.
- Track permissive/enforcing transitions.
- Never claim production readiness from permissive-only boot.

## Init/fstab

- Reconcile recovery tree, stock fstab, and Android version expectations.
- Validate mount points and dynamic partitions.

## Recovery/fastbootd

- Determine whether TWRP/recovery exists for `def`.
- Confirm fastbootd path for dynamic partition operations.
- No hardware writes without approval.

## Emulator/GSI test

- Boot generic image first.
- Record boot complete, adb shell, logcat, and package manager evidence.
- Keep limitations explicit.

## Hardware test gates

- Exact stock boot image available.
- Rollback plan documented.
- Full command list reviewed.
- Jeremy approves current-session hardware write actions.

## Rollback plan

- Preserve stock boot image and firmware package hashes.
- Record active slot before any approved hardware operation.
- Keep known-good boot/recovery path documented.
- Never relock until stock integrity is restored and explicitly approved.

