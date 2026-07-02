# Exact RETUS Radio/Security Resolution Policy

## Scope

This policy defines how the remaining exact RETUS radio/security-sensitive unresolved entries may be evaluated in future work.

It is based on the evidence classification recorded in:

- `reports/exact_retus_radio_security_evidence_plan.md`
- `reports/exact_retus_radio_security_final_evidence_reduction.md`

This policy does not apply source-list edits. It defines decision gates only.

## Authority Boundary

Exact RETUS remains the authority target:

- Device: Motorola One Hyper XT2027-1
- Channel: RETUS / Retail US
- Build: RPFS31.Q1-21-20-1-7-3
- Build tag: 37074e
- System version: 30.201.3.def_retail.retail.en.US

RETBR and other device/channel trees may be used only as comparison evidence. They are not import authority and do not justify source-list acceptance.

## Global Prohibitions

The following remain prohibited:

- no silent waivers
- no RETBR substitution
- no alternate-device substitution
- no blob import from unverified sources
- no generated vendor tree
- no build attempt using unresolved radio/security entries
- no source-list edits without an explicit approval marker
- no device interaction
- no adb
- no fastboot
- no flashing
- no erase/wipe operations

## Current Final Evidence Classes

The remaining 30 hard-blocked entries are classified as:

| Evidence class | Count |
|---|---:|
| exact-retus-qcril-sequence-absent-after-23 | 13 |
| uce-service-version-ahead-of-exact-retus | 4 |
| ims-rcs-framework-broad-token-only | 4 |
| uimgba-product-to-system_ext-location-shift-candidate | 4 |
| radio-ims-version-ahead-of-exact-retus | 3 |
| keymaster-4.1-init-rc-absent-with-4.1-service-present | 1 |
| ims-factory-vendor64-to-system_ext-location-shift-candidate | 1 |

All 30 remain hard-blocked unless moved by a future evidence-backed proposal.

## Resolution States

| State | Meaning |
|---|---|
| `remain-hard-blocked` | No safe resolution yet. Keep unresolved and do not waive. |
| `annotation-only-candidate` | Source list may later receive a non-functional comment explaining exact RETUS evidence. |
| `path-adjustment-candidate` | A future source-list path change may be considered after partition/path impact review. |
| `version-equivalence-candidate` | A future equivalence claim may be considered after ABI/build compatibility review. |
| `source-list-drift-candidate` | Evidence suggests inherited common-tree drift relative to exact RETUS. |
| `non-use-candidate` | Entry may be removable only if build/runtime evidence proves non-use for exact RETUS. |
| `resolved-by-exact-retus-evidence` | Exact expected path is observed in exact RETUS evidence. |

None of the current 30 entries are `resolved-by-exact-retus-evidence`.

## Required Approval Markers

Any future source-list-affecting work must include one of these explicit markers in the relevant proposal before edits are made:

- `APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_ANNOTATION_ONLY`
- `APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_PATH_ADJUSTMENT`
- `APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_VERSION_EQUIVALENCE`
- `APPROVED_FOR_SOURCE_LIST_EDIT: RADIO_SECURITY_REMOVAL_AFTER_NON_USE_PROOF`

Without one of these markers, no source-list edit is authorized.

## Class Policies

### exact-retus-qcril-sequence-absent-after-23

Affected entries:

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

Current evidence:

- exact RETUS contains `qcril.db`
- exact RETUS contains `0_initial.sql`
- exact RETUS contains qcrildb upgrade versions `3` through `23`
- expected source-list entries begin at `24` and continue beyond the observed exact RETUS sequence

Allowed future states:

- `annotation-only-candidate`
- `source-list-drift-candidate`
- `non-use-candidate`

Required evidence before any removal proposal:

1. exact RETUS inventory proof that versions 24+ are absent from the authority firmware
2. source-tree provenance showing why the common tree expects versions 24+
3. build-system reference check showing whether these SQL files are directly required
4. runtime or build rationale explaining why exact RETUS can safely stop at version 23
5. explicit non-use proof if removal is proposed

Default posture:

- `remain-hard-blocked`

### uce-service-version-ahead-of-exact-retus

Affected entries:

- `system_ext/lib/com.qualcomm.qti.uceservice@2.3.so`
- `system_ext/lib64/com.qualcomm.qti.uceservice@2.3.so`
- `vendor/lib/com.qualcomm.qti.uceservice@2.3.so`
- `vendor/lib64/com.qualcomm.qti.uceservice@2.3.so`

Current evidence:

- exact RETUS contains UCE service versions `2.0`, `2.1`, and `2.2`
- expected source-list entries ask for `2.3`
- `2.3` was not observed in exact RETUS inventory evidence

Allowed future states:

- `annotation-only-candidate`
- `version-equivalence-candidate`
- `source-list-drift-candidate`
- `non-use-candidate`

Required evidence before version-equivalence proposal:

1. exact RETUS observed library set by partition and architecture
2. source-list provenance for the `2.3` expectation
3. ABI surface comparison or strong build compatibility rationale
4. dependency/reference scan for consumers expecting `2.3`
5. explicit statement that equivalence is a proposal, not established fact

Default posture:

- `remain-hard-blocked`

### radio-ims-version-ahead-of-exact-retus

Affected entries:

- `system_ext/lib/vendor.qti.hardware.radio.ims@1.7.so`
- `system_ext/lib64/vendor.qti.hardware.radio.ims@1.7.so`
- `vendor/lib64/vendor.qti.hardware.radio.ims@1.7.so`

Current evidence:

- exact RETUS contains radio IMS versions `1.0` through `1.6`
- expected source-list entries ask for `1.7`
- `1.7` was not observed in exact RETUS inventory evidence

Allowed future states:

- `annotation-only-candidate`
- `version-equivalence-candidate`
- `source-list-drift-candidate`
- `non-use-candidate`

Required evidence before version-equivalence proposal:

1. exact RETUS observed radio IMS library set by partition and architecture
2. source-list provenance for the `1.7` expectation
3. manifest/VINTF/init/reference review for expected IMS HAL version
4. ABI/build compatibility review
5. carrier/RETUS-specific risk note
6. explicit statement that no runtime telephony behavior has been validated by this evidence-only phase

Default posture:

- `remain-hard-blocked`

### uimgba-product-to-system_ext-location-shift-candidate

Affected entries:

- `product/etc/permissions/UimGba.xml`
- `product/etc/permissions/UimGbaManager.xml`
- `product/framework/uimgbalibrary.jar`
- `product/framework/uimgbamanagerlibrary.jar`

Current evidence:

- expected basenames appear in exact RETUS `system_ext`
- expected product paths were not observed

Allowed future states:

- `annotation-only-candidate`
- `path-adjustment-candidate`
- `source-list-drift-candidate`

Required evidence before path-adjustment proposal:

1. exact observed system_ext path evidence
2. confirmation that expected product path is absent
3. source-list provenance for product-path expectation
4. build configuration review for where these artifacts are consumed
5. partition ownership impact note
6. explicit statement that the proposal is path adjustment, not waiver

Default posture:

- `remain-hard-blocked`

### ims-factory-vendor64-to-system_ext-location-shift-candidate

Affected entry:

- `vendor/lib64/vendor.qti.ims.factory@1.1.so`

Current evidence:

- basename appears in exact RETUS `system_ext/lib`
- basename appears in exact RETUS `system_ext/lib64`
- expected `vendor/lib64` path was not observed

Allowed future states:

- `annotation-only-candidate`
- `path-adjustment-candidate`
- `source-list-drift-candidate`
- `version-equivalence-candidate`

Required evidence before path-adjustment proposal:

1. exact observed system_ext lib/lib64 path evidence
2. confirmation that expected vendor/lib64 path is absent
3. source-list provenance for vendor/lib64 expectation
4. dependency/reference review for library load path
5. partition boundary impact note
6. ABI/build compatibility note

Default posture:

- `remain-hard-blocked`

### ims-rcs-framework-broad-token-only

Affected entries:

- `system_ext/etc/permissions/vendor.qti.ims.rcsservice.xml`
- `system_ext/framework/vendor.qti.ims.connection-V1.0-java.jar`
- `system_ext/framework/vendor.qti.ims.rcssip-V1.0-java.jar`
- `system_ext/framework/vendor.qti.ims.rcsuce-V1.0-java.jar`

Current evidence:

- exact RETUS has broad IMS/RCS token evidence
- no basename hit was found for these expected framework/config entries

Allowed future states:

- `annotation-only-candidate`
- `source-list-drift-candidate`
- `non-use-candidate`

Required evidence before any source-list change:

1. deeper exact RETUS framework/config inventory review
2. source-list provenance for the expected IMS/RCS framework entries
3. build/reference scan for these Java/framework/config artifacts
4. determination whether absence is expected for exact RETUS, an extraction gap, or source-list drift
5. explicit non-use proof if removal is proposed

Default posture:

- `remain-hard-blocked`

### keymaster-4.1-init-rc-absent-with-4.1-service-present

Affected entry:

- `vendor/etc/init/android.hardware.keymaster@4.1-service-qti.rc`

Current evidence:

- exact RETUS contains keymaster 4.1 service binary
- exact RETUS contains system keymaster 4.1 libraries
- exact RETUS inventory showed keymaster 4.0 init rc
- expected keymaster 4.1 init rc was not observed

Allowed future states:

- `annotation-only-candidate`
- `source-list-drift-candidate`

This entry remains the most sensitive single entry in the bucket because it touches security, TEE, and keymaster service initialization.

Required evidence before any change proposal:

1. exact RETUS init directory inventory confirmation
2. exact RETUS keymaster service binary inventory confirmation
3. VINTF/manifest/init relationship review
4. evidence explaining how keymaster 4.1 service is initialized without the expected 4.1 rc path
5. security risk note
6. explicit human approval marker before any source-list-affecting edit

Default posture:

- `remain-hard-blocked`

## Proposal Requirements

Any future proposal must include:

1. affected entries
2. current evidence class
3. proposed new state
4. exact RETUS evidence used
5. source-list provenance
6. risk assessment
7. why RETBR or other channels are not being used as authority
8. explicit approval marker required before implementation
9. validation plan
10. rollback plan

## Validation Requirements

Before committing any future source-list change, run:

- `python scripts\validate_repo.py`
- `python -m unittest discover -s tests -v`
- `.\scripts\validate_local.ps1`

A source-list change must not be committed unless validation is green and the report trail clearly supports the change.

## Conclusion

The radio/security hard-block bucket is now classified, but not resolved.

The correct next posture is controlled policy-driven review, not edits.

All 30 entries remain hard-blocked until a future proposal provides stronger exact RETUS evidence and an explicit approval marker.
