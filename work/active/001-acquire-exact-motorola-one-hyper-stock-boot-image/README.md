# 001 — Acquire exact Motorola One Hyper stock boot image

> **Status**: Active
> **Owners**: governance-owner (lead).
> **Depends on**: none.

## Intent

Acquire the exact matching stock firmware package, or at minimum the exact
matching stock `boot.img`, for the Motorola One Hyper currently identified as:

- SKU: XT2027-1
- Product/device: `def`
- Build target/name: `def_retail`
- Channel: `retus`
- Android build: `RPFS31.Q1-21-20-1-7-3`
- Security patch: `2022-01-01`

The purpose is to enable a later Magisk patching workflow only after the stock
boot image source is verified. This work item is acquisition and verification
only.

## Decisions

- Do not use random or merely similar `boot.img` files.
- Do not patch or flash until the source package and image match are verified.
- Do not run rescue, repair, reinstall, erase, relock, wipe, or flash actions
  without explicit Jeremy approval.

## Scope

- `firmware/`
- `images/`
- `reports/`
- `evidence/runs/`
- this work item

## Closeout

Each acceptance criterion is satisfied by linked evidence. When all are satisfied,
move this directory to `work/completed/` and regenerate the dashboard.
