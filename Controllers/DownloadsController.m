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

    NSString *tweakBundlePath = [[NSBundle mainBundle] pathForResource:@"YouTubeReborn" ofType:@"bundle"];
    NSString *whiteImageVideoPath;
    NSString *blackImageVideoPath;
    NSString *whiteImageAudioPath;
    NSString *blackImageAudioPath;

    if (tweakBundlePath) {
        NSBundle *tweakBundle = [NSBundle bundleWithPath:tweakBundlePath];
        whiteImageVideoPath = [tweakBundle pathForResource:@"ytrebornbuttonvideowhite" ofType:@"png"];
        blackImageVideoPath = [tweakBundle pathForResource:@"ytrebornbuttonvideoblack" ofType:@"png"];
	whiteImageAudioPath = [tweakBundle pathForResource:@"ytrebornbuttonaudiowhite" ofType:@"png"];
        blackImageAudioPath = [tweakBundle pathForResource:@"ytrebornbuttonaudioblack" ofType:@"png"];
    } else {
	whiteImageVideoPath = ROOT_PATH_NS(@"/Library/Application Support/YouTubeReborn.bundle/ytrebornbuttonvideowhite.png");
        blackImageVideoPath = ROOT_PATH_NS(@"/Library/Application Support/YouTubeReborn.bundle/ytrebornbuttonvideoblack.png");
	whiteImageAudioPath = ROOT_PATH_NS(@"/Library/Application Support/YouTubeReborn.bundle/ytrebornbuttonaudiowhite.png");
        blackImageAudioPath = ROOT_PATH_NS(@"/Library/Application Support/YouTubeReborn.bundle/ytrebornbuttonaudioblack.png");
    }
}

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
    UITabBarItem *videoTabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:blackImageVideoPath tag:0];
    [videoTabBarItem setSelectedImage:whiteImageVideoPath];
    videoViewController.tabBarItem = videoTabBarItem;
    UINavigationController *videoNavViewController = [[UINavigationController alloc] initWithRootViewController:videoViewController];
    
    DownloadsAudioController *audioViewController = [[DownloadsAudioController alloc] init];
    audioViewController.title = LOC(@"AUDIO_TAB");
    UITabBarItem *audioTabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:blackImageAudioPath tag:1];
    [audioTabBarItem setSelectedImage:whiteImageAudioPath];
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
