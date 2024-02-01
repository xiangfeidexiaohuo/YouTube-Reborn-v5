#import <Foundation/Foundation.h>
static NSString *TabBarOPIconPath;

extern NSBundle *YouTubeRebornBundle();

static inline NSString *LOC(NSString *key) {
    NSBundle *tweakBundle = YouTubeRebornBundle();
    TabBarOPIconPath = [tweakBundle pathForResource:@"ytrebornbuttonblack" ofType:@"png"];
    return [tweakBundle localizedStringForKey:key value:nil table:nil];
}
