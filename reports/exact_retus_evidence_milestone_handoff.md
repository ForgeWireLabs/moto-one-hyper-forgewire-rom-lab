# Exact RETUS Evidence Milestone Handoff

Status: milestone handoff; no source-list edits or waivers authorized

## Purpose

This handoff records the current evidence milestone for the Moto One Hyper exact
RETUS ROM lab.

The project has completed a full evidence pass over the exact RETUS firmware
artifact and all unresolved proprietary-file entries.

This handoff is intended for the next operator or agent session.

This is not a source-list edit.

This is not a waiver.

This is not blob import authorization.

This is not generated vendor tree authorization.

This is not build authorization.

This is not device authorization.

## Repository

Public report repository:

- `https://github.com/ForgeWireLabs/moto-one-hyper-forgewire-rom-lab`

Local repository path:

- `C:\Projects\moto-one-hyper`

Local-only work area:

- `C:\Projects\moto-one-hyper-local`

Important local-only directories:

- `C:\Projects\moto-one-hyper-local\firmware`
- `C:\Projects\moto-one-hyper-local\checksums`
- `C:\Projects\moto-one-hyper-local\extracted`
- `C:\Projects\moto-one-hyper-local\audits`
- `C:\Projects\moto-one-hyper-local\logs`
- `C:\Projects\moto-one-hyper-local\sources`
- `C:\Projects\moto-one-hyper-local\tools`

Local-only firmware, extracted images, raw inventories, CSVs, helper scripts, and
transcripts must not be committed.

## Device target

| Field | Value |
|---|---|
| Device | Motorola One Hyper |
| Model | XT2027-1 |
| Codename/product | def / def_retail |
| Channel | RETUS / Retail US |
| Android | 11 |
| Build | RPFS31.Q1-21-20-1-7-3 |
| Build tag | 37074e |
| System version | 30.201.3.def_retail.retail.en.US |
| Fingerprint | motorola/def_retail/def:11/RPFS31.Q1-21-20-1-7-3/37074e:user/release-keys |

## Firmware authority

Exact RETUS is the current authority target.

RETBR remains comparison-only evidence.

RETBR is not import authority.

RETBR must not be used as substitution authority.

## Current commit head

Latest known committed/pushed milestone head:

- `87188b7 Plan exact RETUS radio security evidence review`

Recent milestone chain:

| Commit | Purpose |
|---|---|
| `6573543` | Verify exact RETUS firmware artifact |
| `66de47f` | Document exact RETUS super reconstruction |
| `7f17953` | Document exact RETUS line coverage |
| `3d0dde6` | Classify exact RETUS unresolved entries |
| `954404f` | Review exact RETUS WFD drift block |
| `1625df7` | Document WFD source-list provenance |
| `eb6b65a` | Record WFD source-list decision posture |
| `4af9c2b` | Review exact RETUS deeper vendor entries |
| `f960c2e` | Review exact RETUS renamed version shifts |
| `ed71d0a` | Review exact RETUS camera inventory entry |
| `2bb7745` | Summarize exact RETUS unresolved status |
| `cbb3b80` | Propose WFD source-list handling |
| `1ac0426` | Propose exact RETUS version-shift equivalence review |
| `bc45a58` | Propose same-directory vendor variant review |
| `58af78c` | Propose camera permissions config review |
| `87188b7` | Plan exact RETUS radio security evidence review |

## Validation status

At each committed report/proposal step, validation remained green:

- repository governance validation passed;
- unit tests passed;
- local validation completed.

Current recurring test count:

- `145` tests

## Exact RETUS artifact status

Exact RETUS firmware ZIP was verified locally:

- file: `XT2027-1_DEF_RETUS_11_RPFS31.Q1-21-20-1-7-3_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip`
- size: `2,427,793,578` bytes
- SHA256: `907E380CF26758F9B5E4B2E05AC663123A526FEEFFB40A9E28D72D4568ADD7B8`
- ZIP entry count: `24`

Relevant metadata:

- software version: `def_retail-user 11 RPFS31.Q1-21-20-1-7-3 37074e release-keys`
- modem version: `M6150_09.297.01.68R`
- build date: `Wed Jan 5 07:58:51 CST 2022`
- blur version: `Blur_Version.30.201.3.def_retail.retail.en.US`

## Super reconstruction status

Exact RETUS sparse super chunks were reconstructed to a raw super image locally.

Reconstructed local-only raw super image:

- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS_filesystems\super.raw.img`

Raw super SHA256:

- `562711ADEFF33DBE1334FB8AEF862AEA41749A27BF358E15944195A2EE431659`

Carved logical images:

| Image | Size | SHA256 |
|---|---:|---|
| `product_a.img` | `2,418,454,528` | `6F99793D0CFC2BF201A9725453FD064C6C418D1E1ED07EDBC66811989F57D08F` |
| `system_a.img` | `1,384,513,536` | `79C9B822B6D7A8CD6AAF0852D204620915FF6E63FB46A4BEE34193545123B2AF` |
| `system_b.img` | `173,809,664` | `E2E2B17A2AA4DFC1C7D93963DE403473583A4E511C22057BBDA2507B44AE0E16` |
| `vendor_a.img` | `616,701,952` | `C614411DDAC10288CC55B56EA027AAC50FA2628D23D1991C6B572CE817574B4B` |

Zero-size slots skipped:

- `vendor_b`
- `product_b`

## Coverage baseline

Adjusted exact RETUS coverage:

| Metric | Count |
|---|---:|
| Active expected proprietary entries | `1,213` |
| Direct vendor matches | `957` |
| Direct non-vendor matches | `133` |
| Combined direct matches | `1,090` |
| Remaining active unresolved entries | `123` |
| Disabled/optional entries | `32` |
| Coverage over active expected entries | `89.8599%` |

## Current unresolved map

All `123` unresolved exact RETUS entries are mapped.

| Bucket | Count | Status |
|---|---:|---|
| WFD / Wi-Fi Display / HDCP | `69` | review/provenance/decision/proposal complete; still gated |
| Same-directory vendor variants | `12` | review/proposal complete; still gated |
| Renamed/version-shifted entries | `11` | review complete; 2-entry probable version-shift proposal complete |
| Camera permissions/config | `1` | review/proposal complete; still gated |
| Radio/security-sensitive entries | `30` | evidence plan complete; hard-blocked do-not-waive |

## WFD status

Count:

- `69`

Posture:

- `source-list-drift-candidate`

Evidence:

- all entries are from `sm6150-common`;
- no entries are from device-specific `def`;
- source-list provenance says the WFD block came from Motorola Edge S
  `RRN31.Q1-20-31-3`;
- exact Motorola One Hyper `def_retail` RETUS did not directly match the expected
  WFD paths.

Proposal status:

- WFD source-list proposal exists;
- recommended future action is annotation-only;
- no edit authorized yet;
- no removal authorized;
- no waiver authorized.

## Same-directory vendor variant status

Count:

- `12`

Posture:

- `same-directory-variant-review`

Risk:

- high

Evidence:

- all entries are from `sm6150-common`;
- all expected basenames were absent;
- all entries had same-parent-directory evidence in exact RETUS vendor
  inventories;
- relevant directories exist and are populated.

Proposal status:

- same-directory vendor variant proposal exists;
- recommendation is manual per-entry neighboring-file review;
- no edit authorized yet;
- no removal authorized;
- no waiver authorized.

## Renamed/version-shifted status

Count:

- `11`

Split:

| Posture | Count | Status |
|---|---:|---|
| probable-version-shift | `2` | proposal complete |
| possible-rename-or-stack-shift | `7` | manual review still needed |
| same-directory-absence | `2` | remains blocked |

The two probable version-shift entries are:

- `vendor/lib/hw/vendor.qti.hardware.bluetooth_audio@2.1-impl.so`
- `vendor/lib64/vendor.qti.latency@2.1.so`

Exact RETUS related hits show `2.0` variants, but equivalence is not proven.

Proposal status:

- probable version-shift equivalence proposal exists;
- recommendation is annotation-only pending ABI/build review;
- no path adjustment authorized;
- no removal authorized;
- no waiver authorized.

## Camera permissions/config status

Count:

- `1`

Entry:

- `system_ext/etc/permissions/com.motorola.androidx.camera.extensions.xml`

Posture:

- `camera-related-token-review`

Evidence:

- exact basename hits: `0`;
- same-parent hits: `0`;
- camera path hits: `143`;
- token-related hits: `467`;
- deep exact hits: `0`;
- unresolved deep exact hits: `0`;
- deep camera hits: `71`.

Interpretation:

- exact camera stack evidence exists;
- this is not a missing camera stack case;
- the specific camera permissions/config XML remains absent in current targeted
  evidence;
- risk remains high.

Proposal status:

- camera permissions/config proposal exists;
- recommendation is annotation-only pending manual permissions/config review;
- no edit authorized yet;
- no removal authorized;
- no waiver authorized.

## Radio/security status

Count:

- `30`

Posture:

- `do-not-waive`

Status:

- hard-blocked;
- evidence plan complete;
- no review-resolution attempted yet.

Radio/security entries must not be:

- waived;
- removed;
- silently ignored;
- replaced from RETBR;
- substituted from another device;
- imported from an unverified source;
- treated as optional;
- moved into a build path without stronger exact RETUS evidence.

Next radio/security action:

- focused local-only radio/security evidence review;
- sanitized committed summary only after local evidence collection.

## What is complete

Completed evidence and planning coverage:

- exact RETUS artifact verification;
- exact RETUS super reconstruction;
- exact RETUS line coverage;
- full unresolved classification;
- WFD drift review;
- WFD source provenance review;
- WFD decision posture;
- unresolved status rollup;
- WFD source-list proposal;
- deeper vendor review;
- same-directory vendor variant proposal;
- renamed/version-shifted review;
- probable version-shift proposal;
- camera inventory review;
- camera permissions/config proposal;
- radio/security evidence plan.

## What is not complete

Still incomplete:

- focused local-only radio/security evidence review;
- manual neighboring-file review for 12 same-directory vendor variants;
- manual review for 7 possible rename/stack-shift entries;
- manual review for 2 same-directory absences;
- manual camera permissions/config review;
- any source-list approval report;
- any source-list edit;
- any blob import;
- any generated vendor tree;
- any Lineage build.

## Absolute safety boundaries

The following remain blocked:

- source-list edits;
- source-list waivers;
- WFD removal;
- WFD optionalization;
- version-shift path adjustment;
- same-directory vendor path adjustment;
- camera permission path adjustment;
- radio/security path adjustment;
- RETBR substitution;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- physical device interaction;
- adb;
- fastboot;
- LMSA/RSA rescue or repair;
- flashing;
- bootloader unlock/relock;
- wipe/erase operations.

## Recommended next session

Recommended next session focus:

1. verify clean git status and latest pushed head;
2. run validation once;
3. begin focused local-only radio/security evidence review;
4. isolate the 30 do-not-waive entries into a local-only CSV;
5. classify them into subfamilies;
6. produce a sanitized radio/security review summary;
7. commit only report-safe summaries.

Do not start with source-list edits.

Do not start with blob import.

Do not start with build attempts.

Do not touch the device.

## Suggested first commands next session

Suggested safe startup commands:

    cd C:\Projects\moto-one-hyper
    git status --short
    git log --oneline --max-count=20
    python scripts\validate_repo.py
    python -m unittest discover -s tests -v
    .\scripts\validate_local.ps1

## Operator conclusion

This milestone is clean.

The exact RETUS unresolved surface is mapped, reviewed, and proposal-covered.

The only hard unresolved bucket is radio/security.

The repo is ready for local-only radio/security evidence review.

The repo is not ready for source-list edits, waivers, blob import, generated
vendor trees, Lineage builds, or device interaction.
