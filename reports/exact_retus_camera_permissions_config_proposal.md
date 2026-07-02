# Exact RETUS Camera Permissions / Config Proposal

Status: proposal only; no source-list edits applied

## Scope

This report proposes the future review posture for the single camera-related
entry classified as:

- `camera-related-token-review`

during the exact RETUS camera inventory review.

This proposal concerns only this entry:

- `system_ext/etc/permissions/com.motorola.androidx.camera.extensions.xml`

This proposal does not concern:

- WFD / Wi-Fi Display / HDCP;
- probable version-shift entries;
- same-directory vendor variants;
- radio / IMS / QCRIL hard blockers;
- keymaster / gatekeeper / QSEE hard blockers;
- unrelated vendor XML/config entries.

This is a proposal report only.

This is not a source-list edit.

This is not a waiver.

This is not blob import authorization.

This is not generated vendor tree authorization.

This is not build authorization.

## Supporting evidence

This proposal depends on the committed exact RETUS evidence chain:

- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`
- `reports/exact_retus_camera_inventory_review.md`
- `reports/exact_retus_unresolved_status_rollup.md`

Local-only evidence source:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_camera_inventory_review_20260702.csv`
- `C:\Projects\moto-one-hyper-local\audits\exact_retus_camera_inventory_review_summary_20260702.txt`

The local-only CSV and summary must not be committed.

## Entry under proposal

| Tree | Line | Expected path | Review posture | Risk |
|---|---:|---|---|---|
| `sm6150-common` | `526` | `system_ext/etc/permissions/com.motorola.androidx.camera.extensions.xml` | `camera-related-token-review` | `high` |

## Evidence summary

The camera inventory review found:

| Evidence type | Count |
|---|---:|
| Exact basename hits | `0` |
| Same-parent hits | `0` |
| Camera path hits | `143` |
| Token-related hits | `467` |
| Deep exact hits | `0` |
| Unresolved deep exact hits | `0` |
| Deep camera hits | `71` |

## Interpretation

The expected exact camera extension permissions XML was not observed:

- `system_ext/etc/permissions/com.motorola.androidx.camera.extensions.xml`

The targeted exact RETUS review did not find:

- an exact basename hit;
- a same-parent-directory hit;
- deeper exact path evidence.

However, exact RETUS camera-stack evidence is present:

- camera-related observed paths exist;
- deeper camera inventory evidence exists;
- token-related camera evidence exists.

This supports the following interpretation:

- the exact RETUS camera stack is not absent;
- this is not a missing camera extraction case;
- this is a specific camera extension permissions/config expectation that was not
  matched in the current exact RETUS evidence;
- the entry remains high risk because permissions/config XML can affect framework
  feature exposure, package permissions, and camera extension behavior.

## Proposal

The proposed future handling is:

1. keep the entry blocked for now;
2. do not waive the entry;
3. do not remove the entry;
4. perform a manual camera permissions/config review;
5. determine whether exact RETUS exposes equivalent camera extension permissions
   elsewhere;
6. determine whether the source-list expectation is inherited common-tree drift;
7. require explicit approval before any source-list edit.

## Recommended future review questions

A future manual review should answer:

1. Does exact `def_retail` RETUS include an equivalent camera extension permissions
   XML under a different path?
2. Does exact `def_retail` RETUS expose Motorola camera extension behavior through
   another framework, product, vendor, or system_ext config file?
3. Is `com.motorola.androidx.camera.extensions.xml` inherited from a broader
   common-tree expectation rather than this exact target?
4. Would leaving the entry absent break build-time permissions packaging?
5. Would adding or changing the entry create false feature exposure?
6. Does the entry need to remain blocked until build evidence exists?

## Recommended future decision options

A future human-approved decision should choose exactly one option.

### Option A: retain current expected path

Keep the source-list expectation unchanged.

Use this if the build system or inherited tree requires the permission XML despite
absence from current exact RETUS targeted evidence.

### Option B: annotation only

Add a comment noting that exact RETUS camera stack evidence is present, but the
specific camera extension permission XML was not observed.

This is the recommended first edit if any edit is later approved.

### Option C: move to pending/manual camera review section

Keep the entry visible but clearly mark it as pending manual camera
permissions/config review, if the source-list format and project policy support
that treatment.

### Option D: remove the entry

This option is not recommended now.

Removal would require stronger evidence that the exact target does not need this
permission/config entry and that removal will not create build/runtime regressions.

## Recommended option

Recommended next step:

- Option B: annotation only, pending manual camera permissions/config review.

Rationale:

- exact camera-stack evidence exists;
- the specific expected XML is absent;
- permissions/config XML can affect behavior;
- source-list changes are not yet justified;
- annotation preserves the uncertainty without claiming safety.

## Required approval gate before editing

Before any source-list edit, a separate approval marker must exist in a committed
report or work item.

For annotation-only, the approval marker must state:

- `APPROVED_FOR_SOURCE_LIST_EDIT: CAMERA_PERMISSION_ANNOTATION_ONLY`

For removal or path adjustment, the approval marker must state one of:

- `APPROVED_FOR_SOURCE_LIST_EDIT: CAMERA_PERMISSION_PATH_ADJUSTMENT`
- `APPROVED_FOR_SOURCE_LIST_EDIT: CAMERA_PERMISSION_REMOVAL`

The approval marker must include:

- the exact file to edit;
- the exact source-list entry to edit;
- the old expected path;
- the proposed annotation, replacement, or removal;
- the evidence reports supporting the change;
- the rollback plan;
- confirmation that no blob import or build is authorized.

Without that marker, no source-list edit is authorized.

## Candidate annotation text

If annotation-only is approved later, candidate text could be:

    # Exact RETUS def_retail review note:
    # Camera stack evidence is present, but exact Motorola One Hyper def_retail
    # RETUS RPFS31.Q1-21-20-1-7-3 did not directly match this specific
    # camera extension permissions XML in current targeted inventories.
    # Keep pending manual permissions/config review before path adjustment or removal.

This proposed text is not applied by this report.

## Rollback plan for a future annotation edit

If a future annotation-only edit is approved and applied, rollback is:

1. remove only the added annotation lines;
2. leave the original source-list entry unchanged;
3. rerun validation;
4. commit the rollback with a message referencing camera permission annotation rollback.

## Explicit non-goals

This proposal does not claim the camera extension permission XML is unnecessary.

This proposal does not claim the camera extension permission XML is equivalent to
another observed file.

This proposal does not authorize changing the path.

This proposal does not authorize removing the path.

This proposal does not authorize adding replacement paths.

This proposal does not authorize waiving the entry.

This proposal does not authorize blob import or build use.

This proposal does not reduce the radio/security do-not-waive block.

## Current decision

The camera permissions/config entry remains:

- unresolved;
- high risk;
- camera-related token review candidate;
- blocked from removal;
- blocked from waiver;
- blocked from source-list edit;
- blocked from blob import/build use.

## Still blocked

The following remain blocked:

- source-list edits without explicit approval marker;
- camera permission path adjustment;
- camera permission waiver;
- camera permission removal;
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

The camera permissions/config singleton is ready for manual review planning.

It is not ready for source-list edits.

No edit is authorized by this report.
