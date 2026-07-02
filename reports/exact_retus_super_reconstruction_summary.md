# Exact RETUS Super Reconstruction Summary

Status: exact RETUS `super` image reconstructed and logical partitions carved as local-only evidence.

No firmware images, sparse chunks, raw images, logical partition images, extracted files, blobs, generated vendor trees, or raw inventories are committed.

## Source artifact

Local-only firmware ZIP:

- `C:\Projects\moto-one-hyper-local\firmware\XT2027-1_DEF_RETUS_11_RPFS31.Q1-21-20-1-7-3_subsidy-DEFAULT_regulatory-DEFAULT_CFC.xml.zip`

Previously verified artifact hash:

- SHA256: `907E380CF26758F9B5E4B2E05AC663123A526FEEFFB40A9E28D72D4568ADD7B8`

## Sparse chunk extraction

Extracted local-only sparse chunks:

- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS\super.img_sparsechunk.0`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS\super.img_sparsechunk.1`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS\super.img_sparsechunk.2`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS\super.img_sparsechunk.3`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS\super.img_sparsechunk.4`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS\super.img_sparsechunk.5`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS\super.img_sparsechunk.6`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS\super.img_sparsechunk.7`
- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS\super.img_sparsechunk.8`

Sparse chunk sizes:

| Chunk | Size bytes |
|---|---:|
| `super.img_sparsechunk.0` | `470,122,892` |
| `super.img_sparsechunk.1` | `536,797,676` |
| `super.img_sparsechunk.2` | `507,662,728` |
| `super.img_sparsechunk.3` | `508,604,936` |
| `super.img_sparsechunk.4` | `493,396,372` |
| `super.img_sparsechunk.5` | `523,792,848` |
| `super.img_sparsechunk.6` | `536,830,220` |
| `super.img_sparsechunk.7` | `496,247,012` |
| `super.img_sparsechunk.8` | `505,155,936` |

## Raw super reconstruction

Reconstructed with WSL `simg2img`.

Local-only raw super path:

- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS_filesystems\super.raw.img`

Raw super verification:

| Field | Value |
|---|---|
| Size | `9,730,785,280 bytes` |
| SHA256 | `562711ADEFF33DBE1334FB8AEF862AEA41749A27BF358E15944195A2EE431659` |

## liblp metadata

Local-only metadata audit:

- `C:\Projects\moto-one-hyper-local\audits\super_liblp_metadata_RPFS31_Q1_21_20_1_7_3_RETUS.json`

Observed metadata header:

| Field | Value |
|---|---|
| Header offset | `12288` |
| Header magic | `0x414C5030` |
| Major version | `10` |
| Minor version | `0` |
| Header size | `128` |
| Tables size | `616` |
| Partition entries | `6` |
| Extent entries | `4` |
| Group entries | `3` |
| Block devices | `1` |

Observed block device:

| Field | Value |
|---|---|
| Name | `super` |
| First logical sector | `2048` |
| Alignment | `1048576` |
| Size | `9,730,785,280 bytes` |

Observed groups:

| Group | Maximum size |
|---|---:|
| `default` | `0` |
| `mot_dp_group_a` | `4,861,198,336` |
| `mot_dp_group_b` | `4,861,198,336` |

Observed partition table:

| Partition | Size bytes | Group | Status |
|---|---:|---|---|
| `system_a` | `1,384,513,536` | `mot_dp_group_a` | carved |
| `system_b` | `173,809,664` | `mot_dp_group_b` | carved |
| `vendor_a` | `616,701,952` | `mot_dp_group_a` | carved |
| `vendor_b` | `0` | `mot_dp_group_b` | skipped zero-size |
| `product_a` | `2,418,454,528` | `mot_dp_group_a` | carved |
| `product_b` | `0` | `mot_dp_group_b` | skipped zero-size |

Observed warning:

- Geometry magic mismatch at offset `0`: got `0x00000000`, expected `0x616C4467`.

This warning is recorded as tool observation. The liblp metadata header was still located at offset `12288`, parsed, and used for carving.

## Logical partition carving

Local-only carve summary:

- `C:\Projects\moto-one-hyper-local\audits\super_liblp_carve_summary_RPFS31_Q1_21_20_1_7_3_RETUS.json`

Local-only output directory:

- `C:\Projects\moto-one-hyper-local\extracted\RPFS31_Q1_21_20_1_7_3_RETUS_filesystems\logical`

Carved partitions:

| Partition | Offset | Size bytes | SHA256 |
|---|---:|---:|---|
| `system_a.img` | `1,048,576` | `1,384,513,536` | `79C9B822B6D7A8CD6AAF0852D204620915FF6E63FB46A4BEE34193545123B2AF` |
| `system_b.img` | `1,386,217,472` | `173,809,664` | `E2E2B17A2AA4DFC1C7D93963DE403473583A4E511C22057BBDA2507B44AE0E16` |
| `vendor_a.img` | `1,560,281,088` | `616,701,952` | `C614411DDAC10288CC55B56EA027AAC50FA2628D23D1991C6B572CE817574B4B` |
| `product_a.img` | `2,177,892,352` | `2,418,454,528` | `6F99793D0CFC2BF201A9725453FD064C6C418D1E1ED07EDBC66811989F57D08F` |

Skipped zero-size partitions:

- `vendor_b`
- `product_b`

## Decision

Exact RETUS Route A reconstruction is complete enough to support offline inventory and proprietary line coverage work.

Route B RETBR remains comparison-only evidence.

## Next evidence step

Create report-safe inventories from exact RETUS:

- `vendor_a.img`
- `system_a.img` target paths for `system_ext/*`
- `product_a.img` target paths for `product/*`

Then run exact RETUS proprietary line coverage against the expected source lists.

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
