LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := malloc_count.c stack_count.c
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
LOCAL_MODULE := malloc_count
include $(BUILD_STATIC_LIBRARY)

ifeq (1,$(strip $(BUILD_test_malloc_count)))
    include $(CLEAR_VARS)
    LOCAL_MODULE := test-malloc_count
    LOCAL_SRC_FILES := test-malloc_count/test.c
    LOCAL_STATIC_LIBRARIES := libmalloc_count
    include $(BUILD_EXECUTABLE)
endif
ifeq (1,$(strip $(BUILD_test_memprofile)))
    include $(CLEAR_VARS)
    LOCAL_MODULE := test-memprofile
    LOCAL_SRC_FILES := test-memprofile/test.cc
    LOCAL_STATIC_LIBRARIES := libmalloc_count
    include $(BUILD_EXECUTABLE)
endif
