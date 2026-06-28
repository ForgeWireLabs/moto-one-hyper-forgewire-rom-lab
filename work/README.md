# Work Items

This directory is the active planning surface for the Moto One Hyper ForgeWire ROM Lab.

Work items exist so agents and humans can coordinate through versioned files instead of chat-only memory.

## Folders

- active/ - work currently being implemented
- completed/ - accepted and committed work
- proposed/ - planned work that is not active yet
- blocked/ - work that cannot proceed until an explicit gate is cleared
- deferred/ - intentionally postponed work

## Status values

- proposed
- active
- blocked
- complete
- deferred

## Safety rule

Any work item that could touch a physical phone must say so explicitly and must remain blocked until Jeremy approves the exact current-session action.

Emulator-only work is allowed when it stays within the bridge contract.

## Current sequence

Completed:

- completed/WI-001-project-state-and-work-ledger.md
- completed/WI-002-emulator-bridge-json-wrapper.md

Next recommended active work:

- proposed/WI-003-forgelink-adapter-stub.md

Blocked:

- blocked/WI-004-firmware-acquisition-and-verification.md

Proposed:

- proposed/WI-005-rom-source-and-device-tree-roadmap.md
- proposed/WI-006-public-project-polish-and-ci.md

## Rule

No work item should live directly in this directory except this README.
