# Firmware Source Candidates

Status: metadata-only

Date: 2026-06-28

## Purpose

Track possible stock firmware sources for the Motorola One Hyper recovery anchor.

This report does not accept any firmware as trusted.

This report does not authorize downloading firmware into the repository.

This report does not authorize flashing, restoring, sideloading, rescue, repair, or any physical-phone operation.

## Target firmware identity

Preferred exact match:

- Device: Motorola One Hyper
- Model: XT2027-1
- Product/codename: def / def_retail
- Channel: retus
- Android generation: Android 11
- Observed build: RPFS31.Q1-21-20-1-7-3

A close-looking firmware package is not enough.

## Current source status

No firmware source is currently accepted as a recovery anchor.

No firmware package is currently verified-local.

Physical flash work remains blocked.

## Source trust scale

| Trust level | Meaning |
|---|---|
| unknown | not reviewed |
| weak | unofficial, incomplete metadata, blocked access, or unclear provenance |
| moderate | public source with consistent metadata and accessible archive |
| strong | official/high-trust source with matching metadata |
| verified-local | downloaded outside repo, checksummed, extracted, and inventoried locally |

## Candidate summary

| Candidate | Type | Current trust | Access status | Current classification |
|---|---|---:|---|---|
| Motorola RSA / Software Fix | official rescue/update tool | strong if matching package is exposed | no matching package confirmed | blocked |
| LMSA / Rescue Smart Assistant lineage | official/near-official tooling path | strong if matching package is exposed | no matching package confirmed | blocked |
| Lolinet Motorola firmware mirrors | public mirror | moderate if exact metadata exists | needs review | candidate-source |
| Mirrors with exact filename/build metadata | public mirror | weak/moderate depending provenance | needs review | candidate-source |
| Paid/blocked firmware sites | opaque mirror | weak | blocked or paywalled | reference-only |
| Random forum links / reuploads | informal source | weak | unknown | reference-only |
| Public GitHub stock-derived trees | extracted metadata/source references | weak for firmware recovery | accessible | not firmware anchor |

## Candidate: Motorola RSA / Software Fix

Type:

- official Motorola/Lenovo rescue or software repair path

Potential value:

- strongest possible source if it exposes a matching stock package
- may provide model/channel-compatible restore package
- may provide a practical official recovery route

Current status:

- no matching stock firmware package is currently accepted
- no verified local package recorded
- no checksum recorded
- no extraction inventory recorded

Trust level:

- strong only if exact package is exposed and recorded
- currently blocked

Acceptance requirements:

- package identity must match XT2027-1 / def_retail / retus
- build metadata must be recorded
- archive/package must be stored outside repo
- checksum must be recorded
- extraction/inventory must be documented
- restore path must be written before any physical action

Current classification:

- blocked until matching package evidence exists

## Candidate: Lolinet-style public Motorola firmware mirrors

Type:

- public firmware mirror

Potential value:

- may expose historical Motorola firmware packages
- may include model/build/channel metadata
- may allow checksum and archive inventory

Risks:

- mirror provenance varies
- exact build may not exist
- regional/channel mismatch risk
- package may be older/newer than observed device build
- filenames may look compatible while contents differ

Trust level:

- moderate only after matching metadata and local verification
- currently candidate-source only

Acceptance requirements:

- exact package path recorded
- filename recorded
- claimed model/channel/build recorded
- SHA256 recorded after download outside repo
- extraction performed reproducibly
- image inventory report created
- compatibility review if not exact

Current classification:

- candidate-source

## Candidate: Paid or blocked firmware sites

Type:

- unofficial firmware mirror or paid archive

Potential value:

- may list firmware package names or metadata
- may expose build strings useful for search

Risks:

- opaque provenance
- paywall/subscription access
- Cloudflare/blocked access
- unknown package integrity
- possible repacks
- possible unsafe executable tooling
- unclear licensing/provenance

Trust level:

- weak

Current classification:

- reference-only unless independently verified elsewhere

Policy:

- do not rely on paid/blocked source as sole recovery anchor
- do not run bundled executable repair tools
- do not provide private device identifiers
- do not download into repository

## Candidate: Random forum links and reuploads

Type:

- informal community links

Potential value:

- may reveal package filenames
- may reveal build lineage
- may point to better mirrors

Risks:

- high provenance risk
- stale links
- repacked archives
- wrong regional variant
- wrong model
- incomplete package
- malware or unsafe tools
- no reliable checksum

Trust level:

- weak

Current classification:

- reference-only

Policy:

- metadata may be recorded
- package cannot become recovery anchor without independent verification
- no executable tooling should be run

## Candidate: Public GitHub stock-derived trees

Type:

- extracted device files, public source references, or stock-derived dumps

Potential value:

- may help understand build lineage
- may help identify Android 10 def_retail package naming
- may help compare source assumptions

Risks:

- not a full stock firmware package
- not sufficient for recovery/reflash
- may be Android 10 while target is Android 11
- may include generated or incomplete data
- cannot restore the phone

Trust level:

- weak for firmware recovery

Current classification:

- reference-only for firmware acquisition

Policy:

- useful for source comparison only
- not a recovery anchor

## Search terms to use

Use these terms when looking for metadata:

- XT2027-1 RPFS31.Q1-21-20-1-7-3
- def_retail RPFS31.Q1-21-20-1-7-3
- Motorola One Hyper retus Android 11 firmware
- XT2027-1 retus firmware
- def_retail retus firmware
- RPFS31.Q1-21-20-1-7-3 retus
- Motorola One Hyper stock ROM retus
- Motorola One Hyper software fix XT2027-1

## Candidate record template

For each candidate source, record:

| Field | Value |
|---|---|
| Candidate source ID | TBD |
| Source name | TBD |
| Source type | TBD |
| URL or origin | TBD |
| Claimed model | TBD |
| Claimed product/codename | TBD |
| Claimed channel | TBD |
| Claimed Android version | TBD |
| Claimed build | TBD |
| Filename | TBD |
| File size | TBD |
| Access status | TBD |
| Paywall/login required | TBD |
| Checksum provided by source | TBD |
| Independent checksum computed | TBD |
| Extraction tested | TBD |
| Trust level | TBD |
| Current classification | TBD |
| Notes | TBD |

## Classification rules

A source may be classified as `candidate-source` if:

- it appears relevant to XT2027-1 / def / def_retail
- it exposes enough metadata to compare to target
- it does not require unsafe tooling
- it does not require committing firmware to repo

A source remains `reference-only` if:

- it is paywalled or blocked
- it only provides partial metadata
- it has unclear provenance
- it points to a different build/channel/model
- it is useful only for filename or lineage clues

A source is `rejected` if:

- model conflicts
- codename conflicts
- channel conflicts without compatibility review
- package appears modified or repacked
- source requires suspicious executable tooling
- source requires private identifiers
- archive cannot be checksummed
- archive cannot be extracted reproducibly

A source can become `verified-local` only after:

- downloaded outside repo
- checksum recorded
- extracted reproducibly
- firmware inventory report created
- no private/proprietary payloads committed
- local validation passes

## Current blockers

- no exact matching firmware package accepted
- no verified-local firmware archive
- no firmware inventory report
- no completed recovery anchor
- no completed physical flash gate review

## Current decision

Physical flash work remains blocked.

The next safe step is to collect candidate source metadata only, then create a firmware inventory report only after a package is downloaded outside the repository and verified locally.
