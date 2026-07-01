# Route B RETBR Combined Line Coverage Closeout

Status: evidence closeout; no import/build/device action authorized

## Scope

This report closes the Route B RETBR line-coverage evidence phase by combining
the vendor-side and non-vendor proprietary-file coverage results.

This is a report-safe evidence closeout only. It does not authorize blob import,
generated vendor tree creation, Lineage build use, adb/fastboot, LMSA/RSA
rescue or repair, flashing, bootloader actions, or physical device interaction.

WI-004 remains blocked.

## Source context

Target device:

- Motorola One Hyper XT2027-1
- codename/product: `def` / `def_retail`
- clean target build: `RPFS31.Q1-21-20-1-7-3 / 37074e`
- clean target channel: retus

Route B evidence package:

- firmware build: `RPFS31.Q1-21-20-5 / 1e3de`
- channel/source: RETBR
- use status: offline comparison evidence only

Matched source baseline:

- `sorenlyulf_android_device_motorola_def`
- `lineage20_android_device_motorola_sm6150-common`

## Committed evidence reports

This closeout summarizes:

- `reports/route_b_retbr_vendor_side_line_coverage_result.md`
- `reports/route_b_retbr_non_vendor_line_coverage_result.md`

Local-only CSVs, inventories, extracted images, helper scripts, and firmware
artifacts remain outside Git under `C:\Projects\moto-one-hyper-local`.

## Expected proprietary-file surface

| Tree | Active entries | Disabled/optional entries |
|---|---:|---:|
| `def` | 261 | 0 |
| `sm6150-common` | 952 | 32 |
| Combined | 1,213 | 32 |

Total parsed rows including disabled/optional entries: 1,245.

## Vendor-side result

Final vendor-side result:

| Coverage class | Count |
|---|---:|
| `direct-vendor-match` | 956 |
| `not-visible-in-vendor-combined-targeted-inventory` | 59 |
| `vendor-family-present-but-line-not-proven` | 14 |
| `non-vendor-partition-needed` | 184 |
| `disabled-or-optional` | 32 |

The vendor-side evidence directly matched 956 expected entries. Remaining
vendor-side unresolved entries are concentrated in WFD/Wi-Fi Display/HDCP,
QCRIL database upgrade tail, QTI data/CNE/latency, radio/IMS version gaps,
display calibration, Bluetooth audio, keymaster, and miscellaneous config gaps.

## Non-vendor result

The non-vendor pass analyzed `system_a.img` and `product_a.img` for the 184
entries that `vendor_a.img` could not prove.

Final non-vendor result:

| Coverage class | Count |
|---|---:|
| `direct-non-vendor-match` | 134 |
| `not-visible-in-non-vendor-targeted-inventory` | 50 |

The non-vendor pass resolved 134 of the 184 entries. Remaining non-vendor gaps
are concentrated in WFD/Wi-Fi Display system_ext entries, IMS/RCS newer-version
entries, UCE service 2.3 entries, UIM GBA product entries, and one Motorola
AndroidX camera permission entry.

## Combined result

| Metric | Count |
|---|---:|
| Active expected proprietary entries | 1,213 |
| Direct vendor matches | 956 |
| Direct non-vendor matches | 134 |
| Combined direct matches | 1,090 |
| Remaining active unresolved entries | 123 |
| Disabled/optional entries | 32 |

Direct observed coverage:

- `1,090 / 1,213`
- approximately `89.9%`

Remaining active unresolved entries:

- 73 vendor-side unresolved entries
- 50 non-vendor unresolved entries

## Evidence significance

The Route B RETBR firmware package is now strong offline comparison evidence for
the matched `def` and `sm6150-common` proprietary-file baseline.

The evidence is strong because:

- the firmware package was locally reconstructed and partitioned;
- `vendor_a.img`, `system_a.img`, and `product_a.img` were inspected locally;
- expected proprietary-file entries were parsed from matched source trees;
- direct path-level comparison resolved 1,090 active expected entries;
- remaining gaps are coherent and concentrated in version-sensitive or
  feature-sensitive groups.

## Limits

This closeout does not prove that RETBR is a safe replacement for exact retus
firmware.

Known limits:

- exact retus firmware remains missing;
- Route B is a different channel/source;
- remaining unresolved entries include WFD/Wi-Fi Display, IMS/RCS/UCE, QCRIL
  upgrade tail, and other version-sensitive families;
- source expectations may include entries not present in this Android 11 RETBR
  payload;
- no generated vendor tree has been produced;
- no build has been attempted;
- no device testing has occurred.

## Decision

Route B RETBR line-coverage evidence phase is closed as useful offline evidence.

It supports future decision-making, but it does not authorize any substitute
source decision by itself.

WI-004 remains blocked.

## Still blocked

The following remain blocked:

- exact retus substitution decision;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.

Any future movement from evidence to import/build/device work requires a separate
explicit authorization gate.
