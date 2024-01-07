#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <UIKit/UIKit.h>

@interface DownloadsVideoController : UIViewController <UITableViewDelegate, UITableViewDataSource, AVPlayerViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end
