THEOS_DEVICE_IP = 192.168.1.100
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = QiyeWeixin
# top of the file
SUBSTRATE ?= yes

# under your other instance vars
QiyeWeixin_USE_SUBSTRATE = $(SUBSTRATE)
TARGET = iphone:latest:8.0
QiyeWeixin_FILES = Tweak.xm XMLocationSettingViewController.m

QiyeWeixin_FRAMEWORKS = CoreLocation UIKit CoreGraphics AVFoundation

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
