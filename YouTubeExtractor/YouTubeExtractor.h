#import <Foundation/Foundation.h>

@interface YTIVideoDetails : NSObject
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *author;
@property (nonatomic, strong, readwrite) YTIThumbnailDetails *thumbnail;
@end

@interface YTIPlayerResponse : NSObject
@property (nonatomic, assign, readonly) YTIStreamingData *streamingData;
@property (nonatomic, assign, readonly) YTIVideoDetails *videoDetails;
@end

@interface YTPlayerResponse : NSObject
@property (nonatomic, assign, readonly) YTIPlayerResponse *playerData;
@end

@interface YTPlayerViewController : UIViewController
@property (nonatomic, assign, readonly) YTPlayerResponse *playerResponse;
@property (readonly, nonatomic) NSString *contentVideoID;
@property (nonatomic, assign, readonly) CGFloat currentVideoTotalMediaTime;
@end

@interface YTPlayerView : UIView
@property (nonatomic, strong) FFMpegDownloader *ffmpeg;
@property (nonatomic, assign, readwrite) UIViewController *viewDelegate;
- (void)prepareForDownloading:(UILongPressGestureRecognizer *)sender;
@end

@interface YouTubeExtractor : NSObject
+ (NSDictionary *)youtubePlayerRequest :(NSString *)client :(NSString *)videoID;
@end
