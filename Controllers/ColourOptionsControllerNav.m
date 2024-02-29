#import "ColourOptionsControllerNav.h"
#import "ColourOptionsController.h"
#import "ColourOptionsController2.h"
#import "ColourOptionsController3.h"
#import "ColourOptionsController4.h"
#import "Localization.h"

@interface ColourOptionsControllerNav ()
- (void)configureUI;
- (void)doneButtonTapped;
@end

@implementation ColourOptionsControllerNav
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

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;

    ColourOptionsController *colorViewController = [[ColourOptionsController alloc] init];
    colorViewController.title = LOC(@"CUSTOM_THEME_TAB");
    colorViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOC(@"CUSTOM_THEME_TAB") image:[UIImage systemImageNamed:@"paintpalette.fill"] tag:0];
    UINavigationController *colorNavViewController = [[UINavigationController alloc] initWithRootViewController:colorViewController];

    ColourOptionsController2 *colorViewController2 = [[ColourOptionsController2 alloc] init];
    colorViewController2.title = LOC(@"CUSTOM_TINT_TAB");
    colorViewController2.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOC(@"CUSTOM_TINT_TAB") image:[UIImage systemImageNamed:@"drop.fill"] tag:1];
    UINavigationController *colorNavViewController2 = [[UINavigationController alloc] initWithRootViewController:colorViewController2];

    ColourOptionsController3 *colorViewController3 = [[ColourOptionsController3 alloc] init];
    colorViewController3.title = LOC(@"CUSTOM_SYSTEMBLUE_TAB");
    colorViewController3.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOC(@"CUSTOM_SYSTEMBLUE_TAB") image:[UIImage systemImageNamed:@"square.stack"] tag:2];
    UINavigationController *colorNavViewController3 = [[UINavigationController alloc] initWithRootViewController:colorViewController3];

    ColourOptionsController4 *colorViewController4 = [[ColourOptionsController4 alloc] init];
    colorViewController4.title = LOC(@"CUSTOM_PROGRESS_BAR_TAB");
    colorViewController4.tabBarItem = [[UITabBarItem alloc] initWithTitle:LOC(@"CUSTOM_PROGRESS_BAR_TAB") image:[UIImage systemImageNamed:@"waveform.path.ecg"] tag:3];
    UINavigationController *colorNavViewController4 = [[UINavigationController alloc] initWithRootViewController:colorViewController4];

    self.tabBarController.viewControllers = @[colorNavViewController, colorNavViewController2, colorNavViewController3, colorNavViewController4];
    [self addChildViewController:self.tabBarController];
    self.tabBarController.view.frame = self.view.bounds;
    [self.view addSubview:self.tabBarController.view];
    [self.tabBarController didMoveToParentViewController:self];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    UIView *selectedItemView = [tabBarController.tabBar.subviews objectAtIndex:tabBarController.selectedIndex + 1];
    selectedItemView.backgroundColor = [UIColor systemBlueColor];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self configureUI];
}

- (void)doneButtonTapped {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
