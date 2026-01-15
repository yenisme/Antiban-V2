export THEOS=/home/codespace/theos
TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = "Arena of Valor" "Lien Quan Mobile"

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = UnityFramework_Patch

UnityFramework_Patch_FILES = Tweak.x
UnityFramework_Patch_CFLAGS = -fobjc-arc
UnityFramework_Patch_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
   // Khổng Mạnh Yên No1.