#import "UIKit/UIKit.h"
#import "../YouTubeHeader/YTIPivotBarRenderer.h"

@interface ReorderPivotBarController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) YTIPivotBarController *pivotBarController;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray *tabOrder;
@end
