#import "DownloadsController.h"
#import "DownloadsVideoController.h"
#import "DownloadsAudioController.h"
#import "Localization.h"

@interface DownloadsController ()
- (void)configureUI;
- (void)doneButtonTapped;
@end

@implementation DownloadsController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

NSString *blackImageVideoPath = [tweakBundle pathForResource:@"ytrebornbuttonvideoblack" ofType:@"png"];
NSString *whiteImageVideoPath = [tweakBundle pathForResource:@"ytrebornbuttonvideowhite" ofType:@"png"];
NSString *blackImageAudioPath = [tweakBundle pathForResource:@"ytrebornbuttonaudioblack" ofType:@"png"];
NSString *whiteImageAudioPath = [tweakBundle pathForResource:@"ytrebornbuttonaudiowhite" ofType:@"png"];

UIImage *blackImageVideo = [UIImage imageWithContentsOfFile:blackImageVideoPath];
blackImageVideo = [blackImageVideo imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
UIImage *whiteImageVideo = [UIImage imageWithContentsOfFile:blackImageVideoPath];
blackImageVideo = [whiteImageVideo imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
UIImage *blackImageAudio = [UIImage imageWithContentsOfFile:blackImageVideoPath];
blackImageVideo = [blackImageAudio imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
UIImage *whiteImageAudio = [UIImage imageWithContentsOfFile:blackImageVideoPath];
blackImageVideo = [whiteImageAudio imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

- (void)configureUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    UINavigationBarAppearance *navigationBarAppearance = [[UINavigationBarAppearance alloc] init];
    navigationBarAppearance.backgroundColor = [UIColor systemBackgroundColor];
    navigationBarAppearance.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];

    [self.navigationController.navigationBar setStandardAppearance:navigationBarAppearance];
    [self.navigationController.navigationBar setScrollEdgeAppearance:navigationBarAppearance];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor labelColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.tabBar = [[UITabBarController alloc] init];
    
    DownloadsVideoController *videoViewController = [[DownloadsVideoController alloc] init];
    videoViewController.title = LOC(@"VIDEO_TAB");
    UITabBarItem *videoTabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:blackImageVideo tag:0];
    [videoTabBarItem setSelectedImage:whiteImageVideo];
    videoViewController.tabBarItem = videoTabBarItem;
    UINavigationController *videoNavViewController = [[UINavigationController alloc] initWithRootViewController:videoViewController];
    
    DownloadsAudioController *audioViewController = [[DownloadsAudioController alloc] init];
    audioViewController.title = LOC(@"AUDIO_TAB");
    UITabBarItem *audioTabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:blackImageAudio tag:1];
    [audioTabBarItem setSelectedImage:whiteImageAudio];
    audioViewController.tabBarItem = audioTabBarItem;
    UINavigationController *audioNavViewController = [[UINavigationController alloc] initWithRootViewController:audioViewController];
    
    self.tabBar.viewControllers = @[videoNavViewController, audioNavViewController];
    [self addChildViewController:self.tabBar];
    self.tabBar.view.frame = self.view.bounds;
    [self.view addSubview:self.tabBar.view];
    [self.tabBar didMoveToParentViewController:self];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self configureUI];
}

- (void)doneButtonTapped {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
