#import "RebornSettingsController.h"
#import "Localization.h"

@interface RebornSettingsController ()
- (void)coloursView;
@end

@implementation RebornSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self coloursView];

    self.title = LOC(@"REBORN_SETTINGS");

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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 3;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RebornSettingsTableViewCell";
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
        if (indexPath.section == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                cell.textLabel.text = LOC(@"I_HAVE_YOUTUBE_PREMIUM");
                UISwitch *rebornIHaveYouTubePremiumButton = [[UISwitch alloc] initWithFrame:CGRectZero];
                [rebornIHaveYouTubePremiumButton addTarget:self action:@selector(toggleRebornIHaveYouTubePremiumButton:) forControlEvents:UIControlEventValueChanged];
                rebornIHaveYouTubePremiumButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kRebornIHaveYouTubePremium"];
                cell.accessoryView = rebornIHaveYouTubePremiumButton;
            }
        }
        if (indexPath.section == 1) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                cell.textLabel.text = LOC(@"HIDE_PLAYER_OVERLAY_OP_BUTTON");
                UISwitch *hideRebornPlayerOPButton = [[UISwitch alloc] initWithFrame:CGRectZero];
                [hideRebornPlayerOPButton addTarget:self action:@selector(toggleHideRebornPlayerOPButton:) forControlEvents:UIControlEventValueChanged];
                hideRebornPlayerOPButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideRebornOPButtonVThree"];
                cell.accessoryView = hideRebornPlayerOPButton;
            }
            if (indexPath.row == 1) {
                cell.textLabel.text = LOC(@"HIDE_VIDEO_OVERLAY_OP_BUTTON");
                UISwitch *hideRebornOPButton = [[UISwitch alloc] initWithFrame:CGRectZero];
                [hideRebornOPButton addTarget:self action:@selector(toggleHideRebornOPButton:) forControlEvents:UIControlEventValueChanged];
                hideRebornOPButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideRebornOPButtonVTwo"];
                cell.accessoryView = hideRebornOPButton;
            }
            if (indexPath.row == 2) {
                cell.textLabel.text = LOC(@"HIDE_SHORTS_OVERLAY_OP_BUTTON");
                UISwitch *hideRebornShortsOPButton = [[UISwitch alloc] initWithFrame:CGRectZero];
                [hideRebornShortsOPButton addTarget:self action:@selector(toggleHideRebornShortsOPButton:) forControlEvents:UIControlEventValueChanged];
                hideRebornShortsOPButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideRebornShortsOPButton"];
                cell.accessoryView = hideRebornShortsOPButton;
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.textLabel.text = LOC(@"RESET_CACHE");
                UILabel *cache = [[UILabel alloc] init];
                cache.text = [self getCacheSize];
                cache.textColor = [UIColor secondaryLabelColor];
                cache.font = [UIFont systemFontOfSize:16];
                cache.textAlignment = NSTextAlignmentRight;
                [cache sizeToFit];
                cell.accessoryView = cache;
            }
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                cell.textLabel.text = LOC(@"RESET_COLOR_OPTIONS");
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            if (indexPath.row == 1) {
                cell.textLabel.text = LOC(@"RESET_YOUTUBE_REBORN_OPTIONS");
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
    }
    return cell;
}

- (NSString *)getCacheSize {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:cachePath error:nil];

    unsigned long long int folderSize = 0;
    for (NSString *fileName in filesArray) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        folderSize += [fileAttributes fileSize];
    }

    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    formatter.countStyle = NSByteCountFormatterCountStyleFile;

    return [formatter stringFromByteCount:folderSize];
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [theTableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2 && indexPath.row == 0) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        activityIndicator.color = [UIColor labelColor];
        [activityIndicator startAnimating];
        UITableViewCell *cell = [theTableView cellForRowAtIndexPath:indexPath];
        cell.accessoryView = activityIndicator;

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            [[NSFileManager defaultManager] removeItemAtPath:cachePath error:nil];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
            });
        });
    }

    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:LOC(@"NOTICE_TEXT") message:LOC(@"RESET_COLOR_TEXT") preferredStyle:UIAlertControllerStyleAlert];

            [alert addAction:[UIAlertAction actionWithTitle:LOC(@"CANCEL_TEXT") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];

            [alert addAction:[UIAlertAction actionWithTitle:LOC(@"OKAY_TEXT") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kYTRebornColourOptionsVFour"];
	        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kYTLcmColourOptionVFive"];
	        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kCustomSystemBlueColor"];
	        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kYTProgreessBarColourOption"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[UIApplication sharedApplication] performSelector:@selector(suspend)];
                [NSThread sleepForTimeInterval:1.0];
                exit(0);
            }]];

            [self presentViewController:alert animated:YES completion:nil];
        }
        if (indexPath.row == 1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:LOC(@"NOTICE_TEXT") message:LOC(@"RESET_OPTIONS_TEXT") preferredStyle:UIAlertControllerStyleAlert];

            [alert addAction:[UIAlertAction actionWithTitle:LOC(@"CANCEL_TEXT") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];

            [alert addAction:[UIAlertAction actionWithTitle:LOC(@"OKAY_TEXT") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kEnableNoVideoAds"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kEnableBackgroundPlayback"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kNoCastButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kNoNotificationButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kAllowHDOnCellularData"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHidePlayNextInQueue"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kDisableVideoEndscreenPopups"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kDisableYouTubeKidsPopup"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kEnableExtraSpeedOptions"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kDisableHints"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideYouTubeLogo"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kStickNavigationBar"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kAutoHideHomeBar"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideTabBarLabels"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideExploreTab"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsTab"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideUploadTab"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideSubscriptionsTab"];
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideYouTab"];
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideConnectButton"];
  		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShareButton"];
    		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideRemixButton"];
      		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideThanksButton"];
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideAddToOfflineButton"];
  		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideClipButton"];
      		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideSaveToPlaylistButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kDisableDoubleTapToSkip"];
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideOverlayDarkBackground"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHidePreviousButtonInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideNextButtonInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kDisableVideoAutoPlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kDisablePinchToZoom"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideAutoPlaySwitchInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideCaptionsSubtitlesButtonInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kDisableVideoInfoCards"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kNoSearchButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideChannelWatermark"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsChannelAvatarButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsLikeButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsDislikeButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsCommentsButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsRemixButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsShareButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsMoreActionsButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsSearchButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsBuySuperThanks"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideShortsSubscriptionsButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kDisableResumeToShorts"];
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kAlwaysShowShortsPlayerBar"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideOverlayQuickActions"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kAutoFullScreen"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kDisableRelatedVideosInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kEnableiPadStyleOniPhone"];
	        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kEnableiPhoneStyleOniPad"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kRedProgressBar"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kGrayBufferProgress"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHidePlayerBarHeatwave"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHidePictureInPictureAdsBadge"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHidePictureInPictureSponsorBadge"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kStockVolumeHUD"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHidePreviousButtonShadowInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideNextButtonShadowInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideSeekBackwardButtonShadowInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideSeekForwardButtonShadowInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHidePlayPauseButtonShadowInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kEnableCustomDoubleTapToSkipDuration"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kAlwaysShowPlayerBarVTwo"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kShowStatusBarInOverlay"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kYTRebornColourOptionsVFour"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kEnablePictureInPictureVTwo"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kEnableCustomDoubleTapToSkipDuration"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kCustomDoubleTapToSkipDuration"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kRebornIHaveYouTubePremium"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kSourceSegmentedInt"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kSponsorSegmentedInt"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kSelfPromoSegmentedInt"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kInteractionSegmentedInt"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kIntroSegmentedInt"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kOutroSegmentedInt"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kPreviewSegmentedInt"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kFillerSegmentedInt"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kMusicOffTopicSegmentedInt"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kStartupPageIntVTwo"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideRebornOPButtonVThree"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideRebornOPButtonVTwo"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideRebornShortsOPButton"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideCurrentTime"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kHideDuration"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[UIApplication sharedApplication] performSelector:@selector(suspend)];
                [NSThread sleepForTimeInterval:2.0];
                exit(0);
            }]];

            [self presentViewController:alert animated:YES completion:nil];
        }
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.layer.cornerRadius = 10.0;
    self.view.layer.masksToBounds = YES;
}

@end

@implementation RebornSettingsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleRebornIHaveYouTubePremiumButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kRebornIHaveYouTubePremium"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kRebornIHaveYouTubePremium"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHideRebornPlayerOPButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideRebornOPButtonVThree"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideRebornOPButtonVThree"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHideRebornOPButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideRebornOPButtonVTwo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideRebornOPButtonVTwo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHideRebornShortsOPButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideRebornShortsOPButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideRebornShortsOPButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
