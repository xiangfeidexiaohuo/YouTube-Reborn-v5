#import "UIKit/UIKit.h"
#define SETUP_SECTION(text, imageName, color) cell.textLabel.text = LOC(text); cell.imageView.image = [UIImage systemImageNamed:imageName]; cell.imageView.tintColor = cell.textLabel.textColor = color;

@interface RootOptionsController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *allItems;
@property (nonatomic, strong) NSArray *filteredItems;
@property (nonatomic, assign) BOOL isSearching;
@end
