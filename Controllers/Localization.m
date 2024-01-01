#import <rootless.h>
#import "Localization.h"

NSBundle *YouTubeRebornBundle() {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
        NSString *tweakBundlePath = [[NSBundle mainBundle] pathForResource:@"YouTubeReborn" ofType:@"bundle"];
        if (tweakBundlePath)
            bundle = [NSBundle bundleWithPath:tweakBundlePath];
        else
            bundle = [NSBundle bundleWithPath:ROOT_PATH_NS("/Library/Application Support/YouTubeReborn.bundle")];
    });
    return bundle;
}

NSString *youtubeRebornLightSettingsPath;
NSString *youtubeRebornDarkSettingsPath;
if (YouTubeRebornBundle()) {
    youtubeRebornLightSettingsPath = [[YouTubeRebornBundle() pathForResource:@"ytrebornbuttonwhite" ofType:@"png"]];
    youtubeRebornDarkSettingsPath = [[YouTubeRebornBundle() pathForResource:@"ytrebornbuttonblack" ofType:@"png"]];
} else {
    youtubeRebornLightSettingsPath = ROOT_PATH_NS(@"/Library/Application Support/YouTubeReborn.bundle/ytrebornbuttonwhite.png");
    youtubeRebornDarkSettingsPath = ROOT_PATH_NS(@"/Library/Application Support/YouTubeReborn.bundle/ytrebornbuttonblack.png");
}
