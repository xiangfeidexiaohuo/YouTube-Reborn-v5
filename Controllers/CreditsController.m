#import "CreditsController.h"
#import "Localization.h"

@interface CreditsController ()
- (void)coloursView;
@end

@implementation CreditsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self coloursView];

    self.title = LOC(@"CREDITS_BUTTON");

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 5;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CreditsTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Lillie";
                cell.detailTextLabel.text = LOC(@"DEVELOPER_TEXT");
//              cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [profileImageView sd_setImageWithURL:[NSURL URLWithString:@"https://avatars.githubusercontent.com/u/91358136?v=4"]
                placeholderImage:[UIImage imageNamed:@"ytrebornbuttonwhite"]
                cell.imageView.image = profileImageView.image;
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Alpha_Stream";
                cell.detailTextLabel.text = LOC(@"ICON_DESIGNER_TEXT");
//              cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [profileImageView sd_setImageWithURL:[NSURL URLWithString:@""]
                placeholderImage:[UIImage imageNamed:@"ytrebornbuttonwhite"]
                cell.imageView.image = profileImageView.image;
            }
            if (indexPath.row == 1) {
                cell.textLabel.text = @"kirb";
                cell.detailTextLabel.text = @"Development Support";
//              cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [profileImageView sd_setImageWithURL:[NSURL URLWithString:@"https://avatars.githubusercontent.com/u/773309?v=4"]
                placeholderImage:[UIImage imageNamed:@"ytrebornbuttonwhite"]
                cell.imageView.image = profileImageView.image;
            }
            if (indexPath.row == 2) {
                cell.textLabel.text = @"Dayanch96";
                cell.detailTextLabel.text = @"Features: \"YouTube Reborn v5 Menu\", \"Red Progress Bar\", \"Gray Buffer Progress\" \"Stick Navigation Bar\", \"Disable Double tap to skip\""
                cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [profileImageView sd_setImageWithURL:[NSURL URLWithString:@"https://avatars.githubusercontent.com/u/38832025?v=4"]
                placeholderImage:[UIImage imageNamed:@"ytrebornbuttonwhite"]
                cell.imageView.image = profileImageView.image;
            }
            if (indexPath.row == 3) {
                cell.textLabel.text = @"PoomSmart";
                cell.detailTextLabel.text = @"Features: \"YouTube Reborn Button under Video Player\", \"YouTube-X/Adblock\", \"AutoPlay In Fullscreen\"";
                cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [profileImageView sd_setImageWithURL:[NSURL URLWithString:@"https://avatars.githubusercontent.com/u/3608783?v=4"]
                placeholderImage:[UIImage imageNamed:@"ytrebornbuttonwhite"]
                cell.imageView.image = profileImageView.image;
            }
            if (indexPath.row == 4) {
                cell.textLabel.text = @"NguyenASang";
                cell.detailTextLabel.text = @"Features: \"YouTube Reborn Button under Video Player\"";
    //          cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [profileImageView sd_setImageWithURL:[NSURL URLWithString:@"https://avatars.githubusercontent.com/u/87893636?v=4"]
                placeholderImage:[UIImage imageNamed:@"ytrebornbuttonwhite"]
                cell.imageView.image = profileImageView.image;
            }
            if (indexPath.row == 5) {
                cell.textLabel.text = @"Snoolie";
                cell.detailTextLabel.text = @"Features: \"Enable Extra Video Speed\"";
    //          cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [profileImageView sd_setImageWithURL:[NSURL URLWithString:@""]
                placeholderImage:[UIImage imageNamed:@"ytrebornbuttonwhite"]
                cell.imageView.image = profileImageView.image;
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [theTableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/LillieH1000"] options:@{} completionHandler:nil];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/Kutarin_"] options:@{} completionHandler:nil];
        }
        if (indexPath.row == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Dayanch96"] options:@{} completionHandler:nil];
        }
        if (indexPath.row == 2) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/kirb"] options:@{} completionHandler:nil];
        }
        if (indexPath.row == 3) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/PoomSmart"] options:@{} completionHandler:nil];
        }
        if (indexPath.row == 4) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/0xilis"] options:@{} completionHandler:nil];
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
}

@end

@implementation CreditsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
