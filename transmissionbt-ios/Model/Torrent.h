#import <Foundation/Foundation.h>
#import "TorrentEnums.h"

@interface Torrent : NSObject

@property (nonatomic) NSUInteger id;
@property (nonatomic) tr_torrent_activity status;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSUInteger totalSize;
@property (nonatomic) tr_stat_errtype error;
@property (nonatomic, strong) NSString *errorString;
@property (nonatomic) NSInteger eta;
@property (nonatomic) float percentDone;

@property (nonatomic, strong) NSArray *files;

@end