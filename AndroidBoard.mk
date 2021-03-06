LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_PREBUILT_KERNEL),)
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/kernel/zImage

# modules to include for default kernel
PRODUCT_COPY_FILES += $(shell \
        find $(LOCAL_PATH)/kernel -name '*.ko' \
        | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
        | tr '\n' ' ')
endif

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file): $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init.mapphone_umts.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.mapphone_umts.rc | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init.mapphone_cdma.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.mapphone_cdma.rc | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init_prep_keypad.sh
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init_prep_keypad.sh | $(ACP)
	$(transform-prebuilt-to-target)

include $(CLEAR_VARS)
LOCAL_MODULE := libaudio.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libaudiopolicy.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libcamera.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/$(LOCAL_MODULE)
LOCAL_ADDITIONAL_DEPENDENCIES := libsmiledetect.so
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libril_rds.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libnmea.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libgps_rds.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/$(LOCAL_MODULE)
LOCAL_ADDITIONAL_DEPENDENCIES := libnmea.so libril_rds.so
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

# dependency for libcamera.so
include $(CLEAR_VARS)
LOCAL_MODULE := libsmiledetect.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/$(LOCAL_MODULE)
LOCAL_ADDITIONAL_DEPENDENCIES := libarcsoft.so
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

# dependency for libsmiledetect.so
include $(CLEAR_VARS)
LOCAL_MODULE := libarcsoft.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

# symlink some keymap stuff
file := $(TARGET_OUT)/usr/keychars/sholes-keypad.kcm.bin
ALL_PREBUILT += $(file)
$(file) : $(TARGET_OUT)/usr/keychars/cdma_droid2-keypad.kcm.bin
	@echo "Symlink: $@ -> cdma_droid2-keypad.kcm.bin"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf cdma_droid2-keypad.kcm.bin $@
file := $(TARGET_OUT)/usr/keylayout/sholes-keypad.kl
ALL_PREBUILT += $(file)
$(file) : $(TARGET_OUT)/usr/keylayout/cdma_droid2-keypad.kl
	@echo "Symlink: $@ -> cdma_droid2-keypad.kl"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf cdma_droid2-keypad.kl $@

# link to hijack!
file := $(TARGET_OUT)/bin/logwrapper
ALL_PREBUILT += $(file)
$(file) : $(TARGET_OUT)/bin/hijack
	@echo "Symlink: $@ -> hijack"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf hijack $@

# add custom mount_ext3.sh
file := $(TARGET_OUT)/bin/mount_ext3.sh
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/mount_ext3.sh | $(ACP)
	$(transform-prebuilt-to-target)

# add boot updater
file := $(TARGET_OUT)/etc/droid2-boot.zip
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/droid2-boot.zip | $(ACP)
	$(transform-prebuilt-to-target)

# add droid2bootstrap configuration file
file := $(TARGET_OUT)/etc/Droid2Bootstrap.cfg
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/Droid2Bootstrap.cfg | $(ACP)
	$(transform-prebuilt-to-target)