# Source Audit: ixmoe android_device_motorola_def_twrp

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
| Local path | C:\Projects\moto-one-hyper-local\sources\ixmoe_android_device_motorola_def_twrp |
| Remote | https://github.com/ixmoe/android_device_motorola_def_twrp.git |
| Branch | android-10 |
| HEAD | a5ad58ff0bd739b1fe3e81715f1baa57214db1e1 |
| Total files | 74 |
| Key files inspected | 14 |

## First-pass classification

Classification: recovery-tree-reference

Reason: this candidate is named and structured as a TWRP/recovery device tree for Motorola `def`. It may contain useful recovery, fstab, BoardConfig, partition, and image-layout clues, but it is not a complete custom ROM device tree by itself.

Current build-input decision: rejected for build input pending deeper audit.

Permitted use right now: evidence source only.

## Key file inventory

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

## Interesting term hits

### `BOARD_`

File hits: 1

- `BoardConfig.mk` line 29: `TARGET_BOOTLOADER_BOARD_NAME := sm6150`
- `BoardConfig.mk` line 34: `TARGET_BOARD_PLATFORM := sm6150`
- `BoardConfig.mk` line 35: `TARGET_BOARD_PLATFORM_GPU := qcom-adreno610`
- `BoardConfig.mk` line 58: `BOARD_PROVIDES_GPTUTILS := true`
- `BoardConfig.mk` line 61: `BOARD_KERNEL_CMDLINE := \`
- `BoardConfig.mk` line 76: `BOARD_KERNEL_CMDLINE += androidboot.fastboot=1`
- `BoardConfig.mk` line 77: `BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive`
- `BoardConfig.mk` line 79: `BOARD_BOOT_HEADER_VERSION := 2`
- `BoardConfig.mk` line 80: `BOARD_KERNEL_PAGESIZE := 4096`
- `BoardConfig.mk` line 81: `BOARD_KERNEL_BASE          := 0x00000000`
- `BoardConfig.mk` line 82: `BOARD_KERNEL_OFFSET        := 0x00008000`
- `BoardConfig.mk` line 83: `BOARD_RAMDISK_OFFSET       := 0x01000000`
- `BoardConfig.mk` line 84: `BOARD_KERNEL_SECOND_OFFSET := 0x00f00000`
- `BoardConfig.mk` line 85: `BOARD_KERNEL_TAGS_OFFSET   := 0x00000100`
- `BoardConfig.mk` line 86: `BOARD_DTB_OFFSET           := 0x01f00000`
- `BoardConfig.mk` line 87: `BOARD_KERNEL_SEPARATED_DTBO := true`
- `BoardConfig.mk` line 88: `BOARD_INCLUDE_DTB_IN_BOOTIMG := true`
- `BoardConfig.mk` line 96: `BOARD_KERNEL_IMAGE_NAME := Image.gz`
- `BoardConfig.mk` line 98: `# TARGET_PREBUILT_KERNEL := $(PLATFORM_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)`
- `BoardConfig.mk` line 99: `# BOARD_PREBUILT_DTBOIMAGE := $(PLATFORM_PATH)/prebuilt/dtbo.img`
- Additional hits omitted from first-pass report: 31

### `TARGET_`

File hits: 3

- `Android.mk` line 26: `ifneq ($(filter def, $(TARGET_DEVICE)),)`
- `BoardConfig.mk` line 29: `TARGET_BOOTLOADER_BOARD_NAME := sm6150`
- `BoardConfig.mk` line 30: `TARGET_NO_BOOTLOADER := true`
- `BoardConfig.mk` line 31: `TARGET_USES_UEFI := true`
- `BoardConfig.mk` line 34: `TARGET_BOARD_PLATFORM := sm6150`
- `BoardConfig.mk` line 35: `TARGET_BOARD_PLATFORM_GPU := qcom-adreno610`
- `BoardConfig.mk` line 36: `TARGET_USES_64_BIT_BINDER := true`
- `BoardConfig.mk` line 37: `TARGET_SUPPORTS_64_BIT_APPS := true`
- `BoardConfig.mk` line 41: `TARGET_ARCH := arm64`
- `BoardConfig.mk` line 42: `TARGET_ARCH_VARIANT := armv8-a`
- `BoardConfig.mk` line 43: `TARGET_CPU_ABI := arm64-v8a`
- `BoardConfig.mk` line 44: `TARGET_CPU_ABI2 :=`
- `BoardConfig.mk` line 45: `TARGET_CPU_VARIANT := kryo`
- `BoardConfig.mk` line 47: `TARGET_2ND_ARCH := arm`
- `BoardConfig.mk` line 48: `TARGET_2ND_ARCH_VARIANT := armv8-a`
- `BoardConfig.mk` line 49: `TARGET_2ND_CPU_ABI := armeabi-v7a`
- `BoardConfig.mk` line 50: `TARGET_2ND_CPU_ABI2 := armeabi`
- `BoardConfig.mk` line 51: `TARGET_2ND_CPU_VARIANT := cortex-a73`
- `BoardConfig.mk` line 90: `TARGET_KERNEL_SOURCE := kernel/motorola/sm6150`
- `BoardConfig.mk` line 91: `TARGET_KERNEL_CONFIG := vendor/def_defconfig`
- Additional hits omitted from first-pass report: 35

### `PRODUCT_`

File hits: 4

- `AndroidProducts.mk` line 17: `PRODUCT_MAKEFILES := \`
- `device.mk` line 22: `PRODUCT_PLATFORM := sm6150`
- `device.mk` line 39: `PRODUCT_PACKAGES += \`
- `device.mk` line 45: `PRODUCT_PACKAGES += \`
- `device.mk` line 46: `bootctrl.$(PRODUCT_PLATFORM) \`
- `device.mk` line 61: `PRODUCT_PACKAGES += \`
- `device.mk` line 67: `bootctrl.$(PRODUCT_PLATFORM) \`
- `device.mk` line 68: `bootctrl.$(PRODUCT_PLATFORM).recovery`
- `device.mk` line 71: `PRODUCT_HOST_PACKAGES += \`
- `device.mk` line 75: `PRODUCT_USE_DYNAMIC_PARTITIONS := true`
- `device.mk` line 78: `PRODUCT_PACKAGES += \`
- `device.mk` line 83: `PRODUCT_SOONG_NAMESPACES += \`
- `device.mk` line 87: `PRODUCT_PACKAGES += \`
- `device.mk` line 91: `PRODUCT_SYSTEM_PROPERTY_BLACKLIST += \`
- `device.mk` line 95: `PRODUCT_PROPERTY_OVERRIDES += \`
- `omni_def.mk` line 18: `PRODUCT_RELEASE_NAME := def`
- `omni_def.mk` line 24: `PRODUCT_DEVICE := def`
- `omni_def.mk` line 25: `PRODUCT_NAME := omni_$(PRODUCT_DEVICE)`
- `omni_def.mk` line 26: `PRODUCT_BRAND := motorola`
- `omni_def.mk` line 27: `PRODUCT_MODEL := motorola one hyper`
- Additional hits omitted from first-pass report: 3

### `def`

File hits: 10

- `Android.mk` line 17: `# This contains the module build definitions for the hardware-specific`
- `Android.mk` line 26: `ifneq ($(filter def, $(TARGET_DEVICE)),)`
- `AndroidProducts.mk` line 18: `$(LOCAL_DIR)/omni_def.mk`
- `AndroidProducts.mk` line 21: `omni_def-user \`
- `AndroidProducts.mk` line 22: `omni_def-userdebug \`
- `AndroidProducts.mk` line 23: `omni_def-eng`
- `BoardConfig.mk` line 17: `# This contains the module build definitions for the hardware-specific`
- `BoardConfig.mk` line 26: `PLATFORM_PATH := device/motorola/def`
- `BoardConfig.mk` line 91: `TARGET_KERNEL_CONFIG := vendor/def_defconfig`
- `BoardConfig.mk` line 159: `TW_EXCLUDE_DEFAULT_USB_INIT := true`
- `BoardConfig.mk` line 164: `TW_DEFAULT_BRIGHTNESS := 120`
- `BoardConfig.mk` line 219: `# TW_DEFAULT_LANGUAGE := zh_CN`
- `device.mk` line 21: `# define hardware platform`
- `omni_def.mk` line 18: `PRODUCT_RELEASE_NAME := def`
- `omni_def.mk` line 24: `PRODUCT_DEVICE := def`
- `recovery\root\init.recovery.usb.rc` line 66: `# when changing the default configuration`
- `recovery\root\system\etc\recovery.fstab` line 18: `/dev/block/bootdevice/by-name/misc                      /misc                    emmc    defaults                                             defaults`
- `recovery\root\system\etc\recovery.fstab` line 19: `/dev/block/zram0                                        none                     swap    defaults                                             zramsize=1073741824`
- `recovery\root\system\etc\vintf\manifest.xml` line 13: `<instance>default</instance>`
- `recovery\root\system\etc\vintf\manifest.xml` line 15: `<fqname>@1.0::IDisplayService/default</fqname>`
- Additional hits omitted from first-pass report: 130

### `sm6150`

File hits: 3

- `BoardConfig.mk` line 29: `TARGET_BOOTLOADER_BOARD_NAME := sm6150`
- `BoardConfig.mk` line 34: `TARGET_BOARD_PLATFORM := sm6150`
- `BoardConfig.mk` line 90: `TARGET_KERNEL_SOURCE := kernel/motorola/sm6150`
- `device.mk` line 22: `PRODUCT_PLATFORM := sm6150`
- `recovery\root\init.recovery.qcom.rc` line 34: `setprop ro.board.platform sm6150`

### `recovery`

File hits: 5

- `BoardConfig.mk` line 120: `BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864`
- `BoardConfig.mk` line 138: `# Recovery`
- `BoardConfig.mk` line 141: `BOARD_INCLUDE_RECOVERY_DTBO := true`
- `BoardConfig.mk` line 142: `TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"`
- `BoardConfig.mk` line 151: `TARGET_NO_RECOVERY := false`
- `BoardConfig.mk` line 152: `BOARD_USES_RECOVERY_AS_BOOT := false`
- `BoardConfig.mk` line 156: `RECOVERY_SDCARD_ON_DATA := true`
- `BoardConfig.mk` line 157: `TARGET_RECOVERY_QCOM_RTC_FIX := true`
- `BoardConfig.mk` line 172: `# Additional binaries & libraries needed for recovery`
- `BoardConfig.mk` line 173: `TARGET_RECOVERY_DEVICE_MODULES += \`
- `BoardConfig.mk` line 186: `TW_RECOVERY_ADDITIONAL_RELINK_BINARY_FILES += \`
- `BoardConfig.mk` line 189: `TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \`
- `BoardConfig.mk` line 226: `# Workaround for error copying vendor files to recovery ramdisk`
- `device.mk` line 34: `recovery \`
- `device.mk` line 64: `android.hardware.boot@1.0-impl-wrapper.recovery \`
- `device.mk` line 66: `android.hardware.boot@1.0-impl.recovery \`
- `device.mk` line 68: `bootctrl.$(PRODUCT_PLATFORM).recovery`
- `recovery\root\init.recovery.qcom.rc` line 28: `import /init.recovery.qcom_decrypt.rc`
- `recovery\root\init.recovery.qcom.rc` line 46: `seclabel u:r:recovery:s0`
- `recovery\root\init.recovery.usb.rc` line 184: `write /config/usb_gadget/g1/configs/b.1/strings/0x409/configuration "Motorola Recovery Fastboot"`
- Additional hits omitted from first-pass report: 1

### `fstab`

File hits: 1

- `recovery\root\system\etc\recovery.fstab` line 1: `# Android fstab file.`

### `vendor_boot`

File hits: 0


### `boot`

File hits: 8

- `BoardConfig.mk` line 28: `# Bootloader`
- `BoardConfig.mk` line 29: `TARGET_BOOTLOADER_BOARD_NAME := sm6150`
- `BoardConfig.mk` line 30: `TARGET_NO_BOOTLOADER := true`
- `BoardConfig.mk` line 63: `androidboot.hardware=qcom \`
- `BoardConfig.mk` line 64: `androidboot.console=ttyMSM0 \`
- `BoardConfig.mk` line 65: `androidboot.memcg=1 \`
- `BoardConfig.mk` line 71: `androidboot.usbcontroller=a600000.dwc3 \`
- `BoardConfig.mk` line 76: `BOARD_KERNEL_CMDLINE += androidboot.fastboot=1`
- `BoardConfig.mk` line 77: `BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive`
- `BoardConfig.mk` line 79: `BOARD_BOOT_HEADER_VERSION := 2`
- `BoardConfig.mk` line 88: `BOARD_INCLUDE_DTB_IN_BOOTIMG := true`
- `BoardConfig.mk` line 108: `BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)`
- `BoardConfig.mk` line 109: `BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)`
- `BoardConfig.mk` line 110: `BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)`
- `BoardConfig.mk` line 111: `BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)`
- `BoardConfig.mk` line 112: `BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)`
- `BoardConfig.mk` line 113: `BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)`
- `BoardConfig.mk` line 114: `BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)`
- `BoardConfig.mk` line 115: `BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)`
- `BoardConfig.mk` line 116: `# BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)`
- Additional hits omitted from first-pass report: 33

### `dtbo`

File hits: 2

- `BoardConfig.mk` line 87: `BOARD_KERNEL_SEPARATED_DTBO := true`
- `BoardConfig.mk` line 99: `# BOARD_PREBUILT_DTBOIMAGE := $(PLATFORM_PATH)/prebuilt/dtbo.img`
- `BoardConfig.mk` line 121: `BOARD_DTBOIMG_PARTITION_SIZE := 25165824`
- `BoardConfig.mk` line 141: `BOARD_INCLUDE_RECOVERY_DTBO := true`
- `device.mk` line 32: `dtbo \`

### `vbmeta`

File hits: 2

- `device.mk` line 36: `vbmeta \`
- `recovery\root\system\etc\recovery.fstab` line 9: `system                                                  /system                  ext4    ro,barrier=1                                         wait,slotselect,avb=vbmeta,logical,first_stage_mount`

### `super`

File hits: 1

- `BoardConfig.mk` line 129: `# Super`
- `BoardConfig.mk` line 130: `BOARD_SUPER_PARTITION_SIZE := 8690597888`
- `BoardConfig.mk` line 131: `BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions`

### `dynamic`

File hits: 3

- `BoardConfig.mk` line 131: `BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions`
- `BoardConfig.mk` line 132: `BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 4341104640`
- `BoardConfig.mk` line 133: `BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := \`
- `device.mk` line 55: `# tell update_engine to not change dynamic partition table during updates`
- `device.mk` line 56: `# needed since our qti_dynamic_partitions does not include`
- `device.mk` line 74: `# Dynamic partitions`
- `device.mk` line 75: `PRODUCT_USE_DYNAMIC_PARTITIONS := true`
- `recovery\root\ueventd.qcom.rc` line 387: `/sys/class/graphics/fb*     dynamic_fps              0664    system  graphics`
- `recovery\root\ueventd.qcom.rc` line 403: `/sys/class/graphics/fb0     dynamic_fps              0664    system  graphics`

### `qcom`

File hits: 5

- `BoardConfig.mk` line 35: `TARGET_BOARD_PLATFORM_GPU := qcom-adreno610`
- `BoardConfig.mk` line 63: `androidboot.hardware=qcom \`
- `BoardConfig.mk` line 157: `TARGET_RECOVERY_QCOM_RTC_FIX := true`
- `BoardConfig.mk` line 206: `BOARD_USES_QCOM_FBE_DECRYPTION := true`
- `device.mk` line 77: `# qcom standard decryption`
- `device.mk` line 79: `qcom_decrypt \`
- `device.mk` line 80: `qcom_decrypt_fbe`
- `recovery\root\init.recovery.qcom.rc` line 28: `import /init.recovery.qcom_decrypt.rc`
- `recovery\root\ueventd.qcom.rc` line 177: `/sys/devices/soc/a000000.qcom,wcnss-wlan/net/wlan0/queues/rx-* rps_cpus           0660   system     system`
- `recovery\root\ueventd.qcom.rc` line 178: `/sys/devices/soc/a000000.qcom,wcnss-wlan/net/p2p0/queues/rx-* rps_cpus            0660   system     system`
- `recovery\root\ueventd.qcom.rc` line 293: `/sys/devices/soc/600000.qcom,pcie/pci0000:00/0000:00:00.0/0000:01:00.0/net/wlan0/queues/rx-* rps_cpus 0660 system system`
- `recovery\root\ueventd.qcom.rc` line 294: `/sys/devices/soc/600000.qcom,pcie/pci0000:00/0000:00:00.0/0000:01:00.0/net/p2p0/queues/rx-* rps_cpus 0660 system system`
- `recovery\root\vendor\etc\gpfspath_oem_config.xml` line 17: `To replace with different paths, please also create folder in init.qcom.rc`
- `recovery\root\vendor\etc\gpfspath_oem_config.xml` line 22: `A) rootdir/etc/init.qcom.rc:`

### `motorola`

File hits: 4

- `BoardConfig.mk` line 26: `PLATFORM_PATH := device/motorola/def`
- `BoardConfig.mk` line 90: `TARGET_KERNEL_SOURCE := kernel/motorola/sm6150`
- `BoardConfig.mk` line 131: `BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions`
- `BoardConfig.mk` line 132: `BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 4341104640`
- `BoardConfig.mk` line 133: `BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := \`
- `omni_def.mk` line 26: `PRODUCT_BRAND := motorola`
- `omni_def.mk` line 27: `PRODUCT_MODEL := motorola one hyper`
- `omni_def.mk` line 28: `PRODUCT_MANUFACTURER := motorola`
- `recovery\root\init.recovery.usb.rc` line 184: `write /config/usb_gadget/g1/configs/b.1/strings/0x409/configuration "Motorola Recovery Fastboot"`
- `recovery\root\vendor\etc\vintf\manifest.xml` line 351: `<name>com.motorola.hardware.display.panel</name>`
- `recovery\root\vendor\etc\vintf\manifest.xml` line 361: `<name>com.motorola.hardware.display.touch</name>`
- `recovery\root\vendor\etc\vintf\manifest.xml` line 401: `<name>motorola.hardware.audio.adspd</name>`
- `recovery\root\vendor\etc\vintf\manifest.xml` line 411: `<name>motorola.hardware.camera.imgtuner</name>`
- `recovery\root\vendor\etc\vintf\manifest.xml` line 421: `<name>motorola.hardware.vibrator</name>`
- `recovery\root\vendor\etc\vintf\manifest.xml` line 431: `<name>motorola.hardware.wifi.supplicant</name>`

### `proprietary`

File hits: 1

- `recovery\root\vendor\etc\gpfspath_oem_config.xml` line 4: `Confidential and Proprietary - Qualcomm Technologies, Inc.`

## Direct file excerpts

### BoardConfig file: BoardConfig.mk

Path: `BoardConfig.mk`

```text
#
# Copyright 2021 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

PLATFORM_PATH := device/motorola/def

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sm6150
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Platform
TARGET_BOARD_PLATFORM := sm6150
TARGET_BOARD_PLATFORM_GPU := qcom-adreno610
TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_64_BIT_APPS := true
BUILD_BROKEN_DUP_RULES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a73

# Enable CPUSets
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# GPT Utils
BOARD_PROVIDES_GPTUTILS := true

# Kernel
BOARD_KERNEL_CMDLINE := \
    console=ttyMSM0,115200n8 \
    androidboot.hardware=qcom \
    androidboot.console=ttyMSM0 \
    androidboot.memcg=1 \
    lpm_levels.sleep_disabled=1 \
    video=vfb:640x400,bpp=32,memsize=3072000 \
    msm_rtb.filter=0x237 \
    service_locator.enable=1 \
    swiotlb=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    earlycon=msm_geni_serial,0x880000 \
    printk.devkmsg=on \
    firmware_class.path=/vendor/firmware_mnt/image
# For the love of all that is holy, please do not include this in your ROM unless you really want TWRP to not work correctly!
BOARD_KERNEL_CMDLINE += androidboot.fastboot=1
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE          := 0x00000000
BOARD_KERNEL_OFFSET        := 0x00008000
BOARD_RAMDISK_OFFSET       := 0x01000000
BOARD_KERNEL_SECOND_OFFSET := 0x00f00000
BOARD_KERNEL_TAGS_OFFSET   := 0x00000100
BOARD_DTB_OFFSET           := 0x01f00000
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

TARGET_KERNEL_SOURCE := kernel/motorola/sm6150
TARGET_KERNEL_CONFIG := vendor/def_defconfig

TARGET_KERNEL_ADDITIONAL_FLAGS := \
    DTC=$(shell pwd)/$(PLATFORM_PATH)/dtc/dtc

BOARD_KERNEL_IMAGE_NAME := Image.gz
# TARGET_PREBUILT_DTB := $(PLATFORM_PATH)/prebuilt/dtb.img
# TARGET_PREBUILT_KERNEL := $(PLATFORM_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)
# BOARD_PREBUILT_DTBOIMAGE := $(PLATFORM_PATH)/prebuilt/dtbo.img

TARGET_KERNEL_VERSION := 4.14
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CLANG_VERSION := r328903

BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
# BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 536870912
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# Super
BOARD_SUPER_PARTITION_SIZE := 8690597888
BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 4341104640
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    product \
    vendor

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# A/B device flags
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false
BOARD_USES_RECOVERY_AS_BOOT := false
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# TWRP specific build flags
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_RESETPROP := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 120
TW_THEME := portrait_hdpi
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TW_NO_SCREEN_BLANK := true

TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental"

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.base@1.0 \
    ashmemd \
    ashmemd_aidl_interface-cpp \
    libashmemd_client \
    libcap \
    libicui18n \
    libicuuc \
    libion \
    libpcrecpp \
    libprocinfo \
    libxml2

TW_RECOVERY_ADDITIONAL_RELINK_BINARY_FILES += \
    $(TARGET_OUT_EXECUTABLES)/ashmemd

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.base@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/ashmemd_aidl_interface-cpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libashmemd_client.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libcap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libicui18n.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libicuuc.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpcrecpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libprocinfo.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so

# Encryption
PLATFORM_VERSION := 16.1.0
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
TW_INCLUDE_CRYPTO := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true

# Extras
TARGET_SYSTEM_PROP += $(PLATFORM_PATH)/system.prop

BOARD_SUPPRESS_SECURE_ERASE := true
TW_USE_TOOLBOX := true
TW_EXCLUDE_TWRPAPP := true
TW_HAS_EDL_MODE := true

# Asian region languages
TW_EXTRA_LANGUAGES := true
# TW_DEFAULT_LANGUAGE := zh_CN

# Debug flags
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

ALLOW_MISSING_DEPENDENCIES := true
# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product

```

### AndroidProducts file: AndroidProducts.mk

Path: `AndroidProducts.mk`

```text
#
# Copyright 2021 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/omni_def.mk

COMMON_LUNCH_CHOICES := \
    omni_def-user \
    omni_def-userdebug \
    omni_def-eng

```

### fstab/recovery file: recovery.fstab

Path: `recovery\root\system\etc\recovery.fstab`

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

# Need to have this entry in here even though the mount point itself is no longer needed.
# The update_engine code looks for this entry in order to determine the boot device address
# and fails if it does not find it.
/dev/block/bootdevice/by-name/misc                      /misc                    emmc    defaults                                             defaults
/dev/block/zram0                                        none                     swap    defaults                                             zramsize=1073741824


```

### device/product makefile: device.mk

Path: `device.mk`

```text
#
# Copyright 2021 The Android Open Source Project
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


# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# define hardware platform
PRODUCT_PLATFORM := sm6150

# A/B support
AB_OTA_UPDATER := true

# A/B updater updatable partitions list. Keep in sync with the partition list
# with "_a" and "_b" variants in the device. Note that the vendor can add more
# more partitions to this list for the bootloader and radio.
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    recovery \
    system \
    vbmeta \
    vendor

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier

PRODUCT_PACKAGES += \
    bootctrl.$(PRODUCT_PLATFORM) \
    update_engine_sideload

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    android.hardware.boot@1.0-impl-wrapper.recovery \
    android.hardware.boot@1.0-impl-wrapper \
    android.hardware.boot@1.0-impl.recovery \
    bootctrl.$(PRODUCT_PLATFORM) \
    bootctrl.$(PRODUCT_PLATFORM).recovery

# Apex libraries
PRODUCT_HOST_PACKAGES += \
    libandroidicu

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# qcom standard decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# tzdata
PRODUCT_PACKAGES += \
    tzdata_twrp

# Blacklist
PRODUCT_SYSTEM_PROPERTY_BLACKLIST += \
    ro.bootimage.build.date.utc \
    ro.build.date.utc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2099-12-31

```

### device/product makefile: omni_def.mk

Path: `omni_def.mk`

```text
#
# Copyright 2021 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Release name
PRODUCT_RELEASE_NAME := def

# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := def
PRODUCT_NAME := omni_$(PRODUCT_DEVICE)
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola one hyper
PRODUCT_MANUFACTURER := motorola

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/$(PRODUCT_BRAND)/$(PRODUCT_DEVICE)/device.mk)

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

Next recommended audit: `Nandru86_android_device_motorola_def_twrp`.
