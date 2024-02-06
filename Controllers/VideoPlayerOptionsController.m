#import "VideoPlayerOptionsController.h"
#import "Localization.h"

@interface VideoPlayerOptionsController ()
- (void)coloursView;
@end

@implementation VideoPlayerOptionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self coloursView];

    self.title = LOC(@"VIDEO_PLAYER_OPTIONS");

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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VideoTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
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
            cell.textLabel.text = LOC(@"HIDE_CONNECT_PLAYER_BUTTON");
            UISwitch *hideConnectButton = [[UISwitch alloc] initWithFrame:CGRectZero];
            [hideConnectButton addTarget:self action:@selector(toggleHideConnectButton:) forControlEvents:UIControlEventValueChanged];
            hideConnectButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideConnectButton"];
            cell.accessoryView = hideConnectButton;
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = LOC(@"HIDE_SHARE_PLAYER_BUTTON");
            UISwitch *hideShareButton = [[UISwitch alloc] initWithFrame:CGRectZero];
            [hideShareButton addTarget:self action:@selector(toggleHideShareButton:) forControlEvents:UIControlEventValueChanged];
            hideShareButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideShareButton"];
            cell.accessoryView = hideShareButton;
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = LOC(@"HIDE_REMIX_PLAYER_BUTTON");
            UISwitch *hideRemixButton = [[UISwitch alloc] initWithFrame:CGRectZero];
            [hideRemixButton addTarget:self action:@selector(toggleHideRemixButton:) forControlEvents:UIControlEventValueChanged];
            hideRemixButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideRemixButton"];
            cell.accessoryView = hideRemixButton;
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = LOC(@"HIDE_THANKS_PLAYER_BUTTON");
            UISwitch *hideThanksButton = [[UISwitch alloc] initWithFrame:CGRectZero];
            [hideThanksButton addTarget:self action:@selector(toggleHideThanksButton:) forControlEvents:UIControlEventValueChanged];
            hideThanksButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideThanksButton"];
            cell.accessoryView = hideThanksButton;
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = LOC(@"HIDE_DOWNLOAD_PLAYER_BUTTON");
            UISwitch *hideDownloadButton = [[UISwitch alloc] initWithFrame:CGRectZero];
            [hideDownloadButton addTarget:self action:@selector(toggleHideDownloadButton:) forControlEvents:UIControlEventValueChanged];
            hideDownloadButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideAddToOfflineButton"];
            cell.accessoryView = hideDownloadButton;
        }
        if (indexPath.row == 5) {
            cell.textLabel.text = LOC(@"HIDE_CLIP_PLAYER_BUTTON");
            UISwitch *hideClipButton = [[UISwitch alloc] initWithFrame:CGRectZero];
            [hideClipButton addTarget:self action:@selector(toggleHideClipButton:) forControlEvents:UIControlEventValueChanged];
            hideClipButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideClipButton"];
            cell.accessoryView = hideClipButton;
        }
        if (indexPath.row == 6) {
            cell.textLabel.text = LOC(@"HIDE_SAVE_PLAYER_BUTTON");
            UISwitch *hidePlaylistButton = [[UISwitch alloc] initWithFrame:CGRectZero];
            [hidePlaylistButton addTarget:self action:@selector(toggleHidePlaylistButton:) forControlEvents:UIControlEventValueChanged];
            hidePlaylistButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"kHideSaveToPlaylistButton"];
            cell.accessoryView = hidePlaylistButton;
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

@end

@implementation VideoPlayerOptionsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleHideConnectButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideConnectButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideConnectButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHideShareButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideShareButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideShareButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHideRemixButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideRemixButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideRemixButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHideThanksButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideThanksButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideThanksButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHideDownloadButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideAddToOfflineButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideAddToOfflineButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHideClipButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideClipButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideClipButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleHidePlaylistButton:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kHideSaveToPlaylistButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kHideSaveToPlaylistButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
