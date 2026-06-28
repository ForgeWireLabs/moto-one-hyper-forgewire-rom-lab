# Work Items

This directory is the active planning surface for the Moto One Hyper ForgeWire ROM Lab.

The layout follows a RepoPact-style numbered work-item directory convention:

- active/<number-slug>/README.md
- proposed/<number-slug>/README.md
- blocked/<number-slug>/README.md
- completed/<number-slug>/README.md
- deferred/<number-slug>/README.md

## Folders

- active/ - work currently being implemented
- proposed/ - known candidate work that is not active yet
- blocked/ - work that cannot proceed until an explicit gate is cleared
- completed/ - accepted and committed work
- deferred/ - intentionally postponed work

## Current work

Active:

- none

Completed:

- completed/001-project-state-and-work-ledger/README.md
- completed/002-emulator-bridge-json-wrapper/README.md
- completed/003-forgelink-adapter-stub/README.md

Blocked:

- blocked/004-firmware-acquisition-and-verification/README.md

Proposed:

- proposed/005-rom-source-and-device-tree-roadmap/README.md
- proposed/006-public-project-polish-and-ci/README.md

Deferred:

- none

## Safety rule

Any work item that could touch a physical phone must say so explicitly and must remain blocked until Jeremy approves the exact current-session action.

Emulator-only work is allowed when it stays within the bridge contract.

## Rule

No work item should live directly in this directory except this README.
