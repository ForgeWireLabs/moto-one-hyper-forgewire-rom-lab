# Exact RETUS WFD Source-List Proposal

Status: proposal only; no source-list edits applied

## Scope

This report proposes a future gated treatment for the WFD / Wi-Fi Display / HDCP
source-list block after exact RETUS evidence review.

This proposal concerns only the WFD / Wi-Fi Display / HDCP block.

This proposal does not concern:

- radio;
- IMS;
- QCRIL;
- LPA;
- keymaster;
- gatekeeper;
- QSEE;
- camera permissions/config;
- CNE/data/DPM entries;
- Bluetooth audio version shifts;
- display/graphics config shifts;
- unrelated vendor XML/config entries.

This is a proposal report only.

This is not a source-list edit.

This is not a waiver.

This is not blob import authorization.

This is not generated vendor tree authorization.

This is not build authorization.

## Supporting evidence

This proposal depends on the committed exact RETUS evidence chain:

- `reports/exact_retus_artifact_verification.md`
- `reports/exact_retus_super_reconstruction_summary.md`
- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`
- `reports/exact_retus_wfd_wifi_display_hdcp_drift_review.md`
- `reports/exact_retus_wfd_source_provenance_review.md`
- `reports/exact_retus_wfd_source_list_decision_report.md`
- `reports/exact_retus_unresolved_status_rollup.md`

## Current WFD bucket

The WFD / Wi-Fi Display / HDCP unresolved bucket contains:

| Metric | Count |
|---|---:|
| Entries | 69 |
| Source tree | sm6150-common only |
| def-specific entries | 0 |
| system_ext entries | 37 |
| vendor entries | 32 |
| Current review posture | source-list-drift-candidate |

## Provenance finding

The WFD block is inherited from `sm6150-common`.

The source-list provenance review found that the block is explicitly labeled in
the source list as:

- `WiFi Display - from Motorola Edge S - RRN31.Q1-20-31-3`

The exact RETUS target for this lab is:

- Motorola One Hyper / `def_retail` / `RPFS31.Q1-21-20-1-7-3` / `37074e`

No evidence has been found that the WFD block was validated against exact
Motorola One Hyper `def_retail` RETUS.

## Problem statement

The current source list expects a coherent WFD / Wi-Fi Display / HDCP block that
does not directly match exact RETUS observed inventories.

Because the block appears inherited from a different Motorola SM6150-family
device source, keeping it unqualified creates ambiguity:

- it looks like exact RETUS is missing 69 WFD-related files;
- it obscures the stronger hard blockers such as radio/security entries;
- it makes future extraction/import planning harder;
- it risks treating Edge S-derived common-tree expectations as def_retail facts.

At the same time, silent removal would be too aggressive because:

- WFD and HDCP can affect display, media, protected-content, and casting behavior;
- the project has not attempted a build;
- the project has not performed runtime validation;
- the project has not proven that all WFD functionality is absent or irrelevant;
- source-list edits should remain gated.

## Proposal

The proposed future source-list treatment is:

1. keep the WFD block visible;
2. annotate the block as inherited Edge S common-tree drift;
3. prevent it from being treated as exact def_retail RETUS evidence;
4. keep all WFD entries blocked from import/build use until a human approval gate;
5. defer removal, optionalization, or split handling to a separate approved edit.

Preferred future edit style:

- annotation-first;
- no silent deletion;
- no waiver language that implies the entries are known unnecessary;
- no import/build authority;
- no effect on radio/security blocks.

## Proposed source-list handling options

A future human-approved edit should choose exactly one of these options.

### Option A: annotation only

Add a comment above the WFD block explaining:

- the block is inherited from `sm6150-common`;
- the block is labeled as sourced from Motorola Edge S `RRN31.Q1-20-31-3`;
- exact `def_retail` RETUS did not directly match the expected WFD paths;
- the block remains pending future build/runtime evidence.

This is the safest first edit because it preserves history and avoids changing
extraction behavior until a later gate.

### Option B: annotate and mark as optional/deferred

Add a comment and move the block behind an explicit optional/deferred convention
if the upstream source-list format supports it.

This is only acceptable if the convention is already used in the source tree or
the repo has a documented rule for optional entries.

### Option C: split into def_retail pending block

Separate the WFD block into a clearly labeled pending section for inherited
common-tree WFD expectations that do not yet have exact def_retail evidence.

This is acceptable if the source list can preserve the entries without treating
them as required exact RETUS imports.

### Option D: remove the block

Remove the block only after a stronger gate.

This option is not currently recommended.

Removal would require a separate human approval marker and a rollback note.

## Recommended option

Recommended next edit, if approved later:

- Option A: annotation only

Rationale:

- it is conservative;
- it preserves the inherited source-list history;
- it does not pretend WFD is unnecessary;
- it prevents future agents from mistaking Edge S provenance for exact RETUS evidence;
- it does not alter extraction/build behavior yet;
- it keeps the repo aligned with evidence-gated work.

## Required approval gate before editing

Before any source-list edit, a separate approval marker must exist in a committed
report or work item.

The approval marker must state:

- `APPROVED_FOR_SOURCE_LIST_EDIT: WFD_ANNOTATION_ONLY`

The approval marker must also include:

- the exact file to edit;
- the exact section to annotate;
- the intended edit mode;
- rollback instructions;
- confirmation that no blob import or build is authorized.

Without that marker, no source-list edit is authorized.

## Proposed edit target

Expected future edit target:

- source tree: `C:\Projects\moto-one-hyper-local\sources\lineage20_android_device_motorola_sm6150-common`
- file: `proprietary-files.txt`
- section: `WiFi Display - from Motorola Edge S - RRN31.Q1-20-31-3`

The source tree is local-only. Any upstream/local source edit must be handled
separately from this public report repo.

## Proposed annotation text

If the annotation-only gate is approved later, the candidate annotation should be
similar to:

    # Exact RETUS def_retail review note:
    # This WFD / Wi-Fi Display block is inherited from sm6150-common and is
    # labeled as sourced from Motorola Edge S - RRN31.Q1-20-31-3.
    # Exact Motorola One Hyper def_retail RETUS RPFS31.Q1-21-20-1-7-3 did not
    # directly match these expected paths during Route A inventory review.
    # Keep pending until a separate build/runtime or source-list approval gate.

This proposed text is not applied by this report.

## Rollback plan for a future annotation edit

If a future annotation-only edit is approved and applied, rollback is simple:

1. remove only the added annotation lines;
2. leave the original WFD entries unchanged;
3. rerun local validation;
4. commit the rollback with a message referencing WFD annotation rollback.

No blob artifacts should be involved in the rollback.

## Explicit non-goals

This proposal does not attempt to decide whether WFD functionality should work
in a future ROM.

This proposal does not claim that WFD is absent from the stock device.

This proposal does not claim that WFD is unnecessary.

This proposal does not claim that HDCP/protected-content behavior is safe to
ignore.

This proposal does not modify any source list.

This proposal does not reduce the 30 radio/security do-not-waive hard block.

## Current decision

The WFD block remains:

- unresolved;
- source-list drift candidate;
- inherited common-tree evidence;
- eligible for future annotation-only source-list edit after approval;
- blocked from removal;
- blocked from waiver;
- blocked from blob import/build use.

## Still blocked

The following remain blocked:

- source-list edits without explicit approval marker;
- WFD removal;
- WFD optionalization without a separate approval marker;
- WFD waiver;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- RETBR substitution;
- device interaction;
- adb;
- fastboot;
- LMSA/RSA rescue or repair;
- flashing;
- bootloader unlock/relock;
- wipe/erase operations.

## Operator conclusion

The WFD source-list proposal is ready for human review.

The recommended future action is annotation-only, not removal.

No edit is authorized by this report.

The next committed step, if the operator wants to proceed, should be an explicit
approval report or work item containing:

- `APPROVED_FOR_SOURCE_LIST_EDIT: WFD_ANNOTATION_ONLY`
