# Exact RETUS IMS Factory Location-Shift Proposal

## Scope

This proposal evaluates the single IMS factory entry currently classified as:

- `ims-factory-vendor64-to-system_ext-location-shift-candidate`

This is a proposal report only. It does not edit source lists and does not authorize implementation.

## Authority Target

Exact RETUS remains the only authority target:

- Device: Motorola One Hyper XT2027-1
- Channel: RETUS / Retail US
- Build: RPFS31.Q1-21-20-1-7-3
- Build tag: 37074e
- System version: 30.201.3.def_retail.retail.en.US

RETBR and other device/channel evidence are comparison-only and are not authority for this proposal.

## Affected Entry

The affected source-list entry is:

- `vendor/lib64/vendor.qti.ims.factory@1.1.so`

## Current Classification

From the radio/security final evidence reduction:

- expected IMS factory 1.1 basename appears in exact RETUS `system_ext/lib`
- expected IMS factory 1.1 basename appears in exact RETUS `system_ext/lib64`
- expected `vendor/lib64` path was not observed
- current class: `ims-factory-vendor64-to-system_ext-location-shift-candidate`
- current posture: `remain-hard-blocked`

## Evidence Summary

Observed exact RETUS evidence indicates that `vendor.qti.ims.factory@1.1.so` exists under `system_ext`, not at the expected `vendor/lib64` path.

Observed exact RETUS locations include:

- `system_ext/lib/vendor.qti.ims.factory@1.1.so`
- `system_ext/lib64/vendor.qti.ims.factory@1.1.so`

The expected source-list path is:

- `vendor/lib64/vendor.qti.ims.factory@1.1.so`

No exact expected `vendor/lib64` path hit has been recorded for this entry.

## Interpretation

This appears to be a partition/location shift between inherited source-list expectation and exact RETUS firmware evidence.

The current source-list expectation points to `vendor/lib64`.

The exact RETUS evidence points to `system_ext/lib` and `system_ext/lib64`.

This is not a missing IMS factory stack finding. It is also not yet a safe edit. IMS factory libraries are radio/IMS-sensitive and can be affected by:

- partition ownership
- VNDK/system_ext linkage
- library load path expectations
- IMS service/framework dependencies
- architecture-specific packaging
- vendor versus system_ext boundary assumptions

## Proposed Future State

Recommended future state:

- `path-adjustment-candidate`

This proposal does not move the entry yet. It records that a path-adjustment proposal is the correct next decision surface.

## Required Before Implementation

Before any source-list path adjustment is made, a follow-up implementation proposal must confirm:

1. exact observed `system_ext/lib` and `system_ext/lib64` evidence
2. absence of the expected `vendor/lib64` path in exact RETUS evidence
3. source-list provenance for why inherited common-tree entries expect `vendor/lib64`
4. dependency/reference review for library load path
5. partition boundary impact between `vendor` and `system_ext`
6. ABI/build compatibility note
7. validation remains green after any proposed source-list change

## Approved Actions In This Proposal

This proposal approves no implementation action.

Allowed current actions:

- document evidence
- keep entry hard-blocked
- prepare a future source-list path-adjustment implementation proposal

Not allowed:

- source-list edit
- waiver
- deletion
- blob import
- RETBR substitution
- generated vendor tree
- Lineage build attempt
- device interaction

## Required Approval Marker For Future Edit

A future source-list path adjustment must not occur unless a later report includes this explicit marker:

`APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_PATH_ADJUSTMENT`

This report intentionally does not include that marker.

## Decision

Current decision:

- keep the IMS factory entry hard-blocked
- classify as a path-adjustment candidate
- require a separate implementation proposal before any source-list edit

## Conclusion

The IMS factory entry has concrete basename evidence in exact RETUS, but at `system_ext` paths rather than the inherited expected `vendor/lib64` path.

Because this entry is IMS/radio-sensitive and crosses the `vendor` to `system_ext` boundary, no automatic correction is authorized.

The correct next step is a future source-list path-adjustment implementation proposal, not an immediate edit.
