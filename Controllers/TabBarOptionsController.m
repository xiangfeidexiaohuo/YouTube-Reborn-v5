#import "TabBarOptionsController.h"
#import "StartupPageOptionsController.h"
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
@interface TabBarOptionsController ()
- (void)coloursView;
@end

@implementation TabBarOptionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self coloursView];

    self.title = LOC(@"TAB_BAR_OPTIONS");

    NSString *requiredVersion = @"17.33.2";
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

if ([currentVersion compare:requiredVersion options:NSNumericSearch] == NSOrderedAscending) {
    dispatch_async(dispatch_get_main_queue(), ^{
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:LOC(@"WARNING_TEXT") message:[NSString stringWithFormat:LOC(@"You are using %@ which is an outdated version of the YouTube app. Please update to version %@ or higher to continue using this tweak."), currentVersion, requiredVersion] preferredStyle:UIAlertControllerStyleAlert]; // LOC NAME: CLIENT_OUTDATED
        [alert addAction:[UIAlertAction actionWithTitle:LOC(@"OKAY_TEXT") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    });
    return;
}

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 6;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TabBarTableViewCell";
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
            cell.textLabel.text = LOC(@"STARTUP_PAGE");
            if (![[NSUserDefaults standardUserDefaults] integerForKey:@"kStartupPageIntVTwo"]) {
                cell.detailTextLabel.text = LOC(@"HOME_TEXT");
            } else {
                int selectedTab = [[NSUserDefaults standardUserDefaults] integerForKey:@"kStartupPageIntVTwo"];
                if (selectedTab == 0) {
                    cell.detailTextLabel.text = LOC(@"HOME_TEXT");
                }
                if (selectedTab == 1) {
                    cell.detailTextLabel.text = LOC(@"EXPLORE_TEXT");
                }
                if (selectedTab == 2) {
                    cell.detailTextLabel.text = LOC(@"SHORTS_TEXT");
                }
                if (selectedTab == 3) {
                    cell.detailTextLabel.text = LOC(@"SUB_TEXT");
                }
                if (selectedTab == 4) {
                    cell.detailTextLabel.text = LOC(@"YOU_TEXT");
                }
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = LOC(@"HIDE_TAB_BAR_LABELS");
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideTabBarLabels, toggleHideTabBarLabels, @"kHideTabBarLabels");
            }
            if (indexPath.row == 1) {
                cell.textLabel.text = LOC(@"HIDE_EXPLORE_TAB");
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideExploreTab, toggleHideExploreTab, @"kHideExploreTab");
            }
            if (indexPath.row == 2) {
                cell.textLabel.text = LOC(@"HIDE_SHORTS_TAB");
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideShortsTab, toggleHideShortsTab, @"kHideShortsTab");
            }
            if (indexPath.row == 3) {
                cell.textLabel.text = LOC(@"HIDE_CREATE_TAB");
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideUploadTab, toggleHideUploadTab, @"kHideUploadTab");
            }
            if (indexPath.row == 4) {
                cell.textLabel.text = LOC(@"HIDE_SUBSCRIPTIONS_TAB");
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideSubscriptionsTab, toggleHideSubscriptionsTab, @"kHideSubscriptionsTab");
            }
            if (indexPath.row == 5) {
                cell.textLabel.text = LOC(@"HIDE_YOU_TAB");
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CREATE_SWITCH(hideYouTab, toggleHideYouTab, @"kHideYouTab");
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [theTableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
	    UINavigationController *startupPageOptionsControllerView = [[UINavigationController alloc] initWithRootViewController:[[StartupPageOptionsController alloc] init]];
            [startupPageOptionsControllerView setModalPresentationStyle:UIModalPresentationFullScreen];

            [self presentViewController:startupPageOptionsControllerView animated:YES completion:nil];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

@implementation TabBarOptionsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleHideTabBarLabels:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideTabBarLabels", sender);
}

- (void)toggleHideExploreTab:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideExploreTab", sender);
}

- (void)toggleHideShortsTab:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideShortsTab", sender);
}

- (void)toggleHideUploadTab:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideUploadTab", sender);
}

- (void)toggleHideSubscriptionsTab:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideSubscriptionsTab", sender);
}

- (void)toggleHideYouTab:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideYouTab", sender);
}

@end
