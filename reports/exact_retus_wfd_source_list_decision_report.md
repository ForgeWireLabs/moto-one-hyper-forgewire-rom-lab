# Exact RETUS WFD Source-List Decision Report

Status: gated decision report; no source-list edits applied

## Scope

This report records the source-list decision posture for the WFD / Wi-Fi Display
/ HDCP block after exact RETUS Route A evidence, drift review, and source
provenance review.

This is not a source-list edit.

This is not a waiver.

This is not blob import authorization.

This is not generated vendor tree authorization.

This is not build authorization.

## Committed evidence chain

This report depends on the committed Route A evidence chain:

- `reports/exact_retus_artifact_verification.md`
- `reports/exact_retus_super_reconstruction_summary.md`
- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`
- `reports/exact_retus_wfd_wifi_display_hdcp_drift_review.md`
- `reports/exact_retus_wfd_source_provenance_review.md`

## Current exact RETUS coverage state

Exact RETUS adjusted line coverage established:

| Metric | Count |
|---|---:|
| Active expected proprietary entries | `1,213` |
| Direct vendor matches | `957` |
| Direct non-vendor matches | `133` |
| Combined direct matches | `1,090` |
| Remaining active unresolved entries | `123` |
| Disabled/optional entries | `32` |
| Coverage over active expected entries | `89.8599%` |

## Remaining unresolved buckets

After classification, the active unresolved set is:

| Bucket | Count | Current posture |
|---|---:|---|
| WFD / Wi-Fi Display / HDCP | `69` | `source-list-drift-candidate` |
| Radio / IMS / QCRIL / keymaster-sensitive | `30` | `do-not-waive` |
| Deeper exact RETUS vendor review | `12` | blocked pending deeper review |
| Renamed or version-shifted | `11` | equivalence review needed |
| Deeper camera inventory | `1` | deeper targeted inventory needed |

This report concerns only the `69` WFD / Wi-Fi Display / HDCP entries.

## WFD block evidence summary

The WFD drift review established:

| Metric | Count |
|---|---:|
| WFD/Wi-Fi Display/HDCP entries reviewed | `69` |
| Entries from `sm6150-common` | `69` |
| Entries from `def` | `0` |
| `system_ext` entries | `37` |
| `vendor` entries | `32` |
| Review posture `source-list-drift-candidate` | `69` |

The WFD source provenance review established:

- the WFD block is inherited from `sm6150-common`;
- no WFD entries in this block come from the device-specific `def` tree;
- the source list labels the block as from `Motorola Edge S - RRN31.Q1-20-31-3`;
- the inspected blame range attributes the block to root common-tree commit `6e125f0`;
- `proprietary-files.txt` history shows the block was present at initial common-tree import;
- no evidence has been found that the block was validated against exact `def_retail` RETUS.

## Source-list decision

The WFD / Wi-Fi Display / HDCP block is eligible for a future gated source-list
change proposal.

The recommended posture is:

| Decision | Value |
|---|---|
| Treat as exact RETUS hard blocker | `No` |
| Treat as radio/security-sensitive no-waive block | `No` |
| Treat as random missing firmware | `No` |
| Treat as inherited common-tree drift candidate | `Yes` |
| Allow immediate source-list edit | `No` |
| Allow immediate source-list waiver | `No` |
| Allow immediate blob import/build use | `No` |
| Allow future human-approved source-list change proposal | `Yes` |

## Decision rationale

The WFD block should not be treated like the radio/IMS/QCRIL/keymaster block.

The radio/security-sensitive block remains do-not-waive because it may affect
radio behavior, telephony behavior, carrier compatibility, security services, or
trusted execution surfaces.

The WFD block is different:

- it is concentrated in one inherited common-tree section;
- it is explicitly labeled as sourced from Motorola Edge S;
- it has no device-specific `def` provenance;
- exact RETUS does not directly match its expected paths;
- no evidence shows exact `def_retail` RETUS required these exact entries;
- the entire block is coherent drift, not scattered missing firmware.

Therefore, the WFD block is eligible for a future source-list change proposal,
but the change must remain gated.

## Authorized by this report

This report authorizes only the following future planning posture:

1. create a separate proposed source-list change report for the WFD block;
2. describe the proposed treatment of the WFD block;
3. require human approval before editing source lists;
4. keep all raw firmware, CSVs, inventories, helper scripts, and extracted images local-only;
5. keep import/build/device actions blocked.

## Not authorized by this report

This report does not authorize:

- editing `proprietary-files.txt`;
- deleting the WFD block;
- commenting out the WFD block;
- waiving the WFD block;
- importing blobs;
- generating a vendor tree;
- running a Lineage build;
- using RETBR as substitution authority;
- touching the phone;
- adb;
- fastboot;
- LMSA/RSA rescue or repair;
- flashing;
- bootloader unlock/relock;
- wipe/erase operations.

## Required gate before source-list edit

Before any source-list edit, a separate report or work item must explicitly state:

- the exact file to be changed;
- the exact WFD lines to be changed;
- whether the change is removal, annotation, optionalization, or split handling;
- the evidence reports supporting the decision;
- the remaining risks;
- the rollback plan;
- the human approval marker.

Without that gate, the WFD block remains unchanged.

## Recommended source-list proposal shape

A future source-list proposal should prefer annotation/split handling over silent
removal.

A safe proposal shape would be:

1. preserve the evidence that the block came from Motorola Edge S;
2. add a comment that exact `def_retail` RETUS did not directly match the block;
3. keep the block blocked or optional until a build/import attempt proves the need;
4. avoid mixing WFD drift treatment with radio/security-sensitive entries;
5. avoid claiming the entries are unnecessary unless build evidence later proves that.

## Current project status after this decision

After this decision report, the project remains evidence-forward and blocked
against destructive or premature actions.

Current safe next steps are:

1. create a proposed WFD source-list change report;
2. perform deeper exact RETUS review of the 12 uncategorized vendor entries;
3. perform equivalence review for the 11 renamed/version-shifted entries;
4. perform deeper targeted inventory for the 1 camera entry;
5. keep the 30 radio/security entries blocked as do-not-waive.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- direct WFD removal;
- RETBR substitution;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
