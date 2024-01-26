#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <UIKit/UIKit.h>

@interface DownloadsAllController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate, AVPlayerViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *allItems;
@property (nonatomic, strong) NSArray *filteredItems;
@property (nonatomic, assign) BOOL isSearching;
@end