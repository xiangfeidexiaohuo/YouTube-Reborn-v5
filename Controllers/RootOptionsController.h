#import "UIKit/UIKit.h"

@interface RootOptionsController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) UITableView* tableView;
@end
