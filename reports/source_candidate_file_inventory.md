# Source Candidate File Inventory

Status: generated

Date: 2026-06-28

## Purpose

Inventory real files from local source candidate clones.

This report is evidence from cloned source trees, not a planning placeholder.

No source tree is accepted as a build input by this report.

No physical-phone action is authorized.

## Source root

C:\Projects\moto-one-hyper-local\sources

## Candidate: ixmoe_android_device_motorola_def_twrp

| Field | Value |
|---|---|
| Remote | https://github.com/ixmoe/android_device_motorola_def_twrp.git |
| Branch | android-10 |
| HEAD | a5ad58ff0bd739b1fe3e81715f1baa57214db1e1 |
| Total files | 74 |
| Key files matched | 14 |

### Key file list

| Relative path | Size bytes |
|---|---:|
| Android.mk | 1172 |
| AndroidProducts.mk | 760 |
| BoardConfig.mk | 7690 |
| device.mk | 2719 |
| omni_def.mk | 1132 |
| recovery\root\init.recovery.qcom.rc | 2207 |
| recovery\root\init.recovery.usb.rc | 10231 |
| recovery\root\system\bin\load_modules.sh | 2105 |
| recovery\root\system\etc\init\ashmemd.rc | 152 |
| recovery\root\system\etc\recovery.fstab | 2064 |
| recovery\root\system\etc\vintf\manifest.xml | 4388 |
| recovery\root\ueventd.qcom.rc | 22158 |
| recovery\root\vendor\etc\gpfspath_oem_config.xml | 2190 |
| recovery\root\vendor\etc\vintf\manifest.xml | 30549 |

### Interesting term hits

- def : 10 file(s)
- sm6150 : 3 file(s)
- vendor_boot : 0 file(s)
- boot : 8 file(s)
- dtbo : 2 file(s)
- vbmeta : 2 file(s)
- super : 1 file(s)
- dynamic : 3 file(s)
- recovery : 5 file(s)
- fstab : 1 file(s)
- qcom : 5 file(s)
- motorola : 4 file(s)
- proprietary : 1 file(s)
- BOARD_ : 1 file(s)
- TARGET_ : 3 file(s)
- PRODUCT_ : 4 file(s)

### First-pass classification

Classification: recovery-tree-reference

Reason: candidate appears to be TWRP/recovery-oriented. Useful for partition/recovery/fstab clues, not a full ROM build tree.

### Immediate audit questions

- Does BoardConfig identify def, sm6150, partition sizes, boot image layout, or recovery image layout?
- Does fstab identify dynamic partitions, super, vendor, product, odm, or vbmeta behavior?
- Does the tree reference Android 10 while target phone is Android 11?
- Does the tree include proprietary-files lists or only recovery metadata?
- Does the tree depend on unavailable vendor blobs?
- Does the tree include kernel source references or only prebuilt assumptions?

## Candidate: Nandru86_android_device_motorola_def_twrp

| Field | Value |
|---|---|
| Remote | https://github.com/Nandru86/android_device_motorola_def_twrp.git |
| Branch | android-10 |
| HEAD | a5ad58ff0bd739b1fe3e81715f1baa57214db1e1 |
| Total files | 74 |
| Key files matched | 14 |

### Key file list

| Relative path | Size bytes |
|---|---:|
| Android.mk | 1172 |
| AndroidProducts.mk | 760 |
| BoardConfig.mk | 7690 |
| device.mk | 2719 |
| omni_def.mk | 1132 |
| recovery\root\init.recovery.qcom.rc | 2207 |
| recovery\root\init.recovery.usb.rc | 10231 |
| recovery\root\system\bin\load_modules.sh | 2105 |
| recovery\root\system\etc\init\ashmemd.rc | 152 |
| recovery\root\system\etc\recovery.fstab | 2064 |
| recovery\root\system\etc\vintf\manifest.xml | 4388 |
| recovery\root\ueventd.qcom.rc | 22158 |
| recovery\root\vendor\etc\gpfspath_oem_config.xml | 2190 |
| recovery\root\vendor\etc\vintf\manifest.xml | 30549 |

### Interesting term hits

- def : 10 file(s)
- sm6150 : 3 file(s)
- vendor_boot : 0 file(s)
- boot : 8 file(s)
- dtbo : 2 file(s)
- vbmeta : 2 file(s)
- super : 1 file(s)
- dynamic : 3 file(s)
- recovery : 5 file(s)
- fstab : 1 file(s)
- qcom : 5 file(s)
- motorola : 4 file(s)
- proprietary : 1 file(s)
- BOARD_ : 1 file(s)
- TARGET_ : 3 file(s)
- PRODUCT_ : 4 file(s)

### First-pass classification

Classification: recovery-tree-reference

Reason: candidate appears to be TWRP/recovery-oriented. Useful for partition/recovery/fstab clues, not a full ROM build tree.

### Immediate audit questions

- Does BoardConfig identify def, sm6150, partition sizes, boot image layout, or recovery image layout?
- Does fstab identify dynamic partitions, super, vendor, product, odm, or vbmeta behavior?
- Does the tree reference Android 10 while target phone is Android 11?
- Does the tree include proprietary-files lists or only recovery metadata?
- Does the tree depend on unavailable vendor blobs?
- Does the tree include kernel source references or only prebuilt assumptions?

## Candidate: AndroidBlobs_device_motorola_def

| Field | Value |
|---|---|
| Remote | https://github.com/AndroidBlobs/device_motorola_def.git |
| Branch | def_retail-user-10-QPF30.104-b456f-release-keys |
| HEAD | e4f61a413561d53725e58e55d7747c3695b031eb |
| Total files | 135 |
| Key files matched | 107 |

### Key file list

| Relative path | Size bytes |
|---|---:|
| android.hardware.atrace@1.0-service.xml | 334 |
| android.hardware.cas@1.1-service.xml | 334 |
| android.hardware.gnss@2.0-service-qti.xml | 1815 |
| Android.mk | 138 |
| AndroidProducts.mk | 55 |
| BoardConfig.mk | 710 |
| compatibility_matrix.xml | 2872 |
| configs\audio\a2dp_audio_policy_configuration.xml | 2134 |
| configs\audio\aov_ec_mixer_paths.xml | 528 |
| configs\audio\audio_effects.xml | 4079 |
| configs\audio\audio_platform_info.xml | 20190 |
| configs\audio\audio_policy_configuration.xml | 15318 |
| configs\audio\audio_policy_volumes.xml | 9577 |
| configs\audio\mixer_paths.xml | 42817 |
| configs\audio\r_submix_audio_policy_configuration.xml | 2152 |
| configs\audio\usb_audio_policy_configuration.xml | 2284 |
| configs\media\media_codecs.xml | 13196 |
| configs\media\media_codecs_dolby_audio.xml | 1962 |
| configs\media\media_codecs_google_audio.xml | 4928 |
| configs\media\media_codecs_google_c2.xml | 827 |
| configs\media\media_codecs_google_c2_audio.xml | 6104 |
| configs\media\media_codecs_google_c2_video.xml | 8404 |
| configs\media\media_codecs_google_telephony.xml | 998 |
| configs\media\media_codecs_google_video.xml | 6533 |
| configs\media\media_codecs_google_video_le.xml | 5804 |
| configs\media\media_codecs_performance.xml | 8771 |
| configs\media\media_codecs_performance_v1.xml | 12210 |
| configs\media\media_codecs_performance_v2.xml | 12210 |
| configs\media\media_codecs_v1.xml | 20561 |
| configs\media\media_codecs_v2.xml | 20561 |
| configs\media\media_codecs_vendor.xml | 21438 |
| configs\media\media_codecs_vendor_audio.xml | 1075 |
| configs\media\media_codecs_vendor_v1.xml | 25237 |
| configs\media\media_codecs_vendor_v2.xml | 25237 |
| configs\media\media_profiles.xml | 20934 |
| configs\media\media_profiles_V1_0.xml | 31677 |
| configs\media\media_profiles_vendor.xml | 65994 |
| configs\media\system_properties.xml | 2281 |
| configs\privapp-permissions-qti.xml | 5115 |
| configs\qti_whitelist.xml | 7506 |
| configs\telephony_product_privapp-permissions-qti.xml | 3988 |
| device.mk | 13230 |
| framework_compatibility_matrix.xml | 27064 |
| lineage_def.mk | 919 |
| manifest.xml | 33711 |
| overlay\frameworks\base\core\res\res\values\config.xml | 919 |
| overlay\packages\apps\Bluetooth\res\values\bools.xml | 1738 |
| overlay\packages\apps\CarrierConfig\res\xml\base.xml | 354 |
| overlay\packages\apps\CarrierConfig\res\xml\vendor.xml | 68610 |
| overlay-lineage\lineage-sdk\lineage\res\res\values\config.xml | 2264 |
| proprietary-files.txt | 83438 |
| proprietary-files-system.txt | 9794 |
| rootdir\Android.mk | 13255 |
| rootdir\bin\apanic_annotate.sh | 1541 |
| rootdir\bin\apanic_copy.sh | 1073 |
| rootdir\bin\apanic_save.sh | 319 |
| rootdir\bin\hardware_revisions.sh | 8175 |
| rootdir\bin\init.class_main.sh | 5636 |
| rootdir\bin\init.crda.sh | 1810 |
| rootdir\bin\init.gbmods.sh | 693 |
| rootdir\bin\init.mdm.sh | 1773 |
| rootdir\bin\init.mmi.block_perm.sh | 911 |
| rootdir\bin\init.mmi.boot.sh | 4575 |
| rootdir\bin\init.mmi.laser.sh | 2387 |
| rootdir\bin\init.mmi.mdlog-getlogs.sh | 932 |
| rootdir\bin\init.mmi.touch.sh | 12803 |
| rootdir\bin\init.mmi.usb.sh | 16275 |
| rootdir\bin\init.mmi.wlan-getlogs.sh | 274 |
| rootdir\bin\init.oem.hw.sh | 17242 |
| rootdir\bin\init.qcom.class_core.sh | 7271 |
| rootdir\bin\init.qcom.coex.sh | 3768 |
| rootdir\bin\init.qcom.crashdata.sh | 2055 |
| rootdir\bin\init.qcom.early_boot.sh | 15483 |
| rootdir\bin\init.qcom.efs.sync.sh | 1762 |
| rootdir\bin\init.qcom.post_boot.sh | 255668 |
| rootdir\bin\init.qcom.sdio.sh | 2847 |
| rootdir\bin\init.qcom.sensors.sh | 2001 |
| rootdir\bin\init.qcom.sh | 16396 |
| rootdir\bin\init.qti.chg_policy.sh | 919 |
| rootdir\bin\init.qti.fm.sh | 1439 |
| rootdir\bin\init.qti.ims.sh | 2245 |
| rootdir\bin\pstore_annotate.sh | 716 |
| rootdir\bin\qca6234-service.sh | 3833 |
| rootdir\bin\ufs_ffu.sh | 399 |
| rootdir\bin\ufs_ffu_SAMSUNG.sh | 1689 |
| rootdir\bin\ufs_ffu_SKhynix.sh | 1243 |
| rootdir\bin\ufs_ffu_WDC.sh | 1201 |
| rootdir\etc\fstab.qcom | 3336 |
| rootdir\etc\init.hidl.sensor.rc | 312 |
| rootdir\etc\init.mmi.charge_only.rc | 1249 |
| rootdir\etc\init.mmi.chipset.rc | 2858 |
| rootdir\etc\init.mmi.debug.rc | 174 |
| rootdir\etc\init.mmi.diag.rc | 2 |
| rootdir\etc\init.mmi.diag_mdlog.rc | 1076 |
| rootdir\etc\init.mmi.overlay.rc | 13532 |
| rootdir\etc\init.mmi.rc | 20016 |
| rootdir\etc\init.mmi.sensor.rc | 434 |
| rootdir\etc\init.mmi.tcmd.rc | 5094 |
| rootdir\etc\init.mmi.usb.rc | 25339 |
| rootdir\etc\init.mmi.wlan.rc | 158 |
| rootdir\etc\init.qcom.factory.rc | 8157 |
| rootdir\etc\init.qcom.rc | 35777 |
| rootdir\etc\init.target.rc | 13283 |
| rootdir\etc\init.vendor.st21nfc.rc | 410 |
| rootdir\etc\ueventd.qcom.rc | 25284 |
| vendor.qti.gnss@3.0-service.xml | 652 |
| vendor_prop.mk | 7006 |

### Interesting term hits

- def : 46 file(s)
- sm6150 : 6 file(s)
- vendor_boot : 0 file(s)
- boot : 34 file(s)
- dtbo : 0 file(s)
- vbmeta : 2 file(s)
- super : 0 file(s)
- dynamic : 6 file(s)
- recovery : 4 file(s)
- fstab : 6 file(s)
- qcom : 27 file(s)
- motorola : 17 file(s)
- proprietary : 6 file(s)
- BOARD_ : 1 file(s)
- TARGET_ : 5 file(s)
- PRODUCT_ : 7 file(s)

### First-pass classification

Classification: stock-derived-device-reference

Reason: candidate appears to be a def device tree or stock-derived reference. Needs deeper audit before any build-input consideration.

### Immediate audit questions

- Does BoardConfig identify def, sm6150, partition sizes, boot image layout, or recovery image layout?
- Does fstab identify dynamic partitions, super, vendor, product, odm, or vbmeta behavior?
- Does the tree reference Android 10 while target phone is Android 11?
- Does the tree include proprietary-files lists or only recovery metadata?
- Does the tree depend on unavailable vendor blobs?
- Does the tree include kernel source references or only prebuilt assumptions?

## Candidate: ludevjhon_device_motorola_def

| Field | Value |
|---|---|
| Remote | https://github.com/ludevjhon/device_motorola_def.git |
| Branch | def_retail-user-10-QPF30.104-b456f-release-keys |
| HEAD | 17aaeaac87e5c3b791191179d0ddbd57aba43c4e |
| Total files | 135 |
| Key files matched | 107 |

### Key file list

| Relative path | Size bytes |
|---|---:|
| android.hardware.atrace@1.0-service.xml | 334 |
| android.hardware.cas@1.1-service.xml | 334 |
| android.hardware.gnss@2.0-service-qti.xml | 1815 |
| Android.mk | 138 |
| AndroidProducts.mk | 55 |
| BoardConfig.mk | 3335 |
| compatibility_matrix.xml | 2872 |
| configs\audio\a2dp_audio_policy_configuration.xml | 2134 |
| configs\audio\aov_ec_mixer_paths.xml | 528 |
| configs\audio\audio_effects.xml | 4079 |
| configs\audio\audio_platform_info.xml | 20190 |
| configs\audio\audio_policy_configuration.xml | 15318 |
| configs\audio\audio_policy_volumes.xml | 9577 |
| configs\audio\mixer_paths.xml | 42817 |
| configs\audio\r_submix_audio_policy_configuration.xml | 2152 |
| configs\audio\usb_audio_policy_configuration.xml | 2284 |
| configs\media\media_codecs.xml | 13196 |
| configs\media\media_codecs_dolby_audio.xml | 1962 |
| configs\media\media_codecs_google_audio.xml | 4928 |
| configs\media\media_codecs_google_c2.xml | 827 |
| configs\media\media_codecs_google_c2_audio.xml | 6104 |
| configs\media\media_codecs_google_c2_video.xml | 8404 |
| configs\media\media_codecs_google_telephony.xml | 998 |
| configs\media\media_codecs_google_video.xml | 6533 |
| configs\media\media_codecs_google_video_le.xml | 5804 |
| configs\media\media_codecs_performance.xml | 8771 |
| configs\media\media_codecs_performance_v1.xml | 12210 |
| configs\media\media_codecs_performance_v2.xml | 12210 |
| configs\media\media_codecs_v1.xml | 20561 |
| configs\media\media_codecs_v2.xml | 20561 |
| configs\media\media_codecs_vendor.xml | 21438 |
| configs\media\media_codecs_vendor_audio.xml | 1075 |
| configs\media\media_codecs_vendor_v1.xml | 25237 |
| configs\media\media_codecs_vendor_v2.xml | 25237 |
| configs\media\media_profiles.xml | 20934 |
| configs\media\media_profiles_V1_0.xml | 31677 |
| configs\media\media_profiles_vendor.xml | 65994 |
| configs\media\system_properties.xml | 2281 |
| configs\privapp-permissions-qti.xml | 5115 |
| configs\qti_whitelist.xml | 7506 |
| configs\telephony_product_privapp-permissions-qti.xml | 3988 |
| device.mk | 13230 |
| framework_compatibility_matrix.xml | 27064 |
| lineage_def.mk | 919 |
| manifest.xml | 33711 |
| overlay\frameworks\base\core\res\res\values\config.xml | 919 |
| overlay\packages\apps\Bluetooth\res\values\bools.xml | 1738 |
| overlay\packages\apps\CarrierConfig\res\xml\base.xml | 354 |
| overlay\packages\apps\CarrierConfig\res\xml\vendor.xml | 68610 |
| overlay-lineage\lineage-sdk\lineage\res\res\values\config.xml | 2264 |
| proprietary-files.txt | 83438 |
| proprietary-files-system.txt | 9794 |
| rootdir\Android.mk | 13255 |
| rootdir\bin\apanic_annotate.sh | 1541 |
| rootdir\bin\apanic_copy.sh | 1073 |
| rootdir\bin\apanic_save.sh | 319 |
| rootdir\bin\hardware_revisions.sh | 8175 |
| rootdir\bin\init.class_main.sh | 5636 |
| rootdir\bin\init.crda.sh | 1810 |
| rootdir\bin\init.gbmods.sh | 693 |
| rootdir\bin\init.mdm.sh | 1773 |
| rootdir\bin\init.mmi.block_perm.sh | 911 |
| rootdir\bin\init.mmi.boot.sh | 4575 |
| rootdir\bin\init.mmi.laser.sh | 2387 |
| rootdir\bin\init.mmi.mdlog-getlogs.sh | 932 |
| rootdir\bin\init.mmi.touch.sh | 12803 |
| rootdir\bin\init.mmi.usb.sh | 16275 |
| rootdir\bin\init.mmi.wlan-getlogs.sh | 274 |
| rootdir\bin\init.oem.hw.sh | 17242 |
| rootdir\bin\init.qcom.class_core.sh | 7271 |
| rootdir\bin\init.qcom.coex.sh | 3768 |
| rootdir\bin\init.qcom.crashdata.sh | 2055 |
| rootdir\bin\init.qcom.early_boot.sh | 15483 |
| rootdir\bin\init.qcom.efs.sync.sh | 1762 |
| rootdir\bin\init.qcom.post_boot.sh | 255668 |
| rootdir\bin\init.qcom.sdio.sh | 2847 |
| rootdir\bin\init.qcom.sensors.sh | 2001 |
| rootdir\bin\init.qcom.sh | 16396 |
| rootdir\bin\init.qti.chg_policy.sh | 919 |
| rootdir\bin\init.qti.fm.sh | 1439 |
| rootdir\bin\init.qti.ims.sh | 2245 |
| rootdir\bin\pstore_annotate.sh | 716 |
| rootdir\bin\qca6234-service.sh | 3833 |
| rootdir\bin\ufs_ffu.sh | 399 |
| rootdir\bin\ufs_ffu_SAMSUNG.sh | 1689 |
| rootdir\bin\ufs_ffu_SKhynix.sh | 1243 |
| rootdir\bin\ufs_ffu_WDC.sh | 1201 |
| rootdir\etc\fstab.qcom | 3336 |
| rootdir\etc\init.hidl.sensor.rc | 312 |
| rootdir\etc\init.mmi.charge_only.rc | 1249 |
| rootdir\etc\init.mmi.chipset.rc | 2858 |
| rootdir\etc\init.mmi.debug.rc | 174 |
| rootdir\etc\init.mmi.diag.rc | 2 |
| rootdir\etc\init.mmi.diag_mdlog.rc | 1076 |
| rootdir\etc\init.mmi.overlay.rc | 13532 |
| rootdir\etc\init.mmi.rc | 20016 |
| rootdir\etc\init.mmi.sensor.rc | 434 |
| rootdir\etc\init.mmi.tcmd.rc | 5094 |
| rootdir\etc\init.mmi.usb.rc | 25339 |
| rootdir\etc\init.mmi.wlan.rc | 158 |
| rootdir\etc\init.qcom.factory.rc | 8157 |
| rootdir\etc\init.qcom.rc | 35777 |
| rootdir\etc\init.target.rc | 13283 |
| rootdir\etc\init.vendor.st21nfc.rc | 410 |
| rootdir\etc\ueventd.qcom.rc | 25284 |
| vendor.qti.gnss@3.0-service.xml | 652 |
| vendor_prop.mk | 7006 |

### Interesting term hits

- def : 46 file(s)
- sm6150 : 7 file(s)
- vendor_boot : 0 file(s)
- boot : 35 file(s)
- dtbo : 1 file(s)
- vbmeta : 2 file(s)
- super : 1 file(s)
- dynamic : 7 file(s)
- recovery : 5 file(s)
- fstab : 6 file(s)
- qcom : 28 file(s)
- motorola : 17 file(s)
- proprietary : 6 file(s)
- BOARD_ : 1 file(s)
- TARGET_ : 6 file(s)
- PRODUCT_ : 7 file(s)

### First-pass classification

Classification: stock-derived-device-reference

Reason: candidate appears to be a def device tree or stock-derived reference. Needs deeper audit before any build-input consideration.

### Immediate audit questions

- Does BoardConfig identify def, sm6150, partition sizes, boot image layout, or recovery image layout?
- Does fstab identify dynamic partitions, super, vendor, product, odm, or vbmeta behavior?
- Does the tree reference Android 10 while target phone is Android 11?
- Does the tree include proprietary-files lists or only recovery metadata?
- Does the tree depend on unavailable vendor blobs?
- Does the tree include kernel source references or only prebuilt assumptions?

## Candidate: Fraaxius_device_motorola_sm6150-common

| Field | Value |
|---|---|
| Remote | https://github.com/Fraaxius/device_motorola_sm6150-common.git |
| Branch | lineage-21 |
| HEAD | 0e09fc8bf110b256cdd99d577ec24901715d69c1 |
| Total files | 563 |
| Key files matched | 157 |

### Key file list

| Relative path | Size bytes |
|---|---:|
| Android.mk | 5736 |
| audio\audio_effects.xml | 7733 |
| audio\audio_policy_configuration.xml | 12498 |
| BoardConfigCommon.mk | 7593 |
| common.mk | 21374 |
| common_dynamic.mk | 1144 |
| compatibility_matrix.xml | 3736 |
| configs\media_codecs.xml | 21389 |
| configs\media_codecs_performance.xml | 12861 |
| configs\media_codecs_performance_v1.xml | 13007 |
| configs\media_codecs_performance_v2.xml | 13007 |
| configs\media_codecs_v1.xml | 19275 |
| configs\media_codecs_v2.xml | 18681 |
| configs\media_codecs_vendor.xml | 20068 |
| configs\media_codecs_vendor_audio.xml | 1075 |
| configs\media_codecs_vendor_v1.xml | 23763 |
| configs\media_codecs_vendor_v2.xml | 23169 |
| configs\media_profiles_V1_0.xml | 65994 |
| configs\media_profiles_vendor.xml | 65994 |
| configs\privapp-permissions-hotword.xml | 732 |
| configs\qti_whitelist.xml | 4052 |
| configs\qti_whitelist_system_ext.xml | 1868 |
| configs\system_ext-privapp-permissions-qti.xml | 1519 |
| extract-files.sh | 2705 |
| gps\Android.mk | 1500 |
| gps\android\1.0\android.hardware.gnss@1.0-service-qti.rc | 148 |
| gps\android\1.0\android.hardware.gnss@1.0-service-qti.xml | 1769 |
| gps\android\1.0\Android.mk | 2603 |
| gps\android\1.1\android.hardware.gnss@1.1-service-qti.rc | 148 |
| gps\android\1.1\android.hardware.gnss@1.1-service-qti.xml | 1769 |
| gps\android\1.1\Android.mk | 2669 |
| gps\android\2.0\android.hardware.gnss@2.0-service-qti.rc | 148 |
| gps\android\2.0\android.hardware.gnss@2.0-service-qti.xml | 1815 |
| gps\android\2.0\Android.mk | 3004 |
| gps\android\2.1\android.hardware.gnss@2.1-service-qti.rc | 148 |
| gps\android\2.1\android.hardware.gnss@2.1-service-qti.xml | 1815 |
| gps\android\2.1\Android.mk | 3154 |
| gps\android\Android.mk | 68 |
| gps\CleanSpec.mk | 2356 |
| gps\gps_vendor_board.mk | 233 |
| gps\gps_vendor_product.mk | 1520 |
| livedisplay\vendor.lineage.livedisplay@2.0-service-sysfs.motorola_sm6150.rc | 707 |
| location\Android.mk | 266 |
| location\client_api\mkclientapidoc.sh | 3222 |
| location\gps_vendor_product.mk | 1395 |
| location\integration_api\mkintegrationapidoc.sh | 3242 |
| location\loc_api\Android.mk | 2769 |
| location\loc_api\loc_api_v02\Android.mk | 1158 |
| location\location_api_msg_proto\location_api_msg_protobuf_gen.sh | 7367 |
| location\synergy_loc_api\Android.mk | 948 |
| location\utils\Android.mk | 116 |
| location\utils\loc_socket\Android.mk | 1128 |
| manifest.xml | 19134 |
| overlay\frameworks\base\core\res\res\values\config.xml | 20951 |
| overlay\frameworks\base\core\res\res\values-mcc234-mnc15\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc234-mnc15-en-rGB\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc234-mnc15-en-rIN\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc262-mnc02\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc262-mnc02-en-rGB\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc262-mnc02-en-rIN\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc262-mnc04\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc262-mnc04-en-rGB\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc262-mnc04-en-rIN\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc262-mnc09\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc262-mnc09-en-rGB\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc262-mnc09-en-rIN\config.xml | 3812 |
| overlay\frameworks\base\core\res\res\values-mcc310-mnc004\config.xml | 1979 |
| overlay\frameworks\base\core\res\res\values-mcc310-mnc120\config.xml | 1981 |
| overlay\frameworks\base\core\res\res\values-mcc310-mnc260\config.xml | 1979 |
| overlay\frameworks\base\core\res\res\values-mcc310-mnc410\config.xml | 1979 |
| overlay\frameworks\base\core\res\res\values-mcc311-mnc480\config.xml | 2331 |
| overlay\frameworks\base\core\res\res\values-mcc312-mnc530\config.xml | 2019 |
| overlay\frameworks\base\core\res\res\values-mcc313-mnc100\config.xml | 2532 |
| overlay\frameworks\base\core\res\res\values-mcc454-mnc03\config.xml | 1758 |
| overlay\frameworks\base\core\res\res\values-mcc454-mnc04\config.xml | 1758 |
| overlay\frameworks\base\core\res\res\values-mcc455-mnc02\config.xml | 1758 |
| overlay\frameworks\base\core\res\res\values-mcc455-mnc07\config.xml | 1758 |
| overlay\frameworks\base\core\res\res\values-mcc460-mnc03\config.xml | 2030 |
| overlay\frameworks\base\core\res\res\values-mcc460-mnc11\config.xml | 2030 |
| overlay\frameworks\base\packages\SystemUI\res\values\config.xml | 957 |
| overlay\packages\apps\CarrierConfig\res\xml\vendor.xml | 129668 |
| overlay\packages\services\Telephony\res\values\config.xml | 1497 |
| overlay-lineage\lineage-sdk\lineage\res\res\values\config.xml | 2024 |
| overlay-lineage\packages\apps\Dialer\java\com\android\dialer\callrecord\res\values\config.xml | 824 |
| overlay-lineage\packages\apps\Snap\res\values\config.xml | 1272 |
| overlay-lineage-fastbootd\lineage-sdk\lineage\res\res\values\config.xml | 1058 |
| power-libperfmgr\aidl\android.hardware.power-service.sm6150.xml | 206 |
| power-libperfmgr\aidl\android.hardware.power-service.sm6150-libperfmgr.rc | 1282 |
| properties.mk | 12267 |
| proprietary-files.txt | 44071 |
| rootdir\Android.mk | 6799 |
| rootdir\bin\init.class_main.sh | 5731 |
| rootdir\bin\init.crda.sh | 1810 |
| rootdir\bin\init.mdm.sh | 1773 |
| rootdir\bin\init.mmi.laser.sh | 1841 |
| rootdir\bin\init.mmi.touch.sh | 15495 |
| rootdir\bin\init.mmi.usb.sh | 18529 |
| rootdir\bin\init.oem.hw.sh | 19946 |
| rootdir\bin\init.qcom.class_core.sh | 7271 |
| rootdir\bin\init.qcom.coex.sh | 3768 |
| rootdir\bin\init.qcom.crashdata.sh | 2055 |
| rootdir\bin\init.qcom.early_boot.sh | 17718 |
| rootdir\bin\init.qcom.efs.sync.sh | 1762 |
| rootdir\bin\init.qcom.sdio.sh | 2847 |
| rootdir\bin\init.qcom.sensors.sh | 1815 |
| rootdir\bin\init.qcom.sh | 16419 |
| rootdir\bin\init.qti.fm.sh | 1439 |
| rootdir\bin\init.qti.ims.sh | 2245 |
| rootdir\etc\fstab.qcom | 2763 |
| rootdir\etc\fstab_dynamic.qcom | 3603 |
| rootdir\etc\init.mmi.chipset.rc | 2554 |
| rootdir\etc\init.mmi.rc | 19027 |
| rootdir\etc\init.mmi.usb.rc | 40440 |
| rootdir\etc\init.qcom.power.rc | 13836 |
| rootdir\etc\init.qcom.rc | 30534 |
| rootdir\etc\init.recovery.qcom.rc | 1822 |
| rootdir\etc\init.target.rc | 13001 |
| rootdir\ueventd.rc | 33496 |
| rro_overlays\WifiOverlay\AndroidManifest.xml | 1170 |
| rro_overlays\WifiOverlay\res\values\config.xml | 4461 |
| sepolicy\private\app.te | 102 |
| sepolicy\private\init.te | 110 |
| sepolicy\private\radio.te | 115 |
| sepolicy\private\service.te | 95 |
| sepolicy\private\system_app.te | 51 |
| sepolicy\private\system_server.te | 53 |
| sepolicy\private\untrusted_app.te | 53 |
| sepolicy\private\vendor_qtelephony.te | 131 |
| sepolicy\vendor\capsense_reset.te | 579 |
| sepolicy\vendor\charge_only.te | 3152 |
| sepolicy\vendor\device.te | 86 |
| sepolicy\vendor\file.te | 845 |
| sepolicy\vendor\hal_audio_default.te | 710 |
| sepolicy\vendor\hal_bootctl_default.te | 70 |
| sepolicy\vendor\hal_camera_default.te | 707 |
| sepolicy\vendor\hal_power_default.te | 701 |
| sepolicy\vendor\hal_sensors_default.te | 330 |
| sepolicy\vendor\init.te | 609 |
| sepolicy\vendor\installd.te | 160 |
| sepolicy\vendor\kernel.te | 177 |
| sepolicy\vendor\motpsd.te | 571 |
| sepolicy\vendor\proc_net.te | 43 |
| sepolicy\vendor\property.te | 309 |
| sepolicy\vendor\rild.te | 649 |
| sepolicy\vendor\system_app.te | 188 |
| sepolicy\vendor\system_server.te | 65 |
| sepolicy\vendor\tee.te | 200 |
| sepolicy\vendor\ueventd.te | 41 |
| sepolicy\vendor\vendor_init.te | 579 |
| sepolicy\vendor\vendor_init_fingerprint.te | 1031 |
| sepolicy\vendor\vendor_qti_init_shell.te | 810 |
| sepolicy\vendor\vendor_rmt_storage.te | 478 |
| sepolicy\vendor\vendor_sensors.te | 46 |
| sepolicy\vendor\vendor_thermal-engine.te | 438 |
| sepolicy\vendor\vendor_wcnss_service.te | 48 |
| sepolicy\vendor\vl53l1.te | 453 |
| setup-makefiles.sh | 1210 |

### Interesting term hits

- def : 55 file(s)
- sm6150 : 11 file(s)
- vendor_boot : 0 file(s)
- boot : 35 file(s)
- dtbo : 2 file(s)
- vbmeta : 3 file(s)
- super : 5 file(s)
- dynamic : 10 file(s)
- recovery : 11 file(s)
- fstab : 9 file(s)
- qcom : 34 file(s)
- motorola : 10 file(s)
- proprietary : 4 file(s)
- BOARD_ : 6 file(s)
- TARGET_ : 15 file(s)
- PRODUCT_ : 13 file(s)

### First-pass classification

Classification: common-tree-reference

Reason: candidate appears to be a shared sm6150 common tree. Useful for SoC/common assumptions, not device-specific enough by itself.

### Immediate audit questions

- Does BoardConfig identify def, sm6150, partition sizes, boot image layout, or recovery image layout?
- Does fstab identify dynamic partitions, super, vendor, product, odm, or vbmeta behavior?
- Does the tree reference Android 10 while target phone is Android 11?
- Does the tree include proprietary-files lists or only recovery metadata?
- Does the tree depend on unavailable vendor blobs?
- Does the tree include kernel source references or only prebuilt assumptions?

## Current decision

All cloned source candidates remain audit inputs only.

No source candidate is accepted as a build input yet.

Next step: produce per-candidate source audit reports from the inventoried files.
