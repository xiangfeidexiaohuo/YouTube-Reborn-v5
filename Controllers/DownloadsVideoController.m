#import "DownloadsVideoController.h"
#import <Photos/Photos.h>

@interface DownloadsVideoController ()
{
    NSString *documentsDirectory;
    NSMutableArray *filePathsVideoArray;
    NSMutableArray *filePathsVideoArtworkArray;
}
- (void)coloursView;
- (void)setupVideoArrays;
@end

@implementation DownloadsVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self coloursView];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:@"VideoDownloadsTableViewCell"];
    
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [filePathsVideoArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"VideoDownloadsCollectionViewCell";
    VideoDownloadsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    VideoFile *videoFile = [FileManager.defaultManager getVideoFileAtIndex:indexPath.item];
    [cell configureWithVideoFile:videoFile];

    UIImageView *thumbnailImageView = [cell viewWithTag:100];
    UILabel *titleLabel = [cell viewWithTag:200];
    
    NSString *videoFilePath = filePathsVideoArray[indexPath.item];
    NSString *artworkFilePath = filePathsVideoArtworkArray[indexPath.item];
    
    thumbnailImageView.image = [UIImage imageNamed:artworkFilePath];
    titleLabel.text = [[videoFilePath lastPathComponent] stringByDeletingPathExtension];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoFile *videoFile = [FileManager.defaultManager getVideoFileAtIndex:indexPath.item];
    [self playVideoWithFile:videoFile];
}

    if (cell == nil) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor blackColor];
        }
        else {
            cell.backgroundColor = [UIColor colorWithRed:0.110 green:0.110 blue:0.118 alpha:1.0];
            cell.textLabel.textColor = [UIColor whiteColor];
	    cell.textLabel.shadowColor = [UIColor blackColor];
            cell.textLabel.shadowOffset = CGSizeMake(1.0, 1.0);
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
    }
    cell.textLabel.text = [filePathsVideoArray objectAtIndex:indexPath.row];
    @try {
        NSString *artworkFileName = filePathsVideoArtworkArray[indexPath.item];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [documentsDirectory stringByAppendingPathComponent:artworkFileName]]];
    }
    @catch (NSException *exception) {
    }
return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSString *currentFileName = filePathsVideoArray[indexPath.item];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:currentFileName];
    
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:filePath]];
    playerViewController.allowsPictureInPicturePlayback = NO;
    if (@available(iOS 14.2, *)) {
        playerViewController.canStartPictureInPictureAutomaticallyFromInline = NO;
    }
    [playerViewController.player play];

    [self presentViewController:playerViewController animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *currentVideoFileName = filePathsVideoArray[indexPath.item];
    NSString *currentArtworkFileName = filePathsVideoArtworkArray[indexPath.item];

    UIAlertController *alertMenu = [UIAlertController alertControllerWithTitle:@"Options" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertMenu addAction:[UIAlertAction actionWithTitle:@"Import Video To Camera Roll" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            NSURL *fileURL = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:currentVideoFileName]];
            [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:fileURL];
        } completionHandler:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice" message:@"Video Saved To Camera Roll" preferredStyle:UIAlertControllerStyleAlert];
                                        
                    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }]];

                    [self presentViewController:alert animated:YES completion:nil];
                } else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice" message:@"Save To Camera Roll Failed \nMake Sure To Give Camera Roll Permission To YouTube In The iOS Settings App" preferredStyle:UIAlertControllerStyleAlert];
                                        
                    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }]];

                    [self presentViewController:alert animated:YES completion:nil];
                }
            });
        }];
    }]];

    [alertMenu addAction:[UIAlertAction actionWithTitle:@"Delete Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSFileManager defaultManager] removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:currentVideoFileName] error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:currentArtworkFileName] error:nil];

        UIAlertController *alertDeleted = [UIAlertController alertControllerWithTitle:@"Notice" message:@"Video Successfully Deleted" preferredStyle:UIAlertControllerStyleAlert];

        [alertDeleted addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [filePathsVideoArray removeAllObjects];
            [filePathsVideoArtworkArray removeAllObjects];
            [self setupVideoArrays];
            [self.tableView reloadData];
        }]];

        [self presentViewController:alertDeleted animated:YES completion:nil];
    }]];

    [alertMenu addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];

    [self presentViewController:alertMenu animated:YES completion:nil];
}

- (void)setupVideoArrays {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];

    NSArray *filePathsList = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectory error:nil];
    filePathsVideoArray = [[NSMutableArray alloc] init];
    filePathsVideoArtworkArray = [[NSMutableArray alloc] init];
    for (id object in filePathsList) {
        if ([[object pathExtension] isEqualToString:@"mp4"]){
            [filePathsVideoArray addObject:object];
            NSString *cut = [object substringToIndex:[object length]-4];
            NSString *jpg = [NSString stringWithFormat:@"%@.jpg", cut];
            [filePathsVideoArtworkArray addObject:jpg];
        }
    }
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
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

@end
