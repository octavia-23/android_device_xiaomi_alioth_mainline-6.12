#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(wildcard device/xiaomi/alioth_mainline/device.mk),)
    DEVICE_PATH := device/xiaomi/alioth
else
    DEVICE_PATH := device/xiaomi/alioth_mainline
endif

# Mainline Qualcomm common product config
TARGET_QCOM_SOC_FAMILY := sm8250
$(call inherit-product, device/mainline/qcom-common/mainline_qcom-common.mk)

# Android 17 FCM 202604 forbids deprecated HIDL CAS HAL
TARGET_REQUIRES_HIDL_CAS_HAL := false
PRODUCT_PACKAGES_SHIPPING_API_LEVEL_33 := $(filter-out android.hardware.cas@1.2-service,$(PRODUCT_PACKAGES_SHIPPING_API_LEVEL_33))

# Virtual A/B & dynamic partitions
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_SHIPPING_API_LEVEL := 30
TARGET_FOLLOWS_LATEST_VINTF_TARGET_LEVEL := true
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# Image & OTA packaging configuration
PRODUCT_BUILD_BOOT_IMAGE := true
PRODUCT_BUILD_RAMDISK_IMAGE := true
PRODUCT_BUILD_RECOVERY_IMAGE := true
PRODUCT_BUILD_GENERIC_OTA_PACKAGE := true

# Memory & storage
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Display / boot animation
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2400
TARGET_BOOTANIMATION_HALF_RES := true
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    kernel/mainline/configs

# Mainline memfd support (from kernel/mainline/configs)
PRODUCT_PACKAGES += \
    use_memfd.rc

# Fstab (both vendor and vendor_boot first_stage_ramdisk) & device init
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/fstab.alioth:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.alioth \
    $(DEVICE_PATH)/configs/fstab.alioth:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.alioth \
    $(DEVICE_PATH)/configs/fstab.alioth:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/etc/fstab.alioth \
    $(DEVICE_PATH)/configs/init.alioth.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.alioth.rc

# Adreno 650 GPU firmware (see Section 5 — mandatory for UI!)
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/firmware/a650_sqe.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/qcom/a650_sqe.fw \
    $(DEVICE_PATH)/firmware/a650_gmu.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/qcom/a650_gmu.bin \
    $(DEVICE_PATH)/firmware/a650_zap.mbn:$(TARGET_COPY_OUT_VENDOR)/firmware/qcom/a650_zap.mbn \
    $(DEVICE_PATH)/firmware/a650_zap.mbn:$(TARGET_COPY_OUT_VENDOR)/firmware/qcom/sm8250/a650_zap.mbn \
    $(DEVICE_PATH)/firmware/a650_zap.mbn:$(TARGET_COPY_OUT_VENDOR)/firmware/qcom/sm8250/xiaomi/alioth/a650_zap.mbn
