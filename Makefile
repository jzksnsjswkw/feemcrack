FINALPACKAGE = 1

ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
	TARGET = iphone:clang:16.5:14.5
else ifeq ($(THEOS_PACKAGE_SCHEME),roothide)
	TARGET = iphone:clang:16.5:14.5
else
	TARGET = iphone:clang:14.5:13.7
endif

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = feemcrack

feemcrack_FILES = Tweak.x
feemcrack_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
