# Route B RETBR Vendor-Side Line Coverage Result

Status: evidence result; no import/build/device action authorized

## Scope

This report summarizes local-only, report-safe line coverage analysis comparing
the matched `def` and `sm6150-common` proprietary file expectations against the
Route B RETBR `vendor_a.img` filesystem inventory.

This is an evidence result only. It does not authorize blob import, generated
vendor trees, build use, device interaction, adb/fastboot, LMSA/RSA rescue, or
flashing.

## Source context

Target device:

- Motorola One Hyper XT2027-1
- codename/product: `def` / `def_retail`
- current target build: `RPFS31.Q1-21-20-1-7-3 / 37074e`
- clean source target remains exact retus firmware

Route B evidence package:

- firmware build: `RPFS31.Q1-21-20-5 / 1e3de`
- channel/source: RETBR
- partition analyzed: `vendor_a.img`
- use status: offline comparison evidence only

## Inputs

Local-only inputs used for this evidence pass:

- `C:\Projects\moto-one-hyper-local\sources\sorenlyulf_android_device_motorola_def\proprietary-files.txt`
- `C:\Projects\moto-one-hyper-local\sources\lineage20_android_device_motorola_sm6150-common\proprietary-files.txt`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_5_RETBR_filesystems\logical\vendor_a.img`

Local-only generated audit artifacts:

- `C:\Projects\moto-one-hyper-local\audits\proprietary_files_expected_entries_20260701.csv`
- `C:\Projects\moto-one-hyper-local\audits\vendor_a_report_safe_observed_paths_20260701.csv`
- `C:\Projects\moto-one-hyper-local\audits\vendor_a_deep_targeted_observed_paths_20260701.csv`
- `C:\Projects\moto-one-hyper-local\audits\vendor_a_combined_targeted_observed_paths_20260701.csv`
- `C:\Projects\moto-one-hyper-local\audits\route_b_retbr_expected_vs_vendor_a_combined_targeted_inventory_20260701.csv`
- `C:\Projects\moto-one-hyper-local\audits\route_b_retbr_vendor_side_residual_unresolved_20260701.csv`

These artifacts remain local-only and must not be committed.

## Expected proprietary entries parsed

The matched source proprietary lists produced:

| Tree | Active entries | Disabled/optional entries |
|---|---:|---:|
| `def` | 261 | 0 |
| `sm6150-common` | 952 | 32 |
| Combined | 1,213 | 32 |

Total parsed rows including disabled/optional entries: 1,245.

## Inventory progression

The first report-safe vendor inventory was intentionally shallow. It proved the
package was coherent and that major families existed, but it did not enumerate
deep enough to prove most exact proprietary-file expectations.

Coverage improved across targeted passes:

| Pass | Direct vendor matches | Family present but exact line not proven | Vendor not visible |
|---|---:|---:|---:|
| Initial report-safe inventory | 143 | 659 | 227 |
| Deep targeted inventory | 838 | 37 | 154 |
| Combined targeted inventory | 956 | 14 | 59 |

The large increase from 143 to 956 direct matches shows that the earlier gap was
mostly inventory depth, not evidence of absence.

## Final combined targeted coverage

Final comparison result:

| Coverage class | Count |
|---|---:|
| `direct-vendor-match` | 956 |
| `non-vendor-partition-needed` | 184 |
| `not-visible-in-vendor-combined-targeted-inventory` | 59 |
| `disabled-or-optional` | 32 |
| `vendor-family-present-but-line-not-proven` | 14 |

By tree:

| Tree | Direct vendor match | Non-vendor partition needed | Not visible | Family present but line not proven | Disabled/optional |
|---|---:|---:|---:|---:|---:|
| `def` | 246 | 11 | 4 | 0 | 0 |
| `sm6150-common` | 710 | 173 | 55 | 14 | 32 |

## Direct matches by family

| Tree | Family | Direct matches |
|---|---|---:|
| `sm6150-common` | `vendor/lib64` | 336 |
| `sm6150-common` | `vendor/lib` | 219 |
| `def` | `vendor/lib64` | 106 |
| `sm6150-common` | `vendor/etc` | 73 |
| `def` | `vendor/firmware` | 71 |
| `def` | `vendor/etc` | 58 |
| `sm6150-common` | `vendor/bin` | 54 |
| `sm6150-common` | `vendor/radio` | 23 |
| `def` | `vendor/lib` | 7 |
| `sm6150-common` | `vendor/firmware` | 5 |
| `def` | `vendor/bin` | 4 |

## Residual unresolved vendor-side groups

After the combined targeted pass, 73 vendor-side entries remained unresolved.

| Residual group | Count |
|---|---:|
| WFD / Wi-Fi Display / HDCP | 32 |
| QCRIL database upgrade tail | 13 |
| QTI data / CNE / latency | 9 |
| Miscellaneous config gap | 6 |
| Radio / IMS version gap | 4 |
| Display panel calibration | 4 |
| Other | 2 |
| Bluetooth audio version gap | 2 |
| Keymaster version gap | 1 |

## QCRIL upgrade result

Observed under `vendor/radio/qcril_database/upgrade`:

- `0_initial.sql`
- `3_version_qcrildb.sql` through `23_version_qcrildb.sql`

Not observed from the matched common-tree expectations:

- `24_version_qcrildb.sql` through `31_version_qcrildb.sql`
- `33_version_qcrildb.sql` through `37_version_qcrildb.sql`

Interpretation:

The QCRIL database upgrade residual appears to be a version/build delta between
the common-tree expectation and the Route B RETBR Android 11 vendor payload.

## WFD / Wi-Fi Display / HDCP result

Observed HDCP-related files include:

- `vendor/bin/hdcp1prov`
- `vendor/bin/hdcp2p2prov`
- `vendor/lib/libhdcp1prov.so`
- `vendor/lib/libhdcp2p2prov.so`
- `vendor/lib/libhdcpsrm.so`
- `vendor/lib/libmm-hdcpmgr.so`
- matching `vendor/lib64` HDCP libraries

Not observed from the matched common-tree expectations:

- WFD service binaries such as `wfdvndservice`, `wifidisplayhalservice`, and
  `wfdhdcphalservice`
- WFD proprietary libraries such as `libwfd*_proprietary.so`
- WFD init, seccomp, and config files
- `vendor.qti.hardware.wifidisplaysession*` libraries

Interpretation:

The RETBR vendor payload shows HDCP provisioning/library evidence but does not
show the broader WFD/Wi-Fi Display service stack expected by the common tree.

## Non-vendor partition requirement

184 expected entries cannot be proven from `vendor_a.img` alone because their
source paths are outside `vendor/`.

These require separate report-safe comparison against other logical partitions,
especially:

- `product_a.img`
- `system_a.img`
- possible system/system_ext layout paths exposed through the Android 11 dynamic
  partition structure

No conclusion about these entries should be drawn from vendor-side inventory
alone.

## Conclusion

The Route B RETBR `vendor_a.img` provides strong line-level evidence for the
expected vendor-side proprietary surface from the matched `def` and
`sm6150-common` source baseline.

The final combined targeted pass directly matched 956 vendor-side expected
entries, including the bulk of `vendor/lib`, `vendor/lib64`, `vendor/etc`,
`vendor/bin`, `vendor/firmware`, and `vendor/radio` expectations.

Remaining unresolved vendor-side entries are concentrated in version-sensitive
or feature-sensitive groups, especially WFD/Wi-Fi Display/HDCP service coverage,
QCRIL database upgrade tail files, QTI data/CNE/latency items, and radio/IMS
version gaps.

This result supports the use of RETBR as strong offline comparison evidence. It
does not authorize RETBR as a retus substitute and does not close WI-004.

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

WI-004 remains blocked until exact source, import, build, and device gates are
explicitly resolved.
