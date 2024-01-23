#import "OtherOptionsController.h"
#import "Localization.h"

@interface OtherOptionsController ()
- (void)coloursView;
@end

@implementation OtherOptionsController
@synthesize versionTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self coloursView];

    self.title = LOC(@"OTHER_OPTIONS");

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = doneButton;

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
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"OtherTableViewCell";
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
            cell.textLabel.text = LOC(@"IPAD_LAYOUT");
            UISwitch *enableiPadStyleOniPhone = [[UISwitch alloc] initWithFrame:CGRectZero];
            [enableiPadStyleOniPhone addTarget:self action:@selector(toggleEnableiPadStyleOniPhone:) forControlEvents:UIControlEventValueChanged];
            enableiPadStyleOniPhone.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kEnableiPadStyleOniPhone"];
            cell.accessoryView = enableiPadStyleOniPhone;
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = LOC(@"IPHONE_LAYOUT");
            UISwitch *enableiPhoneStyleOniPad = [[UISwitch alloc] initWithFrame:CGRectZero];
            [enableiPhoneStyleOniPad addTarget:self action:@selector(toggleEnableiPhoneStyleOniPad:) forControlEvents:UIControlEventValueChanged];
            enableiPhoneStyleOniPad.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kEnableiPhoneStyleOniPad"];
            cell.accessoryView = enableiPhoneStyleOniPad;
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = LOC(@"HIDE_CAST_BUTTON");
            UISwitch *noCastButton = [[UISwitch alloc] initWithFrame:CGRectZero];
            [noCastButton addTarget:self action:@selector(toggleNoCastButton:) forControlEvents:UIControlEventValueChanged];
            noCastButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kNoCastButton"];
            cell.accessoryView = noCastButton;
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = LOC(@"HIDE_NOTIFICATION_BUTTON");
            UISwitch *noNotificationButton = [[UISwitch alloc] initWithFrame:CGRectZero];
            [noNotificationButton addTarget:self action:@selector(toggleNoNotificationButton:) forControlEvents:UIControlEventValueChanged];
            noNotificationButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kNoNotificationButton"];
            cell.accessoryView = noNotificationButton;
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = LOC(@"HIDE_SEARCH_BUTTON");
            UISwitch *noSearchButton = [[UISwitch alloc] initWithFrame:CGRectZero];
            [noSearchButton addTarget:self action:@selector(toggleNoSearchButton:) forControlEvents:UIControlEventValueChanged];
            noSearchButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kNoSearchButton"];
            cell.accessoryView = noSearchButton;
        }
         if (indexPath.row == 5) {
            cell.textLabel.text = LOC(@"HIDE_PLAY_NEXT_IN_QUEUE");
            UISwitch *hidePlayNextInQueue = [[UISwitch alloc] initWithFrame:CGRectZero];
            [hidePlayNextInQueue addTarget:self action:@selector(toggleHidePlayNextInQueue:) forControlEvents:UIControlEventValueChanged];
            hidePlayNextInQueue.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHidePlayNextInQueue"];
            cell.accessoryView = hidePlayNextInQueue;
        }
        if (indexPath.row == 6) {
            cell.textLabel.text = LOC(@"DISABLE_YOUTUBE_KIDS");
            UISwitch *disableYouTubeKidsPopup = [[UISwitch alloc] initWithFrame:CGRectZero];
            [disableYouTubeKidsPopup addTarget:self action:@selector(toggleDisableYouTubeKidsPopup:) forControlEvents:UIControlEventValueChanged];
            disableYouTubeKidsPopup.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kDisableYouTubeKidsPopup"];
            cell.accessoryView = disableYouTubeKidsPopup;
        }
        if (indexPath.row == 7) {
            cell.textLabel.text = LOC(@"DISABLE_HINTS");
            UISwitch *disableHints = [[UISwitch alloc] initWithFrame:CGRectZero];
            [disableHints addTarget:self action:@selector(toggleDisableHints:) forControlEvents:UIControlEventValueChanged];
            disableHints.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kDisableHints"];
            cell.accessoryView = disableHints;
        }
        if (indexPath.row == 8) {
            cell.textLabel.text = LOC(@"PREMIUM_YOUTUBE_LOGO");
            UISwitch *premiumYouTubeLogo = [[UISwitch alloc] initWithFrame:CGRectZero];
            [premiumYouTubeLogo addTarget:self action:@selector(togglePremiumYouTubeLogo:) forControlEvents:UIControlEventValueChanged];
            premiumYouTubeLogo.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kPremiumYouTubeLogo"];
            cell.accessoryView = premiumYouTubeLogo;
	}
        if (indexPath.row == 9) {
            cell.textLabel.text = LOC(@"HIDE_YOUTUBE_LOGO");
            UISwitch *hideYouTubeLogo = [[UISwitch alloc] initWithFrame:CGRectZero];
            [hideYouTubeLogo addTarget:self action:@selector(toggleHideYouTubeLogo:) forControlEvents:UIControlEventValueChanged];
            hideYouTubeLogo.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideYouTubeLogo"];
            cell.accessoryView = hideYouTubeLogo;
	}
         if (indexPath.row == 10) {
            cell.textLabel.text = LOC(@"STICK_NAVIGATION_BAR");
            UISwitch *stickNavigationBar = [[UISwitch alloc] initWithFrame:CGRectZero];
            [stickNavigationBar addTarget:self action:@selector(toggleStickNavigationBar:) forControlEvents:UIControlEventValueChanged];
            stickNavigationBar.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kStickNavigationBar"];
            cell.accessoryView = stickNavigationBar;
	}
        if (indexPath.row == 11) {
            cell.textLabel.text = LOC(@"AUTO_HIDE_HOME_BAR");
            UISwitch *autoHideHomeBar = [[UISwitch alloc] initWithFrame:CGRectZero];
            [autoHideHomeBar addTarget:self action:@selector(toggleAutoHideHomeBar:) forControlEvents:UIControlEventValueChanged];
            autoHideHomeBar.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kAutoHideHomeBar"];
            cell.accessoryView = autoHideHomeBar;
        }
        if (indexPath.row == 12) {
            cell.textLabel.text = LOC(@"APP_VERSION_SPOOFER");
            UISwitch *appVersionSpoofer = [[UISwitch alloc] initWithFrame:CGRectZero];
            [appVersionSpoofer addTarget:self action:@selector(toggleAppVersionSpoofer:) forControlEvents:UIControlEventValueChanged];
            appVersionSpoofer.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kAppVersionSpoofer"];
            cell.accessoryView = appVersionSpoofer;
	    
            self.versionTextField = [[UITextField alloc] initWithFrame:CGRectZero];
            self.versionTextField.placeholder = LOC(@"ENTER_CUSTOM_APP_VERSION");
            self.versionTextField.enabled = appVersionSpoofer.isOn;
            [self.versionTextField addTarget:self action:@selector(versionTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.accessoryView = self.versionTextField;
	}
    }
    return cell;
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
}

- (void)versionTextFieldChanged:(UITextField *)textField {
    NSString *customVersion = textField.text;
    
    NSString *validVersionFormat = @"(17|18|19)(\\.\\d{1,2}){2}";
    NSPredicate *validVersionPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validVersionFormat];

    NSCharacterSet *allowedCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    NSCharacterSet *inputCharacterSet = [NSCharacterSet characterSetWithCharactersInString:customVersion];

   if (![validVersionPredicate evaluateWithObject:customVersion] || ![allowedCharacterSet isSupersetOfSet:inputCharacterSet]) {
        // Invalid format, set the default value or display an error message
        textField.text = @"19.03.1";
        return;
    } 
    self.customAppVersion = customVersion;
}

@end

@implementation OtherOptionsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleEnableiPadStyleOniPhone:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kEnableiPadStyleOniPhone"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kEnableiPadStyleOniPhone"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleEnableiPhoneStyleOniPad:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kEnableiPhoneStyleOniPad"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kEnableiPhoneStyleOniPad"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleNoCastButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kNoCastButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kNoCastButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleNoNotificationButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kNoNotificationButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kNoNotificationButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleNoSearchButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kNoSearchButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kNoSearchButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHidePlayNextInQueue:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHidePlayNextInQueue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHidePlayNextInQueue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleDisableYouTubeKidsPopup:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kDisableYouTubeKidsPopup"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kDisableYouTubeKidsPopup"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleDisableHints:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kDisableHints"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kDisableHints"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)togglePremiumYouTubeLogo:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kPremiumYouTubeLogo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kPremiumYouTubeLogo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHideYouTubeLogo:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideYouTubeLogo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideYouTubeLogo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleStickNavigationBar:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kStickNavigationBar"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kStickNavigationBar"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleAutoHideHomeBar:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kAutoHideHomeBar"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kAutoHideHomeBar"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleAppVersionSpoofer:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kAppVersionSpoofer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kAppVersionSpoofer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
