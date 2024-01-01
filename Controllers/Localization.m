#import <rootless.h>
#import "Localization.h"

NSBundle *YouTubeRebornBundle() {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *tweakBundlePath = [[NSBundle mainBundle] pathForResource:@"YouTubeReborn" ofType:@"bundle"];
        if (tweakBundlePath) {
            bundle = [NSBundle bundleWithPath:tweakBundlePath];
        } else {
            NSString *fallbackBundlePath = ROOT_PATH_NS(@"/Library/Application Support/YouTubeReborn.bundle");
            bundle = [NSBundle bundleWithPath:fallbackBundlePath];
        }
    });
    return bundle;
}
