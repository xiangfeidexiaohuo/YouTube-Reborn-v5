#import "UIKit/UIKit.h"

@interface OtherOptionsController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, copy) NSString *customAppVersion;
@end
