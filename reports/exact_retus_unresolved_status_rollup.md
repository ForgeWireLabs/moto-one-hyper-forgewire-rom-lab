# Exact RETUS Unresolved Status Rollup

Status: operator-facing rollup; no source-list edits or waivers authorized

## Scope

This report summarizes the current status of all unresolved exact RETUS
proprietary-file entries after Route A firmware verification, super
reconstruction, line coverage, unresolved classification, drift review, source
provenance review, and focused follow-up reviews.

This is a status rollup only.

This is not a source-list edit.

This is not a waiver.

This is not blob import authorization.

This is not generated vendor tree authorization.

This is not build authorization.

## Target firmware authority

The current authority target is exact RETUS firmware for Motorola One Hyper:

| Field | Value |
|---|---|
| Device | Motorola One Hyper |
| Model | XT2027-1 |
| Product/codename | def / def_retail |
| Channel | RETUS / Retail US |
| Android | 11 |
| Build | RPFS31.Q1-21-20-1-7-3 |
| Build tag | 37074e |
| System version | 30.201.3.def_retail.retail.en.US |
| Fingerprint | motorola/def_retail/def:11/RPFS31.Q1-21-20-1-7-3/37074e:user/release-keys |

RETBR remains comparison-only evidence and is not import authority.

## Committed evidence chain

Current committed evidence chain:

| Commit | Report / purpose |
|---|---|
| 6573543 | Verify exact RETUS firmware artifact |
| 66de47f | Document exact RETUS super reconstruction |
| 7f17953 | Document exact RETUS line coverage |
| 3d0dde6 | Classify exact RETUS unresolved entries |
| 954404f | Review exact RETUS WFD drift block |
| 1625df7 | Document WFD source-list provenance |
| eb6b65a | Record WFD source-list decision posture |
| 4af9c2b | Review exact RETUS deeper vendor entries |
| f960c2e | Review exact RETUS renamed version shifts |
| ed71d0a | Review exact RETUS camera inventory entry |

## Supporting committed reports

This rollup summarizes:

- `reports/exact_retus_artifact_verification.md`
- `reports/exact_retus_super_reconstruction_summary.md`
- `reports/exact_retus_line_coverage_result.md`
- `reports/exact_retus_unresolved_classification_report.md`
- `reports/exact_retus_wfd_wifi_display_hdcp_drift_review.md`
- `reports/exact_retus_wfd_source_provenance_review.md`
- `reports/exact_retus_wfd_source_list_decision_report.md`
- `reports/exact_retus_deeper_vendor_review.md`
- `reports/exact_retus_renamed_version_shifted_review.md`
- `reports/exact_retus_camera_inventory_review.md`

## Exact RETUS coverage baseline

Adjusted exact RETUS coverage:

| Metric | Count |
|---|---:|
| Active expected proprietary entries | 1,213 |
| Direct vendor matches | 957 |
| Direct non-vendor matches | 133 |
| Combined direct matches | 1,090 |
| Remaining active unresolved entries | 123 |
| Disabled/optional entries | 32 |
| Coverage over active expected entries | 89.8599% |

## Current unresolved map

All `123` unresolved exact RETUS entries now have a documented review posture.

| Bucket | Count | Current posture |
|---|---:|---|
| WFD / Wi-Fi Display / HDCP | 69 | source-list drift candidate; provenance and decision posture documented |
| Deeper vendor entries | 12 | same-directory variant review documented |
| Renamed/version-shifted entries | 11 | equivalence review split into probable version shift, possible rename/stack shift, and same-directory absence |
| Camera entry | 1 | camera-related token review documented |
| Radio/security-sensitive entries | 30 | do-not-waive hard block |

## WFD / Wi-Fi Display / HDCP status

Count:

| Metric | Count |
|---|---:|
| Entries | 69 |
| Tree | sm6150-common only |
| def-specific entries | 0 |
| system_ext entries | 37 |
| vendor entries | 32 |

Current posture:

- `source-list-drift-candidate`

Evidence summary:

- the entire WFD block is inherited from `sm6150-common`;
- the source list labels the block as from `Motorola Edge S - RRN31.Q1-20-31-3`;
- no evidence has been found that the WFD block was validated against exact `def_retail` RETUS;
- exact RETUS did not directly match the expected WFD paths;
- the block is coherent inherited common-tree drift, not scattered random missing firmware.

Decision:

- eligible for a future gated source-list proposal;
- no edit authorized yet;
- no waiver authorized yet;
- no blob import/build use authorized.

Recommended next action for this bucket:

- create a separate WFD source-list proposal report before any source-list change;
- prefer annotation/split handling over silent removal;
- require explicit human approval before edits.

## Deeper vendor entries status

Count:

| Metric | Count |
|---|---:|
| Entries | 12 |
| Tree | sm6150-common only |
| Risk | high |
| Review posture | same-directory-variant-review |

Family split:

| Family | Count |
|---|---:|
| uncategorized_vendor | 7 |
| data_dpm | 5 |

Evidence summary:

- no exact basename matches were found;
- all 12 entries had same-parent-directory evidence in exact RETUS vendor inventories;
- relevant vendor directories are present and heavily populated;
- this supports variant/version drift rather than missing-directory or failed-extraction evidence.

Decision:

- reclassified from `exact-retus-needed-deeper-vendor-review` to `same-directory-variant-review`;
- risk remains high;
- no removal authorized;
- no waiver authorized;
- no source-list edit authorized.

Recommended next action for this bucket:

- create a focused same-directory variant/equivalence review;
- inspect nearby exact RETUS vendor observed files;
- determine whether each expected interface is absent, version-shifted, inherited drift, or build-critical.

## Renamed/version-shifted entries status

Count:

| Metric | Count |
|---|---:|
| Entries | 11 |
| Partition | vendor |
| def entries | 4 |
| sm6150-common entries | 7 |

Equivalence posture split:

| Review posture | Count | Current decision |
|---|---:|---|
| probable-version-shift | 2 | eligible for future narrow equivalence proposal |
| possible-rename-or-stack-shift | 7 | requires manual equivalence review |
| same-directory-absence | 2 | remains blocked |

Risk split:

| Risk | Count |
|---|---:|
| medium | 2 |
| high | 9 |

Family split:

| Family | Count |
|---|---:|
| manifest_permissions_config | 4 |
| qti_data_cne_latency | 3 |
| bluetooth_audio | 2 |
| display_graphics | 2 |

Decision:

- no entry approved for removal;
- no entry approved for waiver;
- no source-list edit authorized;
- the two probable version shifts may receive a future narrow equivalence proposal;
- the seven possible rename/stack-shift entries require deeper manual review;
- the two same-directory absences remain blocked.

Recommended next action for this bucket:

- create a narrow equivalence proposal only for the two probable version-shift entries;
- leave the seven possible rename/stack-shift entries and two same-directory absences blocked.

## Camera entry status

Entry:

| Tree | Line | Expected path |
|---|---:|---|
| sm6150-common | 526 | system_ext/etc/permissions/com.motorola.androidx.camera.extensions.xml |

Evidence counters:

| Evidence type | Count |
|---|---:|
| Exact basename hits | 0 |
| Same-parent hits | 0 |
| Camera path hits | 143 |
| Token-related hits | 467 |
| Deep exact hits | 0 |
| Unresolved deep exact hits | 0 |
| Deep camera hits | 71 |

Current posture:

- `camera-related-token-review`

Decision:

- the exact expected permission/config XML is absent from current exact RETUS targeted evidence;
- the exact RETUS camera stack is present;
- this is not a missing camera stack or missing extraction case;
- the entry remains high risk because permission/config XML can affect framework feature exposure and camera extension behavior;
- no removal authorized;
- no waiver authorized;
- no source-list edit authorized.

Recommended next action for this bucket:

- keep blocked until future manual camera permissions/config review.

## Radio/security-sensitive hard block

Count:

| Bucket | Count |
|---|---:|
| Radio / IMS / QCRIL / keymaster-sensitive entries | 30 |

Current posture:

- `do-not-waive`

Risk:

- critical/high

Decision:

- this bucket remains the hard unresolved block;
- do not waive;
- do not remove;
- do not substitute from RETBR;
- do not import/build around it without stronger exact RETUS evidence.

Rationale:

Radio, IMS, QCRIL, LPA, keymaster, gatekeeper, QSEE, and related vendor/security
surfaces can affect:

- cellular behavior;
- carrier compatibility;
- IMS/VoLTE behavior;
- emergency or provisioning behavior;
- trusted execution/security behavior;
- boot/runtime stability.

This bucket must remain blocked until a separate exact RETUS radio/security
evidence process is defined.

## What is now closed

The following work is complete as evidence classification:

- exact RETUS firmware artifact verification;
- exact RETUS super reconstruction;
- exact RETUS logical image carve summary;
- exact RETUS adjusted line coverage;
- full unresolved classification of 123 entries;
- WFD drift review;
- WFD source provenance review;
- WFD source-list decision posture;
- deeper vendor 12-entry review;
- renamed/version-shifted 11-entry review;
- camera singleton review.

## What is still not allowed

The following remain blocked:

- source-list edits;
- source-list waivers;
- WFD removal;
- WFD optionalization;
- WFD annotation edits;
- version-shift source-list edits;
- camera source-list edits;
- radio/security source-list edits;
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

## Safe next steps

The safe next steps are report/proposal work only:

1. create a WFD source-list proposal report;
2. create a narrow two-entry probable-version-shift equivalence proposal;
3. create a same-directory variant review proposal for the 12 deeper vendor entries;
4. create a manual camera permissions/config review proposal;
5. define a separate radio/security evidence plan for the 30 do-not-waive entries.

No source-list proposal should be applied without a separate human approval gate.

## Operator conclusion

The exact RETUS unresolved surface is now mapped.

The project has moved from broad uncertainty to bounded decision posture:

- WFD is inherited common-tree drift candidate, but still gated;
- 12 vendor entries are same-directory variants, but still high-risk;
- 11 renamed/version-shifted entries are split by evidence strength;
- 1 camera entry is a missing permission/config expectation with camera stack present;
- 30 radio/security entries remain the hard do-not-waive block.

The repo is ready for proposal reports.

The repo is not ready for source-list edits, blob import, generated vendor trees,
Lineage builds, or device interaction.
