#import <Foundation/Foundation.h>

@interface YouTubeExtractor : NSObject
+ (NSDictionary *)youtubePlayerRequest :(NSString *)clientName :(NSString *)clientVersion :(NSString *)videoID;
+ (NSDictionary *)sponsorBlockRequest :(NSString *)videoID;
@end