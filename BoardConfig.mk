#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(wildcard device/xiaomi/alioth_mainline/BoardConfig.mk),)
    DEVICE_PATH := device/xiaomi/alioth
else
    DEVICE_PATH := device/xiaomi/alioth_mainline
endif

# SoC architecture for Qualcomm SM8250 (Kona)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a76
TARGET_QCOM_SOC_FAMILY_IS_LEGACY := false
TARGET_QCOM_SOC_FAMILY_DOWNSTREAM_IS_PRE_GKI := false

# SoC family for device/mainline/qcom-common
TARGET_QCOM_SOC_FAMILY := sm8250

# Inherit mainline Qualcomm common (Mesa Freedreno/Turnip, drm_hwcomposer, minigbm, sepolicy)
-include device/mainline/qcom-common/BoardConfigMainlineQcomCommon.mk

# Kernel (octavia-23/alioth-aosp-mainline)
TARGET_KERNEL_SOURCE := kernel/xiaomi/alioth-mainline
TARGET_KERNEL_CONFIG := alioth_aosp_defconfig
TARGET_KERNEL_DTB := qcom/sm8250-xiaomi-alioth.dtb
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_ADDITIONAL_FLAGS := LLVM=1 LLVM_IAS=1
BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := false

# Boot header v3 & kernel cmdline
BOARD_BOOT_HEADER_VERSION := 3
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_KERNEL_CMDLINE := \
    androidboot.hardware=qcom \
    androidboot.fstab_suffix=alioth \
    androidboot.usbcontroller=a600000.dwc3 \
    androidboot.init_fatal_reboot_target=recovery \
    androidboot.selinux=permissive

# Display
TARGET_SCREEN_DENSITY := 440

# Exact Alioth partition sizes & Virtual A/B dynamic partitions
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot

BOARD_USES_METADATA_PARTITION := true
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 201326592
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions

BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    odm \
    product \
    system \
    system_ext \
    vendor

BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_ODM := odm

# Verified Boot (VBMeta) & Recovery
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/configs/fstab.alioth
TARGET_OTA_ASSERT_DEVICE := alioth,aliothin

# HALs & VINTF Compatibility (Android 17 FCM 202604 uses AIDL APEX com.android.hardware.cas)
TARGET_REQUIRES_HIDL_CAS_HAL := false

