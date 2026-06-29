# Source Audit: Fraaxius device_motorola_sm6150-common

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
| Local path | C:\Projects\moto-one-hyper-local\sources\Fraaxius_device_motorola_sm6150-common |
| Remote | https://github.com/Fraaxius/device_motorola_sm6150-common.git |
| Branch | lineage-21 |
| HEAD | 0e09fc8bf110b256cdd99d577ec24901715d69c1 |
| Total files | 563 |
| Key files inspected | 157 |

## First-pass classification

Classification: common-tree-reference

Reason: this candidate is named and structured as a shared Motorola `sm6150-common` tree. It may contain SoC/common BoardConfig, sepolicy, init, vendor, kernel, and shared-device assumptions. It is not device-specific enough to accept as a build input by itself.

Current build-input decision: rejected for build input pending deeper audit.

Permitted use right now: evidence source only.

## Key file inventory

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

## Interesting term hits

### `BOARD_`

File hits: 6

- `BoardConfigCommon.mk` line 21: `BOARD_VENDOR := motorola`
- `BoardConfigCommon.mk` line 44: `TARGET_BOOTLOADER_BOARD_NAME := sm6150`
- `BoardConfigCommon.mk` line 49: `BOARD_BOOT_HEADER_VERSION := 2`
- `BoardConfigCommon.mk` line 50: `BOARD_KERNEL_BASE := 0x00000000`
- `BoardConfigCommon.mk` line 51: `BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=2048 loop.max_part=7 cgroup.memory=nokmem,nosocket reboot=panic_warm`
- `BoardConfigCommon.mk` line 52: `BOARD_KERNEL_IMAGE_NAME := Image`
- `BoardConfigCommon.mk` line 53: `BOARD_KERNEL_PAGESIZE := 4096`
- `BoardConfigCommon.mk` line 54: `BOARD_KERNEL_SEPARATED_DTBO := true`
- `BoardConfigCommon.mk` line 55: `BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)`
- `BoardConfigCommon.mk` line 100: `BOARD_USES_QCOM_HARDWARE := true`
- `BoardConfigCommon.mk` line 101: `QCOM_BOARD_PLATFORMS += sm6150`
- `BoardConfigCommon.mk` line 102: `TARGET_BOARD_PLATFORM := sm6150`
- `BoardConfigCommon.mk` line 103: `TARGET_BOARD_PLATFORM_GPU := qcom-adreno620`
- `BoardConfigCommon.mk` line 117: `BOARD_USES_ALSA_AUDIO := true`
- `BoardConfigCommon.mk` line 118: `BOARD_SUPPORTS_SOUND_TRIGGER := true`
- `BoardConfigCommon.mk` line 122: `BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(VENDOR_PATH)/bluetooth/include`
- `BoardConfigCommon.mk` line 126: `BOARD_USES_QCNE := true`
- `BoardConfigCommon.mk` line 154: `BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)`
- `BoardConfigCommon.mk` line 169: `BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864`
- `BoardConfigCommon.mk` line 170: `BOARD_DTBOIMG_PARTITION_SIZE := 25165824`
- Additional hits omitted from first-pass report: 104

### `TARGET_`

File hits: 15

- `Android.mk` line 19: `ifneq ($(filter foles parker def liber odessa minsk hanoip,$(TARGET_DEVICE)),)`
- `Android.mk` line 26: `FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt`
- `Android.mk` line 29: `@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt`
- `Android.mk` line 31: `BT_FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/bt_firmware`
- `Android.mk` line 34: `@mkdir -p $(TARGET_OUT_VENDOR)/bt_firmware`
- `Android.mk` line 36: `DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp`
- `Android.mk` line 39: `@mkdir -p $(TARGET_OUT_VENDOR)/dsp`
- `Android.mk` line 41: `FSG_MOUNT_POINT := $(TARGET_OUT_VENDOR)/fsg`
- `Android.mk` line 44: `@mkdir -p $(TARGET_OUT_VENDOR)/fsg`
- `Android.mk` line 46: `SUPER_MODEM_MOUNT_POINT := $(TARGET_OUT_VENDOR)/super_modem`
- `Android.mk` line 49: `@mkdir -p $(TARGET_OUT_VENDOR)/super_modem`
- `Android.mk` line 51: `SUPER_FSG_MOUNT_POINT := $(TARGET_OUT_VENDOR)/super_fsg`
- `Android.mk` line 54: `@mkdir -p $(TARGET_OUT_VENDOR)/super_fsg`
- `Android.mk` line 59: `IMS_SYMLINKS := $(addprefix $(TARGET_OUT_SYSTEM_EXT_APPS_PRIVILEGED)/ims/lib/arm64/,$(notdir $(IMS_LIBS)))`
- `Android.mk` line 68: `RFS_MSM_ADSP_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/adsp/`
- `Android.mk` line 80: `RFS_MSM_CDSP_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/cdsp/`
- `Android.mk` line 92: `RFS_MSM_MPSS_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/mpss/`
- `Android.mk` line 104: `RFS_MSM_SLPI_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/slpi/`
- `Android.mk` line 116: `WIFI_FIRMWARE_SYMLINKS := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld`
- `Android.mk` line 125: `EXPAT_SYMLINKS := $(TARGET_OUT_VENDOR_EXECUTABLES)/expat`
- Additional hits omitted from first-pass report: 203

### `PRODUCT_`

File hits: 13

- `BoardConfigCommon.mk` line 18: `BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true`
- `BoardConfigCommon.mk` line 179: `ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)`
- `BoardConfigCommon.mk` line 203: `ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)`
- `common.mk` line 24: `PRODUCT_COPY_FILES += \`
- `common.mk` line 32: `PRODUCT_ENFORCE_RRO_TARGETS := *`
- `common.mk` line 33: `PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \`
- `common.mk` line 53: `PRODUCT_PACKAGES += \`
- `common.mk` line 59: `PRODUCT_PACKAGES += \`
- `common.mk` line 69: `PRODUCT_COPY_FILES += \`
- `common.mk` line 110: `PRODUCT_PACKAGES += \`
- `common.mk` line 133: `PRODUCT_COPY_FILES += \`
- `common.mk` line 137: `PRODUCT_COPY_FILES += \`
- `common.mk` line 140: `PRODUCT_COPY_FILES += \`
- `common.mk` line 149: `PRODUCT_PACKAGES += \`
- `common.mk` line 154: `PRODUCT_PACKAGES_DEBUG += \`
- `common.mk` line 158: `PRODUCT_PACKAGES += \`
- `common.mk` line 167: `PRODUCT_PACKAGES += \`
- `common.mk` line 180: `PRODUCT_PACKAGES += \`
- `common.mk` line 209: `PRODUCT_PACKAGES += \`
- `common.mk` line 215: `PRODUCT_PACKAGES += \`
- Additional hits omitted from first-pass report: 143

### `def`

File hits: 55

- `Android.mk` line 19: `ifneq ($(filter foles parker def liber odessa minsk hanoip,$(TARGET_DEVICE)),)`
- `Android.mk` line 56: `ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MOUNT_POINT) $(BT_FIRMWARE_MOUNT_POINT) $(DSP_MOUNT_POINT) $(FSG_MOUNT_POINT) $(SUPER_MODEM_MOUNT_POINT) $(SUPER_FSG_MOUNT_POINT)`
- `Android.mk` line 66: `ALL_DEFAULT_INSTALLED_MODULES += $(IMS_SYMLINKS)`
- `Android.mk` line 123: `ALL_DEFAULT_INSTALLED_MODULES += $(RFS_MSM_ADSP_SYMLINKS) $(RFS_MSM_CDSP_SYMLINKS) $(RFS_MSM_MPSS_SYMLINKS) $(RFS_MSM_SLPI_SYMLINKS) $(WIFI_FIRMWARE_SYMLINKS)`
- `Android.mk` line 132: `ALL_DEFAULT_INSTALLED_MODULES += $(EXPAT_SYMLINKS)`
- `audio\audio_policy_configuration.xml` line 20: `"route": is defined by an attribute:`
- `audio\audio_policy_configuration.xml` line 26: `defined in <devicePorts> section.`
- `audio\audio_policy_configuration.xml` line 27: `“defaultOutputDevice”: device to be used by default when no policy rule applies`
- `audio\audio_policy_configuration.xml` line 41: `<defaultOutputDevice>Speaker</defaultOutputDevice>`
- `audio\audio_policy_configuration.xml` line 197: `<xi:include href="default_volume_tables.xml"/>`
- `BoardConfigCommon.mk` line 231: `WIFI_DRIVER_DEFAULT := qca_cld3`
- `common.mk` line 116: `audio.bluetooth.default \`
- `common.mk` line 118: `audio.r_submix.default \`
- `common.mk` line 119: `audio.usb.default \`
- `common.mk` line 144: `frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \`
- `common.mk` line 410: `PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \`
- `common_dynamic.mk` line 24: `ro.crypto.dm_default_key.options_format.version=2 \`
- `common_dynamic.mk` line 25: `ro.crypto.volume.metadata.method=dm-default-key \`
- `compatibility_matrix.xml` line 34: `<instance>default</instance>`
- `compatibility_matrix.xml` line 42: `<instance>default</instance>`
- Additional hits omitted from first-pass report: 297

### `sm6150`

File hits: 11

- `BoardConfigCommon.mk` line 23: `VENDOR_PATH := device/motorola/sm6150-common`
- `BoardConfigCommon.mk` line 44: `TARGET_BOOTLOADER_BOARD_NAME := sm6150`
- `BoardConfigCommon.mk` line 57: `TARGET_KERNEL_SOURCE := kernel/motorola/sm6150`
- `BoardConfigCommon.mk` line 101: `QCOM_BOARD_PLATFORMS += sm6150`
- `BoardConfigCommon.mk` line 102: `TARGET_BOARD_PLATFORM := sm6150`
- `BoardConfigCommon.mk` line 165: `TARGET_INIT_VENDOR_LIB := //$(VENDOR_PATH):libinit_sm6150`
- `BoardConfigCommon.mk` line 166: `TARGET_RECOVERY_DEVICE_MODULES := libinit_sm6150`
- `common.mk` line 21: `$(call inherit-product-if-exists, vendor/motorola/sm6150-common/sm6150-common-vendor.mk)`
- `common.mk` line 57: `$(call inherit-product, device/motorola/sm6150-common/common_dynamic.mk)`
- `common.mk` line 117: `audio.primary.sm6150 \`
- `common.mk` line 226: `gralloc.sm6150 \`
- `common.mk` line 227: `hwcomposer.sm6150 \`
- `common.mk` line 233: `memtrack.sm6150 \`
- `common.mk` line 314: `vendor.lineage.livedisplay@2.0-service-sysfs.motorola_sm6150`
- `common.mk` line 388: `android.hardware.power-service.sm6150-libperfmgr`
- `configs\media_codecs.xml` line 84: `SM6150 Non-Secure decoder capabilities`
- `configs\media_codecs.xml` line 98: `SM6150 Secure decoder capabilities`
- `configs\media_codecs.xml` line 108: `SM6150 Non-Secure encoder capabilities (Secure not supported)`
- `configs\media_codecs_vendor.xml` line 84: `SM6150 Non-Secure decoder capabilities`
- `configs\media_codecs_vendor.xml` line 97: `SM6150 Secure decoder capabilities`
- Additional hits omitted from first-pass report: 10

### `recovery`

File hits: 11

- `BoardConfigCommon.mk` line 166: `TARGET_RECOVERY_DEVICE_MODULES := libinit_sm6150`
- `BoardConfigCommon.mk` line 182: `BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864`
- `BoardConfigCommon.mk` line 197: `# Recovery`
- `BoardConfigCommon.mk` line 199: `BOARD_INCLUDE_RECOVERY_DTBO := true`
- `BoardConfigCommon.mk` line 200: `TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"`
- `BoardConfigCommon.mk` line 204: `TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab_dynamic.qcom`
- `BoardConfigCommon.mk` line 206: `TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab.qcom`
- `common.mk` line 152: `android.hardware.boot@1.1-impl-qti.recovery`
- `common.mk` line 204: `init.recovery.qcom.rc \`
- `common.mk` line 280: `android.hardware.health@2.1-impl.recovery \`
- `common_dynamic.mk` line 19: `recovery \`
- `overlay-lineage-fastbootd\lineage-sdk\lineage\res\res\values\config.xml` line 22: `<item>restart_recovery</item>`
- `properties.mk` line 166: `vendor.display.disable_hw_recovery_dump=1`
- `rootdir\Android.mk` line 199: `LOCAL_MODULE       := init.recovery.qcom.rc`
- `rootdir\Android.mk` line 203: `LOCAL_SRC_FILES    := etc/init.recovery.qcom.rc`
- `rootdir\bin\init.mmi.touch.sh` line 109: `# perform recovery if touch is declared dead`
- `rootdir\bin\init.mmi.touch.sh` line 111: `notice "Touch needs to go through recovery!!!"`
- `rootdir\bin\init.mmi.touch.sh` line 398: `local recovery`
- `rootdir\bin\init.mmi.touch.sh` line 399: `recovery=0`
- `rootdir\bin\init.mmi.touch.sh` line 401: `recovery=1`
- Additional hits omitted from first-pass report: 11

### `fstab`

File hits: 9

- `BoardConfigCommon.mk` line 204: `TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab_dynamic.qcom`
- `BoardConfigCommon.mk` line 206: `TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab.qcom`
- `common.mk` line 181: `fstab.qcom \`
- `common_dynamic.mk` line 28: `# Fstab`
- `common_dynamic.mk` line 30: `$(LOCAL_PATH)/rootdir/etc/fstab_dynamic.qcom:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom`
- `proprietary-files.txt` line 198: `vendor/etc/charger_fstab.qti`
- `rootdir\Android.mk` line 3: `# Fstab`
- `rootdir\Android.mk` line 6: `LOCAL_MODULE       := fstab.qcom`
- `rootdir\Android.mk` line 10: `LOCAL_SRC_FILES    := etc/fstab_dynamic.qcom`
- `rootdir\Android.mk` line 12: `LOCAL_SRC_FILES    := etc/fstab.qcom`
- `rootdir\etc\fstab.qcom` line 1: `# Android fstab file.`
- `rootdir\etc\fstab_dynamic.qcom` line 1: `# Android fstab file.`
- `rootdir\etc\init.mmi.rc` line 134: `swapon_all /vendor/etc/fstab.qcom`
- `rootdir\etc\init.mmi.rc` line 325: `mount_all /vendor/etc/fstab.qcom --late`
- `rootdir\etc\init.target.rc` line 54: `mount_all /vendor/etc/fstab.qcom --early`
- `rootdir\etc\init.target.rc` line 76: `mount_all /vendor/etc/fstab.qcom --late`

### `vendor_boot`

File hits: 0


### `boot`

File hits: 35

- `BoardConfigCommon.mk` line 43: `# Bootloader`
- `BoardConfigCommon.mk` line 44: `TARGET_BOOTLOADER_BOARD_NAME := sm6150`
- `BoardConfigCommon.mk` line 45: `TARGET_NO_BOOTLOADER := true`
- `BoardConfigCommon.mk` line 49: `BOARD_BOOT_HEADER_VERSION := 2`
- `BoardConfigCommon.mk` line 51: `BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=2048 loop.max_part=7 cgroup.memory=nokmem,nosocket reboot=panic_warm`
- `BoardConfigCommon.mk` line 55: `BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)`
- `BoardConfigCommon.mk` line 134: `WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY ?= true`
- `BoardConfigCommon.mk` line 169: `BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864`
- `BoardConfigCommon.mk` line 198: `BOARD_INCLUDE_DTB_IN_BOOTIMG := true`
- `BoardConfigCommon.mk` line 221: `# Android Verified Boot`
- `common.mk` line 41: `boot \`
- `common.mk` line 148: `# Boot control`
- `common.mk` line 150: `android.hardware.boot@1.1-impl-qti \`
- `common.mk` line 151: `android.hardware.boot@1.1-service \`
- `common.mk` line 152: `android.hardware.boot@1.1-impl-qti.recovery`
- `common.mk` line 155: `bootctl`
- `common.mk` line 195: `init.qcom.early_boot.sh \`
- `common.mk` line 473: `PRODUCT_BOOT_JARS += \`
- `common.mk` line 527: `PRODUCT_BOOT_JARS += \`
- `common_dynamic.mk` line 32: `# Fastbootd`
- Additional hits omitted from first-pass report: 219

### `dtbo`

File hits: 2

- `BoardConfigCommon.mk` line 54: `BOARD_KERNEL_SEPARATED_DTBO := true`
- `BoardConfigCommon.mk` line 170: `BOARD_DTBOIMG_PARTITION_SIZE := 25165824`
- `BoardConfigCommon.mk` line 199: `BOARD_INCLUDE_RECOVERY_DTBO := true`
- `common.mk` line 42: `dtbo \`

### `vbmeta`

File hits: 3

- `BoardConfigCommon.mk` line 223: `BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3`
- `common.mk` line 45: `vbmeta`
- `rootdir\etc\fstab_dynamic.qcom` line 9: `system                                                  /system                  ext4    ro,barrier=1                                         wait,slotselect,avb=vbmeta,avb_keys=/avb/q-gsi.avbpubkey:/avb/r-gsi.avbpubkey:/avb/s-gsi.avbpubkey,logical,first_stage_mount`

### `super`

File hits: 5

- `Android.mk` line 46: `SUPER_MODEM_MOUNT_POINT := $(TARGET_OUT_VENDOR)/super_modem`
- `Android.mk` line 47: `$(SUPER_MODEM_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)`
- `Android.mk` line 48: `@echo "Creating $(SUPER_MODEM_MOUNT_POINT)"`
- `Android.mk` line 49: `@mkdir -p $(TARGET_OUT_VENDOR)/super_modem`
- `Android.mk` line 51: `SUPER_FSG_MOUNT_POINT := $(TARGET_OUT_VENDOR)/super_fsg`
- `Android.mk` line 52: `$(SUPER_FSG_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)`
- `Android.mk` line 53: `@echo "Creating $(SUPER_FSG_MOUNT_POINT)"`
- `Android.mk` line 54: `@mkdir -p $(TARGET_OUT_VENDOR)/super_fsg`
- `Android.mk` line 56: `ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MOUNT_POINT) $(BT_FIRMWARE_MOUNT_POINT) $(DSP_MOUNT_POINT) $(FSG_MOUNT_POINT) $(SUPER_MODEM_MOUNT_POINT) $(SUPER_FSG_MOUNT_POINT)`
- `BoardConfigCommon.mk` line 192: `BOARD_SUPER_PARTITION_GROUPS := mot_dp_group`
- `BoardConfigCommon.mk` line 193: `BOARD_SUPER_PARTITION_SIZE := 9729736704`
- `rootdir\bin\init.oem.hw.sh` line 40: `policy_prop=ro.vendor.super_image_policy`
- `rootdir\bin\init.oem.hw.sh` line 42: `super_image_detection()`
- `rootdir\bin\init.oem.hw.sh` line 50: `local is_super_image`
- `rootdir\bin\init.oem.hw.sh` line 51: `local super_image_prop`
- `rootdir\bin\init.oem.hw.sh` line 59: `is_super_image=""`
- `rootdir\bin\init.oem.hw.sh` line 65: `[ -f $image_dir/super_modem ] && is_super_image="true"`
- `rootdir\bin\init.oem.hw.sh` line 66: `debug "super image '$is_super_image'"`
- `rootdir\bin\init.oem.hw.sh` line 68: `if [ "$is_super_image" == "true" ]; then`
- `rootdir\bin\init.oem.hw.sh` line 71: `modem) super_image_prop="ro.vendor.hw.modem_super_image"`
- Additional hits omitted from first-pass report: 34

### `dynamic`

File hits: 10

- `audio\audio_effects.xml` line 37: `<library name="dynamics_processing" path="libdynproc.so"/>`
- `audio\audio_effects.xml` line 81: `<effect name="dynamics_processing" library="dynamics_processing" uuid="e0e6539b-1781-7261-676f-6d7573696340"/>`
- `BoardConfigCommon.mk` line 179: `ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)`
- `BoardConfigCommon.mk` line 203: `ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)`
- `BoardConfigCommon.mk` line 204: `TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab_dynamic.qcom`
- `common.mk` line 57: `$(call inherit-product, device/motorola/sm6150-common/common_dynamic.mk)`
- `common_dynamic.mk` line 30: `$(LOCAL_PATH)/rootdir/etc/fstab_dynamic.qcom:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom`
- `overlay\frameworks\base\core\res\res\values\config.xml` line 345: `<!-- Flag specifying whether or not IMS will use the dynamic ImsResolver -->`
- `overlay\frameworks\base\core\res\res\values\config.xml` line 346: `<bool name="config_dynamic_bind_ims">true</bool>`
- `properties.mk` line 66: `vendor.audio.feature.dynamic_ecns.enable=true \`
- `proprietary-files.txt` line 109: `system_ext/framework/vendor.qti.hardware.data.dynamicdds-V1.0-java.jar`
- `proprietary-files.txt` line 110: `system_ext/lib/vendor.qti.hardware.data.dynamicdds@1.0.so`
- `proprietary-files.txt` line 111: `system_ext/lib64/vendor.qti.hardware.data.dynamicdds@1.0.so`
- `proprietary-files.txt` line 156: `vendor/lib/vendor.qti.hardware.data.dynamicdds@1.0.so`
- `proprietary-files.txt` line 177: `vendor/lib64/vendor.qti.hardware.data.dynamicdds@1.0.so`
- `rootdir\Android.mk` line 9: `ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)`
- `rootdir\Android.mk` line 10: `LOCAL_SRC_FILES    := etc/fstab_dynamic.qcom`
- `rootdir\bin\init.qcom.class_core.sh` line 49: `# Dynamic Memory Managment (DMM) provides a sys file system to the userspace`
- `rootdir\bin\init.qcom.class_core.sh` line 58: `# configuration that supports DynamicMemoryManagement.`
- `rootdir\ueventd.rc` line 413: `/sys/class/graphics/fb*     dynamic_fps              0664    system  graphics`
- Additional hits omitted from first-pass report: 2

### `qcom`

File hits: 34

- `Android.mk` line 120: `$(hide) ln -sf /vendor/etc/wifi/WCNSS_qcom_cfg.ini $@/WCNSS_qcom_cfg.ini`
- `audio\audio_effects.xml` line 34: `<library name="visualizer_hw" path="libqcomvisualizer.so"/>`
- `audio\audio_effects.xml` line 39: `<library name="offload_bundle" path="libqcompostprocbundle.so"/>`
- `audio\audio_effects.xml` line 40: `<library name="audio_pre_processing" path="libqcomvoiceprocessing.so"/>`
- `BoardConfigCommon.mk` line 51: `BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=2048 loop.max_part=7 cgroup.memory=nokmem,nosocket reboot=panic_warm`
- `BoardConfigCommon.mk` line 100: `BOARD_USES_QCOM_HARDWARE := true`
- `BoardConfigCommon.mk` line 101: `QCOM_BOARD_PLATFORMS += sm6150`
- `BoardConfigCommon.mk` line 103: `TARGET_BOARD_PLATFORM_GPU := qcom-adreno620`
- `BoardConfigCommon.mk` line 154: `BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)`
- `BoardConfigCommon.mk` line 204: `TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab_dynamic.qcom`
- `BoardConfigCommon.mk` line 206: `TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab.qcom`
- `BoardConfigCommon.mk` line 217: `include device/qcom/sepolicy_vndr-legacy-um/SEPolicy.mk`
- `common.mk` line 124: `libqcompostprocbundle \`
- `common.mk` line 125: `libqcomvisualizer \`
- `common.mk` line 126: `libqcomvoiceprocessing \`
- `common.mk` line 181: `fstab.qcom \`
- `common.mk` line 192: `init.qcom.class_core.sh \`
- `common.mk` line 193: `init.qcom.coex.sh \`
- `common.mk` line 194: `init.qcom.crashdata.sh \`
- `common.mk` line 195: `init.qcom.early_boot.sh \`
- Additional hits omitted from first-pass report: 336

### `motorola`

File hits: 10

- `BoardConfigCommon.mk` line 21: `BOARD_VENDOR := motorola`
- `BoardConfigCommon.mk` line 23: `VENDOR_PATH := device/motorola/sm6150-common`
- `BoardConfigCommon.mk` line 57: `TARGET_KERNEL_SOURCE := kernel/motorola/sm6150`
- `common.mk` line 21: `$(call inherit-product-if-exists, vendor/motorola/sm6150-common/sm6150-common-vendor.mk)`
- `common.mk` line 57: `$(call inherit-product, device/motorola/sm6150-common/common_dynamic.mk)`
- `common.mk` line 252: `com.motorola.hardware.biometric.fingerprint@1.0.vendor`
- `common.mk` line 314: `vendor.lineage.livedisplay@2.0-service-sysfs.motorola_sm6150`
- `livedisplay\vendor.lineage.livedisplay@2.0-service-sysfs.motorola_sm6150.rc` line 10: `service vendor.livedisplay-hal-2-0-sysfs /vendor/bin/hw/vendor.lineage.livedisplay@2.0-service-sysfs.motorola_sm6150`
- `manifest.xml` line 569: `<name>motorola.hardware.health</name>`
- `manifest.xml` line 578: `<name>motorola.hardware.audio.adspd</name>`
- `overlay\frameworks\base\core\res\res\values\config.xml` line 116: `<string name="config_mms_user_agent" translatable="false">motorolaedge</string>`
- `proprietary-files.txt` line 524: `product/etc/permissions/com.motorola.moto-uirefresh.xml`
- `proprietary-files.txt` line 525: `product/etc/permissions/com.motorola.motodisplay.xml`
- `proprietary-files.txt` line 526: `system_ext/etc/permissions/com.motorola.androidx.camera.extensions.xml:vendor/etc/permissions/com.motorola.androidx.camera.extensions.xml`
- `proprietary-files.txt` line 982: `# WiFi Display - from Motorola Edge S - RRN31.Q1-20-31-3`
- `proprietary-files.txt` line 1062: `# WiFi Display (HDCP) - from Motorola Edge S - RRN31.Q1-20-31-3`
- `rootdir\etc\init.mmi.usb.rc` line 185: `write /config/usb_gadget/g1/configs/b.1/strings/0x409/configuration "Motorola Test Command"`
- `rootdir\etc\init.mmi.usb.rc` line 201: `write /config/usb_gadget/g1/configs/b.1/strings/0x409/configuration "Motorola Test Command without ADB"`
- `rootdir\etc\init.mmi.usb.rc` line 216: `write /config/usb_gadget/g1/configs/b.1/strings/0x409/configuration "Motorola Test Command"`
- `rootdir\etc\init.mmi.usb.rc` line 233: `write /config/usb_gadget/g1/configs/b.1/strings/0x409/configuration "Motorola Test Command without ADB"`
- Additional hits omitted from first-pass report: 4

### `proprietary`

File hits: 4

- `extract-files.sh` line 84: `extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"`
- `extract-files.sh` line 87: `if [ -z "${ONLY_COMMON}" ] && [ -s "${MY_DIR}/../${DEVICE}/proprietary-files.txt" ]; then`
- `extract-files.sh` line 92: `extract "${MY_DIR}/../${DEVICE}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"`
- `proprietary-files.txt` line 460: `vendor/lib/libFileMux_proprietary.so`
- `proprietary-files.txt` line 482: `vendor/lib/libmmrtpdecoder_proprietary.so`
- `proprietary-files.txt` line 483: `vendor/lib/libmmrtpencoder_proprietary.so`
- `proprietary-files.txt` line 1038: `vendor/lib/libFileMux_proprietary.so|e59edd4604a7c73147118161cab5b7ac6bb16c82`
- `proprietary-files.txt` line 1040: `vendor/lib/libmmrtpdecoder_proprietary.so|9232f505ea8f0c1e9f81a049c583fba32a450d73`
- `proprietary-files.txt` line 1041: `vendor/lib/libmmrtpencoder_proprietary.so|bb345cb90834bfec208ae38359b2601e98ff115b`
- `proprietary-files.txt` line 1042: `vendor/lib/libwfdcodecv4l2_proprietary.so|fe8895ec0bf07c74ac7d607d5e622d28d2754a80`
- `proprietary-files.txt` line 1043: `vendor/lib/libwfdcommonutils_proprietary.so|4b71ff7e1994b493cfee47445928f565a169a7e1`
- `proprietary-files.txt` line 1044: `vendor/lib/libwfdconfigutils_proprietary.so|2cead6568ddec07d8e5d06149b79c0f89c9bf258`
- `proprietary-files.txt` line 1045: `vendor/lib/libwfddisplayconfig_proprietary.so|2c8d94e73cc76697c1973c4bfdb03cc8aff50cba`
- `proprietary-files.txt` line 1046: `vendor/lib/libwfdmminterface_proprietary.so|3eb3455633d5814a5d7cddb0d95f9d45b7c05db2`
- `proprietary-files.txt` line 1047: `vendor/lib/libwfdmmservice_proprietary.so|d98b728661708e1c63819b42bb4d9a01fa94ec6b`
- `proprietary-files.txt` line 1048: `vendor/lib/libwfdmmsrc_proprietary.so|76e77df162d5c3c3d437290db054a57dd1212c3a`
- `proprietary-files.txt` line 1049: `vendor/lib/libwfdrtsp_proprietary.so|180c0e00c549cf56ef71ad5ac0ae123f2e5d9bc1`
- `proprietary-files.txt` line 1051: `vendor/lib/libwfdsourcesession_proprietary.so|d22cda23dc76cbdcc191d8127596a256ca59f331`
- `proprietary-files.txt` line 1052: `vendor/lib/libwfdsourcesm_proprietary.so|ccc41df5c7b15830d4661f6917020e0192060544`
- `proprietary-files.txt` line 1053: `vendor/lib/libwfduibcinterface_proprietary.so|78da77406a29d342803d108ca25aa55df5ec333c`
- Additional hits omitted from first-pass report: 10

## Direct file excerpts

### BoardConfig file: BoardConfigCommon.mk

Path: `BoardConfigCommon.mk`

```text
#
# Copyright (C) 2017-2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_INCORRECT_PARTITION_IMAGES := true

BOARD_VENDOR := motorola

VENDOR_PATH := device/motorola/sm6150-common

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a76

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sm6150
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Kernel
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=2048 loop.max_part=7 cgroup.memory=nokmem,nosocket reboot=panic_warm
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/motorola/sm6150
TARGET_KERNEL_ADDITIONAL_FLAGS := \
    LLVM=1 \
    LLVM_IAS=1

# Kernel modules - Audio
TARGET_MODULE_ALIASES += \
    adsp_loader_dlkm.ko:audio_adsp_loader.ko \
    apr_dlkm.ko:audio_apr.ko \
    bolero_cdc_dlkm.ko:audio_bolero_cdc.ko \
    hdmi_dlkm.ko:audio_hdmi.ko \
    machine_dlkm.ko:audio_machine_talos.ko \
    mbhc_dlkm.ko:audio_mbhc.ko \
    native_dlkm.ko:audio_native.ko \
    pinctrl_lpi_dlkm.ko:audio_pinctrl_lpi.ko \
    pinctrl_wcd_dlkm.ko:audio_pinctrl_wcd.ko \
    platform_dlkm.ko:audio_platform.ko \
    q6_dlkm.ko:audio_q6.ko \
    q6_notifier_dlkm.ko:audio_q6_notifier.ko \
    q6_pdr_dlkm.ko:audio_q6_pdr.ko \
    rx_macro_dlkm.ko:audio_rx_macro.ko \
    snd_event_dlkm.ko:audio_snd_event.ko \
    stub_dlkm.ko:audio_stub.ko \
    swr_ctrl_dlkm.ko:audio_swr_ctrl.ko \
    swr_dlkm.ko:audio_swr.ko \
    tx_macro_dlkm.ko:audio_tx_macro.ko \
    usf_dlkm.ko:audio_usf.ko \
    va_macro_dlkm.ko:audio_va_macro.ko \
    wcd934x_dlkm.ko:audio_wcd934x.ko \
    wcd937x_dlkm.ko:audio_wcd937x.ko \
    wcd937x_slave_dlkm.ko:audio_wcd937x_slave.ko \
    wcd9xxx_dlkm.ko:audio_wcd9xxx.ko \
    wcd_core_dlkm.ko:audio_wcd_core.ko \
    wcd_spi_dlkm.ko:audio_wcd_spi.ko \
    wglink_dlkm.ko:audio_wglink.ko \
    wsa881x_dlkm.ko:audio_wsa881x.ko \
    wsa_macro_dlkm.ko:audio_wsa_macro.ko

# Kernel modules - WLAN
TARGET_MODULE_ALIASES += \
    wlan.ko:qca_cld3_wlan.ko

# Platform
BOARD_USES_QCOM_HARDWARE := true
QCOM_BOARD_PLATFORMS += sm6150
TARGET_BOARD_PLATFORM := sm6150
TARGET_BOARD_PLATFORM_GPU := qcom-adreno620

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Audio
AUDIO_FEATURE_ENABLED_AAC_ADTS_OFFLOAD := true
AUDIO_FEATURE_ENABLED_AUDIOSPHERE := true
AUDIO_FEATURE_ENABLED_COMPRESS_VOIP := true
AUDIO_FEATURE_ENABLED_EXTN_FORMATS := true
AUDIO_FEATURE_ENABLED_FM_POWER_OPT := true
AUDIO_FEATURE_ENABLED_HDMI_SPK := true
AUDIO_FEATURE_ENABLED_INSTANCE_ID := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE := true
BOARD_USES_ALSA_AUDIO := true
BOARD_SUPPORTS_SOUND_TRIGGER := true
USE_CUSTOM_AUDIO_POLICY := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(VENDOR_PATH)/bluetooth/include
TARGET_FWK_SUPPORTS_FULL_VALUEADDS := true

# CNE and DPM
BOARD_USES_QCNE := true

# Dex
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    WITH_DEXPREOPT ?= true
  endif
endif
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY ?= true

# Display
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
TARGET_USES_DISPLAY_RENDER_INTENTS := true
TARGET_USES_GRALLOC4 := true
TARGET_USES_HWC2 := true
TARGET_USES_ION := true

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# Filesystem
TARGET_FS_CONFIG_GEN := \
    $(VENDOR_PATH)/config.fs \
    $(VENDOR_PATH)/mot_aids.fs

# GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)
GNSS_HIDL_VERSION := 2.1
LOC_HIDL_VERSION := 4.0
TARGET_NO_RPC := true
USE_DEVICE_SPECIFIC_GPS := true

# HIDL
DEVICE_MATRIX_FILE := $(VENDOR_PATH)/compatibility_matrix.xml
DEVICE_MANIFEST_FILE := $(VENDOR_PATH)/manifest.xml

# Init
TARGET_INIT_VENDOR_LIB := //$(VENDOR_PATH):libinit_sm6150
TARGET_RECOVERY_DEVICE_MODULES := libinit_sm6150

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
TARGET_COPY_OUT_VENDOR := vendor

# Media
TARGET_DISABLED_UBWC := true

ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
# Metadata
BOARD_USES_METADATA_PARTITION := true
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_EXTFS_INODE_COUNT := -1
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 660602880
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := -1
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 1258291200
endif
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_MOT_DP_GROUP_PARTITION_LIST := product system vendor
BOARD_MOT_DP_GROUP_SIZE := 4864868352
BOARD_SUPER_PARTITION_GROUPS := mot_dp_group
BOARD_SUPER_PARTITION_SIZE := 9729736704
TARGET_COPY_OUT_PRODUCT := product
endif

# Recovery
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab_dynamic.qcom
else
TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab.qcom
endif

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Security patch level
VENDOR_SECURITY_PATCH := 2022-05-01

# SELinux
TARGET_SEPOLICY_DIR := msmsteppe
include device/qcom/sepolicy_vndr-legacy-um/SEPolicy.mk
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(VENDOR_PATH)/sepolicy/private
BOARD_VENDOR_SEPOLICY_DIRS += $(VENDOR_PATH)/sepolicy/vendor

# Android Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# WiFi
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_DEFAULT := qca_cld3
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X

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
/dev/block/bootdevice/by-name/system                    /                        ext4    ro,barrier=1,discard                                 wait,slotselect,avb
/dev/block/bootdevice/by-name/userdata                  /data                    f2fs    rw,discard,nosuid,nodev,noatime,nodiratime,quota,nobarrier,reserve_root=32768,resgid=1065   latemount,wait,check,formattable,fileencryption=ice:aes-256-cts,quota,reservedsize=128M
/devices/platform/soc/8804000.sdhci/mmc_host*           auto                     auto    defaults                                             wait,voldmanaged=sdcard1:auto
/dev/block/bootdevice/by-name/modem                     /vendor/firmware_mnt     ext4    ro,nosuid,nodev,context=u:object_r:firmware_file:s0  wait,slotselect
/dev/block/bootdevice/by-name/dsp                       /vendor/dsp              ext4    ro,nosuid,nodev,barrier=1                            wait,slotselect
/dev/block/bootdevice/by-name/persist                   /mnt/vendor/persist      ext4    noatime,nosuid,nodev,data=ordered,barrier=1          wait
/dev/block/bootdevice/by-name/prodpersist               /mnt/product/persist     ext4    noatime,nosuid,nodev,data=ordered,barrier=1          wait,formattable,nofail
/dev/block/bootdevice/by-name/bluetooth                 /vendor/bt_firmware      ext4    ro,nosuid,nodev,context=u:object_r:bt_firmware_file:s0 wait,slotselect
/devices/platform/soc/a600000.ssusb/a600000.dwc3/xhci-hcd.0.auto*    /storage/usbotg          vfat    nosuid,nodev                                         wait,voldmanaged=usbotg:auto
/dev/block/bootdevice/by-name/fsg                       /vendor/fsg              ext4    ro,nosuid,nodev,context=u:object_r:fsg_firmware_file:s0       wait,slotselect
# Need to have this entry in here even though the mount point itself is no longer needed.
# The update_engine code looks for this entry in order to determine the boot device address
# and fails if it does not find it.
/dev/block/bootdevice/by-name/misc                      /misc                    emmc    defaults                                             defaults
/dev/block/zram0                                        none                     swap    defaults                                             zramsize=70%

```

### fstab/recovery file: fstab_dynamic.qcom

Path: `rootdir\etc\fstab_dynamic.qcom`

```text
# Android fstab file.
# The filesystem that contains the filesystem checker binary (typically /system) cannot
# specify MF_CHECK, and must come before any filesystems that do specify MF_CHECK

#TODO: Add 'check' as fs_mgr_flags with data partition.
# Currently we dont have e2fsck compiled. So fs check would failed.

#<src>                                                 <mnt_point>               <type>  <mnt_flags and options>                            <fs_mgr_flags>
system                                                  /system                  ext4    ro,barrier=1                                         wait,slotselect,avb=vbmeta,avb_keys=/avb/q-gsi.avbpubkey:/avb/r-gsi.avbpubkey:/avb/s-gsi.avbpubkey,logical,first_stage_mount
vendor                                                  /vendor                  ext4    ro,barrier=1                                         wait,slotselect,avb,logical,first_stage_mount
product                                                 /product                 ext4    ro,barrier=1                                         wait,slotselect,avb,logical,nofail,first_stage_mount
/dev/block/by-name/metadata                             /metadata                ext4    noatime,nosuid,nodev,discard,data=journal,commit=1   wait,formattable,first_stage_mount,check,metadata_csum
/dev/block/bootdevice/by-name/userdata                  /data                    f2fs    noatime,nosuid,nodev,discard,reserve_root=32768,resgid=1065,fsync_mode=nobarrier,inlinecrypt       latemount,wait,check,formattable,fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized,keydirectory=/metadata/vold/metadata_encryption,quota,reservedsize=512M,sysfs_path=/sys/devices/platform/soc/1d84000.ufshc,checkpoint=fs
/devices/platform/soc/8804000.sdhci/mmc_host*           auto                     auto    defaults                                             wait,voldmanaged=sdcard1:auto
/dev/block/bootdevice/by-name/modem                     /vendor/firmware_mnt     ext4    ro,nosuid,nodev,context=u:object_r:firmware_file:s0  wait,slotselect
/dev/block/bootdevice/by-name/dsp                       /vendor/dsp              ext4    ro,nosuid,nodev,barrier=1                            wait,slotselect
/dev/block/bootdevice/by-name/persist                   /mnt/vendor/persist      ext4    noatime,nosuid,nodev,data=ordered,barrier=1          wait
/dev/block/bootdevice/by-name/prodpersist               /mnt/product/persist     ext4    noatime,nosuid,nodev,data=ordered,barrier=1          wait,formattable,nofail
/dev/block/bootdevice/by-name/bluetooth                 /vendor/bt_firmware      ext4    ro,nosuid,nodev,context=u:object_r:bt_firmware_file:s0 wait,slotselect
/devices/platform/soc/a600000.ssusb/a600000.dwc3/xhci-hcd.0.auto*   /storage/usbotg          vfat    nosuid,nodev                                         wait,voldmanaged=usbotg:auto
/dev/block/bootdevice/by-name/fsg                       /vendor/fsg              ext4    ro,nosuid,nodev,context=u:object_r:fsg_firmware_file:s0       wait,slotselect
# Need to have this entry in here even though the mount point itself is no longer needed.
# The update_engine code looks for this entry in order to determine the boot device address
# and fails if it does not find it.
/dev/block/bootdevice/by-name/misc                      /misc                    emmc    defaults                                             defaults
/dev/block/zram0                                        none                     swap    defaults                                             zramsize=70%

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

Next recommended step: create an evidence matrix across TWRP, stock def, and sm6150-common candidates.
