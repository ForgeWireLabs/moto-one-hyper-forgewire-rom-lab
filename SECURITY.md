# Security Policy

## Scope

This repository contains an Android ROM research lab, emulator tooling, and bridge contracts for future ForgeWire Android integration.

## Safety-sensitive areas

Report issues involving:

- accidental physical-device targeting
- destructive ADB or fastboot command exposure
- bridge bypasses that allow arbitrary shell execution
- scripts that can flash, erase, wipe, relock, sideload, repair, rescue, or write to a physical phone
- leaked credentials or private data

## Current rule

The physical Motorola One Hyper must not be flashed, erased, wiped, relocked, sideloaded, repaired, rescued, or otherwise written to without explicit current-session approval from the device owner.

## Reporting

Open a GitHub issue for non-sensitive problems.

For sensitive reports, contact the repository owner privately through the GitHub profile.
