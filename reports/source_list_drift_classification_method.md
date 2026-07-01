# Source-List Drift Classification Method

Status: method definition only; no source-list changes authorized

## Scope

This report defines the method for classifying the 123 active proprietary-file
entries that remain unresolved after the Route B RETBR vendor-side and
non-vendor line-coverage passes.

This is a method report only. It does not classify the entries yet, and it does
not authorize source-list edits, blob waivers, RETBR substitution, blob import,
generated vendor tree creation, Lineage build, adb/fastboot, LMSA/RSA rescue or
repair, flashing, bootloader actions, or physical device interaction.

WI-004 remains blocked.

## Input state

Current committed evidence chain:

| Commit | Purpose |
|---|---|
| `0815984` | Document Route B vendor-side line coverage result |
| `142458c` | Document Route B non-vendor line coverage result |
| `a800ab9` | Close Route B line coverage evidence phase |
| `513cb35` | Map Route B unresolved active entries |
| `b58f3ff` | Plan exact RETUS reacquisition and source drift review |
| `28eeb68` | Expand exact RETUS reacquisition plan |

Current Route B status:

| Metric | Count |
|---|---:|
| Active expected proprietary entries | 1,213 |
| Combined direct matches | 1,090 |
| Remaining active unresolved entries | 123 |
| Disabled/optional entries | 32 |

Current unresolved residual groups:

| Residual group | Count |
|---|---:|
| `non_vendor_unresolved` | 50 |
| `wfd_wifi_display_hdcp` | 32 |
| `qcril_database_upgrade_tail` | 13 |
| `qti_data_cne_latency` | 9 |
| `misc_config_gap` | 6 |
| `radio_ims_version_gap` | 4 |
| `display_panel_calibration` | 4 |
| `bluetooth_audio_version_gap` | 2 |
| `other` | 2 |
| `keymaster_version_gap` | 1 |

## Purpose

The purpose of source-list drift classification is to separate unresolved entries
into evidence-backed categories before any decision about source-list correction,
substitute source use, or import/build readiness.

The method must distinguish between entries that are probably still required,
entries that need exact RETUS firmware evidence, entries that may reflect
source-list drift, entries that may exist under renamed or version-shifted paths,
entries that may be optional but require proof, entries that may reflect
inventory/parser limitations, and entries that must not be waived.

## Classification labels

Each unresolved active entry should receive exactly one primary classification.

| Classification | Meaning | Default decision posture |
|---|---|---|
| `still-required` | Entry appears necessary and remains unresolved | blocker |
| `exact-retus-needed` | Cannot decide without exact target firmware | blocker |
| `source-list-drift-candidate` | Entry may reflect stale or mismatched source expectation | blocked pending proof |
| `renamed-or-version-shifted` | Equivalent may exist under another name or version | blocked pending mapping |
| `optional-candidate` | Entry may be optional but not proven optional | blocked pending proof |
| `parser-or-inventory-gap` | Current inventory method may have missed the entry | blocked pending improved inventory |
| `do-not-waive` | Entry is security-, radio-, boot-, calibration-, or device-critical | hard blocker |

No classification is an automatic waiver.

## Evidence required by classification

### `still-required`

Use this when the entry belongs to a functional family that appears necessary for
device bring-up, HAL service availability, radio behavior, display calibration,
security startup, framework permission availability, or product behavior.

Required evidence:

- original expected path;
- owning tree: `def` or `sm6150-common`;
- residual group;
- category;
- why the entry appears required;
- whether Route B lacked it directly;
- whether exact RETUS is needed to settle the entry.

Decision posture:

- remains blocked;
- no source-list edit;
- no waiver.

### `exact-retus-needed`

Use this when Route B is insufficient because the entry may differ by channel,
build, region, or target package.

Required evidence:

- expected path;
- why RETBR cannot decide the entry;
- target build/channel that must be checked;
- whether the missing entry is version- or channel-sensitive.

Decision posture:

- remains blocked until exact RETUS evidence exists.

### `source-list-drift-candidate`

Use this when an expected entry may be stale, inherited from a broader common
tree, mismatched to Android 11, or not applicable to this exact target.

Required evidence:

- expected path;
- source list where it appears;
- reason it may be drift;
- observed nearby files or family evidence if available;
- risk if removed or ignored;
- whether the drift is target-specific or common-tree-wide.

Decision posture:

- blocked pending a separate source-list decision report.

### `renamed-or-version-shifted`

Use this when a likely equivalent exists with a different suffix, version,
library soname, service version, framework version, or config filename.

Required evidence:

- expected path;
- observed candidate equivalent;
- why the candidate may be equivalent;
- version relationship;
- risk of substituting or mapping;
- whether exact RETUS must confirm the mapping.

Decision posture:

- blocked pending proof;
- no automatic substitution.

### `optional-candidate`

Use this only when there is affirmative evidence that the entry may be optional,
feature-gated, disabled, product-specific, or not required for the target.

Required evidence:

- expected path;
- feature family;
- reason it may be optional;
- evidence that the feature can be absent safely;
- evidence that absence is expected for this target/build/channel.

Decision posture:

- blocked pending proof;
- optional does not mean waived.

### `parser-or-inventory-gap`

Use this when the current inventory process may have missed the entry because of
partition mount layout, symlink handling, packed artifacts, generated files, case
sensitivity, image parsing limits, or root path mapping.

Required evidence:

- expected path;
- inventory method used;
- suspected inventory limitation;
- improved inventory action needed;
- whether the file may be present under an unobserved path.

Decision posture:

- blocked pending improved local-only inventory.

### `do-not-waive`

Use this for entries touching security, keymaster/gatekeeper/QSEE, radio/IMS,
boot-critical services, device-specific calibration, or other high-risk hardware
behavior.

Required evidence:

- expected path;
- risk family;
- why waiver is unsafe;
- required future evidence.

Decision posture:

- hard blocker.

## Residual-family defaults

The following defaults should guide classification. They are not final
classifications.

| Residual family | Default starting classification |
|---|---|
| WFD / Wi-Fi Display / HDCP | `source-list-drift-candidate` or `exact-retus-needed` |
| QCRIL database upgrade tail | `renamed-or-version-shifted` or `source-list-drift-candidate` |
| QTI data / CNE / latency | `exact-retus-needed` |
| Radio / IMS version gaps | `do-not-waive` or `exact-retus-needed` |
| Display panel calibration | `do-not-waive` |
| Bluetooth audio version gaps | `exact-retus-needed` |
| Keymaster version gap | `do-not-waive` |
| Non-vendor unresolved system_ext/product entries | family-specific review required |

## Review order

The 123 unresolved entries should be reviewed in this order:

1. `keymaster_version_gap`
2. `display_panel_calibration`
3. `radio_ims_version_gap`
4. `qcril_database_upgrade_tail`
5. `qti_data_cne_latency`
6. `bluetooth_audio_version_gap`
7. `wfd_wifi_display_hdcp`
8. `non_vendor_unresolved`
9. `misc_config_gap`
10. `other`

This order prioritizes safety-critical and bring-up-sensitive families before
feature-level or miscellaneous gaps.

## Output format for future classification report

A future classification report should include expected path, source tree,
original source-list location, residual group, category, primary classification,
evidence summary, risk level, required next evidence, and decision posture.

Recommended risk levels:

| Risk level | Meaning |
|---|---|
| `critical` | Security, boot, keymaster, radio, or device calibration impact |
| `high` | HAL/service/framework behavior likely affected |
| `medium` | Feature behavior likely affected |
| `low` | Likely optional or narrow feature, but still needs proof |
| `unknown` | Insufficient evidence |

Recommended decision postures:

| Decision posture | Meaning |
|---|---|
| `hard-blocked` | Cannot waive or proceed without exact proof |
| `blocked-exact-retus` | Needs exact target firmware |
| `blocked-drift-review` | Needs source-list drift decision |
| `blocked-inventory-review` | Needs better inventory evidence |
| `blocked-equivalence-review` | Needs proof of renamed/versioned equivalent |
| `blocked-optional-proof` | Needs proof before optional treatment |

## Prohibited shortcuts

The following shortcuts are prohibited:

- treating Route B direct absence as proof of target absence;
- treating Route B family presence as proof of line-level presence;
- treating optional-looking entries as optional without evidence;
- silently editing proprietary-files lists;
- collapsing unresolved entries into a generic waiver;
- using non-exact firmware as import authority without a decision gate;
- proceeding to blob import or build because overall coverage is high.

## Decision

The next evidence step should be a classification report that applies this method
to the 123 unresolved active entries.

Until that classification exists, all 123 unresolved active entries remain
blocked.

WI-004 remains blocked.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- RETBR substitution;
- exact RETUS substitution decision;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
