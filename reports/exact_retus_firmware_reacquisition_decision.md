# Exact Retus Firmware Reacquisition Decision

Status: planning; no acquisition or device action authorized

Date: 2026-07-01

## Purpose

Decide whether the next effort should keep searching for exact retus firmware,
attempt a safer official LMSA/RSA metadata-only route, accept RETBR only for
evidence, or defer firmware-source resolution entirely.

This is a report-only decision review. It does not perform a new firmware
search, download firmware, inspect local-only artifacts, launch LMSA/RSA, connect
a phone, start Rescue/Repair, extract blobs, import blobs, generate a vendor
tree, build, use adb, use fastboot, or flash anything.

## Current target

The clean source target remains:

| Field | Value |
|---|---|
| Device | Motorola One Hyper / XT2027-1 |
| Codename/product | `def` / `def_retail` |
| Channel | `retus` |
| Exact build | `RPFS31.Q1-21-20-1-7-3` |
| Build tag/hash | `37074e` |
| Fingerprint | `motorola/def_retail/def:11/RPFS31.Q1-21-20-1-7-3/37074e:user/release-keys` |

The exact retus flashable package, exact retus vendor filesystem, exact retus
stock boot/recovery anchor, and exact retus hashes remain missing.

## Why RETBR cannot close WI-004

Route B RETBR `RPFS31.Q1-21-20-5 / 1e3de` is useful evidence, but it cannot close
WI-004 by itself because:

- it is RETBR, not retus;
- it is not the phone's installed `RPFS31.Q1-21-20-1-7-3 / 37074e` build;
- no byte-level or version-level RETBR-vs-retus comparison exists;
- modem/radio, qcril, IMS, TEE, keymaster, gatekeeper, fingerprint trustlets,
  DSP, and camera signed firmware remain channel/security-sensitive;
- no RETBR blob import is authorized;
- no RETBR build use is authorized;
- no RETBR file is accepted as a rollback or recovery asset for the physical
  phone.

The current Route B chain is a strong evidence trail, not a source substitution:

```text
evidence -> closeout -> coverage plan -> line coverage review -> blocked import gate
```

## Prior source outcomes

| Route/source | Outcome | Current reading |
|---|---|---|
| Software Fix / LMSA / RSA environment readiness | installed and inspectable, version `7.5.5.19`; no static exact package metadata found | official route exists but is GUI/device mediated |
| Route A supervised phone identification | phone identified as `XT2027-1`, Android `11`, current version `RPFS31.Q1-21-20-1-7-3`; no package filename, checksum, size, channel, or retus offer before `Start Rescue` | exact current build confirmed; package metadata gated behind write-coupled Rescue flow |
| lolinet / lenomola official path probes | no standard `def` path or `RPFS31.Q1-21-20` package found; h5ai JS rendering limited static enumeration | useful null result; not worth repeating unchanged |
| mirror metadata triangulation | found same-family A11 `-5` RETBR and `-10` generic `DEF_RETAIL`; no exact retus package or checksums | reached useful metadata limit |
| Route B RETBR acquisition | one mirror artifact acquired, hashed, and later inspected locally as evidence | useful for offline comparison only |
| Route B import authorization gate | opened as blocked | import remains blocked until exact retus or explicit acceptance decision |

## Is another exact-retus public search worth doing?

Not as a broad mirror crawl.

The prior metadata search already found that:

- exact retus `RPFS31.Q1-21-20-1-7-3 / 37074e` is attested but not packaged in
  surveyed public metadata;
- no reputable public/checksummed exact retus package was found;
- standard lolinet `def` paths did not expose the package;
- aggregators and Google Drive mirrors did not expose hashes and did not surface
  exact retus.

A repeat public search is worth doing only if one of these changes:

- a new official/reputable source class is identified;
- a known Motorola firmware index gains a `def`/retus path;
- an exact filename, checksum, or Lenovo/Motorola package identifier appears in
  a trusted source;
- Jeremy explicitly asks for a time-boxed refresh with current web evidence.

Otherwise, more mirror searching is likely to add noise rather than reduce the
core blocker.

## Can LMSA/RSA be used metadata-only?

Only under a very narrow future gate.

The prior supervised attempt proves Software Fix can identify the phone and
current build without adb, fastboot, root, or phone writes. It also proves that
the observed firmware-relevant next step was `Start Rescue`, and package
metadata was not visible before that hard stop.

Therefore a future official-source attempt may be metadata-only only if all of
the following are true:

- Jeremy explicitly approves a current-session supervised Route A metadata-only
  attempt;
- the goal is limited to observing package metadata, not starting Rescue/Repair;
- hard stops remain active for `Start Rescue`, Rescue, Repair, Update, Flash,
  Erase, download-and-repair, or any write-coupled preparation step;
- no adb, fastboot, bundled flash plugin, or device write helper is invoked;
- no firmware download starts unless separately approved;
- serial/IMEI/private identifiers are redacted from any public report.

If the GUI again hides package metadata behind `Start Rescue`, stop and record
the boundary. Do not cross it to obtain metadata.

## Decision options

| Option | Decision | Reason |
|---|---|---|
| Keep searching public mirrors now | not recommended | prior search reached useful limit; no hashes or exact retus package surfaced |
| Open a new official LMSA/RSA metadata-only attempt | possible later, but not authorized by this report | official route is the cleanest path, but it is device-mediated and Rescue-coupled |
| Accept RETBR as source substitute | blocked | RETBR evidence is not retus and cannot close channel/security-sensitive gaps |
| Defer firmware-source resolution | acceptable safe posture | preserves safety while source/build planning continues in report-only lanes |
| Time-boxed exact-retus refresh | possible later | useful only with explicit scope, current web search approval, and no downloads |

## Conditions for any future acquisition attempt

Any future acquisition attempt requires a separate explicit gate that records:

- route name and source class;
- whether the route is public metadata, official LMSA/RSA metadata, or download;
- exact target build/channel/product;
- allowed commands or GUI actions;
- local-only storage path;
- required hash/checksum capture;
- stop conditions;
- whether phone connection is allowed;
- whether firmware download is allowed;
- explicit statement that acquisition is not extraction, blob import, build, or
  flash approval.

For exact retus, acceptance should require:

- `XT2027-1`;
- `def` / `def_retail`;
- retus or clearly equivalent US retail channel;
- `RPFS31.Q1-21-20-1-7-3`;
- `37074e` or matching package metadata;
- package filename and size;
- SHA256 after local acquisition;
- package kept outside Git;
- committed report only.

## Still forbidden

This report does not authorize:

- LMSA/RSA execution;
- phone connection;
- `Start Rescue`;
- Rescue/Repair/Update/Flash/Erase;
- firmware download;
- local artifact inspection;
- extraction;
- filesystem mounting;
- blob import;
- generated `vendor/motorola` trees;
- Lineage build attempts;
- adb or fastboot;
- bootloader actions;
- flashing or booting any image.

## Current decision

Exact retus firmware remains the clean source target and the master blocker for
closing WI-004. RETBR remains useful only as offline evidence and planning input.

The next safest route is not import. It is either:

- defer firmware-source resolution and keep working only in report/governance
  lanes; or
- later open a tightly scoped official-source metadata-only decision gate for
  LMSA/RSA, with `Start Rescue` and all write-coupled actions as hard stops.

No acquisition or device action is authorized by this report.
