#import <rootless.h>
#import "Localization.h"

NSString *blackImageVideoPath = [tweakBundle pathForResource:@"ytrebornbuttonvideoblack" ofType:@"png"];
NSString *whiteImageVideoPath = [tweakBundle pathForResource:@"ytrebornbuttonvideowhite" ofType:@"png"];
NSString *blackImageAudioPath = [tweakBundle pathForResource:@"ytrebornbuttonaudioblack" ofType:@"png"];
NSString *whiteImageAudioPath = [tweakBundle pathForResource:@"ytrebornbuttonaudiowhite" ofType:@"png"];

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
