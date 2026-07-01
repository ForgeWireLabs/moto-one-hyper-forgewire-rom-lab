# Route B RETBR Proprietary-Files Line Coverage Review

Status: report-only review; no import gate opened

Date: 2026-07-01

## Safety boundary

This report is the next governance layer after
`reports/route_b_retbr_vendor_coverage_delta_plan.md`.

It uses committed reports only. It does not reopen the WSL evidence phase, read
or write local-only artifacts, enumerate raw filesystem trees, extract blobs,
import blobs, mount filesystems, build, use adb, use fastboot, touch a phone, or
flash anything.

WI-004 remains blocked. RETBR `RPFS31.Q1-21-20-5 / 1e3de` remains an offline
comparison source only. Exact retus `RPFS31.Q1-21-20-1-7-3` firmware remains
unavailable. Nothing in this report authorizes RETBR-as-retus substitution,
blob import, Lineage build attempts, live-device testing, adb/fastboot use, or
flashing.

## Review inputs

Primary inputs:

- `reports/proprietary_files_expectation_map.md`
- `reports/route_b_retbr_vendor_coverage_delta_plan.md`
- `reports/vendor_blob_coverage_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/vendor_blob_expectation_gap_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/firmware_filesystem_extraction_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/channel_sensitive_blob_review_RPFS31_Q1_21_20_5_RETBR.md`
- `reports/source_audit_sorenlyulf_def.md`
- `reports/source_audit_sm6150_common_lineage20.md`
- `work/blocked/WI-004-firmware-acquisition-and-verification.md`

The committed expectation map records 261 def entries and 984 sm6150-common
entries, but does not commit the full proprietary path list. Therefore this
review is line-family coverage: it groups expected proprietary-files lines by
the families and representative entries already committed in the map, then
classifies those groups against report-safe RETBR evidence.

## Classification key

| Classification | Use in this review |
|---|---|
| confirmed by report-safe evidence | Family is directly named in committed RETBR `vendor_a` or package evidence |
| likely present; needs safer enumeration | Family is expected and plausibly represented, but current committed summaries are not complete enough for path-level coverage |
| not visible in current report-safe inventory | Family or path root is not visible in committed summaries; this is not proof of absence from local images |
| channel-sensitive | RETBR evidence exists or is likely, but exact retus comparison is required before any compatibility/use conclusion |
| generated/source-side expectation | Expected by extraction/build scripts or source setup, not a firmware blob to locate directly |
| blocked from conclusion | Requires full path enumeration, exact retus firmware, hashes/versions, or another explicit gate |

## Def proprietary-files review

The def manifest is the most relevant first pass because its provenance says the
blobs were extracted from def `RPFS31.Q1-21-20-5`, the same build family as the
Route B RETBR evidence.

| Expected line family | Representative expected entries from committed map | RETBR report-safe evidence | Classification | Import-gate implication |
|---|---|---|---|---|
| ArcSoft / QTI camera stack | `libarcsoft_tricam_*`, `dc_capture`, `smooth_transition`, `distortion_correction`, `zoomtranslator` | camera provider, camera/media config, QTI CHI components, and camera firmware families are reported | confirmed by report-safe evidence | Future gate should enumerate exact ArcSoft paths before import discussion |
| Motorola EEPROM camera libs | `com.mot.eeprom.*ov32a*`, `*s5kgw1*`, `*s5k4h7*` | camera/EEPROM family is reported, but exact EEPROM path examples are not committed | likely present; needs safer enumeration | Needs report-safe path grouping or count-only comparator |
| Camera calibration firmware | `arcsoft_calibration_u_dc.bin` and related camera calibration payloads | camera signed firmware family is present | channel-sensitive | Presence is useful, but firmware version/retus equivalence cannot be concluded |
| Cirrus speaker amp firmware | `cs35l41-dsp1-spk-{cali,diag,prot}.{bin,wmfw}` | Cirrus audio firmware family is reported | confirmed by report-safe evidence | Exact filename coverage still needs safer enumeration |
| Cirrus haptics firmware | `cs40l20.wmfw` | haptics/Cirrus family is reported | confirmed by report-safe evidence | Strong def-family coverage signal; no import approval |
| ACDB / audio calibration | ACDB calibration data | audio/calibration family is expected and audio/DSP families are reported | likely present; needs safer enumeration | Needs root/path grouping because calibration files may not appear in the short inventory |
| Motorola pop-up camera HAL | `motorola.hardware.popup@1.0-service`, `motorola.hardware.popup@1.0.so` | Motorola popup/camera HAL and service families are reported | confirmed by report-safe evidence | Device-signature family appears covered at family level |
| Egistec fingerprint HAL | `vendor.egistec.hardware.fingerprint@2.0.so`, `fingerprint@2.1-service-ets` | Egistec fingerprint service/library families are reported | confirmed by report-safe evidence | HAL family appears covered; trustlet/security pairing remains channel-sensitive |
| Motorola biometric wrapper | `com.motorola.hardware.biometric.fingerprint@1.0.so` | Motorola biometric/fingerprint wrapper family is reported | confirmed by report-safe evidence | Needs exact path enumeration before import gate |
| Fingerprint trustlet pair | fingerprint trustlet/security pieces noted by expectation map | fingerprint trustlet detail is not closed; TEE/security families are present | channel-sensitive | Cannot conclude without exact retus firmware and trustlet version comparison |
| ST21NFC firmware | `st21nfc_fw.bin` | ST21NFC firmware family is reported | confirmed by report-safe evidence | Strong family-level match |
| ST21NFC libraries | `nfc_nci.st21nfc.st.so` in lib/lib64 | ST21NFC/NFC library family is reported | confirmed by report-safe evidence | Needs exact lib/lib64 path enumeration |
| Display HDR / calibration / firmware | HDR, panel firmware, display-calibration blobs | display and device firmware families are reported | likely present; needs safer enumeration | Not yet closed path-by-path |
| Sensor blobs | def sensor blobs, SAR/SX933X-adjacent families | sensor/device firmware families are reported | likely present; needs safer enumeration | Needs path grouping by sensor family |
| Misc IPA / Marley / OEM firmware | IPA, Marley, OEM firmware families | firmware payload directories and device firmware families are reported | likely present; needs safer enumeration | Current summaries do not close all firmware filenames |

## sm6150-common proprietary-files review

The common manifest is larger and more mixed: paths are expected for a def build,
but the committed map records Hanoip / Edge S provenance for some common copies.
RETBR `vendor_a` is useful as an offline def evidence baseline, not as retus
compatibility proof.

| Expected line family | Representative expected entries from committed map | RETBR report-safe evidence | Classification | Import-gate implication |
|---|---|---|---|---|
| Radio / modem / telephony | common `# Radio`, QMI, RIL, qcril database, carrier/data/voice files | `radio.img`, modem/FSG versions, qcril, IMS, radio HAL libraries | channel-sensitive | Highest-risk bucket; cannot conclude without exact retus firmware |
| qcril database and framework | `qcril_database`, qcril libraries/services | qcril service and libraries are reported | channel-sensitive | Presence is not enough; database/carrier contents require retus comparison |
| IMS stack | IMS APK/libraries/configuration | IMS rc files and libraries are reported | channel-sensitive | Carrier/channel-sensitive; no substitution conclusion |
| CNE / connectivity policy | CNE entries in common radio family | common map expects CNE; coverage report names major connectivity/platform services but not a full CNE path set | likely present; needs safer enumeration | If present, still channel-sensitive for carrier behavior |
| Qualcomm TEE / TrustZone | QSEE/QTEE trustlets and support libraries | QSEE/QTEE services and `libQSEEComAPI.so` family are reported | channel-sensitive | Security/AVB coupled; blocked without retus |
| Keymaster / keystore | keymaster and keystore blobs | keymaster service and libraries are reported | channel-sensitive | Cannot be treated as usable without retus/security comparison |
| Gatekeeper | gatekeeper HAL/service/libraries | gatekeeper service and implementation family are reported | channel-sensitive | Same security hold as keymaster |
| Soter / trusted UI / trust stack | Soter, trusted UI, trust connector families | Soter and trust-stack families are reported | channel-sensitive | Requires version and retus comparison |
| Audio DSP / ADSP modules | ADSP modules, sound-trigger, Listen stack | audio/DSP/CDSP families are reported | likely present; needs safer enumeration | Needs path grouping before import gate |
| CDSP / neural networks / Snapdragon CV | compute-DSP, NN HAL, CVP families | DSP/CDSP and platform service families are reported at family level | likely present; needs safer enumeration | Current reports are too coarse for exact coverage |
| Media codecs | media codec/userspace libraries | media family is reported | confirmed by report-safe evidence | Exact library set remains uncounted |
| DRM / Widevine | Widevine/DRM blobs | DRM/Widevine family is reported | confirmed by report-safe evidence | Presence does not imply usable DRM/security state |
| Graphics / Adreno | Adreno userspace and firmware | graphics family is reported | confirmed by report-safe evidence | Needs exact path enumeration later |
| GPS / GNSS | GPS/GNSS libraries and services | GNSS family is reported | confirmed by report-safe evidence | Family-level coverage only |
| WiFi | WiFi HAL/firmware/config families | WiFi family is reported | confirmed by report-safe evidence | Exact path list still uncounted |
| Bluetooth / A2DP / aptX | Bluetooth firmware and audio codec support | Bluetooth family is reported | confirmed by report-safe evidence | Exact codec subfamilies need safer enumeration |
| FM / ANT+ | FM and ANT+ connectivity families | expected in common map; not singled out in committed RETBR summaries | not visible in current report-safe inventory | Not proof of absence; needs report-safe grouping |
| Thermal / charger / alarm / time / perf / latency | platform service families | thermal, time, perf, and platform services are reported; charger/alarm/latency not fully singled out | likely present; needs safer enumeration | Useful low-risk platform bucket for later count-only review |
| Moto permissions / ConfigStore / OEM | permissions XML, configstore HAL, OEM config | permissions XML and Motorola service families are reported | confirmed by report-safe evidence | Generated/vendor config boundaries need review |
| WiFi Display / HDCP | Miracast/HDCP families | media/DRM/WiFi families are reported, but WiFi Display/HDCP are not singled out | likely present; needs safer enumeration | Some entries may be source-side or pinned from Edge S provenance |

## Cross-manifest overlap review

The expectation map records six paths appearing in both manifests:

```text
vendor/lib64/libbase64.so
vendor/lib64/libcapiv2svacnn.so
vendor/lib64/libcapiv2vop.so
vendor/lib64/libmotext_inf.so
vendor/lib64/libxml.so
vendor/lib64/unnhal-acc-hvx.so
```

Classification: blocked from conclusion.

Planning result: no conflict is proven by committed evidence, but import-gate
work should decide whether these are harmless duplicates, source-side
deduplication candidates, or device/common ownership choices. That decision
requires either a path-level comparator or generated makefile review. It does
not require blob import yet.

## Question answers

| Question | Answer |
|---|---|
| Which proprietary-files entries are already confirmed by report-safe evidence? | Confirmed families include Motorola pop-up HAL/service, ST21NFC firmware/libraries, Egistec fingerprint HAL, Cirrus audio/haptics firmware, camera/QTI CHI families, VINTF/init/permissions metadata, graphics, media, DRM/Widevine, GNSS, WiFi, Bluetooth, qcril/IMS presence, keymaster/gatekeeper/QSEE/QTEE/Soter presence. |
| Which are likely present but need safer enumeration? | EEPROM exact paths, display/panel/sensor firmware, ACDB calibration, IPA/Marley/OEM firmware, ADSP/CDSP/Listen/NN/CV families, CNE, FM/ANT+, charger/alarm/latency, WiFi Display/HDCP, and some common platform service subfamilies. |
| Which are not visible in current report-safe inventory? | FM/ANT+ are expected but not singled out; `vendor_boot.img` is absent at package level; `odm`, `system_ext`, `vendor_dlkm`, and `odm_dlkm` logical partitions were not found in parsed metadata. These are not absence proofs for every related manifest path. |
| Which are channel-sensitive? | Radio/modem, qcril database, IMS, CNE/carrier policy, TEE/TrustZone/QSEE/QTEE, keymaster, gatekeeper, keystore, Soter/trusted UI, fingerprint trustlets, DSP/CDSP signed firmware, and camera signed firmware. |
| Which are generated/source-side expectations rather than firmware blobs? | `def-vendor.mk`, `sm6150-common-vendor.mk`, setup/extract script outputs, dependency declarations, and build-generated makefile surfaces are source-side outputs, not firmware blobs to find directly. |
| Which cannot be concluded without exact retus firmware? | RETBR-vs-retus compatibility for radio/IMS/qcril, TEE/keymaster/gatekeeper/keystore, fingerprint trustlets, DSP/camera signed firmware, DRM/security behavior, and any claim that RETBR blobs are safe to use on the retus `-1-7-3` phone. |

## Import-gate readiness posture

This review makes a future import gate easier to design, but it does not open
one. Before any import discussion, a later explicit gate would need at minimum:

- a report-safe manifest family map that includes every def and common
  proprietary-files line or line group;
- a count-only present/likely/missing summary that does not commit proprietary
  payloads or raw inventories;
- explicit separation of channel-sensitive families from ordinary hardware
  families;
- exact retus `RPFS31.Q1-21-20-1-7-3` firmware or a written decision that
  continuing without it is still only planning;
- a rollback/reference story that does not use RETBR files as physical-device
  recovery assets.

## Current decision

Route B proprietary-files line coverage review is open and completed as a
report-only governance layer. It turns the broad delta plan into an import-gate
checklist, but keeps WI-004 blocked and keeps all downstream work unauthorized:
no blob import, no build, no adb/fastboot, no phone interaction, and no flashing.
