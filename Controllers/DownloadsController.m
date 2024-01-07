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
    videoViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"ytrebornbuttonvideoblack.png"] tag:0];
    videoViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"ytrebornbuttonvideowhite.png"];
    UINavigationController *videoNavViewController = [[UINavigationController alloc] initWithRootViewController:videoViewController];
    
    DownloadsAudioController *audioViewController = [[DownloadsAudioController alloc] init];
    audioViewController.title = LOC(@"AUDIO_TAB");
    audioViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"ytrebornbuttonaudioblack.png"] tag:1];
    audioViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"ytrebornbuttonaudiowhite.png"];
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
