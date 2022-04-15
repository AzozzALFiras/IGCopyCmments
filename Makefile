ARCHS = arm64e arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = IGCopyCmments

IGCopyCmments_FILES = Tweak.xm
IGCopyCmments_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
