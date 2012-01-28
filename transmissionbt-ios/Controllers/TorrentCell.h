#import <UIKit/UIKit.h>

@class Torrent;

@interface TorrentCell : UITableViewCell {
    IBOutlet UILabel*lblTorrentName;
    IBOutlet UILabel*lblSizeInfoLine;
    IBOutlet UIProgressView *ctlProgress;
    IBOutlet UILabel*lblStatusLine;
}

- (void)torrent:(Torrent *)torrent;

@end
