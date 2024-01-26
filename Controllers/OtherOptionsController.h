#import "UIKit/UIKit.h"

@interface OtherOptionsController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *versionTextField;
@property (nonatomic, strong) NSString *customAppVersion;
@end
