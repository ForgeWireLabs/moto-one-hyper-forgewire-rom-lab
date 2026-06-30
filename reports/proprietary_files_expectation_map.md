# Proprietary-Files Expectation Map — def / sm6150-common (lineage-20)

Status: expectation map (no blobs acquired)

Date: 2026-06-30

## Safety boundary

Reports only. Built by **reading the committed `proprietary-files.txt` manifests**
in the already-cloned, out-of-repo, matched lineage-20 source set. No firmware
download, no image download, no extraction, no blobs, no LMSA, no phone, no
fastboot, no adb, no flashing, no build. No third-party source tree is committed.
The firmware acquisition/extraction gate stays at **Route C**
(`reports/firmware_acquisition_extraction_gate.md`); this map only prepares a
clean yardstick for a *future, separately approved* extraction.

## Source manifests

| Manifest | Path | Entries | Manifest provenance note (from its own header) |
|---|---|---|---|
| def device | `sorenlyulf/android_device_motorola_def/proprietary-files.txt` | 261 (259 unique) | "extracted from def **RPFS31.Q1-21-20-5**" |
| sm6150-common | `sorenlyulf/android_device_motorola_sm6150-common/proprietary-files.txt` | 984 (952 unique) | unpinned blobs "extracted from **Hanoip S2RI32.32-20-7**"; some pinned from "Motorola Edge S RRN31.Q1-20-31-3" |

Two provenance facts shape everything below:

- **The def blob set is literally the `-5` file set.** The expected device-specific
  blobs are exactly those captured from `RPFS31.Q1-21-20-5` — the same build
  sorenlyulf's vendor base targets, and the wrong-channel (RETBR) candidate from
  the firmware track.
- **The common manifest's reference copies came from other devices** (Hanoip /
  Edge S), not def. The *paths* are the contract; for a def build these files are
  re-pulled from def's own vendor image. So common paths are "expected to exist in
  a def image," not "proven present from def."

## 1. Blob families expected by the def tree (261)

| Family | Representative entries | Notes |
|---|---|---|
| Camera (largest) | ArcSoft tricam (`libarcsoft_tricam_calibration/verification`, `dc_capture`, `smooth_transition`, `distortion_correction`, `zoomtranslator`), Motorola EEPROM (`com.mot.eeprom.*ov32a*`, `*s5kgw1*`, `*s5k4h7*`), `arcsoft_calibration_u_dc.bin` | triple-camera ISP stack; ArcSoft + Qualcomm Spectra |
| Audio / Cirrus / calibration | `cs35l41-dsp1-spk-{cali,diag,prot}.{bin,wmfw}` (speaker-protection amp), ACDB calibration data | matches device-tree cs35l41 module aliases |
| Vibrator/haptics | `cs40l20.wmfw` (Cirrus haptics firmware) | |
| Pop-up camera HAL | `motorola.hardware.popup@1.0-service`, `motorola.hardware.popup@1.0.so` (lib/lib64), init `.rc` | the def signature feature; HAL is blob-backed |
| Fingerprint | `vendor.egistec.hardware.fingerprint@2.0.so`, `com.motorola.hardware.biometric.fingerprint@1.0.so`, `fingerprint@2.1-service-ets` | **Egistec** sensor + Motorola wrapper (+ a TEE trustlet, security-coupled) |
| NFC | `nfc_nci.st21nfc.st.so` (lib/lib64), `st21nfc_fw.bin` | **ST21NFC** — matches kernel `NFC_NQ` disabled + device-tree `st21nfc` |
| Display (HDR/firmware/calibration) | HDR, panel firmware, display-calibration blobs | def panel-adjacent |
| Sensors | def sensor blobs | SAR (SX933X) etc. |
| Misc/IPA/Marley/OEM firmware | IPA (IP accelerator) FW, "Marley", OEM | misc vendor firmware |

## 2. Blob families expected by sm6150-common (984)

| Family | Scale | Notes |
|---|---|---|
| Radio / modem / telephony | **largest** (`# Radio` ~150 incl. `qcril_database` ×36, CNE ×29) | QMI, IMS (APK + Moto Telephony Framework + IMS libs), data/voice — **most security/baseband-version-coupled** |
| Audio (ADSP + ADSP Modules + Listen) | large | DSP audio stack, sound-trigger |
| Media / DRM | large | codecs, Widevine/DRM |
| Graphics (+ firmware) | medium | Adreno 620 GPU userspace + firmware |
| Qualcomm TEE / Gatekeeper / Keystore | medium | **Trustzone trustlets — AVB/keymaster/security-version-coupled** |
| GPS, WiFi, Bluetooth (+A2DP/aptX), FM, ANT+ | medium each | connectivity stack |
| CDSP / Neural-networks / Snapdragon CV Engine | medium | compute-DSP, NN HAL, CVP |
| Peripheral manager / Servicetracker / Thermal / Charger / Alarm / Time / Perf / Latency | small each | platform services |
| Moto Permissions / ConfigStore / OEM | small | permissions XML, configstore HAL |
| WiFi Display (+HDCP) | small (pinned from Edge S) | Miracast |

## 3. def-specific vs common

- **def-specific** = the 261 device blobs: camera (ArcSoft/EEPROM), Cirrus
  audio+haptics, pop-up HAL, Egistec fingerprint, ST NFC, def display/sensors.
  These are what make the hardware *this* phone.
- **common** = the 984 SoC blobs: modem/IMS, ADSP/CDSP audio, media/DRM, graphics,
  TEE/gatekeeper/keystore, GPS/WiFi/BT. These are shared across Motorola sm6150
  devices.

## 4. Apparent duplicates / conflicts

Only **6 paths** appear in both manifests:

```
vendor/lib64/libbase64.so
vendor/lib64/libcapiv2svacnn.so
vendor/lib64/libcapiv2vop.so
vendor/lib64/libmotext_inf.so
vendor/lib64/libxml.so
vendor/lib64/unnhal-acc-hvx.so
```

These are minor shared libs (audio/SVA, xml, base64, HVX accel) listed in both the
device and common manifests. In a real build this is a harmless duplication (the
same file copied from both layers, device layer typically wins) — worth
deduplicating but **not a blocking conflict**. No version conflict can be seen
from paths alone (manifests carry no version/hash here).

## 5. Files most likely to determine whether `-5` RETBR is usable vs the phone's `-1-7-3` retus

The def blob set *is* `-5`. So "is `-5` usable on a `-1-7-3` phone" reduces to:
**which blob families change between `-5` and `-1-7-3`, and are any of them
security-/AVB-/baseband-coupled?** The version-sensitive families, in priority
order:

1. **Modem / radio firmware + qcril** (common `# Radio`) — baseband is tightly
   bound to the security patch and carrier (RETBR vs retus!). Highest risk:
   VoLTE/IMS/telephony and carrier features differ by channel.
2. **TEE / Trustzone trustlets, Gatekeeper, Keystore** (common) — keymaster/AVB
   version-coupled; a mismatch can break secure boot / biometrics / DRM.
3. **Fingerprint (Egistec) trustlet** (def + its TEE pair) — pairs with #2.
4. **ADSP/CDSP + camera firmware** (`.mbn`/`.bin` signed images) — coupled to the
   kernel/DSP version; AVB-signed.
5. **`vendor/firmware/*` signed images** generally — most likely AVB-gated.

Channel matters most for the **radio** family (RETBR `-5` vs retus `-1-7-3`):
that is where a Brazil-channel blob set is most likely to diverge from a US-retail
device. The pure-hardware blobs (camera/ArcSoft, Cirrus, pop-up, NFC, sensors) are
far more likely to be identical across `-5`/`-1-7-3` because the hardware is the
same.

## 6. Files to check first after any future (approved) extraction

1. **The extracted build fingerprint / `build.prop`** — confirm exactly which
   build the artifact is (`-5` vs `-1-7-3`, RETBR vs retus) before trusting anything.
2. **Modem / NON-HLOS firmware version** and `qcril_database` — channel/baseband.
3. **TEE / keymaster / gatekeeper / fingerprint trustlets** — security-version.
4. **The def-signature blobs** — pop-up HAL, Egistec fingerprint, ArcSoft/EEPROM
   camera, Cirrus cs35l41/cs40l20, ST21NFC — confirm presence + that they load.
5. **The 6 overlap libs** — confirm which copy is authoritative.
6. **Coverage diff**: every path in both manifests present in the extraction?
   (the common manifest references Hanoip, so some paths may be absent/renamed on
   a def image — that delta is the real "missing blob" set).

## 7. What cannot be verified until an artifact is acquired

- **Versions and hashes** — the manifests list paths only; no blob versions,
  sizes, or checksums are knowable from source.
- **`-5` vs `-1-7-3` byte/AVB compatibility** — cannot be judged without both
  images (and the phone's is unavailable; the `-5` package is gated).
- **Actual presence on a def image** — especially the 984 common paths, whose
  reference copies came from Hanoip, not def.
- **Whether any blob is missing/renamed** between the manifest and a real def
  vendor image.
- **Modem/TEE channel compatibility** (RETBR vs retus) — the central open risk.

Nothing here is a green light to acquire `-5`; it is the yardstick to judge `-5`
(or an exact `-1-7-3`) *if and when* a route is approved.

## Future extraction-check (for a later approved artifact)

After a future approved firmware extraction, compare the extracted files against
this map and produce:

```
reports/vendor_blob_expectation_gap_<build>.md
```

That report should record, for the `<build>` actually acquired:

- present / missing / extra vs each manifest (coverage diff);
- the extracted build fingerprint + channel (confirm `<build>`);
- the version/hash of the priority families from §5 (modem, TEE, fingerprint,
  camera/audio firmware);
- a verdict on whether `<build>` is a usable blob baseline for a def build, and
  if `-5` RETBR, whether the radio/TEE delta vs a `-1-7-3` retus device is
  acceptable or blocking.

## Current decision

Expectation map complete from the matched lineage-20 manifests. The blob
contract is now written down: ~261 def-specific + ~984 common paths, 6 trivial
overlaps, def set anchored to `-5`, with modem/TEE/radio as the channel-sensitive
determinants. No blobs acquired; firmware gate stays at **Route C**; blocker
unchanged. This map is the clean yardstick a future extraction will be judged
against.
