# Device Tree Candidates

## What we need

A real Motorola One Hyper ROM needs at least:

- `device/motorola/def`
- `device/motorola/sm6150-common` or equivalent
- product makefiles
- BoardConfig and partition declarations
- init, fstab, uevent, sepolicy, recovery, and fastbootd configuration
- proprietary-files list and extraction scripts

## Current candidate state

- `android_device_motorola_def_twrp` is a useful recovery-tree lead, not a full
  ROM tree.
- `motorola-sm6150-devs/android_device_motorola_sm6150-common` is a common-tree
  lead, not proof of `def` support.
- A def-specific ROM tree has not been verified in this repository.

## Next pass

Clone or inspect candidate repositories without committing them, then record:

- exact URL
- branch
- commit
- license
- whether `def` appears in product makefiles
- whether the tree targets dynamic partitions
- whether it references a compatible kernel and vendor tree

