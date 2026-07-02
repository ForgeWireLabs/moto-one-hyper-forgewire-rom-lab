# Exact RETUS WFD / Wi-Fi Display / HDCP Source Provenance Review

Status: source provenance review; no source-list edits or waivers authorized

## Scope

This report records source-list provenance for the 69 exact RETUS unresolved
entries previously isolated as the WFD / Wi-Fi Display / HDCP drift block.

This is a follow-up to:

- reports/exact_retus_line_coverage_result.md
- reports/exact_retus_unresolved_classification_report.md
- reports/exact_retus_wfd_wifi_display_hdcp_drift_review.md

The purpose is to determine whether the WFD residual block is device-specific to
Motorola One Hyper def_retail exact RETUS, or inherited from a different
common-tree source lineage.

## Inputs

Committed reports:

- reports/exact_retus_line_coverage_result.md
- reports/exact_retus_unresolved_classification_report.md
- reports/exact_retus_wfd_wifi_display_hdcp_drift_review.md

Local source tree inspected:

- C:\Projects\moto-one-hyper-local\sources\lineage20_android_device_motorola_sm6150-common

Remote recorded by the local source tree:

- https://github.com/sorenlyulf/android_device_motorola_sm6150-common.git

Branch/head observed locally:

- branch: lineage-20
- head: a5206c5
- latest commit summary: Delete Droidian directory

## Commands used

The following read-only Git commands were used against the local source tree:

- git status --short
- git remote -v
- git log --oneline --decorate --max-count=20
- git log --follow --oneline -- proprietary-files.txt
- git blame -L 982,1028 -- proprietary-files.txt
- git log --stat --oneline --max-count=1 6e125f0
- git show --stat --summary 6e125f0

No source files were modified.

No source-list edits were made.

## Local source tree status

The local sm6150-common source tree was clean at inspection time.

## Local Git history

The local sm6150-common history was short:

| Commit | Summary |
|---|---|
| a5206c5 | Delete Droidian directory |
| b83d226 | Delete lineage.dependencies |
| 6e125f0 | Common files for Motorola Sm6150 devices |

proprietary-files.txt history showed only:

| Commit | Summary |
|---|---|
| 6e125f0 | Common files for Motorola Sm6150 devices |

This means the WFD block was present when proprietary-files.txt entered the
local source history. It was not introduced by a later local edit.

## WFD block provenance

The source list itself labels the WFD block:

- proprietary-files.txt line 982:
  - # WiFi Display - from Motorola Edge S - RRN31.Q1-20-31-3

The WFD block begins immediately after that comment. Example lines include:

- system_ext/bin/wfdservice
- system_ext/etc/init/wfdservice.rc
- system_ext/etc/seccomp_policy/wfdservice.policy
- system_ext/etc/wfdconfigsink.xml
- system_ext/lib/libwfdclient.so
- system_ext/lib64/libwfdclient.so
- system_ext/lib/vendor.qti.hardware.wifidisplaysession@1.0.so
- system_ext/lib64/vendor.qti.hardware.wifidisplaysession@1.0.so

The inspected blame range shows the WFD block attributed to the root common-tree
commit:

| Evidence | Value |
|---|---|
| Commit | 6e125f0 |
| Commit summary | Common files for Motorola Sm6150 devices |
| Author shown by blame | Robert Maxwell |
| Timestamp shown by blame | 2026-06-12 17:49:04 -0700 |
| File | proprietary-files.txt |
| Range inspected | lines 982 through 1028 |

## Root common-tree commit

The root common-tree commit is:

| Field | Value |
|---|---|
| Commit | 6e125f09adf31facf3b50febd016538bde9d671c |
| Author | Robert Maxwell <solarcataclysm@gmail.com> |
| Date | Fri Jun 12 17:49:04 2026 -0700 |
| Summary | Common files for Motorola Sm6150 devices |

The commit is a large initial common-tree import:

| Metric | Value |
|---|---:|
| Files changed | 566 |
| Insertions | 239,751 |
| proprietary-files.txt lines added | 1,071 |

## Provenance finding

The WFD / Wi-Fi Display / HDCP unresolved block is not device-specific evidence
for Motorola One Hyper def_retail.

It is inherited common-tree content, and the source list explicitly identifies
its donor source as:

- Motorola Edge S - RRN31.Q1-20-31-3

The exact RETUS target for this lab is:

- Motorola One Hyper / def_retail / RPFS31.Q1-21-20-1-7-3 / 37074e

Therefore, the WFD block is best understood as inherited sm6150-common
source-list drift until proven otherwise.

## Relationship to exact RETUS evidence

The exact RETUS WFD drift review found:

| Metric | Count |
|---|---:|
| WFD/Wi-Fi Display/HDCP residual entries reviewed | 69 |
| Entries from sm6150-common | 69 |
| Entries from def | 0 |
| system_ext entries | 37 |
| vendor entries | 32 |
| Review posture source-list-drift-candidate | 69 |

That finding now has source provenance support:

- the entire residual block is inherited from sm6150-common;
- the source list labels the block as from Motorola Edge S;
- no evidence has been found that the WFD block was validated against exact def_retail RETUS;
- exact RETUS observed inventories did not directly match the expected WFD paths.

## Decision

The 69 WFD / Wi-Fi Display / HDCP entries remain classified as:

- residual family: wfd_wifi_display_hdcp
- decision posture: source-list-drift-candidate
- risk: high

The provenance review strengthens the drift interpretation.

This report does not authorize removing the entries.

This report does not authorize source-list edits.

This report does not authorize source-list waivers.

This report does not authorize blob import or build use.

## Recommended next evidence step

Create a proposed source-list decision report for the WFD block.

That report should be explicit and conservative. It should decide between:

1. retain all WFD entries pending a real build/import attempt;
2. annotate the WFD block as Edge S inherited drift;
3. split the WFD block behind a device/build-specific note;
4. propose removal only after a separate human approval gate;
5. keep selected entries if exact RETUS equivalence is later proven.

Any actual source-list edit must be a separate gated action after the decision
report.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- direct removal of the WFD block;
- RETBR substitution;
- blob import into vendor/motorola;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
