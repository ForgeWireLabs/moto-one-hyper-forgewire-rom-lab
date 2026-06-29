# Source Audit: AndroidBlobs device_motorola_def

Status: first-pass evidence audit

Date: 2026-06-28

## Safety boundary

This audit only inspects a public source clone in the local hard-work workspace.

No physical phone action is authorized.

No source tree is accepted as a build input by this audit.

No firmware, boot image, recovery image, vbmeta image, dtbo image, or partition image is produced or flashed.

## Candidate metadata

| Field | Value |
|---|---|
| Local path | C:\Projects\moto-one-hyper-local\sources\AndroidBlobs_device_motorola_def |
| Remote | https://github.com/AndroidBlobs/device_motorola_def.git |
| Branch | def_retail-user-10-QPF30.104-b456f-release-keys |
| HEAD | e4f61a413561d53725e58e55d7747c3695b031eb |
| Total files | 135 |
| Key files inspected | 107 |

## First-pass classification

Classification: stock-derived-device-reference

Reason: this candidate is named and structured as a Motorola `def` device metadata tree. It may contain product, device, BoardConfig, proprietary-files, and vendor metadata clues, but it is not accepted as a ROM build input until verified against stock firmware and dependency requirements.

Current build-input decision: rejected for build input pending deeper audit.

Permitted use right now: evidence source only.

## Key file inventory

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

## Interesting term hits

### `BOARD_`

File hits: 1

- `BoardConfig.mk` line 2: `BOARD_VENDOR := motorola`

### `TARGET_`

File hits: 5

- `Android.mk` line 2: `ifeq ($(TARGET_DEVICE),def)`
- `device.mk` line 3: `$(LOCAL_PATH)/configs/audio/Bluetooth_split_audio_V1.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/Bluetooth_split_audio_V1.cfg \`
- `device.mk` line 4: `$(LOCAL_PATH)/configs/audio/MM_audio_playback_capture_v2.0.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/MM_audio_playback_capture_v2.0.cfg \`
- `device.mk` line 5: `$(LOCAL_PATH)/configs/audio/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \`
- `device.mk` line 6: `$(LOCAL_PATH)/configs/audio/aov_ec_mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/aov_ec_mixer_paths.xml \`
- `device.mk` line 7: `$(LOCAL_PATH)/configs/audio/audio_cal.wav:$(TARGET_COPY_OUT_VENDOR)/etc/audio_cal.wav \`
- `device.mk` line 8: `$(LOCAL_PATH)/configs/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \`
- `device.mk` line 9: `$(LOCAL_PATH)/configs/audio/audio_ext_spkr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_ext_spkr.conf \`
- `device.mk` line 10: `$(LOCAL_PATH)/configs/audio/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \`
- `device.mk` line 11: `$(LOCAL_PATH)/configs/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \`
- `device.mk` line 12: `$(LOCAL_PATH)/configs/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \`
- `device.mk` line 13: `$(LOCAL_PATH)/configs/audio/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml \`
- `device.mk` line 14: `$(LOCAL_PATH)/configs/audio/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \`
- `device.mk` line 15: `$(LOCAL_PATH)/configs/audio/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \`
- `device.mk` line 19: `$(LOCAL_PATH)/configs/gps/apdr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/apdr.conf \`
- `device.mk` line 20: `$(LOCAL_PATH)/configs/gps/flp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/flp.conf \`
- `device.mk` line 21: `$(LOCAL_PATH)/configs/gps/gps.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gps.conf \`
- `device.mk` line 22: `$(LOCAL_PATH)/configs/gps/izat.conf:$(TARGET_COPY_OUT_VENDOR)/etc/izat.conf \`
- `device.mk` line 23: `$(LOCAL_PATH)/configs/gps/lowi.conf:$(TARGET_COPY_OUT_VENDOR)/etc/lowi.conf \`
- `device.mk` line 24: `$(LOCAL_PATH)/configs/gps/sap.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sap.conf \`
- Additional hits omitted from first-pass report: 158

### `PRODUCT_`

File hits: 7

- `AndroidProducts.mk` line 1: `PRODUCT_MAKEFILES := \`
- `device.mk` line 2: `PRODUCT_COPY_FILES += \`
- `device.mk` line 18: `PRODUCT_COPY_FILES += \`
- `device.mk` line 28: `PRODUCT_COPY_FILES += \`
- `device.mk` line 32: `PRODUCT_COPY_FILES += \`
- `device.mk` line 36: `PRODUCT_COPY_FILES += \`
- `device.mk` line 40: `PRODUCT_COPY_FILES += \`
- `device.mk` line 44: `PRODUCT_COPY_FILES += \`
- `device.mk` line 73: `PRODUCT_COPY_FILES += \`
- `device.mk` line 108: `PRODUCT_COPY_FILES += \`
- `device.mk` line 112: `PRODUCT_COPY_FILES += \`
- `device.mk` line 116: `PRODUCT_PACKAGES += \`
- `device.mk` line 171: `PRODUCT_COPY_FILES += \`
- `device.mk` line 176: `PRODUCT_COPY_FILES += \`
- `device.mk` line 180: `PRODUCT_COPY_FILES += \`
- `lineage_def.mk` line 11: `PRODUCT_BRAND := motorola`
- `lineage_def.mk` line 12: `PRODUCT_DEVICE := def`
- `lineage_def.mk` line 13: `PRODUCT_MANUFACTURER := motorola`
- `lineage_def.mk` line 14: `PRODUCT_NAME := lineage_def`
- `lineage_def.mk` line 15: `PRODUCT_MODEL := motorola one hyper`
- Additional hits omitted from first-pass report: 37

### `def`

File hits: 46

- `android.hardware.atrace@1.0-service.xml` line 8: `<instance>default</instance>`
- `android.hardware.cas@1.1-service.xml` line 8: `<instance>default</instance>`
- `android.hardware.gnss@2.0-service-qti.xml` line 32: `<fqname>@1.1::IGnss/default</fqname>`
- `android.hardware.gnss@2.0-service-qti.xml` line 33: `<fqname>@2.0::IGnss/default</fqname>`
- `Android.mk` line 2: `ifeq ($(TARGET_DEVICE),def)`
- `AndroidProducts.mk` line 2: `$(LOCAL_DIR)/lineage_def.mk`
- `BoardConfig.mk` line 1: `DEVICE_PATH := device/motorola/def`
- `BoardConfig.mk` line 16: `-include vendor/motorola/def/BoardConfigVendor.mk`
- `compatibility_matrix.xml` line 11: `<instance>default</instance>`
- `compatibility_matrix.xml` line 19: `<instance>default</instance>`
- `compatibility_matrix.xml` line 35: `<instance>default</instance>`
- `compatibility_matrix.xml` line 51: `<instance>default</instance>`
- `compatibility_matrix.xml` line 59: `<instance>default</instance>`
- `compatibility_matrix.xml` line 67: `<instance>default</instance>`
- `compatibility_matrix.xml` line 75: `<instance>default</instance>`
- `configs\audio\aov_ec_mixer_paths.xml` line 4: `<!-- AOV default EC REF settings -->`
- `configs\audio\aov_ec_mixer_paths.xml` line 8: `<!-- AOV default EC REF settings end -->`
- `configs\audio\audio_policy_configuration.xml` line 20: `"route": is defined by an attribute:`
- `configs\audio\audio_policy_configuration.xml` line 26: `defined in <devicePorts> section.`
- `configs\audio\audio_policy_configuration.xml` line 27: `“defaultOutputDevice”: device to be used by default when no policy rule applies`
- Additional hits omitted from first-pass report: 406

### `sm6150`

File hits: 6

- `configs\media\media_codecs_vendor.xml` line 84: `SM6150 Non-Secure decoder capabilities`
- `configs\media\media_codecs_vendor.xml` line 98: `SM6150 Secure decoder capabilities`
- `configs\media\media_codecs_vendor.xml` line 108: `SM6150 Non-Secure encoder capabilities (Secure not supported)`
- `proprietary-files.txt` line 125: `vendor/lib/hw/audio.primary.sm6150.so`
- `proprietary-files.txt` line 543: `vendor/lib/hw/gralloc.sm6150.so`
- `proprietary-files.txt` line 544: `vendor/lib/hw/hwcomposer.sm6150.so`
- `proprietary-files.txt` line 545: `vendor/lib/hw/memtrack.sm6150.so`
- `proprietary-files.txt` line 573: `vendor/lib64/hw/gralloc.sm6150.so`
- `proprietary-files.txt` line 574: `vendor/lib64/hw/hwcomposer.sm6150.so`
- `proprietary-files.txt` line 575: `vendor/lib64/hw/memtrack.sm6150.so`
- `proprietary-files.txt` line 874: `vendor/lib/hw/vulkan.sm6150.so`
- `proprietary-files.txt` line 903: `vendor/lib64/hw/vulkan.sm6150.so`
- `proprietary-files.txt` line 1774: `vendor/lib/hw/thermal.sm6150.so`
- `proprietary-files.txt` line 1777: `vendor/lib64/hw/thermal.sm6150.so`
- `rootdir\bin\init.mmi.usb.sh` line 188: `"sm6150")`
- `rootdir\bin\init.qcom.early_boot.sh` line 110: `"sm6150")`
- `rootdir\bin\init.qcom.early_boot.sh` line 395: `"sm6150_au")`
- `rootdir\bin\init.qcom.post_boot.sh` line 3068: `"sm6150")`
- `rootdir\bin\init.qcom.post_boot.sh` line 3070: `#Apply settings for sm6150`
- `rootdir\bin\init.qcom.post_boot.sh` line 5040: `"msm8909" | "msm8916" | "msm8937" | "msm8952" | "msm8953" | "msm8994" | "msm8992" | "msm8996" | "msm8998" | "sdm660" | "apq8098_latv" | "sdm845" | "sdm710" | "msmnile" | "msmsteppe" | "sm6150" | "kona" | "lito" | "trinket" | "atoll" )`
- Additional hits omitted from first-pass report: 1

### `recovery`

File hits: 4

- `rootdir\bin\init.mmi.touch.sh` line 104: `# perform recovery if touch is declared dead`
- `rootdir\bin\init.mmi.touch.sh` line 106: `notice "Touch needs to go through recovery!!!"`
- `rootdir\bin\init.mmi.touch.sh` line 351: `local recovery`
- `rootdir\bin\init.mmi.touch.sh` line 352: `recovery=0`
- `rootdir\bin\init.mmi.touch.sh` line 354: `recovery=1`
- `rootdir\bin\init.mmi.touch.sh` line 355: `notice "Initiating touch firmware recovery"`
- `rootdir\bin\init.mmi.touch.sh` line 359: `if [ $dec_cfg_id_boot -ne $dec_cfg_id_latest ] || [ "$recovery" == "1" ]; then`
- `rootdir\etc\init.qcom.rc` line 43: `# Change ownership of hw_recovery related nodes`
- `rootdir\etc\init.qcom.rc` line 45: `chown system graphics /sys/kernel/debug/dri/0/debug/recovery_reg`
- `rootdir\etc\init.qcom.rc` line 46: `chown system graphics /sys/kernel/debug/dri/0/debug/recovery_dbgbus`
- `rootdir\etc\init.qcom.rc` line 47: `chown system graphics /sys/kernel/debug/dri/0/debug/recovery_vbif_dbgbus`
- `rootdir\etc\init.target.rc` line 198: `#service security-check2 /sbin/security_boot_check recovery`
- `vendor_prop.mk` line 139: `vendor.display.disable_hw_recovery_dump=1 \`

### `fstab`

File hits: 6

- `device.mk` line 167: `fstab.qcom \`
- `rootdir\Android.mk` line 405: `LOCAL_MODULE       := fstab.qcom`
- `rootdir\Android.mk` line 408: `LOCAL_SRC_FILES    := etc/fstab.qcom`
- `rootdir\etc\fstab.qcom` line 1: `# Android fstab file.`
- `rootdir\etc\init.mmi.rc` line 134: `swapon_all /vendor/etc/fstab.qcom`
- `rootdir\etc\init.qcom.factory.rc` line 109: `# Mount fstab in init.{$device}.rc by mount_all with '--late' parameter`
- `rootdir\etc\init.target.rc` line 57: `mount_all /vendor/etc/fstab.qcom --early`
- `rootdir\etc\init.target.rc` line 71: `mount_all /vendor/etc/fstab.qcom --late`

### `vendor_boot`

File hits: 0


### `boot`

File hits: 34

- `configs\privapp-permissions-qti.xml` line 77: `<permission name="android.permission.REBOOT"/>`
- `configs\telephony_product_privapp-permissions-qti.xml` line 69: `<permission name="android.permission.REBOOT"/>`
- `device.mk` line 126: `init.mmi.boot.sh \`
- `device.mk` line 136: `init.qcom.early_boot.sh \`
- `device.mk` line 138: `init.qcom.post_boot.sh \`
- `manifest.xml` line 61: `<name>android.hardware.boot</name>`
- `manifest.xml` line 65: `<name>IBootControl</name>`
- `manifest.xml` line 68: `<fqname>@1.0::IBootControl/default</fqname>`
- `proprietary-files.txt` line 749: `vendor/firmware/FT8006U_Pramboot.bin`
- `proprietary-files.txt` line 1914: `vendor/bin/bootloaderlog`
- `rootdir\Android.mk` line 77: `LOCAL_MODULE       := init.mmi.boot.sh`
- `rootdir\Android.mk` line 80: `LOCAL_SRC_FILES    := bin/init.mmi.boot.sh`
- `rootdir\Android.mk` line 157: `LOCAL_MODULE       := init.qcom.early_boot.sh`
- `rootdir\Android.mk` line 160: `LOCAL_SRC_FILES    := bin/init.qcom.early_boot.sh`
- `rootdir\Android.mk` line 173: `LOCAL_MODULE       := init.qcom.post_boot.sh`
- `rootdir\Android.mk` line 176: `LOCAL_SRC_FILES    := bin/init.qcom.post_boot.sh`
- `rootdir\bin\apanic_copy.sh` line 24: `apanic_logcopy=$(getprop 'ro.vendor.bootreason')`
- `rootdir\bin\apanic_copy.sh` line 25: `if [ "$apanic_logcopy" == "coldboot" ]; then`
- `rootdir\bin\apanic_copy.sh` line 30: `if [ -e /dev/block/bootdevice/by-name/logs ] ; then`
- `rootdir\bin\apanic_copy.sh` line 31: `BL_logs_parti=/dev/block/bootdevice/by-name/logs`
- Additional hits omitted from first-pass report: 231

### `dtbo`

File hits: 0


### `vbmeta`

File hits: 2

- `framework_compatibility_matrix.xml` line 811: `<vbmeta-version>1.0</vbmeta-version>`
- `rootdir\etc\fstab.qcom` line 9: `system                                                  /system                  ext4    ro,barrier=1                                         wait,slotselect,avb=vbmeta,logical,first_stage_mount`

### `super`

File hits: 0


### `dynamic`

File hits: 6

- `configs\audio\audio_effects.xml` line 11: `<library name="dynamics_processing" path="libdynproc.so"/>`
- `configs\audio\audio_effects.xml` line 29: `<effect name="dynamics_processing" library="dynamics_processing" uuid="e0e6539b-1781-7261-676f-6d7573696340"/>`
- `proprietary-files.txt` line 186: `product/framework/vendor.qti.hardware.data.dynamicdds-V1.0-java.jar`
- `proprietary-files.txt` line 199: `product/lib/vendor.qti.hardware.data.dynamicdds@1.0.so`
- `proprietary-files.txt` line 212: `product/lib64/vendor.qti.hardware.data.dynamicdds@1.0.so`
- `proprietary-files.txt` line 255: `vendor/lib/vendor.qti.hardware.data.dynamicdds@1.0.so`
- `proprietary-files.txt` line 270: `vendor/lib64/vendor.qti.hardware.data.dynamicdds@1.0.so`
- `proprietary-files-system.txt` line 120: `product/framework/vendor.qti.hardware.data.dynamicdds-V1.0-java.jar`
- `proprietary-files-system.txt` line 167: `product/lib/vendor.qti.hardware.data.dynamicdds@1.0.so`
- `proprietary-files-system.txt` line 218: `product/lib64/vendor.qti.hardware.data.dynamicdds@1.0.so`
- `rootdir\bin\init.qcom.class_core.sh` line 49: `# Dynamic Memory Managment (DMM) provides a sys file system to the userspace`
- `rootdir\bin\init.qcom.class_core.sh` line 58: `# configuration that supports DynamicMemoryManagement.`
- `rootdir\bin\init.qcom.post_boot.sh` line 716: `echo 0 > /sys/module/msm_dcvs/cores/cpu0/slack_mode_dynamic`
- `rootdir\bin\init.qcom.post_boot.sh` line 722: `echo 0 > /sys/module/msm_dcvs/cores/cpu1/slack_mode_dynamic`
- `rootdir\bin\init.qcom.post_boot.sh` line 728: `echo 0 > /sys/module/msm_dcvs/cores/cpu2/slack_mode_dynamic`
- `rootdir\bin\init.qcom.post_boot.sh` line 734: `echo 0 > /sys/module/msm_dcvs/cores/cpu3/slack_mode_dynamic`
- `rootdir\bin\init.qcom.post_boot.sh` line 739: `echo 0 > /sys/module/msm_dcvs/cores/gpu0/slack_mode_dynamic`
- `rootdir\bin\init.qcom.post_boot.sh` line 1351: `# Enable dynamic clock gatin`
- `rootdir\bin\init.qcom.post_boot.sh` line 1352: `echo 1 > /sys/module/lpm_levels/lpm_workarounds/dynamic_clock_gating`
- `rootdir\bin\init.qcom.post_boot.sh` line 1531: `# Enable dynamic clock gating`
- Additional hits omitted from first-pass report: 8

### `qcom`

File hits: 27

- `configs\audio\audio_effects.xml` line 13: `<library name="audio_pre_processing" path="libqcomvoiceprocessing.so"/>`
- `configs\media\media_codecs.xml` line 26: `<MediaCodec name="OMX.qcom.video.encoder.hevc" type="video/hevc" >`
- `configs\media\media_codecs.xml` line 42: `<MediaCodec name="OMX.qcom.video.encoder.avc" type="video/avc" >`
- `configs\media\media_codecs.xml` line 58: `<MediaCodec name="OMX.qcom.video.encoder.vp8" type="video/x-vnd.on2.vp8" >`
- `configs\media\media_codecs.xml` line 72: `<MediaCodec name="OMX.qcom.video.encoder.h263sw" type="video/3gpp" >`
- `configs\media\media_codecs.xml` line 85: `<MediaCodec name="OMX.qcom.video.encoder.mpeg4sw" type="video/mp4v-es" >`
- `configs\media\media_codecs.xml` line 101: `<MediaCodec name="OMX.qcom.video.decoder.avc" type="video/avc" >`
- `configs\media\media_codecs.xml` line 117: `<MediaCodec name="OMX.qcom.video.decoder.avc.secure" type="video/avc" >`
- `configs\media\media_codecs.xml` line 131: `<MediaCodec name="OMX.qcom.video.decoder.mpeg2" type="video/mpeg2" >`
- `configs\media\media_codecs.xml` line 144: `<MediaCodec name="OMX.qcom.video.decoder.hevc" type="video/hevc" >`
- `configs\media\media_codecs.xml` line 160: `<MediaCodec name="OMX.qcom.video.decoder.vp8" type="video/x-vnd.on2.vp8" >`
- `configs\media\media_codecs.xml` line 175: `<MediaCodec name="OMX.qcom.video.decoder.vp9" type="video/x-vnd.on2.vp9" >`
- `configs\media\media_codecs_performance.xml` line 44: `<MediaCodec name="OMX.qcom.video.encoder.avc" type="video/avc" update="true">`
- `configs\media\media_codecs_performance.xml` line 50: `<MediaCodec name="OMX.qcom.video.encoder.h263sw" type="video/3gpp" update="true">`
- `configs\media\media_codecs_performance.xml` line 54: `<MediaCodec name="OMX.qcom.video.encoder.hevc" type="video/hevc" update="true">`
- `configs\media\media_codecs_performance.xml` line 61: `<MediaCodec name="OMX.qcom.video.encoder.mpeg4sw" type="video/mp4v-es" update="true">`
- `configs\media\media_codecs_performance.xml` line 67: `<MediaCodec name="OMX.qcom.video.encoder.vp8" type="video/x-vnd.on2.vp8" update="true">`
- `configs\media\media_codecs_performance.xml` line 107: `<MediaCodec name="OMX.qcom.video.decoder.avc" type="video/avc" update="true">`
- `configs\media\media_codecs_performance.xml` line 117: `<MediaCodec name="OMX.qcom.video.decoder.hevc" type="video/hevc" update="true">`
- `configs\media\media_codecs_performance.xml` line 129: `<MediaCodec name="OMX.qcom.video.decoder.vp8" type="video/x-vnd.on2.vp8" update="true">`
- Additional hits omitted from first-pass report: 431

### `motorola`

File hits: 17

- `BoardConfig.mk` line 1: `DEVICE_PATH := device/motorola/def`
- `BoardConfig.mk` line 2: `BOARD_VENDOR := motorola`
- `BoardConfig.mk` line 16: `-include vendor/motorola/def/BoardConfigVendor.mk`
- `compatibility_matrix.xml` line 63: `<name>com.motorola.hardware.display.panel</name>`
- `compatibility_matrix.xml` line 71: `<name>motorola.hardware.popup</name>`
- `device.mk` line 191: `$(call inherit-product, vendor/motorola/def/def-vendor.mk)`
- `framework_compatibility_matrix.xml` line 84: `<name>com.motorola.hardware.display.panel</name>`
- `framework_compatibility_matrix.xml` line 152: `<name>motorola.hardware.audio.adspd</name>`
- `framework_compatibility_matrix.xml` line 160: `<name>motorola.hardware.audio.eqservice</name>`
- `framework_compatibility_matrix.xml` line 168: `<name>motorola.hardware.health</name>`
- `framework_compatibility_matrix.xml` line 176: `<name>motorola.hardware.light</name>`
- `framework_compatibility_matrix.xml` line 184: `<name>motorola.hardware.mods_camera.provider</name>`
- `framework_compatibility_matrix.xml` line 192: `<name>motorola.hardware.mods_camera.provider</name>`
- `framework_compatibility_matrix.xml` line 200: `<name>motorola.hardware.popup</name>`
- `framework_compatibility_matrix.xml` line 208: `<name>motorola.hardware.vibrator</name>`
- `framework_compatibility_matrix.xml` line 216: `<name>motorola.hardware.wifi.supplicant</name>`
- `lineage_def.mk` line 11: `PRODUCT_BRAND := motorola`
- `lineage_def.mk` line 13: `PRODUCT_MANUFACTURER := motorola`
- `lineage_def.mk` line 15: `PRODUCT_MODEL := motorola one hyper`
- `lineage_def.mk` line 17: `PRODUCT_GMS_CLIENTID_BASE := android-motorola`
- Additional hits omitted from first-pass report: 69

### `proprietary`

File hits: 6

- `configs\media\media_codecs_dolby_audio.xml` line 24: `an unpublished work. This program is confidential and proprietary to the`
- `configs\telephony_product_privapp-permissions-qti.xml` line 5: `~ Confidential and Proprietary - Qualcomm Technologies, Inc.`
- `proprietary-files.txt` line 1098: `vendor/lib/libmmosal_proprietary.so`
- `proprietary-files.txt` line 1111: `vendor/lib/libOmxMux_proprietary.so`
- `proprietary-files.txt` line 1131: `vendor/lib64/libmmosal_proprietary.so`
- `proprietary-files.txt` line 2084: `vendor/lib/libFileMux_proprietary.so`
- `proprietary-files.txt` line 2095: `vendor/lib/libmmparser_lite_proprietary.so`
- `proprietary-files.txt` line 2096: `vendor/lib/libmmrtpdecoder_proprietary.so`
- `proprietary-files.txt` line 2097: `vendor/lib/libmmrtpencoder_proprietary.so`
- `proprietary-files.txt` line 2195: `vendor/lib64/libmmparser_lite_proprietary.so`
- `rootdir\bin\init.qti.chg_policy.sh` line 6: `# Confidential and Proprietary - Qualcomm Technologies, Inc.`
- `rootdir\bin\init.qti.fm.sh` line 4: `# Confidential and Proprietary - Qualcomm Technologies, Inc.`
- `vendor.qti.gnss@3.0-service.xml` line 3: `Confidential and Proprietary - Qualcomm Technologies, Inc.`

## Direct file excerpts

### BoardConfig file: BoardConfig.mk

Path: `BoardConfig.mk`

```text
DEVICE_PATH := device/motorola/def
BOARD_VENDOR := motorola

# Security patch level
VENDOR_SECURITY_PATCH := 2019-10-05

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/android.hardware.atrace@1.0-service.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/android.hardware.cas@1.1-service.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/android.hardware.gnss@2.0-service-qti.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/vendor.qti.gnss@3.0-service.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/framework_compatibility_matrix.xml

-include vendor/motorola/def/BoardConfigVendor.mk
```

### AndroidProducts file: AndroidProducts.mk

Path: `AndroidProducts.mk`

```text
PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/lineage_def.mk
```

### fstab/recovery file: fstab.qcom

Path: `rootdir\etc\fstab.qcom`

```text
# Android fstab file.
# The filesystem that contains the filesystem checker binary (typically /system) cannot
# specify MF_CHECK, and must come before any filesystems that do specify MF_CHECK

#TODO: Add 'check' as fs_mgr_flags with data partition.
# Currently we dont have e2fsck compiled. So fs check would failed.

#<src>                                                 <mnt_point>               <type>  <mnt_flags and options>                            <fs_mgr_flags>
system                                                  /system                  ext4    ro,barrier=1                                         wait,slotselect,avb=vbmeta,logical,first_stage_mount
vendor                                                  /vendor                  ext4    ro,barrier=1                                         wait,slotselect,avb,logical,first_stage_mount
product                                                 /product                 ext4    ro,barrier=1                                         wait,slotselect,avb,logical,nofail,first_stage_mount
/dev/block/bootdevice/by-name/metadata                  /metadata                ext4    noatime,nosuid,nodev,discard                         wait,formattable,first_stage_mount
/dev/block/bootdevice/by-name/userdata                  /data                    f2fs    rw,discard,nosuid,nodev,noatime,nodiratime,quota,nobarrier,reserve_root=32768,resgid=1065   latemount,wait,check,formattable,fileencryption=ice:aes-256-cts,quota,reservedsize=128M,checkpoint=fs
/devices/platform/soc/8804000.sdhci/mmc_host*           auto                     auto    defaults                                             wait,voldmanaged=sdcard1:auto
/dev/block/bootdevice/by-name/modem                     /vendor/firmware_mnt     ext4    ro,nosuid,nodev,context=u:object_r:firmware_file:s0  wait,slotselect
/dev/block/bootdevice/by-name/dsp                       /vendor/dsp              ext4    ro,nosuid,nodev,barrier=1                            wait,slotselect
/dev/block/bootdevice/by-name/persist                   /mnt/vendor/persist      ext4    noatime,nosuid,nodev,barrier=1                       wait
/dev/block/bootdevice/by-name/prodpersist               /mnt/product/persist     ext4    noatime,nosuid,nodev,barrier=1                       wait,formattable,nofail
/dev/block/bootdevice/by-name/bluetooth                 /vendor/bt_firmware      ext4    ro,nosuid,nodev,context=u:object_r:bt_firmware_file:s0 wait,slotselect
/devices/platform/soc/a600000.ssusb/a600000.dwc3/xhci-hcd.0.auto*     /storage/usbotg    vfat    nosuid,nodev         wait,voldmanaged=usbotg:auto
/dev/block/bootdevice/by-name/fsg                       /vendor/fsg              ext4    ro,nosuid,nodev,context=u:object_r:fsg_file:s0       wait,slotselect
# Need to have this entry in here even though the mount point itself is no longer needed.
# The update_engine code looks for this entry in order to determine the boot device address
# and fails if it does not find it.
/dev/block/bootdevice/by-name/misc                      /misc                    emmc    defaults                                             defaults
/dev/block/zram0                                        none                     swap    defaults                                             zramsize=1073741824


```

### device/product makefile: device.mk

Path: `device.mk`

```text
# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/Bluetooth_split_audio_V1.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/Bluetooth_split_audio_V1.cfg \
    $(LOCAL_PATH)/configs/audio/MM_audio_playback_capture_v2.0.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/MM_audio_playback_capture_v2.0.cfg \
    $(LOCAL_PATH)/configs/audio/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/aov_ec_mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/aov_ec_mixer_paths.xml \
    $(LOCAL_PATH)/configs/audio/audio_cal.wav:$(TARGET_COPY_OUT_VENDOR)/etc/audio_cal.wav \
    $(LOCAL_PATH)/configs/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    $(LOCAL_PATH)/configs/audio/audio_ext_spkr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_ext_spkr.conf \
    $(LOCAL_PATH)/configs/audio/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/configs/audio/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml \
    $(LOCAL_PATH)/configs/audio/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \

# GPS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps/apdr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/apdr.conf \
    $(LOCAL_PATH)/configs/gps/flp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/flp.conf \
    $(LOCAL_PATH)/configs/gps/gps.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gps.conf \
    $(LOCAL_PATH)/configs/gps/izat.conf:$(TARGET_COPY_OUT_VENDOR)/etc/izat.conf \
    $(LOCAL_PATH)/configs/gps/lowi.conf:$(TARGET_COPY_OUT_VENDOR)/etc/lowi.conf \
    $(LOCAL_PATH)/configs/gps/sap.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sap.conf \
    $(LOCAL_PATH)/configs/gps/xtwifi.conf:$(TARGET_COPY_OUT_VENDOR)/etc/xtwifi.conf \

# IRQ
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf \

# IRSC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config \

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayout/gpio-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/gpio-keys.kl \

# Low power Whitelist
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/qti_whitelist.xml:system/etc/sysconfig/qti_whitelist.xml \

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_dolby_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_dolby_audio.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_google_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_google_video_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video_le.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_performance_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_v1.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_performance_v2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_v2.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_v1.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_v2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_v2.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_vendor_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor_audio.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_vendor_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor_v1.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_vendor_v2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor_v2.xml \
    $(LOCAL_PATH)/configs/media/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    $(LOCAL_PATH)/configs/media/media_profiles_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml \
    $(LOCAL_PATH)/configs/media/system_properties.xml:$(TARGET_COPY_OUT_VENDOR)/etc/system_properties.xml \

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \

# Public Libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt \

# QTI
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/privapp-permissions-qti.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/privapp-permissions-qti.xml \

# Ramdisk
PRODUCT_PACKAGES += \
    apanic_annotate.sh \
    apanic_copy.sh \
    apanic_save.sh \
    hardware_revisions.sh \
    init.class_main.sh \
    init.crda.sh \
    init.gbmods.sh \
    init.mdm.sh \
    init.mmi.block_perm.sh \
    init.mmi.boot.sh \
    init.mmi.laser.sh \
    init.mmi.mdlog-getlogs.sh \
    init.mmi.touch.sh \
    init.mmi.usb.sh \
    init.mmi.wlan-getlogs.sh \
    init.oem.hw.sh \
    init.qcom.class_core.sh \
    init.qcom.coex.sh \
    init.qcom.crashdata.sh \
    init.qcom.early_boot.sh \
    init.qcom.efs.sync.sh \
    init.qcom.post_boot.sh \
    init.qcom.sdio.sh \
    init.qcom.sensors.sh \
    init.qcom.sh \
    init.qti.chg_policy.sh \
    init.qti.fm.sh \
    init.qti.ims.sh \
    pstore_annotate.sh \
    qca6234-service.sh \
    ufs_ffu.sh \
    ufs_ffu_SAMSUNG.sh \
    ufs_ffu_SKhynix.sh \
    ufs_ffu_WDC.sh \
    init.hidl.sensor.rc \
    init.mmi.charge_only.rc \
    init.mmi.chipset.rc \
    init.mmi.debug.rc \
    init.mmi.diag.rc \
    init.mmi.diag_mdlog.rc \
    init.mmi.overlay.rc \
    init.mmi.rc \
    init.mmi.sensor.rc \
    init.mmi.tcmd.rc \
    init.mmi.usb.rc \
    init.mmi.wlan.rc \
    init.qcom.factory.rc \
    init.qcom.rc \
    init.target.rc \
    init.vendor.st21nfc.rc \
    fstab.qcom \
    ueventd.qcom.rc \

# Seccomp
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/seccomp/configstore@1.1.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/configstore@1.1.policy \
    $(LOCAL_PATH)/configs/seccomp/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \

# Sensors
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf \

# WiFi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/configs/wifi/aoa_cldb_falcon.bin:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/aoa_cldb_falcon.bin \
    $(LOCAL_PATH)/configs/wifi/aoa_cldb_swl14.bin:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/aoa_cldb_swl14.bin \
    $(LOCAL_PATH)/configs/wifi/fstman.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/fstman.ini \
    $(LOCAL_PATH)/configs/wifi/icm.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/icm.conf \
    $(LOCAL_PATH)/configs/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/configs/wifi/wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/configs/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \

# Inherit vendor
$(call inherit-product, vendor/motorola/def/def-vendor.mk)
```

### device/product makefile: lineage_def.mk

Path: `lineage_def.mk`

```text
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from def device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := motorola
PRODUCT_DEVICE := def
PRODUCT_MANUFACTURER := motorola
PRODUCT_NAME := lineage_def
PRODUCT_MODEL := motorola one hyper

PRODUCT_GMS_CLIENTID_BASE := android-motorola
TARGET_VENDOR := motorola
TARGET_VENDOR_PRODUCT_NAME := def
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="def_retail-user 10 QPF30.104 b456f release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := motorola/def_retail/def:10/QPF30.104/b456f:user/release-keys

```

## Audit findings

### What this candidate can help with

- Recovery bring-up clues.
- fstab and mount layout clues.
- BoardConfig recovery image assumptions.
- Motorola `def` naming confirmation.
- Possible partition naming and dynamic partition hints.

### What this candidate does not prove

- It does not prove compatibility with the target phone build `RPFS31.Q1-21-20-1-7-3`.
- It does not provide a verified stock boot image.
- It does not provide a verified stock recovery anchor.
- It does not establish a full ROM build tree.
- It does not authorize flashing, booting, or testing on the physical phone.

### Required follow-up questions

- Does the tree assume Android 10-era recovery behavior while the target phone is Android 11?
- Does BoardConfig mention recovery image size, boot header version, dtbo, vendor_boot, or AVB?
- Does fstab expose dynamic partitions, super, product, vendor, odm, or logical partition layout?
- Does the tree require a prebuilt kernel?
- Does the tree depend on vendor blobs unavailable from this repo?
- Does the tree include recovery-only assumptions that would be dangerous to treat as ROM assumptions?

## Current decision

Keep this candidate as an audit input only.

Do not use this candidate as a build input yet.

Do not use this candidate for physical-device boot or flash attempts.

Next recommended audit: `ludevjhon_device_motorola_def`.
