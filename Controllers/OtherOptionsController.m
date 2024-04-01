#import "OtherOptionsController.h"
#import "Localization.h"

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
@interface OtherOptionsController ()
- (void)coloursView;
- (void)showVersionAlert;
@end

@implementation OtherOptionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self coloursView];

    self.title = LOC(@"OTHER_OPTIONS");

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
    return 14;
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
        CREATE_SWITCH(enableiPadStyleOniPhone, toggleEnableiPadStyleOniPhone, @"kEnableiPadStyleOniPhone");
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = LOC(@"IPHONE_LAYOUT");
        CREATE_SWITCH(enableiPhoneStyleOniPad, toggleEnableiPhoneStyleOniPad, @"kEnableiPhoneStyleOniPad");
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = LOC(@"HIDE_CAST_BUTTON");
        CREATE_SWITCH(noCastButton, toggleNoCastButton, @"kNoCastButton");
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = LOC(@"HIDE_NOTIFICATION_BUTTON");
        CREATE_SWITCH(noNotificationButton, toggleNoNotificationButton, @"kNoNotificationButton");
    }
    if (indexPath.row == 4) {
        cell.textLabel.text = LOC(@"HIDE_SEARCH_BUTTON");
        CREATE_SWITCH(noSearchButton, toggleNoSearchButton, @"kNoSearchButton");
    }
    if (indexPath.row == 5) {
        cell.textLabel.text = LOC(@"HIDE_PLAY_NEXT_IN_QUEUE");
        CREATE_SWITCH(hidePlayNextInQueue, toggleHidePlayNextInQueue, @"kHidePlayNextInQueue");
    }
    if (indexPath.row == 6) {
        cell.textLabel.text = LOC(@"DISABLE_YOUTUBE_KIDS");
        CREATE_SWITCH(disableYouTubeKidsPopup, toggleDisableYouTubeKidsPopup, @"kDisableYouTubeKidsPopup");
    }
    if (indexPath.row == 7) {
        cell.textLabel.text = LOC(@"DISABLE_HINTS");
        CREATE_SWITCH(disableHints, toggleDisableHints, @"kDisableHints");
    }
    if (indexPath.row == 8) {
        cell.textLabel.text = LOC(@"PREMIUM_YOUTUBE_LOGO");
        CREATE_SWITCH(premiumYouTubeLogo, togglePremiumYouTubeLogo, @"kPremiumYouTubeLogo");
    }
    if (indexPath.row == 9) {
        cell.textLabel.text = LOC(@"HIDE_YOUTUBE_LOGO");
        CREATE_SWITCH(hideYouTubeLogo, toggleHideYouTubeLogo, @"kHideYouTubeLogo");
    }
    if (indexPath.row == 10) {
        cell.textLabel.text = LOC(@"STICK_NAVIGATION_BAR");
        CREATE_SWITCH(stickNavigationBar, toggleStickNavigationBar, @"kStickNavigationBar");
    }
    if (indexPath.row == 11) {
        cell.textLabel.text = LOC(@"AUTO_HIDE_HOME_BAR");
        CREATE_SWITCH(autoHideHomeBar, toggleAutoHideHomeBar, @"kAutoHideHomeBar");
    }
    if (indexPath.row == 12) {
        cell.textLabel.text = LOC(@"APP_VERSION_SPOOFER");
        CREATE_SWITCH(appVersionSpoofer, toggleAppVersionSpoofer, @"kAppVersionSpoofer");
    }
    if (indexPath.row == 13) {
        cell.textLabel.text = LOC(@"ENTER_CUSTOM_APP_VERSION");
        UIButton *alertViewButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [alertViewButton setTitle:LOC(@"ENTER_CUSTOM_APP_VERSION") forState:UIControlStateNormal];
        [alertViewButton addTarget:self action:@selector(showVersionAlert) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = alertViewButton;
        }
    }
    return cell;
}

- (void)showVersionAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:LOC(@"ENTER_CUSTOM_APP_VERSION") message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = LOC(@"ENTER_CUSTOM_APP_VERSION");
        textField.text = self.customAppVersion;
        textField.enabled = BOOL_FOR_KEY(@"kAppVersionSpoofer");
    }];
    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:LOC(@"RESET_TEXT") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        textField.text = @"";
        self.customAppVersion = @"";
    }];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:LOC(@"SAVE_TEXT") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        self.customAppVersion = textField.text;
    }];
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:LOC(@"OKAY_TEXT") style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:resetAction];
    [alert addAction:saveAction];
    [alert addAction:closeAction];
    [self presentViewController:alert animated:YES completion:nil];
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

@implementation OtherOptionsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleEnableiPadStyleOniPhone:(UISwitch *)sender {
    TOGGLE_SETTING(@"kEnableiPadStyleOniPhone", sender);
}

- (void)toggleEnableiPhoneStyleOniPad:(UISwitch *)sender {
    TOGGLE_SETTING(@"kEnableiPhoneStyleOniPad", sender);
}

- (void)toggleNoCastButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kNoCastButton", sender);
}

- (void)toggleNoNotificationButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kNoNotificationButton", sender);
}

- (void)toggleNoSearchButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kNoSearchButton", sender);
}

- (void)toggleHidePlayNextInQueue:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHidePlayNextInQueue", sender);
}

- (void)toggleDisableYouTubeKidsPopup:(UISwitch *)sender {
    TOGGLE_SETTING(@"kDisableYouTubeKidsPopup", sender);
}

- (void)toggleDisableHints:(UISwitch *)sender {
    TOGGLE_SETTING(@"kDisableHints", sender);
}

- (void)togglePremiumYouTubeLogo:(UISwitch *)sender {
    TOGGLE_SETTING(@"kPremiumYouTubeLogo", sender);
}

- (void)toggleHideYouTubeLogo:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideYouTubeLogo", sender);
}

- (void)toggleStickNavigationBar:(UISwitch *)sender {
    TOGGLE_SETTING(@"kStickNavigationBar", sender);
}

- (void)toggleAutoHideHomeBar:(UISwitch *)sender {
    TOGGLE_SETTING(@"kAutoHideHomeBar", sender);
}

- (void)toggleAppVersionSpoofer:(UISwitch *)sender {
    TOGGLE_SETTING(@"kAppVersionSpoofer", sender);
}
@end
