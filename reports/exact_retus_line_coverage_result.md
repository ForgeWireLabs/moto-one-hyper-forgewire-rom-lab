# Exact RETUS Line Coverage Result

Status: exact RETUS Route A evidence result; no import/build/device action authorized

## Scope

This report summarizes local-only, report-safe line coverage analysis comparing
the matched `def` and `sm6150-common` proprietary file expectations against the
exact RETUS firmware package:

- Product: `def_retail`
- Android: `11`
- Build: `RPFS31.Q1-21-20-1-7-3`
- Fingerprint tail: `37074e`
- Channel/region evidence: `retail.en.US` / RETUS package filename and path

This is an evidence result only. It does not authorize blob import, generated
vendor trees, Lineage build use, device interaction, adb/fastboot, LMSA/RSA
rescue, flashing, bootloader actions, source-list edits, or source-list waivers.

## Inputs

Local-only source expectation files:

- `C:\Projects\moto-one-hyper-local\sources\sorenlyulf_android_device_motorola_def\proprietary-files.txt`
- `C:\Projects\moto-one-hyper-local\sources\lineage20_android_device_motorola_sm6150-common\proprietary-files.txt`

Local-only exact RETUS reconstructed images:

- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS_filesystems\logical\vendor_a.img`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS_filesystems\logical\system_a.img`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS_filesystems\logical\product_a.img`

Previously verified exact RETUS firmware ZIP:

- `C:\Projects\moto-one-hyper-local\firmware\XT2027-1_DEF_RETUS_11_RPFS31.Q1-21-20-1-7-3_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip`
- SHA256: `907E380CF26758F9B5E4B2E05AC663123A526FEEFFB40A9E28D72D4568ADD7B8`

Previously verified exact RETUS raw super:

- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS_filesystems\super.raw.img`
- SHA256: `562711ADEFF33DBE1334FB8AEF862AEA41749A27BF358E15944195A2EE431659`

## Local-only generated audit artifacts

The following local-only artifacts were generated under
`C:\Projects\moto-one-hyper-local\audits` and must not be committed:

- `vendor_a_report_safe_inventory_RPFS31_Q1_21_20_1_7_3_RETUS.txt`
- `vendor_a_deep_targeted_inventory_RPFS31_Q1_21_20_1_7_3_RETUS.txt`
- `vendor_a_unresolved_deep_inventory_RPFS31_Q1_21_20_1_7_3_RETUS.txt`
- `non_vendor_targeted_inventory_RPFS31_Q1_21_20_1_7_3_RETUS.txt`
- `exact_retus_proprietary_files_expected_entries_20260702.csv`
- `exact_retus_vendor_a_combined_targeted_observed_paths_20260702.csv`
- `exact_retus_expected_vs_vendor_a_combined_targeted_inventory_20260702.csv`
- `exact_retus_non_vendor_targeted_observed_paths_20260702.csv`
- `exact_retus_expected_vs_non_vendor_targeted_inventory_20260702.csv`
- `exact_retus_combined_line_coverage_20260702.csv`
- `exact_retus_combined_line_coverage_adjusted_v2_20260702.csv`
- `exact_retus_fallback_path_matches_v2_20260702.csv`
- `exact_retus_line_coverage_summary_adjusted_v2_20260702.txt`
- `exact_retus_unresolved_active_entries_20260702.csv`

## Inventory generation

Exact RETUS targeted inventories were generated from:

- `vendor_a.img`
- `system_a.img`
- `product_a.img`

Inventory outputs:

| Inventory | SHA256 | Lines |
|---|---|---:|
| `vendor_a_report_safe_inventory_RPFS31_Q1_21_20_1_7_3_RETUS.txt` | `494d9cc6c9596ffb6faed378dc4294ba9d6e8b7d89a83ee29522d3102c876060` | `567` |
| `vendor_a_deep_targeted_inventory_RPFS31_Q1_21_20_1_7_3_RETUS.txt` | `3a5360fa1ba92fa56509717780c8de16deac2d9f6286f6ba81d3bd79f2070aa2` | `2,204` |
| `vendor_a_unresolved_deep_inventory_RPFS31_Q1_21_20_1_7_3_RETUS.txt` | `48cb61bd6b606f26a5f8a7f2ab2969567db2a8daf7cc6a8cdf877c04fcd38b89` | `283` |
| `non_vendor_targeted_inventory_RPFS31_Q1_21_20_1_7_3_RETUS.txt` | `ff624930098f5e0be55c0c95526664c46d1a28c772fa3ee52c9698a58834e3be` | `1,853` |

Observed path counts after dedupe:

| Observed set | Count |
|---|---:|
| Vendor observed paths | `2,195` |
| Non-vendor observed paths | `1,729` |

## Expected proprietary-file surface

Parsed expected proprietary entries:

| Metric | Count |
|---|---:|
| Expected parsed rows with normalized paths | `1,245` |
| Active expected entries | `1,213` |
| Disabled/optional entries | `32` |

## First-pass vendor-side result

Vendor-side classification before fallback adjustment:

| Coverage class | Count |
|---|---:|
| `direct-vendor-match` | `956` |
| `non-vendor-partition-needed` | `184` |
| `not-visible-in-vendor-combined-targeted-inventory` | `73` |
| `disabled-or-optional` | `32` |

By partition family:

| Partition family | Coverage class | Count |
|---|---|---:|
| `vendor` | `direct-vendor-match` | `956` |
| `vendor` | `not-visible-in-vendor-combined-targeted-inventory` | `73` |
| `vendor` | `disabled-or-optional` | `21` |
| `system_ext` | `non-vendor-partition-needed` | `169` |
| `system_ext` | `disabled-or-optional` | `9` |
| `product` | `non-vendor-partition-needed` | `9` |
| `product` | `disabled-or-optional` | `1` |
| `other` | `non-vendor-partition-needed` | `6` |
| `other` | `disabled-or-optional` | `1` |

## First-pass non-vendor result

Non-vendor target classification before fallback adjustment:

| Coverage class | Count |
|---|---:|
| `direct-non-vendor-match` | `128` |
| `not-visible-in-non-vendor-targeted-inventory` | `50` |

By partition family:

| Partition family | Coverage class | Count |
|---|---|---:|
| `system_ext` | `direct-non-vendor-match` | `123` |
| `system_ext` | `not-visible-in-non-vendor-targeted-inventory` | `46` |
| `product` | `direct-non-vendor-match` | `5` |
| `product` | `not-visible-in-non-vendor-targeted-inventory` | `4` |

## Fallback path adjustment

The first-pass comparison intentionally used strict normalized source paths. Six
active entries were classified as `other` because their source side lacked an
explicit `vendor/`, `system/`, `system_ext/`, or `product/` prefix, or because
the destination side carried the true partition mapping.

A second report-safe adjustment pass checked those six unprefixed paths against
the exact RETUS observed path sets and recorded explicit fallback matches.

Fallback matches:

| Tree | Line | Source path | Adjusted class | Observed fallback path |
|---|---:|---|---|---|
| `def` | `237` | `lib/motorola.hardware.popup@1.0.so` | `direct-vendor-match` | `vendor/lib/motorola.hardware.popup@1.0.so` |
| `sm6150-common` | `93` | `lib64/libaptXHD_encoder.so` | `direct-non-vendor-match` | `system/lib64/libaptXHD_encoder.so` |
| `sm6150-common` | `94` | `lib64/libaptX_encoder.so` | `direct-non-vendor-match` | `system/lib64/libaptX_encoder.so` |
| `sm6150-common` | `599` | `etc/permissions/privapp-permissions-qti.xml` | `direct-non-vendor-match` | `system/etc/permissions/privapp-permissions-qti.xml` |
| `sm6150-common` | `754` | `etc/permissions/moto-telephony.xml` | `direct-non-vendor-match` | `system/etc/permissions/moto-telephony.xml` |
| `sm6150-common` | `755` | `framework/moto-telephony.jar` | `direct-non-vendor-match` | `system/framework/moto-telephony.jar` |

This adjustment is evidence-only. It records that the expected files are present
under exact RETUS observed paths; it does not authorize source-list edits or
waivers.

## Final adjusted exact RETUS coverage

Final adjusted combined classes:

| Coverage class | Count |
|---|---:|
| `direct-vendor-match` | `957` |
| `direct-non-vendor-match` | `133` |
| `not-visible-in-vendor-combined-targeted-inventory` | `73` |
| `not-visible-in-non-vendor-targeted-inventory` | `50` |
| `disabled-or-optional` | `32` |

Combined direct evidence:

| Metric | Count |
|---|---:|
| Active expected entries | `1,213` |
| Direct vendor matches | `957` |
| Direct non-vendor matches | `133` |
| Combined direct matches | `1,090` |
| Remaining active unresolved entries | `123` |
| Disabled/optional entries | `32` |

Direct observed coverage over active expected entries:

- `1,090 / 1,213`
- approximately `89.8599%`

## Comparison to Route B RETBR

The adjusted exact RETUS result reaches the same combined direct count previously
observed in Route B RETBR evidence:

| Evidence route | Combined direct matches | Active expected entries | Coverage |
|---|---:|---:|---:|
| Route B RETBR | `1,090` | `1,213` | approximately `89.9%` |
| Route A exact RETUS | `1,090` | `1,213` | approximately `89.8599%` |

The significance is not that RETBR can be substituted. The significance is that
the exact RETUS package now independently supports the same broad proprietary
file coverage result while remaining the authoritative Route A evidence source.

RETBR remains comparison-only evidence.

## Remaining unresolved active entries

After exact RETUS adjusted coverage, `123` active expected entries remain
unresolved:

| Unresolved class | Count |
|---|---:|
| `not-visible-in-vendor-combined-targeted-inventory` | `73` |
| `not-visible-in-non-vendor-targeted-inventory` | `50` |

The unresolved entries remain local-only in:

- `C:\Projects\moto-one-hyper-local\audits\exact_retus_unresolved_active_entries_20260702.csv`

They require further drift/equivalence review before any source-list decision.

## Decision

Exact RETUS Route A line coverage is complete enough to replace Route B as the
authoritative firmware evidence path for this stage.

Route B RETBR remains useful only as comparison evidence.

No source-list edits, waivers, blob imports, generated vendor trees, or builds
are authorized by this report.

## Next evidence step

Create an exact RETUS unresolved-entry classification report using the local-only
adjusted unresolved CSV. The classification should separate:

- hard blockers;
- exact source-list drift candidates;
- renamed/version-shifted entries;
- destination-mapping or prefix-normalization issues;
- entries requiring deeper targeted inventory;
- entries that must remain do-not-waive.

## Still blocked

The following remain blocked:

- source-list edits;
- source-list waivers;
- RETBR substitution;
- blob import into `vendor/motorola`;
- generated vendor tree creation;
- Lineage build;
- device interaction;
- adb/fastboot;
- LMSA/RSA rescue/repair;
- flashing or bootloader actions.
