#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Android 17 FCM 202604 forbids deprecated HIDL CAS HAL in favor of AIDL APEX (com.android.hardware.cas)
TARGET_REQUIRES_HIDL_CAS_HAL := false

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

ifneq ($(wildcard device/xiaomi/alioth_mainline/device.mk),)
    $(call inherit-product, device/xiaomi/alioth_mainline/device.mk)
else
    $(call inherit-product, device/xiaomi/alioth/device.mk)
endif

$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_alioth
PRODUCT_DEVICE := alioth
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := POCO
PRODUCT_MODEL := M2012K11AG
