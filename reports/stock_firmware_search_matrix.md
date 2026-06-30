# Stock Firmware Search Matrix

Status: refreshed with metadata-only discovery findings

Date: 2026-06-28 (framework); refreshed 2026-06-30 (discovery pass)

Refresh note (2026-06-30): added a metadata-only discovery pass (web listings and
source metadata only — no firmware/image downloads, no extraction, no blobs, no
committed firmware artifacts). See "Discovered candidates" and "Discovery answers"
below. The search framework above the refresh is unchanged.

## Safety boundary

This report defines firmware search and metadata review only.

No physical phone action is authorized.

No firmware package is accepted by this report.

No firmware package should be downloaded into the Git repository.

No boot, recovery, vbmeta, dtbo, super, modem, radio, persist, EFS-like, or partition image is produced, modified, flashed, or booted.

Firmware packages, if later downloaded, must stay outside the repo under:

    C:\Projects\moto-one-hyper-local\firmware

Extracted firmware metadata, if later produced, must stay outside the repo under:

    C:\Projects\moto-one-hyper-local\extracted

Only scripts, manifests, checksums, and metadata reports may be committed.

## Known target identity

| Field | Current known value | Search importance |
|---|---|---|
| Device | Motorola One Hyper | high |
| Model | XT2027-1 | critical |
| Codename | def | critical |
| Product | def_retail | critical |
| Channel | retus | critical |
| Android version | 11 | high |
| Build | RPFS31.Q1-21-20-1-7-3 | critical |
| Fingerprint | motorola/def_retail/def:11/RPFS31.Q1-21-20-1-7-3/37074e:user/release-keys | critical |
| Active slot previously observed | _a | informational only; not used for action |
| Bootloader state previously observed | unlocked / AVB orange | informational only; not used for action |

## Search strings

| Priority | Query | Purpose |
|---:|---|---|
| 1 | XT2027-1 RPFS31.Q1-21-20-1-7-3 | exact model/build search |
| 2 | def_retail RPFS31.Q1-21-20-1-7-3 | exact product/build search |
| 3 | RPFS31.Q1-21-20-1-7-3 retus | exact build/channel search |
| 4 | Motorola One Hyper retus Android 11 firmware | broad channel/version search |
| 5 | XT2027-1 retus firmware | model/channel search |
| 6 | def_retail retus firmware | product/channel search |
| 7 | Motorola One Hyper stock ROM retus | stock ROM mirror search |
| 8 | XT2027-1 def_retail Android 11 stock firmware | broad model/product/version search |

## Candidate source classes

| Source class | Use | Acceptance posture |
|---|---|---|
| Motorola RSA / Software Fix route | authoritative recovery path and package discovery clue | preferred metadata source; do not run opaque tools blindly |
| Lolinet / Lenomola Motorola firmware paths | firmware package discovery and filename metadata | useful if exact model/product/channel/build match is found |
| Community forum posts | filename and version clues only | not accepted without independent package verification |
| Random firmware mirrors | last-resort metadata clues | high skepticism; require checksum/source corroboration |
| GitHub source trees | source metadata only | not firmware evidence |

## Acceptance requirements

A firmware package is not accepted unless the metadata strongly supports:

- Motorola One Hyper / XT2027-1.
- def or def_retail.
- retus channel, or a clearly compatible retail US package.
- Android 11.
- Build RPFS31.Q1-21-20-1-7-3 exactly, or a consciously documented near-match with risks.
- Package contents suitable for metadata extraction.
- Checksums recorded outside the repo before extraction.

## Rejection rules

Reject or quarantine firmware candidates when:

- Model does not match XT2027-1.
- Product/codename does not match def / def_retail.
- Channel is not retus or clearly compatible.
- Android generation is not Android 11 unless explicitly being retained as historical evidence.
- Build is older/newer and no risk note is written.
- Package origin is unclear.
- Package requires an opaque downloader or executable with no metadata visibility.
- Package includes files that cannot be safely identified.

## Metadata to capture per candidate

| Field | Required | Notes |
|---|---|---|
| Source URL or source description | yes | raw URLs may stay in local notes if needed; committed reports should avoid unsafe direct download instructions |
| Filename | yes | important for Motorola package matching |
| Model | yes | must be checked against XT2027-1 |
| Product/codename | yes | must be checked against def/def_retail |
| Channel/region | yes | must be checked against retus |
| Android version | yes | target is Android 11 |
| Build ID | yes | target is RPFS31.Q1-21-20-1-7-3 |
| Size | yes | metadata sanity check |
| Hash/checksum | yes, once downloaded outside repo | never skip for accepted local artifacts |
| Package contents | later | requires local extraction outside repo |
| Acceptance status | yes | accepted / rejected / pending / historical clue |

## Local artifact policy

Permitted local-only paths:

    C:\Projects\moto-one-hyper-local\firmware
    C:\Projects\moto-one-hyper-local\extracted
    C:\Projects\moto-one-hyper-local\checksums
    C:\Projects\moto-one-hyper-local\audits
    C:\Projects\moto-one-hyper-local\logs

Forbidden Git artifacts:

- firmware ZIPs
- payload BIN files
- boot/recovery/vendor_boot/dtbo/vbmeta images
- sparse images
- super images
- modem/radio images
- extracted proprietary blobs
- large binaries

## Discovered candidates (2026-06-30, metadata only)

All entries below are from web listings/metadata only. Nothing was downloaded,
extracted, or committed. "Reputable" = lolinet/Android-Dumps/official; "mirror" =
aggregator/forum/Google-Drive tier.

| Build (RPFS31.Q1-21-20-…) | Hash | Channel (claimed) | Best provenance found | Tier | Flashable pkg located? |
|---|---|---|---|---|---|
| `-1-7-3` (phone's exact build) | `37074e` | retus | UA strings only (user-agents.net) | attestation only | **No reputable package located** |
| `-5` (sorenlyulf's vendor base) | `1e3de` | def_retail (romstockbr labels RETBR) | Android Dumps GitLab filesystem dump `def_retail-user-11-RPFS31.Q1-21-20-5-1e3de` | reputable (metadata/dump) | dump yes; full flashable pkg on mirror/GDrive tier |
| `-2` | — | def_retail / RETBR | romstockbr / stockrom.net listings | mirror | mirror tier |
| `-10` | — | DEF_RETAIL | Google Drive file + aggregator listings (`…DEF_RETAIL_RPFS31.Q1-21-20-10_Subsidy_11.zip`, ~2.25 GB) | mirror | mirror/GDrive tier |
| A10 `QPF30.104` / `QPF30.103-*` | various | retail, reteu | Android Dumps branches (15 total) | reputable (dump) | historical (A10) — matches ludevjhon/AndroidBlobs base |

Note: the `-5` dump hash `1e3de` matches sorenlyulf's `BUILD_FINGERPRINT`
(`def:11/RPFS31.Q1-21-20-5/1e3de`), independently corroborating that audit. The
phone's `-1-7-3` carries a different hash `37074e` (per the framework fingerprint
above), i.e. a distinct package from `-5`.

## Source reputability classification

| Source | URL | Tier | What it offers |
|---|---|---|---|
| lolinet / lenomola | `mirrors.lolinet.com/firmware/lenomola/<year>/<codename>/official/<CHANNEL>/` | reputable mirror (h5ai) | flashable packages; exact `def` path not pinned this pass (RETUS guesses 404'd; `def` likely under RETAIL/RETBR/RETEU, matching the channels Android Dumps shows) |
| Android Dumps | `dumps.tadiphone.dev/dumps/motorola/def` | reputable (metadata/dumps) | filesystem dumps, not flashable firmware; **has the `-5` (1e3de) A11 dump** and the A10 QPF30 dumps |
| Motorola RSA / LMSA | official Motorola/Lenovo rescue | authoritative, on-demand | device-matched firmware; **no static URLs or pre-published checksums** |
| Aggregators | motostockrom, getdroidtips, addrom, firmwareoficial, romstockbr, stockrom.net, firmwaredrive, firmwareupdate24 | mirror/forum | filename/version clues; repackaging risk; checksums rarely exposed |
| Google Drive mirrors | per-file links | mirror | unverifiable provenance |

## Discovery answers (the seven questions)

1. **Exact `RPFS31.Q1-21-20-1-7-3` available reputably?** No. The build is
   **attested as a real retus OTA** (UA strings) but **no reputable flashable
   package was located**. The `-1-7-3` suffix is consistent with an
   incremental/OTA build that is often not separately mirrored as a full image.
2. **`RPFS31.Q1-21-20-5` available?** Yes, as **metadata** (Android Dumps
   `…-5-1e3de` filesystem dump — sorenlyulf's exact base). Full flashable
   packages appear only on mirror/Google-Drive tier; romstockbr labels `-5` as
   RETBR.
3. **Other `RPFS31.Q1-21-20` family retus XT2027-1 packages?** Family confirmed:
   `-2`, `-5`, `-10` surfaced (def_retail / RETBR / DEF_RETAIL). `-10` is the
   highest seen. None confirmed as a clean **retus** flashable package this pass.
4. **Official/reputable vs mirrors/forums?** Reputable: lolinet, Android Dumps,
   Motorola RSA/LMSA. Lower trust: the aggregator and Google-Drive listings above.
5. **Safest future blob baseline (if any)?** Provisionally **`-5` (1e3de)** —
   it is the exact base sorenlyulf was built against *and* has a reputable
   Android Dumps filesystem dump for provenance cross-checking. Caveats: it is
   **not** the phone's `-1-7-3` build, and its channel may be RETBR (retus match
   unverified). A true **retus `RPFS31.Q1-21-20`** package located via a direct
   lolinet browse would be preferable if one exists.
6. **Hashes/checksums available?** **None exposed** in the metadata reviewed this
   pass. lolinet folders sometimes ship in-folder checksums, but the exact `def`
   path was not pinned; aggregators rarely publish hashes. Checksum capture
   remains pending a direct reputable-source browse.
7. **What remains unverified?** Existence/provenance of a reputable `-1-7-3`
   retus package; the actual channel of `-5` (RETBR vs RETAIL vs RETUS); all
   checksums; whether `-5` blobs are compatible with a `-1-7-3` device; lolinet's
   exact `def` folder path and contents.

## lolinet official-directory enumeration (2026-06-30, read-only)

Goal: determine whether lolinet exposes an official `def` firmware path with
`RPFS31.Q1-21-20` packages and checksums. Method: read-only HTTP probes of the
`lenomola/<year>/<codename>/official/<CHANNEL>/` scheme. No downloads.

Tooling limitation: lolinet directory pages are rendered by **h5ai via
JavaScript**. A static read-only fetch sees only each folder's `README.html`, not
the JS-populated entries. So a year bucket that *exists* returns a near-empty
render, while a non-existent path returns a hard **HTTP 404**. The 404-vs-render
distinction is therefore a reliable *existence* signal even though folder
*contents* could not be enumerated.

| Path probed | Result | Reading |
|---|---|---|
| `lenomola/` | renders | year buckets exist (2020–2026, `_obsoleted_`); contents JS-only |
| `lenomola/def/` | **404** | no def folder at root |
| `lenomola/def/official/` | **404** | — |
| `lenomola/2021/` | renders | bucket exists; contents JS-only |
| `lenomola/2021/def/` | **404** | no def under 2021 |
| `lenomola/2021/def/official/` | **404** | — |
| `lenomola/2021/def/official/RETUS/` | **404** | — |
| `lenomola/2020/def/` | **404** | no def under 2020 |
| `lenomola/2019/def/` | **404** | no def under 2019 |
| `lenomola/_obsoleted_/def/` | **404** | not in the obsolete bucket |
| `mirrors-obs-1 …/2021/def/official/` | connection closed | inconclusive (alt mirror) |

Control: sibling codenames resolve under the same scheme (e.g. `denver` under
2021, `tonga` under `2021/.../official/RETUS/`), confirming the path scheme is
valid and that the `def` 404s reflect an absent codename folder, not a wrong
scheme.

### lolinet enumeration answers

1. Real `def` path under `lenomola/2021/def/official/` or equivalent? **No** —
   404 at every standard location probed.
2. Channel folders (retus/RETUS/def_retail/retail/RETBR)? **None reachable** — no
   def parent folder exists to contain them.
3. `RPFS31.Q1-21-20-*` packages on lolinet? **None located.**
4. Exact `RPFS31.Q1-21-20-1-7-3` on lolinet? **Not present** at standard paths.
5. `RPFS31.Q1-21-20-5` on lolinet? **Not present** at standard paths.
6. Checksums / XML / filenames / dates / sizes? **None accessible** — h5ai JS
   rendering blocks static enumeration; no in-folder checksum files were
   reachable.
7. Anything distinguishing retus from RETBR / def_retail? **N/A** — no def path.
8. Safest future blob baseline? **Unchanged** — lolinet added nothing; the only
   provenance-backed option remains `-5` (1e3de) via Android Dumps
   (`dumps.tadiphone.dev/dumps/motorola/def`), still **provisional** and not a
   retus match. **Blocker remains open.**

Caveat: because the year buckets could not be fully enumerated (JS rendering),
"def is absent from lolinet" is **strongly indicated, not exhaustively proven**.
A def folder under a non-standard path cannot be fully excluded by these probes.

Posture: per instruction, with no usable official lolinet def path found, **do not
pivot to mirror/Google-Drive downloads** (motostockrom, romstockbr, GDrive, etc.)
**without separate approval**. This pass stays official-source, metadata-only.

## Current decision

No stock firmware package is accepted. No package was downloaded, extracted, or
committed. Safety posture unchanged.

lolinet did not expose a checksummed official `def` retus package (or any
`RPFS31.Q1-21-20` def package) at standard paths, so no new preferred baseline is
set and the firmware master blocker stays open. The provenance-backed `-5`
(1e3de) Android Dumps entry remains the only same-family metadata baseline, and
it is provisional (not retus, not the phone's `-1-7-3`).

State of the master blocker: the `RPFS31.Q1-21-20` family and the phone's exact
`-1-7-3` build are **confirmed real**, and a reputable metadata dump exists for
the `-5` (1e3de) base that sorenlyulf targets — so the A11 vendor base is
*locatable in principle*. It is **not yet pinned to a reputable, checksum-verified
retus flashable package**.

Recommended next safe (still metadata-only) actions, in order:

1. ~~Direct read-only browse of lolinet~~ — **done 2026-06-30, null result** (see
   the lolinet enumeration section: no `def` path at standard locations; no
   `RPFS31.Q1-21-20` package; no checksums reachable).
2. Pursue the **official Motorola route** for a checksum-bearing retus package:
   Rescue and Smart Assistant (LMSA) / Motorola support firmware, which serves
   device-matched packages on demand. Capture only the resulting metadata
   (filename, build, channel, size, hash) into
   `reports/stock_firmware_candidate_inventory.md`; do not download images.
3. As the provenance-backed fallback, document `-5` (1e3de) via the Android Dumps
   route (`dumps.tadiphone.dev/dumps/motorola/def`) as the A11 metadata baseline,
   with the explicit retus-vs-RETBR channel caveat.
4. Do **not** pivot to aggregator/Google-Drive mirror downloads without a separate
   explicit approval.
5. Only after a checksum-verified package is identified (downloaded **outside**
   the repo, under `C:\Projects\moto-one-hyper-local\firmware`) should extraction
   planning begin — still no phone action.
