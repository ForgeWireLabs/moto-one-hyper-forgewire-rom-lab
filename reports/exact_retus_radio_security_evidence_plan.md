# Exact RETUS Radio / Security Evidence Plan

Status: evidence plan; hard block remains active

## Scope

This report defines the evidence plan for the `30` exact RETUS unresolved entries
classified as:

- `do-not-waive`

This plan concerns radio/security-sensitive entries, including surfaces related
to:

- radio;
- IMS;
- QCRIL;
- LPA;
- keymaster;
- gatekeeper;
- QSEE;
- trusted execution or security-adjacent vendor components.

This is an evidence plan only.

This is not a source-list edit.

This is not a waiver.

This is not blob import authorization.

This is not generated vendor tree authorization.

This is not build authorization.

This is not device authorization.

## Supporting evidence

This plan depends on the committed exact RETUS evidence chain:

- `reports/exact_retus_artifact_verification.md`
- `reports/exact_retus_super_reconstruction_summary.md`
- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`
- `reports/exact_retus_unresolved_status_rollup.md`

Related non-radio proposal coverage now exists for:

- `reports/exact_retus_wfd_source_list_proposal.md`
- `reports/exact_retus_probable_version_shift_equivalence_proposal.md`
- `reports/exact_retus_same_directory_vendor_variant_proposal.md`
- `reports/exact_retus_camera_permissions_config_proposal.md`

This plan covers the remaining hard unresolved bucket.

## Current unresolved state

Adjusted exact RETUS coverage established:

| Metric | Count |
|---|---:|
| Active expected proprietary entries | `1,213` |
| Combined direct matches | `1,090` |
| Remaining active unresolved entries | `123` |

Current unresolved bucket map:

| Bucket | Count | Status |
|---|---:|---|
| WFD / Wi-Fi Display / HDCP | `69` | proposal coverage complete; still gated |
| Same-directory vendor variants | `12` | proposal coverage complete; still gated |
| Renamed/version-shifted entries | `11` | reviewed; partial proposal coverage for 2 probable version shifts |
| Camera permissions/config | `1` | proposal coverage complete; still gated |
| Radio/security-sensitive entries | `30` | hard block; do-not-waive |

## Radio/security hard-block rule

The `30` radio/security-sensitive entries remain hard-blocked.

They must not be:

- waived;
- removed;
- silently ignored;
- replaced from RETBR;
- substituted from another device;
- imported from an unverified source;
- treated as optional;
- moved into a build path without stronger exact RETUS evidence.

## Why this bucket is different

Radio/security entries are materially different from WFD drift or camera
permissions/config uncertainty.

These entries may affect:

- cellular registration;
- modem/RIL behavior;
- IMS and VoLTE behavior;
- emergency calling behavior;
- carrier provisioning;
- SIM/eSIM or LPA behavior;
- trusted execution behavior;
- key storage or attestation behavior;
- boot/runtime stability;
- security boundary behavior.

Because of that risk, the project must treat this bucket as a hard stop until a
separate, stronger evidence process is completed.

## Evidence standard required

To move any entry out of the hard-block bucket, at least one of the following
must be true.

### Standard A: exact RETUS direct evidence

The exact expected path is found in exact RETUS extracted evidence.

Required evidence:

- exact source image or partition;
- exact path;
- file size;
- hash;
- inventory artifact reference;
- confirmation that the artifact came from exact RETUS
  `RPFS31.Q1-21-20-1-7-3 / 37074e`.

### Standard B: exact RETUS path-normalized evidence

The expected entry is proven to exist under a normalized path or partition shift
within exact RETUS.

Required evidence:

- old expected source-list path;
- observed exact RETUS path;
- explanation of path normalization;
- source partition;
- hash or inventory proof;
- risk assessment.

### Standard C: exact RETUS version/equivalence evidence

The expected entry is absent, but an exact RETUS version-equivalent entry exists
and can be justified.

Required evidence:

- expected version/interface;
- observed exact RETUS version/interface;
- neighboring files;
- compatibility rationale;
- reason this is not a radio/security regression risk;
- explicit human approval.

### Standard D: source-list drift evidence plus non-use proof

The expected entry is proven to be inherited source-list drift and not required
for this target.

Required evidence:

- source-list provenance;
- donor-device or donor-build identification;
- exact RETUS absence;
- build or dependency evidence showing non-use;
- explicit human approval.

This standard is intentionally difficult for radio/security entries.

## Evidence that is not sufficient

The following are not sufficient to move a radio/security entry:

- RETBR has a similar file;
- another SM6150 device has the file;
- the parent directory exists;
- token-related filenames exist;
- a similar version exists without compatibility analysis;
- the file seems optional;
- the build has not yet failed;
- WFD drift was accepted as a proposal;
- non-radio buckets have proposal coverage.

## Required local-only review artifacts

A future radio/security evidence review may create local-only artifacts under:

- `C:\Projects\moto-one-hyper-local\audits`
- `C:\Projects\moto-one-hyper-local\checksums`
- `C:\Projects\moto-one-hyper-local\extracted`

Those artifacts must remain local-only unless they are sanitized into committed
report-safe summaries.

Do not commit:

- raw proprietary blobs;
- extracted partition images;
- raw firmware contents;
- raw CSVs containing blob-level paths beyond report-safe summaries;
- helper scripts generated for one-off local review;
- transcripts containing sensitive or noisy local paths beyond necessary evidence.

## Proposed review sequence

A future radio/security evidence process should proceed in this order.

### Step 1: isolate the 30 entries

Create a local-only CSV containing only entries where:

- `decision_posture == do-not-waive`

The CSV should include:

- tree;
- line number;
- raw source-list line;
- normalized path;
- partition family;
- residual family;
- risk;
- reason.

### Step 2: classify into subfamilies

Split the 30 entries into subfamilies such as:

- radio / RIL / QCRIL;
- IMS / VoLTE;
- LPA / SIM / eSIM;
- keymaster / gatekeeper;
- QSEE / trusted execution;
- firmware/security-adjacent configs;
- unknown but sensitive.

### Step 3: exact RETUS focused search

For each subfamily, search exact RETUS inventories for:

- exact basename hits;
- version-related hits;
- partition-shifted hits;
- same-parent hits;
- known interface/HAL neighbors;
- init/manifest/compatibility matrix references.

### Step 4: produce a committed summary

Produce a report-safe committed summary that includes:

- counts by subfamily;
- evidence found;
- evidence absent;
- entries that remain hard blocked;
- entries eligible for manual review;
- entries still needing deeper exact RETUS search.

### Step 5: no edit without approval

Even after a focused report, no source-list edit is allowed unless a separate
approval marker exists.

## Required approval markers

For any future radio/security movement, one of the following explicit markers
must appear in a committed approval report.

For annotation-only:

- `APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_ANNOTATION_ONLY`

For path adjustment:

- `APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_PATH_ADJUSTMENT`

For removal:

- `APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_REMOVAL`

For waiver:

- `APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_WAIVER`

Removal and waiver should be treated as exceptional and unsafe by default.

Any approval marker must include:

- exact source-list file;
- exact line or entry;
- old expected path;
- proposed change;
- supporting evidence;
- rollback plan;
- explicit confirmation that no blob import or build is authorized by the edit;
- human approval.

## Default decision

Default decision for all 30 entries:

- remain blocked;
- remain do-not-waive;
- remain unresolved;
- remain excluded from source-list proposal edits;
- remain excluded from blob import/build use.

## Relationship to other proposal reports

The existence of non-radio proposal reports does not weaken the radio/security
hard block.

The following proposal reports are bounded to their own buckets:

- WFD proposal: WFD only;
- probable version-shift proposal: 2 entries only;
- same-directory vendor variant proposal: 12 entries only;
- camera permissions/config proposal: 1 entry only.

None of those reports authorizes radio/security movement.

## Still blocked

The following remain blocked:

- radio/security source-list edits;
- radio/security waivers;
- radio/security removals;
- radio/security path substitutions;
- RETBR substitution;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb;
- fastboot;
- LMSA/RSA rescue or repair;
- flashing;
- bootloader unlock/relock;
- wipe/erase operations.

## Operator conclusion

The 30 radio/security-sensitive entries are the remaining hard unresolved block.

The correct next action is not editing.

The correct next action is a focused local-only radio/security evidence review
that produces a sanitized committed summary.

Until that exists, all 30 entries remain do-not-waive.
