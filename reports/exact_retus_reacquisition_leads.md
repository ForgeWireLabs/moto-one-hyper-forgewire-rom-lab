# Exact RETUS Firmware Reacquisition Leads

Status: public lead report only; no firmware committed

## Target

Required exact target:

| Field | Required value |
|---|---|
| Device | Motorola One Hyper |
| Model | XT2027-1 |
| Codename/product | def / def_retail |
| Channel | Retail USA / RETUS |
| Android | 11 |
| Build | RPFS31.Q1-21-20-1-7-3 |
| Expected fingerprint tail | 37074e |

## Local result

A local search of `C:\Projects\moto-one-hyper-local\firmware` found only the
Route B RETBR package:

- `stockrom.net_RETBR_DEF_RETAIL_RPFS31.Q1-21-20-5_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip`

A local source search found Android 10 `QPF30.104 / b456f` references and the
Route B Android 11 `RPFS31.Q1-21-20-5 / 1e3de` reference, but did not find the
required exact RETUS `RPFS31.Q1-21-20-1-7-3 / 37074e` payload.

## Public reacquisition leads

### Moto Updates Tracker

Observed lead:

- Codename: `def`
- Carrier: `Retail USA`
- Model: `XT2027-1-DS/PAGR0029US`
- Version: `RPFS31.Q1-21-20-1-7-3`
- Android: `11`

Use posture:

- promising exact-target lead;
- download/link must be manually verified;
- package hash must be recorded before use;
- file must remain local-only.

### Filewale

Observed lead:

- `Motorola One Hyper XT2027-1 DEF_RETAIL_RPFS31.Q1-21-20-1-7-3_subsidy-DEFAULT_regulatory-DEFAULT_CFC...xml.zip`
- File size shown publicly as approximately `2.26 GB`
- Listed under `retus`

Use posture:

- promising exact-target lead;
- source trust is weaker than direct Motorola/Lolinet-style mirrors;
- downloaded artifact must be hash-verified and treated as untrusted until package
  metadata is inspected.

### GetDroidTips

Observed lead:

- Android 11 version: `RPFS31.Q1-21-20-1-7-3`
- Model: `XT2027-1`
- Channel/region: `RETUS | USA`

Use posture:

- useful index lead;
- download target must be verified independently;
- do not treat page listing as artifact proof.

## Required local handling if reacquired

If a candidate exact RETUS ZIP is downloaded, place it under:

- `C:\Projects\moto-one-hyper-local\firmware`

Do not place it inside the Git repo.

Before use, record locally:

- filename;
- size;
- SHA256;
- archive listing;
- XML metadata;
- build fingerprint;
- channel/carrier;
- model;
- whether the package contains sparse super chunks;
- whether it matches `RPFS31.Q1-21-20-1-7-3`;
- whether fingerprint/build metadata confirms `37074e`.

## Verification gate

The candidate artifact cannot be used as exact RETUS evidence until all of the
following are true:

1. model resolves to `XT2027-1`;
2. product resolves to `def` / `def_retail`;
3. channel resolves to `retus` / Retail USA;
4. build resolves to `RPFS31.Q1-21-20-1-7-3`;
5. fingerprint/build description confirms `37074e`;
6. SHA256 is recorded;
7. archive structure is consistent with Motorola XML firmware packages;
8. no firmware, partition image, blob, extracted tree, raw CSV, or download
   transcript is committed.

## Decision

Exact RETUS remains missing locally, but public reacquisition leads exist.

The next operator action is manual reacquisition of a candidate exact RETUS ZIP
into the local-only firmware directory, followed by local hash and metadata
verification.

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
