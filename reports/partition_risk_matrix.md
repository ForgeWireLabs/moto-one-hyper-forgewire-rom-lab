# Partition Risk Matrix

Status: draft

Date: 2026-06-28

## Purpose

Classify partition risk before any physical-device operation is considered.

This matrix is intentionally conservative.

No partition listed here is approved for flashing.

## Risk levels

| Level | Meaning |
|---|---|
| Green | Low-risk candidate only after verified stock image and rollback path exist |
| Yellow | Medium-risk; requires specific gate review |
| Red | High-risk; avoid unless official stock restore procedure specifically requires it |
| Black | Never touch in this project without a separate emergency/unbrick review |

## Initial matrix

| Partition / Area | Risk | Reason | Current policy |
|---|---|---|---|
| boot | Yellow | Failed boot image may soft-brick/bootloop | blocked until stock boot image verified |
| vendor_boot | Yellow | Boot/vendor init dependency if present | blocked |
| recovery | Yellow | Bad recovery can remove easy recovery path | blocked |
| dtbo | Red | Hardware/device-tree overlay mismatch can break boot/display | blocked |
| vbmeta | Red | AVB changes can complicate boot and recovery | blocked |
| vbmeta_system | Red | AVB/dynamic partition verification risk | blocked |
| super | Red | Dynamic partition container; broad impact | blocked |
| system | Yellow/Red | OS partition, dynamic partition context matters | blocked |
| product | Yellow/Red | Dynamic partition context matters | blocked |
| system_ext | Yellow/Red | Dynamic partition context matters | blocked |
| vendor | Red | HAL/vendor compatibility; can break boot/userspace | blocked |
| odm | Red | Device/vendor-specific behavior | blocked |
| modem/radio | Black | Radio firmware risk, regulatory and brick risk | never touch |
| persist | Black | Calibration/device-specific data risk | never touch |
| EFS-like identity/calibration | Black | Identity/calibration loss risk | never touch |
| bootloader | Black | Hard-brick risk | never touch |
| partition table/GPT | Black | Hard-brick risk | never touch |
| frp | Black | Lock/security state risk | never touch |
| carrier/security/calibration unknowns | Black | Unknown irreversible behavior | never touch |
| unknown partition | Black | Unknown risk | never touch |

## Slot policy

No slot change is allowed until:

- slot layout is documented
- active slot is verified
- inactive slot behavior is understood
- stock images exist for relevant slots
- rollback plan exists

## Dynamic partition policy

No dynamic partition mutation is allowed until:

- super layout is extracted from verified stock firmware
- logical partitions are inventoried
- image compatibility is proven
- no generated sparse images are committed
- rollback path exists

## Current decision

The only approved physical-device state is no mutation.

All future physical actions require a written gate review and current-session approval.
