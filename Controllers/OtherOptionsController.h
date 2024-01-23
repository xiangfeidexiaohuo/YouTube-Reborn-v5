#import "UIKit/UIKit.h"

@interface OtherOptionsController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, copy) NSString *customAppVersion;
@property (nonatomic, strong) UITextField *versionTextField;
@end
