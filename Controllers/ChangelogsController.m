#import "ChangelogsController.h"

@interface ChangelogsController ()
@end

@implementation ChangelogsController

- (void)loadView {
	[super loadView];
    
    self.rebornChangelogsWebView = [[WKWebView alloc] initWithFrame:self.view.frame];  
    [self.rebornChangelogsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://lillieh001.github.io/changelogs/youtuberebornv4.html"]]];
    self.rebornChangelogsWebView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.rebornChangelogsWebView];
}

@end