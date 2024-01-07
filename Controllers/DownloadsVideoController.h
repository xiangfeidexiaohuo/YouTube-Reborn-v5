#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <UIKit/UIKit.h>

@interface DownloadsVideoController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, AVPlayerViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end
