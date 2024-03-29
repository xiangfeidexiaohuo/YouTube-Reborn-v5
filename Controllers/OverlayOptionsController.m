#import "OverlayOptionsController.h"
#import "Localization.h"
#import <LocalAuthentication/LocalAuthentication.h>

#define BOOL_FOR_KEY(KEY) [[NSUserDefaults standardUserDefaults] boolForKey:KEY]
#define SET_BOOL_FOR_KEY(KEY, VALUE) [[NSUserDefaults standardUserDefaults] setBool:VALUE forKey:KEY]; [[NSUserDefaults standardUserDefaults] synchronize];

#define TOGGLE_SETTING(KEY, SENDER) \
if ([SENDER isOn]) { \
    SET_BOOL_FOR_KEY(KEY, YES); \
} else { \
    SET_BOOL_FOR_KEY(KEY, NO); \
}

#define CREATE_SWITCH(NAME, SELECTOR, KEY) \
UISwitch *NAME = [[UISwitch alloc] initWithFrame:CGRectZero]; \
[NAME addTarget:self action:@selector(SELECTOR:) forControlEvents:UIControlEventValueChanged]; \
NAME.on = BOOL_FOR_KEY(KEY);\
cell.accessoryView = NAME;

//
@interface OverlayOptionsController ()
- (void)coloursView;
@end

static BOOL hasDeviceNotch() {
	if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
		return NO;
	} else {
		LAContext* context = [[LAContext alloc] init];
		[context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
		return [context biometryType] == LABiometryTypeFaceID;
	}
}

@implementation OverlayOptionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self coloursView];

    self.title = LOC(@"OVERLAY_OPTIONS");

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = doneButton;

    UITableViewStyle style;
        if (@available(iOS 13, *)) {
            style = UITableViewStyleInsetGrouped;
        } else {
            style = UITableViewStyleGrouped;
        }

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.tableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.tableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
        [self.tableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor]
    ]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"OverlayTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor blackColor];
        }
        else {
            cell.backgroundColor = [UIColor colorWithRed:0.110 green:0.110 blue:0.118 alpha:1.0];
            cell.textLabel.textColor = [UIColor whiteColor];
	    cell.textLabel.shadowColor = [UIColor blackColor];
            cell.textLabel.shadowOffset = CGSizeMake(1.0, 1.0);
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.textLabel.text = LOC(@"SHOW_STATUS_BAR_IN_OVERLAY");
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kEnableiPadStyleOniPhone"] == YES || hasDeviceNotch() == YES) {
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
            }
            else {
                CREATE_SWITCH(showStatusBarInOverlay, toggleShowStatusBarInOverlay, @"kShowStatusBarInOverlay");
            }
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = LOC(@"STOCK_VOLUME_HUD");
            CREATE_SWITCH(stockVolumeHUD, toggleStockVolumeHUD, @"kStockVolumeHUD");
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = LOC(@"HIDE_PREVIOUS_BUTTON");
            CREATE_SWITCH(hidePreviousButtonInOverlay, toggleHidePreviousButtonInOverlay, @"kHidePreviousButtonInOverlay");
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = LOC(@"HIDE_PREVIOUS_BUTTON_SHADOW");
            CREATE_SWITCH(hidePreviousButtonShadowInOverlay, toggleHidePreviousButtonShadowInOverlay, @"kHidePreviousButtonShadowInOverlay");
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = LOC(@"HIDE_NEXT_BUTTON");
            CREATE_SWITCH(hideNextButtonInOverlay, toggleHideNextButtonInOverlay, @"kHideNextButtonInOverlay");
        }
        if (indexPath.row == 5) {
            cell.textLabel.text = LOC(@"HIDE_NEXT_BUTTON_SHADOW");
            CREATE_SWITCH(hideNextButtonShadowInOverlay, toggleHideNextButtonShadowInOverlay, @"kHideNextButtonShadowInOverlay");
        }
        if (indexPath.row == 6) {
            cell.textLabel.text = LOC(@"HIDE_SEEK_BACKWARD_BUTTON_SHADOW");
            CREATE_SWITCH(hideSeekBackwardButtonShadowInOverlay, toggleHideSeekBackwardButtonShadowInOverlay, @"kHideSeekBackwardButtonShadowInOverlay");
        }
        if (indexPath.row == 7) {
            cell.textLabel.text = LOC(@"HIDE_SEEK_FORWARD_BUTTON_SHADOW");
            CREATE_SWITCH(hideSeekForwardButtonShadowInOverlay, toggleHideSeekForwardButtonShadowInOverlay, @"kHideSeekForwardButtonShadowInOverlay");
        }
        if (indexPath.row == 8) {
            cell.textLabel.text = LOC(@"HIDE_PLAY_AND_PAUSE_BUTTON_SHADOW");
            CREATE_SWITCH(hidePlayPauseButtonShadowInOverlay, toggleHidePlayPauseButtonShadowInOverlay, @"kHidePlayPauseButtonShadowInOverlay");
        }
        if (indexPath.row == 9) {
            cell.textLabel.text = LOC(@"HIDE_AUTOPLAY_SWITCH");
            CREATE_SWITCH(hideAutoPlaySwitchInOverlay, toggleHideAutoPlaySwitchInOverlay, @"kHideAutoPlaySwitchInOverlay");
        }
        if (indexPath.row == 10) {
            cell.textLabel.text = LOC(@"HIDE_CAPTIONS_AND_SUBTITLES_BUTTON");
            CREATE_SWITCH(hideCaptionsSubtitlesButtonInOverlay, toggleHideCaptionsSubtitlesButtonInOverlay, @"kHideCaptionsSubtitlesButtonInOverlay");
        }
        if (indexPath.row == 11) {
            cell.textLabel.text = LOC(@"DISABLE_RELATED_VIDEOS");
            CREATE_SWITCH(disableRelatedVideosInOverlay, toggleDisableRelatedVideosInOverlay, @"kDisableRelatedVideosInOverlay");
        }
        if (indexPath.row == 12) {
            cell.textLabel.text = LOC(@"HIDE_CHANNEL_WATERMARK");
            CREATE_SWITCH(hideChannelWatermark, toggleHideChannelWatermark, @"kHideChannelWatermark");
        }
        if (indexPath.row == 13) {
            cell.textLabel.text = LOC(@"HIDE_DARK_OVERLAY_BACKGROUND");
            CREATE_SWITCH(hideOverlayDarkBackground, toggleHideOverlayDarkBackground, @"kHideOverlayDarkBackground");
        }
        if (indexPath.row == 14) {
            cell.textLabel.text = LOC(@"HIDE_QUICK_ACTIONS");
            CREATE_SWITCH(hideOverlayQuickActions, toggleHideOverlayQuickActions, @"kHideOverlayQuickActions");
        }
        if (indexPath.row == 15) {
            cell.textLabel.text = LOC(@"HIDE_CURRENT_TIME");
            CREATE_SWITCH(hideCurrentTime, toggleHideCurrentTime, @"kHideCurrentTime");
        }
        if (indexPath.row == 16) {
            cell.textLabel.text = LOC(@"HIDE_DURATION");
            CREATE_SWITCH(hideDuration, toggleHideDuration, @"kHideDuration");
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (hasDeviceNotch()) {
        UIAlertController *alertError = [UIAlertController alertControllerWithTitle:LOC(@"NOTICE_TEXT") message:LOC(@"STATUS_BAR_TEXT") preferredStyle:UIAlertControllerStyleAlert];

        [alertError addAction:[UIAlertAction actionWithTitle:LOC(@"OKAY_TEXT") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];

        [self presentViewController:alertError animated:YES completion:nil];
    } else {
        UIAlertController *alertError = [UIAlertController alertControllerWithTitle:LOC(@"NOTICE_TEXT") message:LOC(@"IPAD_TEXT") preferredStyle:UIAlertControllerStyleAlert];

        [alertError addAction:[UIAlertAction actionWithTitle:LOC(@"OKAY_TEXT") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];

        [self presentViewController:alertError animated:YES completion:nil];
    }
}

- (void)coloursView {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
        self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.969 alpha:1.0];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    }
    else {
        self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self coloursView];
    [self.tableView reloadData];
}

@end

@implementation OverlayOptionsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleShowStatusBarInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kShowStatusBarInOverlay", sender);
}

- (void)toggleStockVolumeHUD:(UISwitch *)sender {
    TOGGLE_SETTING(@"kStockVolumeHUD", sender);
}

- (void)toggleHidePreviousButtonInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHidePreviousButtonInOverlay", sender);
}

- (void)toggleHidePreviousButtonShadowInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHidePreviousButtonShadowInOverlay", sender);
}

- (void)toggleHideNextButtonInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideNextButtonInOverlay", sender);
}

- (void)toggleHideNextButtonShadowInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideNextButtonShadowInOverlay", sender);
}

- (void)toggleHideSeekBackwardButtonShadowInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideSeekBackwardButtonShadowInOverlay", sender);
}

- (void)toggleHideSeekForwardButtonShadowInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideSeekForwardButtonShadowInOverlay", sender);
}

- (void)toggleHidePlayPauseButtonShadowInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHidePlayPauseButtonShadowInOverlay", sender);
}

- (void)toggleHideAutoPlaySwitchInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideAutoPlaySwitchInOverlay", sender);
}

- (void)toggleHideCaptionsSubtitlesButtonInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideCaptionsSubtitlesButtonInOverlay", sender);
}

- (void)toggleDisableRelatedVideosInOverlay:(UISwitch *)sender {
    TOGGLE_SETTING(@"kDisableRelatedVideosInOverlay", sender);
}

- (void)toggleHideChannelWatermark:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideChannelWatermark", sender);
}

- (void)toggleHideOverlayDarkBackground:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideOverlayDarkBackground", sender);
}

- (void)toggleHideOverlayQuickActions:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideOverlayQuickActions", sender);
}

- (void)toggleHideCurrentTime:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideCurrentTime", sender);
}

- (void)toggleHideDuration:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideDuration", sender);
}

@end
