#import "ColourOptionsController4.h"
#import "Localization.h"

@interface ColourOptionsController4 ()
- (void)coloursView;
@end

@implementation ColourOptionsController4

- (void)loadView {
	[super loadView];
    [self coloursView];

    self.title = LOC(@"COLOR_OPTIONS_4");
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = doneButton;

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:LOC(@"SAVE_TEXT") style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;

    self.supportsAlpha = NO;
    NSData *progressbarColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"kYTProgreessBarColourOption"];
    NSKeyedUnarchiver *progressbarUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:progressbarColorData error:nil];
    [progressbarUnarchiver setRequiresSecureCoding:NO];
    UIColor *color = [progressbarUnarchiver decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    self.selectedColor = color;
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
}

@end

@implementation ColourOptionsController4(Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    NSData *progressbarColorData = [NSKeyedArchiver archivedDataWithRootObject:self.selectedColor requiringSecureCoding:nil error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:progressbarColorData forKey:@"kYTProgreessBarColourOption"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    UIAlertController *alertSaved = [UIAlertController alertControllerWithTitle:LOC(@"COLOR_SAVED") message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertSaved addAction:[UIAlertAction actionWithTitle:LOC(@"OKAY_TEXT") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];

    [self presentViewController:alertSaved animated:YES completion:nil];
}

@end
