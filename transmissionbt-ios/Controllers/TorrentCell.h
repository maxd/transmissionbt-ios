#import <UIKit/UIKit.h>

@interface TorrentCell : UITableViewCell {
    IBOutlet UILabel* torrentNameLabel;
}

- (void)torrentName:(NSString *)torrentName;

@end
