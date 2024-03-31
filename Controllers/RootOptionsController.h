#import "UIKit/UIKit.h"
#import <YouTubeHeader/YTHUDMessage.h>
#import <YouTubeHeader/GOOHUDManagerInternal.h>

@interface RootOptionsController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *allItems;
@property (nonatomic, strong) NSArray *filteredItems;
@property (nonatomic, assign) BOOL isSearching;
@end
