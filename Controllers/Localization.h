#import <Foundation/Foundation.h>

extern NSBundle *YTRebornBundle();

static inline NSString *LOC(NSString *key) {
    NSBundle *tweakBundle = YTRebornBundle();
    return [tweakBundle localizedStringForKey:key value:nil table:nil];
}
