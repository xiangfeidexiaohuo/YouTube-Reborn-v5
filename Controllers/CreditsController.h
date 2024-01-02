#import <UIKit/UIKit.h>
#import "SDWebImage/SDWebImage/Core/UIImageView+WebCache.h"

@interface CreditsController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@end
