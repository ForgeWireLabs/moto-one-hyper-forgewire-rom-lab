# Source-List Drift Candidate Decision Report

Status: decision report for drift/equivalence candidates only; no source-list edits authorized

## Scope

This report interprets the unresolved-entry classification results for entries classified as source-list drift candidates or renamed/version-shifted candidates.

It does not change source lists, waive blobs, authorize RETBR substitution, authorize import, authorize build work, or authorize device interaction.

WI-004 remains blocked.

## Input

Committed classification report:

- reports/source_list_drift_classification_report.md

Relevant counts:

| Bucket | Count |
|---|---:|
| source-list-drift-candidate | 33 |
| renamed-or-version-shifted | 13 |
| drift/equivalence candidate total | 46 |
| hard-blocked | 41 |
| blocked-exact-retus | 36 |

## Decision boundary

This report only decides what kind of evidence is needed next for the drift/equivalence candidate set.

This report does not authorize editing proprietary-files.txt, deleting expected entries, marking entries optional, treating RETBR as target-equivalent, importing blobs, generating a vendor tree, starting a Lineage build, touching the phone, adb, fastboot, LMSA/RSA, flashing, or bootloader actions.

## Candidate families

The drift/equivalence candidate set is expected to be dominated by two families:

1. WFD / Wi-Fi Display / HDCP entries.
2. QCRIL database upgrade-tail entries.

These families are different and must not be collapsed into one decision.

## WFD / Wi-Fi Display / HDCP decision

WFD / Wi-Fi Display / HDCP entries are not waived.

They are moved into a drift-review-needed bucket.

Their absence from Route B at exact expected paths may reflect stale feature-stack expectations, product or region differences, reduced feature layout, common-tree inheritance, or missing exact target evidence.

A future source-list correction may only be considered if exact RETUS also lacks the same expected entries, the entries are proven not applicable to XT2027-1 retus, or the source baseline is proven to include stale/common-tree feature assumptions.

Current posture: blocked-drift-review.

## QCRIL database upgrade-tail decision

QCRIL database upgrade-tail entries are not waived.

They are moved into an equivalence-review-needed bucket.

The pattern suggests a version-tail mismatch in the radio database upgrade directory, not random absence.

A future source-list correction may only be considered if the observed QCRIL database upgrade sequence is proven complete for the target build, the missing tail belongs to another version or branch, exact RETUS confirms the same boundary, or source-list comparison proves the expected tail is stale.

Current posture: blocked-equivalence-review.

## Non-candidate entries remain blocked

This report does not affect do-not-waive entries, exact-retus-needed entries, critical radio/IMS entries, display calibration entries, keymaster/QSEE-adjacent entries, QTI data/CNE/latency entries, Bluetooth audio version entries, or non-vendor IMS/RCS/UCE/UIM entries.

Those remain blocked under their existing classification posture.

## Decision summary

| Bucket | Count | Decision |
|---|---:|---|
| Source-list drift candidates | 33 | blocked pending drift proof |
| Renamed/version-shifted candidates | 13 | blocked pending equivalence proof |
| Total drift/equivalence candidates | 46 | no waiver, no import authority |

## Practical next step

The next useful evidence step is one of:

1. reacquire exact RETUS firmware and compare these candidate families directly;
2. perform a local-only source-list comparison against branch history or known sm6150-common/def variants;
3. produce a narrow WFD/QCRIL drift evidence report that cites exact observed paths and missing expected paths without committing raw CSVs or blobs.

## Decision

The 46 drift/equivalence candidates are now separated from the 77 entries that are either hard-blocked or exact-RETUS-dependent.

This does not reduce the unresolved count.

This does not authorize source-list edits.

This does not authorize import/build.

WI-004 remains blocked.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- RETBR substitution;
- exact RETUS substitution decision;
- blob import into vendor/motorola;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
