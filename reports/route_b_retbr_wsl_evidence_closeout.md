# Route B RETBR WSL Evidence Closeout

Status: closed for WSL evidence phase

Date: 2026-07-01

Commit closed by: `58a4294` Summarize Route B WSL filesystem evidence

## Scope closed

The Route B RETBR WSL evidence phase is closed.

This phase covered local-only offline evidence collection for the RETBR
`RPFS31.Q1-21-20-5 / 1e3de` firmware package, including:

- safe WSL/Debian toolchain setup;
- confirmation that adb and fastboot were absent;
- sparse `super.img_sparsechunk.*` reconstruction into local-only
  `super.raw.img`;
- liblp metadata inspection using transparent local helper logic;
- logical partition carving for `system_a`, `system_b`, `vendor_a`, and
  `product_a`;
- zero-size confirmation for `vendor_b` and `product_b`;
- read-only filesystem identification;
- representative `vendor_a` inventory of def/sm6150 vendor families;
- report-only Git summary updates.

## Evidence summary

The pushed report-only evidence confirms that the RETBR package contains a
coherent def/sm6150 Android 11 vendor payload useful for offline comparison and
coverage analysis.

The phase confirmed representative vendor families including:

- VINTF manifest and compatibility matrix metadata;
- init rc service declarations;
- permissions XML declarations;
- firmware payload directories;
- camera/QTI CHI components;
- radio/IMS/QCRIL components;
- NFC/ST21 components;
- fingerprint components;
- keymaster/gatekeeper/QSEE/Soter trust-stack components;
- DRM/Widevine-related components;
- Motorola popup/camera/display/vibrator related HAL/service families.

## Safety boundary preserved

No prohibited action occurred in this phase:

- no phone interaction;
- no adb;
- no fastboot;
- no LMSA/RSA rescue;
- no flashing;
- no bootloader action;
- no wipe/erase/unlock/relock;
- no mounting;
- no build attempt;
- no blob import;
- no write into `vendor/motorola`;
- no firmware/image/blob/local transcript committed to Git.

## Still blocked

Closing this evidence phase does not authorize any downstream action.

Still blocked:

- exact retus firmware substitution decisions;
- blob import into `vendor/motorola`;
- build use of RETBR-derived blobs;
- Lineage build attempts;
- live-device testing;
- adb/fastboot use;
- flashing or bootloader operations.

## Next phase candidate

The next phase should be planning-only unless explicitly reopened by a new gate.

Recommended next phase:

`Route B vendor coverage delta planning`

That phase should compare the report-safe RETBR inventory against the matched
device/common proprietary-files expectations and produce a gap map only.

It must not extract blobs, import blobs, build, or touch a device.
