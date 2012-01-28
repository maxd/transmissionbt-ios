#import "TorrentCell.h"

@implementation TorrentCell

- (void)torrentName:(NSString *)torrentName {
    torrentNameLabel.text = torrentName;
}

@end
