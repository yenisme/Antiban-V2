export THEOS=/home/codespace/theos
TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

# Tên process của Liên Quân (Check lại bundle ID nếu cần, thường là kgame)
INSTALL_TARGET_PROCESSES = kgame

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = UnityFramework_Patch

# Các file source
UnityFramework_Patch_FILES = Tweak.x

# Framework cần thiết để vẽ UI
UnityFramework_Patch_FRAMEWORKS = UIKit Foundation CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk
