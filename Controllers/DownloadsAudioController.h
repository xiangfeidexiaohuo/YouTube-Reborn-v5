#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DownloadsAudioController : UIViewController <UITableViewDelegate, UITableViewDataSource, AVPlayerViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end
