# Exact RETUS Radio/Security Final Evidence Reduction

## Scope

This report summarizes the local-only evidence reduction for the remaining exact RETUS unresolved radio/security-sensitive entries.

Target firmware authority:

- Device: Motorola One Hyper XT2027-1
- Channel: RETUS / Retail US
- Build: RPFS31.Q1-21-20-1-7-3
- Build tag: 37074e
- System version: 30.201.3.def_retail.retail.en.US

This report is sanitized for repository commit. Raw local CSVs, inventories, transcripts, extracted images, firmware material, helper scripts, and blob material remain local-only and are not committed.

## Safety Boundary

This report does not authorize:

- source-list edits
- source-list waivers
- blob import
- generated vendor tree creation
- Lineage build attempts
- RETBR substitution
- alternate-device substitution
- adb, fastboot, flashing, wiping, or physical device interaction

All entries reviewed here remain hard-blocked.

## Inputs

Local-only source inputs included:

- exact RETUS unresolved classification CSV
- isolated `do-not-waive` radio/security CSV
- exact RETUS vendor observed path inventory
- exact RETUS non-vendor observed path inventory
- exact RETUS vendor deep targeted inventory
- exact RETUS unresolved deep inventory
- exact RETUS report-safe vendor inventory
- exact RETUS product inventory
- exact RETUS system/system_ext inventory
- local-only basename, token-neighbor, QCRIL sequence, versioned-interface, and final reduction CSVs

No local-only raw evidence artifacts are committed by this report.

## Starting Bucket

The radio/security hard-block bucket contained 30 entries.

Family split:

| Family | Count |
|---|---:|
| radio_ims_qcril | 29 |
| keymaster_gatekeeper_qsee | 1 |

Partition split:

| Partition family | Count |
|---|---:|
| vendor | 18 |
| system_ext | 8 |
| product | 4 |

Tree split:

| Source tree | Count |
|---|---:|
| sm6150-common | 30 |

All 30 entries are inherited from `sm6150-common`; none are device-specific `def` entries.

## Scan Summary

### Basename scan

The basename scan found:

| Result | Count |
|---|---:|
| no-basename-hit entries | 25 |
| basename-hit rows | 16 |
| exact-path-hit rows | 0 |
| same-parent-basename-hit rows | 0 |

Five expected entries had basename evidence somewhere in exact RETUS inventories, but none appeared at the expected source-list path.

Those five were:

- `product/etc/permissions/UimGba.xml`
- `product/etc/permissions/UimGbaManager.xml`
- `product/framework/uimgbalibrary.jar`
- `product/framework/uimgbamanagerlibrary.jar`
- `vendor/lib64/vendor.qti.ims.factory@1.1.so`

### Token-neighbor scan

The token-neighbor scan found token/family evidence for all 30 entries, but the result was broad and intentionally noisy. It established that every entry belongs to a family visible in exact RETUS evidence, but it did not establish exact-path presence.

### QCRIL sequence scan

The focused QCRIL database scan found that exact RETUS contains:

- `vendor/radio/qcril_database/qcril.db`
- `vendor/radio/qcril_database/upgrade/0_initial.sql`
- `vendor/radio/qcril_database/upgrade/3_version_qcrildb.sql`
- through
- `vendor/radio/qcril_database/upgrade/23_version_qcrildb.sql`

The source list expects later entries:

- `24_version_qcrildb.sql`
- `25_version_qcrildb.sql`
- `26_version_qcrildb.sql`
- `27_version_qcrildb.sql`
- `28_version_qcrildb.sql`
- `29_version_qcrildb.sql`
- `30_version_qcrildb.sql`
- `31_version_qcrildb.sql`
- `33_version_qcrildb.sql`
- `34_version_qcrildb.sql`
- `35_version_qcrildb.sql`
- `36_version_qcrildb.sql`
- `37_version_qcrildb.sql`

Interpretation: exact RETUS has a QCRIL database upgrade chain, but the observed exact RETUS sequence stops at 23. The expected source-list entries are beyond the observed exact RETUS sequence.

### Versioned interface scan

The focused versioned-interface scan found:

#### Keymaster

Exact RETUS contains:

- keymaster 3.0 service / implementation / system libraries
- keymaster 4.0 service / init rc / system libraries
- keymaster 4.1 service binary / system libraries

But the expected path:

- `vendor/etc/init/android.hardware.keymaster@4.1-service-qti.rc`

was not observed. Exact RETUS evidence showed the 4.0 init rc path, while 4.1 service evidence exists as service binary and system libraries.

#### UCE service

Exact RETUS contains:

- `com.qualcomm.qti.uceservice@2.0.so`
- `com.qualcomm.qti.uceservice@2.1.so`
- `com.qualcomm.qti.uceservice@2.2.so`

The expected source-list entries ask for `@2.3.so`, which was not observed.

#### Radio IMS

Exact RETUS contains:

- `vendor.qti.hardware.radio.ims@1.0.so`
- through
- `vendor.qti.hardware.radio.ims@1.6.so`

The expected source-list entries ask for `@1.7.so`, which was not observed.

#### IMS factory

Exact RETUS contains:

- `vendor.qti.ims.factory@1.0.so`
- `vendor.qti.ims.factory@1.1.so`

The expected `vendor/lib64/vendor.qti.ims.factory@1.1.so` basename appears in exact RETUS `system_ext/lib` and `system_ext/lib64` inventory evidence, not at the expected `vendor/lib64` path.

## Final Evidence Classes

| Evidence class | Count |
|---|---:|
| exact-retus-qcril-sequence-absent-after-23 | 13 |
| uce-service-version-ahead-of-exact-retus | 4 |
| ims-rcs-framework-broad-token-only | 4 |
| uimgba-product-to-system_ext-location-shift-candidate | 4 |
| radio-ims-version-ahead-of-exact-retus | 3 |
| keymaster-4.1-init-rc-absent-with-4.1-service-present | 1 |
| ims-factory-vendor64-to-system_ext-location-shift-candidate | 1 |

## Per-Entry Findings

### exact-retus-qcril-sequence-absent-after-23

These entries are beyond the observed exact RETUS QCRIL upgrade sequence, which currently appears to stop at version 23:

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

### uce-service-version-ahead-of-exact-retus

Exact RETUS contains UCE service versions 2.0, 2.1, and 2.2. These expected 2.3 entries were not observed:

- `system_ext/lib/com.qualcomm.qti.uceservice@2.3.so`
- `system_ext/lib64/com.qualcomm.qti.uceservice@2.3.so`
- `vendor/lib/com.qualcomm.qti.uceservice@2.3.so`
- `vendor/lib64/com.qualcomm.qti.uceservice@2.3.so`

### ims-rcs-framework-broad-token-only

Exact RETUS has broad IMS/RCS token evidence, but no basename hit for these expected framework/config entries:

- `system_ext/etc/permissions/vendor.qti.ims.rcsservice.xml`
- `system_ext/framework/vendor.qti.ims.connection-V1.0-java.jar`
- `system_ext/framework/vendor.qti.ims.rcssip-V1.0-java.jar`
- `system_ext/framework/vendor.qti.ims.rcsuce-V1.0-java.jar`

### uimgba-product-to-system_ext-location-shift-candidate

The expected UimGba basenames appear in exact RETUS `system_ext` inventory evidence, not at the expected product paths:

- `product/etc/permissions/UimGba.xml`
- `product/etc/permissions/UimGbaManager.xml`
- `product/framework/uimgbalibrary.jar`
- `product/framework/uimgbamanagerlibrary.jar`

### radio-ims-version-ahead-of-exact-retus

Exact RETUS contains radio IMS versions 1.0 through 1.6. These expected 1.7 entries were not observed:

- `system_ext/lib/vendor.qti.hardware.radio.ims@1.7.so`
- `system_ext/lib64/vendor.qti.hardware.radio.ims@1.7.so`
- `vendor/lib64/vendor.qti.hardware.radio.ims@1.7.so`

### keymaster-4.1-init-rc-absent-with-4.1-service-present

Exact RETUS contains keymaster 4.1 service binary and system keymaster 4.1 libraries, but observed exact RETUS inventory contains keymaster 4.0 init rc, not keymaster 4.1 init rc:

- `vendor/etc/init/android.hardware.keymaster@4.1-service-qti.rc`

### ims-factory-vendor64-to-system_ext-location-shift-candidate

The expected IMS factory 1.1 basename appears in exact RETUS `system_ext/lib` and `system_ext/lib64` inventory evidence, not at the expected `vendor/lib64` path:

- `vendor/lib64/vendor.qti.ims.factory@1.1.so`

## Decision Posture

All 30 entries remain hard-blocked.

This review supports classification and future manual decision-making only. It does not establish safe waiver authority, source-list edit authority, or replacement/import authority.

Recommended posture for all 30 entries:

- `remain-hard-blocked`

## Recommended Next Work

Recommended next step is a separate proposal report that defines possible handling paths per final evidence class, without applying them:

1. QCRIL sequence entries: evaluate whether source-list annotation can record exact RETUS sequence stop at 23.
2. UCE and radio IMS version-ahead entries: require ABI/build review before any equivalence or removal decision.
3. UimGba and IMS factory location-shift candidates: require partition/path impact review before any source-list adjustment.
4. IMS/RCS broad-token-only entries: require deeper exact RETUS framework/config review.
5. Keymaster 4.1 init rc: remain security hard-blocked pending stronger init/service evidence review.

No implementation action is authorized by this report.
