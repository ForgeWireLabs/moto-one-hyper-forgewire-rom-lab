# Stock Boot and Recovery Anchor - RPFS31.Q1-21-20-5 RETBR

Status: reference anchors observed; physical use not authorized

Date: 2026-07-01

## Safety boundary

This report identifies offline reference anchors only. It does not authorize
boot, recovery, vendor_boot, dtbo, vbmeta, modem, radio, super, bootloader, or
partition flashing. No phone, adb, fastboot, LMSA/RSA, rescue, repair, root,
flash, erase, wipe, blob import, or build action was performed.

## Anchor evidence

| Artifact | Present? | Evidence |
|---|---|---|
| `boot.img` | yes | 67108864 bytes; Android boot-image header `ANDROID!` |
| `recovery.img` | yes | 67108864 bytes; Android boot-image header `ANDROID!` |
| `vendor_boot.img` | no | absent from ZIP and extraction root |
| `dtbo.img` | yes | 25165824 bytes; DTBO header evidence observed |
| `vbmeta.img` | yes | 4096 bytes; AVB header `AVB0` |

## Recovery layout reading

This package contains a standalone `recovery.img` and no `vendor_boot.img`.
For this package, recovery is therefore represented as a direct recovery image,
not only as boot-as-recovery.

This reading is limited to the extracted RETBR `RPFS31.Q1-21-20-5` package. It
does not prove the exact retus `RPFS31.Q1-21-20-1-7-3` package would be byte
identical or channel-compatible.

## Future rollback/reference value

The observed files can serve as future local reference anchors for metadata and
comparison work:

- `boot.img`: stock boot-image reference for this `-5` package
- `recovery.img`: stock standalone recovery reference for this `-5` package
- `dtbo.img`: stock DTBO reference for this `-5` package
- `vbmeta.img`: AVB/vbmeta relationship reference for this `-5` package

They are not rollback assets for the physical phone unless a later gate proves
the exact build/channel/partition relationship and explicitly authorizes a
physical action. That gate does not exist.

## Current decision

No boot or recovery flashing is authorized.

No vbmeta, dtbo, bootloader, radio, super, or partition flashing is authorized.

No image is accepted for physical-device recovery use. The files are offline
reference anchors only.
