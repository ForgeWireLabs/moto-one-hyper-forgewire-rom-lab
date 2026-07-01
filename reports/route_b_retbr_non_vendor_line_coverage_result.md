# Route B RETBR Non-Vendor Line Coverage Result

Status: evidence result; no import/build/device action authorized

## Scope

This report summarizes local-only, report-safe comparison of expected
non-vendor proprietary file entries against Route B RETBR `system_a.img` and
`product_a.img`.

This pass follows the vendor-side line coverage result and targets only the
entries that could not be proven from `vendor_a.img` because their source paths
were outside `vendor/`.

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
- images analyzed:
  - `system_a.img`
  - `product_a.img`
- use status: offline comparison evidence only

## Inputs

Local-only inputs used for this evidence pass:

- `C:\Projects\moto-one-hyper-local\audits\route_b_retbr_expected_vs_vendor_a_combined_targeted_inventory_20260701.csv`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_5_RETBR_filesystems\logical\system_a.img`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_5_RETBR_filesystems\logical\product_a.img`

Local-only generated audit artifacts:

- `C:\Projects\moto-one-hyper-local\audits\non_vendor_targeted_inventory_RPFS31_Q1_21_20_5_RETBR.txt`
- `C:\Projects\moto-one-hyper-local\audits\non_vendor_targeted_observed_paths_20260701.csv`
- `C:\Projects\moto-one-hyper-local\audits\route_b_retbr_expected_vs_non_vendor_targeted_inventory_20260701.csv`

These artifacts remain local-only and must not be committed.

## Layout result

The non-vendor layout check confirmed:

- `system_a.img` exposes populated `system_ext` paths directly under `/system_ext`.
- `product_a.img` exposes product contents at image root.
- `product_a.img` does not contain nested `/product/...` paths.

Expected path mapping used for this pass:

| Expected source path prefix | Image | Observed path prefix |
|---|---|---|
| `system_ext/bin` | `system_a.img` | `/system_ext/bin` |
| `system_ext/etc` | `system_a.img` | `/system_ext/etc` |
| `system_ext/framework` | `system_a.img` | `/system_ext/framework` |
| `system_ext/lib` | `system_a.img` | `/system_ext/lib` |
| `system_ext/lib64` | `system_a.img` | `/system_ext/lib64` |
| `product/etc` | `product_a.img` | `/etc` |
| `product/framework` | `product_a.img` | `/framework` |

## Targeted inventory result

The targeted non-vendor inventory produced:

| Metric | Count |
|---|---:|
| Observed non-vendor rows after dedupe | 1,778 |
| Files | 1,729 |
| Directories | 49 |

Top logical prefixes:

| Prefix | Count |
|---|---:|
| `system_ext/lib64` | 232 |
| `system_ext/lib` | 224 |
| `system_ext/etc` | 117 |
| `product/etc` | 98 |
| `system_ext/framework` | 67 |
| `etc/permissions` | 39 |
| `system_ext/bin` | 17 |
| `product/framework` | 6 |

## Non-vendor comparison result

The prior vendor-side comparison left 184 entries classified as
`non-vendor-partition-needed`.

The targeted `system_a` + `product_a` comparison resolved:

| Coverage class | Count |
|---|---:|
| `direct-non-vendor-match` | 134 |
| `not-visible-in-non-vendor-targeted-inventory` | 50 |

By tree/family:

| Tree | Family | Coverage | Count |
|---|---|---|---:|
| `def` | `system_ext/lib` | direct match | 5 |
| `def` | `system_ext/lib64` | direct match | 5 |
| `def` | `other` | direct match | 1 |
| `sm6150-common` | `system_ext/lib64` | direct match | 46 |
| `sm6150-common` | `system_ext/lib64` | not visible | 17 |
| `sm6150-common` | `system_ext/lib` | direct match | 42 |
| `sm6150-common` | `system_ext/lib` | not visible | 20 |
| `sm6150-common` | `system_ext/framework` | direct match | 16 |
| `sm6150-common` | `system_ext/framework` | not visible | 3 |
| `sm6150-common` | `system_ext/etc` | direct match | 9 |
| `sm6150-common` | `system_ext/etc` | not visible | 5 |
| `sm6150-common` | `system_ext/bin` | not visible | 1 |
| `sm6150-common` | `product/etc` | direct match | 5 |
| `sm6150-common` | `product/etc` | not visible | 2 |
| `sm6150-common` | `product/framework` | not visible | 2 |
| `sm6150-common` | `other` | direct match | 5 |

## Combined line coverage after vendor and non-vendor passes

Previous vendor-side direct matches:

- `956 direct-vendor-match`

Non-vendor direct matches from this pass:

- `134 direct-non-vendor-match`

Combined direct evidence:

| Metric | Count |
|---|---:|
| Active expected proprietary entries | 1,213 |
| Direct matches after vendor + non-vendor targeted passes | 1,090 |
| Remaining vendor-side unresolved | 73 |
| Remaining non-vendor unresolved | 50 |
| Disabled/optional entries | 32 |

Direct observed coverage over active expected entries:

- `1,090 / 1,213`
- approximately `89.9%`

## Remaining non-vendor unresolved themes

The remaining 50 non-vendor unresolved entries are concentrated in:

- WFD / Wi-Fi Display system_ext stack;
- IMS / RCS newer-version framework and library entries;
- UCE service 2.3 library entries;
- UIM GBA product permission and framework entries;
- one Motorola AndroidX camera permission item.

These remaining gaps align with the vendor-side residual pattern: WFD/Wi-Fi
Display is not fully observed, and some IMS/RCS/UCE expectations appear newer or
differently packaged than the Route B RETBR Android 11 payload.

## Interpretation

The Route B RETBR `system_a.img` and `product_a.img` provide strong additional
line-level evidence for expected non-vendor proprietary entries, resolving 134
of the 184 entries that could not be proven from `vendor_a.img`.

Combined with the vendor-side result, Route B RETBR now directly proves 1,090 of
1,213 active expected proprietary entries across the matched `def` and
`sm6150-common` proprietary lists.

This supports RETBR as strong offline comparison evidence. It does not authorize
RETBR as a retus substitute and does not close WI-004.

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
