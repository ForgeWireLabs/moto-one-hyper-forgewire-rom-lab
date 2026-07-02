# Exact RETUS UimGba Location-Shift Proposal

## Scope

This proposal evaluates the four UimGba entries currently classified as:

- `uimgba-product-to-system_ext-location-shift-candidate`

This is a proposal report only. It does not edit source lists and does not authorize implementation.

## Authority Target

Exact RETUS remains the only authority target:

- Device: Motorola One Hyper XT2027-1
- Channel: RETUS / Retail US
- Build: RPFS31.Q1-21-20-1-7-3
- Build tag: 37074e
- System version: 30.201.3.def_retail.retail.en.US

RETBR and other device/channel evidence are not authority for this proposal.

## Affected Entries

The affected source-list entries are:

- `product/etc/permissions/UimGba.xml`
- `product/etc/permissions/UimGbaManager.xml`
- `product/framework/uimgbalibrary.jar`
- `product/framework/uimgbamanagerlibrary.jar`

## Current Classification

From the radio/security final evidence reduction:

- expected UimGba basenames appear in exact RETUS `system_ext` inventory evidence
- expected product paths were not observed
- all four entries remain hard-blocked
- current class: `uimgba-product-to-system_ext-location-shift-candidate`

## Evidence Summary

Observed exact RETUS evidence indicates the UimGba permission XML and framework JAR basenames exist under `system_ext`, not under the expected `product` paths.

Observed basename evidence:

| Expected source-list path | Observed exact RETUS location class |
|---|---|
| `product/etc/permissions/UimGba.xml` | `system_ext/etc/permissions/UimGba.xml` |
| `product/etc/permissions/UimGbaManager.xml` | `system_ext/etc/permissions/UimGbaManager.xml` |
| `product/framework/uimgbalibrary.jar` | `system_ext/framework/uimgbalibrary.jar` |
| `product/framework/uimgbamanagerlibrary.jar` | `system_ext/framework/uimgbamanagerlibrary.jar` |

No exact expected product-path hit has been recorded for these entries.

## Interpretation

This appears to be a partition/location shift between the inherited source-list expectation and exact RETUS firmware evidence.

The current source-list expectation points to `product`.

The exact RETUS evidence points to `system_ext`.

This is not a missing-stack finding. It is also not yet a safe edit. Framework and permission artifacts can be partition-sensitive, because path location may affect:

- framework classpath behavior
- permission XML loading
- product versus system_ext ownership
- extraction path assumptions
- build packaging expectations
- runtime exposure of telephony/GBA components

## Proposed Future State

Recommended future state:

- `path-adjustment-candidate`

This proposal does not move the entries yet. It only records that a path-adjustment proposal is now the correct next decision surface.

## Required Before Implementation

Before any source-list path adjustment is made, a follow-up implementation proposal must confirm:

1. exact observed `system_ext` paths for all four basenames
2. absence of the expected `product` paths in exact RETUS evidence
3. source-list provenance for why inherited common-tree entries expect `product`
4. whether the build extraction tooling expects partition-prefixed source-list paths exactly
5. whether these four entries should be moved as a group or left annotated
6. whether any dependent makefiles, proprietary extraction scripts, or generated vendor logic assume product placement
7. validation remains green after any proposed source-list change

## Approved Actions In This Proposal

This proposal approves no implementation action.

Allowed current actions:

- document evidence
- keep entries hard-blocked
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

- keep all four UimGba entries hard-blocked
- classify as path-adjustment candidates
- require a separate implementation proposal before any source-list edit

## Conclusion

The UimGba entries are the safest radio/security subset to review first because exact RETUS contains the expected basenames and the discrepancy appears to be partition/location related.

However, because these are telephony/GBA framework and permission artifacts, no automatic correction is authorized.

The correct next step is a future source-list path-adjustment implementation proposal, not an immediate edit.
