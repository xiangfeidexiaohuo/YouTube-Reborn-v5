#import <LocalAuthentication/LocalAuthentication.h>
#import <Foundation/Foundation.h>
#import <CaptainHook/CaptainHook.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <YouTubeExtractor/YouTubeExtractor.h>
#import <dlfcn.h>
#import <rootless.h>
#import "Controllers/RootOptionsController.h"
#import "Controllers/PictureInPictureController.h"
#import "Controllers/YouTubeDownloadController.h"
// YT Headers
#import "YouTubeHeader/QTMIcon.h"
#import "YouTubeHeader/YTColor.h"
#import "YouTubeHeader/YTVideoQualitySwitchOriginalController.h"
#import "YouTubeHeader/YTVideoWithContextNode.h"
#import "YouTubeHeader/YTIElementRenderer.h"
#import "YouTubeHeader/ELMCellNode.h"
#import "YouTubeHeader/ELMNodeController.h"
#import "YouTubeHeader/YTIMenuConditionalServiceItemRenderer.h"
#import "YouTubeHeader/YTTouchFeedbackController.h"
#import "YouTubeHeader/YTWatchViewController.h"

@interface YTQTMButton : UIButton
@property (strong, nonatomic) UIImageView *imageView;
+ (instancetype)iconButton;
@end

@interface YTPlaybackButton : UIControl
@end

@interface ABCSwitch : UISwitch
@end

@interface YTTopAlignedView : UIView
@end

@interface YTCommentDetailHeaderCell : UIView
@end

@interface YTIPivotBarItemRender : NSObject
@property(nonatomic, copy) NSArray *tabItems;
@end

@interface _ASCollectionViewCell : UICollectionViewCell
- (id)node;
@end

@interface YTAsyncCollectionView : UICollectionView
- (void)removeCellsAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface YTRightNavigationButtons : UIView
- (id)_viewControllerForAncestor;
@property(readonly, nonatomic) YTQTMButton *MDXButton;
@property(readonly, nonatomic) YTQTMButton *searchButton;
@property(readonly, nonatomic) YTQTMButton *notificationButton;
@property(strong, nonatomic) YTQTMButton *youtubeRebornButton;
- (void)setLeadingPadding:(CGFloat)arg1;
- (void)rebornRootOptionsAction;
@end

@interface YTMainAppControlsOverlayView : UIView
- (id)_viewControllerForAncestor;
@property(readonly, nonatomic) YTQTMButton *playbackRouteButton;
@property(readonly, nonatomic) YTQTMButton *previousButton;
@property(readonly, nonatomic) YTQTMButton *nextButton;
@property(readonly, nonatomic) ABCSwitch *autonavSwitch;
@property(readonly, nonatomic) YTQTMButton *closedCaptionsOrSubtitlesButton;
@property(strong, nonatomic) UIButton *rebornOverlayButton;
- (id)playPauseButton;
- (void)didPressPause:(id)button;
- (void)rebornOptionsAction;
- (void)rebornVideoDownloader :(NSString *)videoID;
- (void)rebornAudioDownloader :(NSString *)videoID;
- (void)rebornPictureInPicture :(NSString *)videoID;
- (void)rebornPlayInExternalApp :(NSString *)videoID;
@end

@interface YTMainAppSkipVideoButton
@property(readonly, nonatomic) UIImageView *imageView;
@end

@protocol YTPlaybackController
@end

@interface YTPlayerView : UIView
- (void)downloadVideo;
@end

@interface YTPlayerViewController : UIViewController <YTPlaybackController>
@property (nonatomic, strong) id activeVideo;
@property (nonatomic) float playbackRate;
- (void)seekToTime:(CGFloat)time;
- (NSString *)currentVideoID;
- (CGFloat)currentVideoMediaTime;
- (void)autoFullscreen;
@end

@interface YTLocalPlaybackController : NSObject
- (NSString *)currentVideoID;
- (void)setPlaybackRate:(float)rate;
- (id)activeVideo;
@end

@interface YTMainAppVideoPlayerOverlayViewController : UIViewController
- (CGFloat)mediaTime;
- (int)playerViewLayout;
- (NSInteger)playerState;
@end

@interface YTVarispeedSwitchControllerOption : NSObject
- (id)initWithTitle:(id)title rate:(float)rate;
@end

@interface MLHAMQueuePlayer : NSObject
@property id playerEventCenter;
@property id delegate;
- (void)setRate:(float)rate;
- (void)internalSetRate;
@end

@interface MLPlayerStickySettings : NSObject
- (void)setRate:(float)rate;
@end

@interface MLPlayerEventCenter : NSObject
- (void)broadcastRateChange:(float)rate;
@end

@interface HAMPlayerInternal : NSObject
- (void)setRate:(float)rate;
@end

@interface YTUserDefaults : NSObject
- (long long)appThemeSetting;
@end

@interface YTWatchController : NSObject
- (void)showFullScreen;
@end

@interface YTPageStyleController
+ (NSInteger)pageStyle;
@end

@interface YTSingleVideoTime : NSObject
@end

@interface YTPivotBarView : UIView
@end

@interface YTPivotBarIndicatorView : UIView
@end

@interface YTPivotBarViewController : UIViewController
- (void)selectItemWithPivotIdentifier:(id)pivotIndentifier;
@end

@interface YTPivotBarItemView : UIView
@property(readonly, nonatomic) YTQTMButton *navigationButton;
@end

@interface YTIPivotBarItemRenderer : NSObject
- (NSString *)pivotIdentifier;
@end

@interface YTIPivotBarIconOnlyItemRenderer : GPBMessage
- (NSString *)pivotIdentifier;
@end

@interface YTIPivotBarSupportedRenderers : NSObject
@property(retain, nonatomic) YTIPivotBarItemRenderer *pivotBarItemRenderer;
- (YTIPivotBarItemRenderer *)pivotBarItemRenderer;
- (YTIPivotBarIconOnlyItemRenderer *)pivotBarIconOnlyItemRenderer;
@end

@interface YTIPivotBarRenderer : NSObject
- (NSMutableArray <YTIPivotBarSupportedRenderers *> *)itemsArray;
@end

@interface YTSingleVideo : NSObject
- (NSString *)videoId;
@end

@interface YTReelHeaderView : UIView
- (id)_viewControllerForAncestor;
- (void)rebornOptionsAction;
- (void)rebornVideoDownloader :(NSString *)videoID;
- (void)rebornAudioDownloader :(NSString *)videoID;
- (void)rebornPictureInPicture :(NSString *)videoID;
- (void)rebornPlayInExternalApp :(NSString *)videoID;
@end

@interface YTReelPlayerMoreButton : YTQTMButton
@end

@interface YTReelPlayerButton : UIButton
@end

@interface YTReelWatchPlaybackOverlayView : UIView
@end

@interface YTReelTransparentStackView : UIView
@end

@interface YTTransportControlsButtonView : UIView
@end

@interface SSOConfiguration : NSObject
@end

@interface _ASDisplayView : UIView
@end

@interface YTLabel : UILabel
@end

@interface YTInlinePlayerBarContainerView : UIView
@property(readonly, nonatomic) YTLabel *durationLabel;
@property(readonly, nonatomic) YTLabel *currentTimeLabel;
@end

@interface YTColorPalette : NSObject
@property(readonly, nonatomic) long long pageStyle;
@end

@interface YTCommonColorPalette : NSObject
@property(readonly, nonatomic) long long pageStyle;
@end

// YouTube Reborn Settings
@interface FRPreferences : UITableViewController
@end

@interface FRPSelectListTable : UITableViewController
@end

@interface settingsReorderTable : UIViewController
@property(nonatomic, strong) UITableView *tableView;
@end

@interface SponsorBlockSettingsController : UITableViewController
@end

@interface SponsorBlockViewController : UIViewController
@end
