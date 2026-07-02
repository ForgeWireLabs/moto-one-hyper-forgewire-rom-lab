# Exact RETUS QCRIL Sequence Absence Proposal

## Scope

This proposal evaluates the thirteen QCRIL database upgrade entries currently classified as:

- `exact-retus-qcril-sequence-absent-after-23`

This is a proposal report only. It does not edit source lists and does not authorize implementation.

## Authority Target

Exact RETUS remains the only authority target:

- Device: Motorola One Hyper XT2027-1
- Channel: RETUS / Retail US
- Build: RPFS31.Q1-21-20-1-7-3
- Build tag: 37074e
- System version: 30.201.3.def_retail.retail.en.US

RETBR and other device/channel evidence are comparison-only. They are not import authority and do not justify accepting QCRIL database entries for exact RETUS.

## Affected Entries

The affected source-list entries are:

- `vendor/radio/qcril_database/upgrade/24_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/25_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/26_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/27_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/28_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/29_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/30_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/31_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/33_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/34_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/35_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/36_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/37_version_qcrildb.sql`

## Current Classification

From the radio/security final evidence reduction:

- exact RETUS contains the QCRIL database directory
- exact RETUS contains `qcril.db`
- exact RETUS contains `0_initial.sql`
- exact RETUS contains QCRIL database upgrade versions `3` through `23`
- the expected source-list entries begin at version `24` and continue beyond the observed exact RETUS sequence
- current class: `exact-retus-qcril-sequence-absent-after-23`
- current posture: `remain-hard-blocked`

## Evidence Summary

The focused exact RETUS QCRIL sequence scan found the following observed sequence:

- `vendor/radio/qcril_database/qcril.db`
- `vendor/radio/qcril_database/upgrade/0_initial.sql`
- `vendor/radio/qcril_database/upgrade/3_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/4_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/5_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/6_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/7_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/8_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/9_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/10_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/11_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/12_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/13_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/14_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/15_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/16_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/17_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/18_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/19_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/20_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/21_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/22_version_qcrildb.sql`
- `vendor/radio/qcril_database/upgrade/23_version_qcrildb.sql`

The expected source-list sequence continues with `24` through `31`, skips `32`, and then continues with `33` through `37`.

No exact RETUS evidence has been recorded for expected QCRIL database upgrade versions `24` through `31` or `33` through `37`.

## Interpretation

This appears to be inherited common-tree QCRIL database sequence drift relative to exact RETUS.

The important distinction is:

- exact RETUS does contain the QCRIL database upgrade mechanism
- exact RETUS does contain a valid observed upgrade sequence
- the observed exact RETUS sequence stops at version `23`
- the inherited source-list expectation continues beyond the observed exact RETUS sequence

This is stronger than a generic missing-file finding. It indicates that the source-list expectation is probably ahead of the exact RETUS authority firmware for this QCRIL database sequence.

However, this evidence does not automatically authorize removal or waiver. QCRIL database files are radio/telephony-sensitive and may affect carrier, IMS, SIM, provisioning, or modem behavior.

## Proposed Future State

Recommended future state:

- `source-list-drift-candidate`

Secondary possible future state after stronger evidence:

- `non-use-candidate`

This proposal does not move the entries yet. It records that source-list drift is now the correct next decision surface.

## Why This Is Not A Waiver

These entries must not be waived merely because exact RETUS appears to stop at version `23`.

A waiver would imply that the expected files are safe to ignore. This proposal does not establish that.

The current evidence only supports:

- the entries are absent from observed exact RETUS sequence evidence
- the exact RETUS sequence appears to stop earlier than inherited source-list expectation
- further build/reference/non-use review is required before removal or source-list adjustment

## Required Before Any Removal Proposal

Before these entries can be proposed for removal from the source list, a follow-up implementation proposal must confirm:

1. exact RETUS inventory proof that versions `24` through `31` and `33` through `37` are absent
2. source-list provenance explaining why the inherited common tree expects versions `24` and later
3. reference scan showing whether build scripts, extraction scripts, or makefiles directly require the later SQL files
4. runtime/build rationale explaining why exact RETUS can safely stop at `23`
5. determination whether missing version `32` in the expected sequence is meaningful or inherited from upstream source-list history
6. explicit non-use proof if removal is proposed
7. validation remains green after any proposed source-list change

## Required Before Annotation-Only Proposal

A lower-risk future proposal may annotate the source list without removing entries.

Before annotation-only work, a follow-up proposal must confirm:

1. exact RETUS observed sequence stops at `23`
2. expected entries are inherited from `sm6150-common`
3. no exact RETUS authority evidence has been found for versions `24` through `31` and `33` through `37`
4. annotation text is non-functional and does not change extraction/build behavior
5. explicit approval marker is present

## Approved Actions In This Proposal

This proposal approves no implementation action.

Allowed current actions:

- document evidence
- keep entries hard-blocked
- prepare a future annotation-only proposal
- prepare a future non-use/removal proposal only after stronger evidence

Not allowed:

- source-list edit
- waiver
- deletion
- blob import
- RETBR substitution
- alternate-device substitution
- generated vendor tree
- Lineage build attempt
- device interaction

## Required Approval Marker For Future Edit

A future annotation-only edit must not occur unless a later report includes:

`APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_ANNOTATION_ONLY`

A future removal edit must not occur unless a later report includes:

`APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_REMOVAL_AFTER_NON_USE_PROOF`

This report intentionally includes neither marker.

## Decision

Current decision:

- keep all thirteen QCRIL sequence entries hard-blocked
- classify as source-list drift candidates
- require a separate proposal before annotation or removal
- require stronger non-use evidence before any removal decision

## Conclusion

The QCRIL database entries have clean exact RETUS evidence showing that the authority firmware contains the QCRIL database and an upgrade sequence ending at version `23`.

The inherited source-list expectation continues beyond the observed exact RETUS sequence.

This supports a controlled `source-list-drift-candidate` posture, not waiver or removal.

The correct next step is a future annotation-only or non-use/removal proposal with explicit approval markers, not an immediate edit.
