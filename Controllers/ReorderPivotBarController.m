#import "ReorderPivotBarController.h"
#import "Localization.h"

@interface ReorderPivotBarController ()
@end

@implementation ReorderPivotBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LOC(@"REORDER_TABS");
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:LOC(@"SAVE_TEXT") style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc] initWithTitle:LOC(@"RESET_TEXT") style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
    self.navigationItem.leftBarButtonItems = @[saveButton, resetButton];
    self.navigationItem.rightBarButtonItem = doneButton;

    UITableViewStyle style;
    if (@available(iOS 13, *)) {
        style = UITableViewStyleInsetGrouped;
    } else {
        style = UITableViewStyleGrouped;
    }

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.tableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.tableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
        [self.tableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor]
    ]];

    NSArray *savedTabOrder = [[NSUserDefaults standardUserDefaults] objectForKey:@"kTabOrder"];
    if (savedTabOrder != nil) {
        self.tabOrder = [NSMutableArray arrayWithObjects:@"Home", @"Shorts", @"Create", @"Subscriptions", @"You", nil];

        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [self.tableView addGestureRecognizer:longPressGesture];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TabBarTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor blackColor];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:0.110 green:0.110 blue:0.118 alpha:1.0];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.shadowColor = [UIColor blackColor];
            cell.textLabel.shadowOffset = CGSizeMake(1.0, 1.0);
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Home";
        } else if (indexPath.row == 1) { 
            cell.textLabel.text = @"Shorts";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Create";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"Subscriptions";
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"You";
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *tabIdentifier = self.tabOrder[sourceIndexPath.row];
    NSMutableArray *reorderedTabs = [NSMutableArray arrayWithArray:self.tabOrder];
    if ([tabIdentifier isEqualToString:@"Home"]) {
        [reorderedTabs replaceObjectAtIndex:sourceIndexPath.row withObject:@"Home"];
    } else if ([tabIdentifier isEqualToString:@"Shorts"]) {
        [reorderedTabs replaceObjectAtIndex:sourceIndexPath.row withObject:@"Shorts"];
    } else if ([tabIdentifier isEqualToString:@"Create"]) {
        [reorderedTabs replaceObjectAtIndex:sourceIndexPath.row withObject:@"Create"];
    } else if ([tabIdentifier isEqualToString:@"Subscriptions"]) {
        [reorderedTabs replaceObjectAtIndex:sourceIndexPath.row withObject:@"Subscriptions"];
    } else if ([tabIdentifier isEqualToString:@"You"]) {
        [reorderedTabs replaceObjectAtIndex:sourceIndexPath.row withObject:@"You"];
    }
    [self setTabOrder:reorderedTabs];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
        if (indexPath && indexPath.section == 0) {
            [self.tableView setEditing:YES animated:YES];
            NSInteger sourceIndex = indexPath.row;
            NSInteger destinationIndex = [self.tableView numberOfRowsInSection:0] - 1;
            NSRange sourceRange = NSMakeRange(sourceIndex, 1);
            NSRange destinationRange = NSMakeRange(destinationIndex, 1);
            [self.tabOrder replaceObjectsInRange:sourceRange withObjectsFromArray:[self.tabOrder subarrayWithRange:destinationRange]];
        }
    }
}

- (void)reset {
    self.tabOrder = [NSMutableArray arrayWithObjects:@"Home", @"Shorts", @"Create", @"Subscriptions", @"You", nil];
    [self.tableView reloadData];
    [self save];
}

- (void)save {
    NSMutableArray *orderedTabs = [NSMutableArray array];
    for (NSIndexPath *indexPath in self.tableView.indexPathsForVisibleRows) {
        if (indexPath.section == 0) {
            NSString *tabIdentifier = @"";
            if (indexPath.row == 0) {
                tabIdentifier = @"Home";
            } else if (indexPath.row == 1) {
                tabIdentifier = @"Shorts";
            } else if (indexPath.row == 2) {
                tabIdentifier = @"Create";
            } else if (indexPath.row == 3) {
                tabIdentifier = @"Subscriptions";
            } else if (indexPath.row == 4) {
                tabIdentifier = @"You";
            }
            [orderedTabs addObject:tabIdentifier];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:orderedTabs forKey:@"kTabOrder"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)done {   
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
