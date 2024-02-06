#import "PictureInPictureController.h"

@interface PictureInPictureController ()
- (void)coloursView;
@end

@implementation PictureInPictureController

AVPlayer *rebornPlayer;
AVPlayerLayer *rebornPlayerLayer;
AVPictureInPictureController *rebornPictureInPictureController;
UIButton *stopRebornPictureInPictureButton;
UILabel *rebornPictureInPictureLoadingLabel;

- (void)loadView {
	[super loadView];

    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [self coloursView];

    UIWindow *boundsWindow = [[[UIApplication sharedApplication] windows] firstObject];

    AVPlayerItem *rebornPlayerItem = [[AVPlayerItem alloc] initWithURL:self.videoPath];
    rebornPlayer = [[AVPlayer alloc] initWithPlayerItem:rebornPlayerItem];
    CMTime newTime = CMTimeMakeWithSeconds([self.videoTime floatValue], NSEC_PER_SEC);
    [rebornPlayer seekToTime:newTime];

    [rebornPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
    [rebornPlayer addObserver:self forKeyPath:@"timeControlStatus" options:0 context:nil];

    rebornPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:rebornPlayer];
    rebornPlayerLayer.frame = CGRectMake(0, boundsWindow.safeAreaInsets.top, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    rebornPlayerLayer.hidden = YES;

    [self.view.layer addSublayer:rebornPlayerLayer];

    stopRebornPictureInPictureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stopRebornPictureInPictureButton addTarget:self action:@selector(closePictureInPicture) forControlEvents:UIControlEventTouchUpInside];
    stopRebornPictureInPictureButton.frame = self.view.bounds;
    stopRebornPictureInPictureButton.hidden = YES;
    [stopRebornPictureInPictureButton setTitle:@"Tap To Stop Picture-In-Picture" forState:UIControlStateNormal];
    [self.view addSubview:stopRebornPictureInPictureButton];

    rebornPictureInPictureLoadingLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    rebornPictureInPictureLoadingLabel.text = @"Picture In Picture Is Loading, Please Wait";
    rebornPictureInPictureLoadingLabel.textAlignment = NSTextAlignmentCenter;
    rebornPictureInPictureLoadingLabel.adjustsFontSizeToFitWidth = true;
    [self.view addSubview:rebornPictureInPictureLoadingLabel];
}

- (void)coloursView {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
        self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.969 alpha:1.0];
    }
    else {
        self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self coloursView];
}

@end

@implementation PictureInPictureController (Privates)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == rebornPlayer && [keyPath isEqualToString:@"status"]) {
        if (rebornPlayer.status == AVPlayerStatusReadyToPlay) {
            if ([AVPictureInPictureController isPictureInPictureSupported]) {
                rebornPictureInPictureController = [[AVPictureInPictureController alloc] initWithPlayerLayer:rebornPlayerLayer];
                rebornPictureInPictureController.delegate = self;
                if (@available(iOS 14.2, *)) {
                    rebornPictureInPictureController.canStartPictureInPictureAutomaticallyFromInline = YES;
                }
            }
            [rebornPlayer play];
            rebornPictureInPictureLoadingLabel.hidden = YES;
            stopRebornPictureInPictureButton.hidden = NO;
        }
    } else if (object == rebornPlayer && [keyPath isEqualToString:@"timeControlStatus"]) {
        if (rebornPlayer.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
            if ([AVPictureInPictureController isPictureInPictureSupported]) {
                [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startPictureInPicture:) userInfo:nil repeats:YES];
            }
        }
    }
}

- (void)startPictureInPicture:(NSTimer *)timer {
    if (![rebornPictureInPictureController isPictureInPictureActive]) {
        [timer isValid];
        [rebornPictureInPictureController startPictureInPicture];
    } else if ([rebornPictureInPictureController isPictureInPictureActive]) {
        [timer invalidate];
    }
}

- (void)closePictureInPicture {
    if ([rebornPictureInPictureController isPictureInPictureActive]) {
        [rebornPictureInPictureController stopPictureInPicture];
    }
    [rebornPlayer pause];
    [rebornPlayerLayer removeFromSuperlayer];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
