#import <Foundation/Foundation.h>

extern NSBundle *YouTubeRebornBundle();

static inline NSString *LOC(NSString *key) {
    NSBundle *tweakBundle = YouTubeRebornBundle();
    return [tweakBundle localizedStringForKey:key value:nil table:nil];
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
