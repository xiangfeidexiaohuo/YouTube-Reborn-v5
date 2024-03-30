#import "UIKit/UIKit.h"

@interface RebornSettingsController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@end

// snackbar (RebornSettingsController)
@interface YTHUDMessage : NSObject
+ (id)messageWithText:(id)text;
- (void)setAction:(id)action;
@end

@interface GOOHUDMessageAction : NSObject
- (void)setTitle:(NSString *)title;
- (void)setHandler:(void (^)(id))handler;
@end

@interface GOOHUDManagerInternal : NSObject
- (void)showMessageMainThread:(id)message;
+ (id)sharedInstance;
@end
