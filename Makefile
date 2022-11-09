TARGET := iphone:clang:15.5:14.0
INSTALL_TARGET_PROCESSES = YouTube
GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YouTubeReborn
YouTubeReborn_FILES = Tweak.xm $(shell find Controllers -name '*.m') $(shell find AFNetworking -name '*.m') $(shell find YouTubeExtractor -name '*.m')
YouTubeReborn_FRAMEWORKS = UIKit Foundation AVFoundation AVKit Photos Accelerate CoreMotion GameController VideoToolbox
YouTubeReborn_EXTRA_FRAMEWORKS = ffmpegkit libavcodec libavdevice libavfilter libavformat libavutil libswresample libswscale
YouTubeReborn_CFLAGS = -FFrameworks -fobjc-arc -Wno-deprecated-declarations
YouTubeReborn_LDFLAGS += -FFrameworks -rpath @loader_path/Frameworks/
YouTubeReborn_LIBRARIES = bz2 c++ iconv z
ARCHS = arm64

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
