#import "TorrentCell.h"
#import "Torrent.h"

@implementation TorrentCell

- (void)torrent:(Torrent *)torrent {
    lblTorrentName.text = torrent.name;

    double torrentSizeInMegabytes = torrent.totalSize / (1024.0 * 1024.0);
    lblSizeInfoLine.text = [NSString stringWithFormat:@"%.2f Mb", torrentSizeInMegabytes];

    ctlProgress.progress = torrent.percentDone;

    switch (torrent.error) {
        case TR_STAT_OK:
            [ctlProgress setProgressTintColor:[UIColor darkGrayColor]];
            [lblStatusLine setTextColor:[UIColor whiteColor]];
            [lblStatusLine setText:@""];
            break;
        case TR_STAT_TRACKER_WARNING:
            [ctlProgress setProgressTintColor:[UIColor yellowColor]];
            [lblStatusLine setTextColor:[UIColor yellowColor]];
            [lblStatusLine setText:torrent.errorString];
            break;
        case TR_STAT_TRACKER_ERROR:
        case TR_STAT_LOCAL_ERROR:
            [ctlProgress setProgressTintColor:[UIColor redColor]];
            [lblStatusLine setTextColor:[UIColor redColor]];
            [lblStatusLine setText:torrent.errorString];
            break;
    }
}

@end
