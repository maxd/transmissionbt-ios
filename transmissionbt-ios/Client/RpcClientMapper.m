#import "RpcClientMapper.h"
#import "Torrent.h"


@implementation RpcClientMapper {
}

+ (NSArray *)torrentFields {
    static NSArray *torrentFields = nil;
    if (torrentFields == nil) {
        torrentFields = [NSArray arrayWithObjects:@"id", @"status", @"name", @"totalSize", @"error", @"errorString", @"eta", @"leftUntilDone", nil];
    }
    return torrentFields;
}

+ (void)jsonNode:(NSDictionary *)torrentNode toTorrent:(Torrent *)torrent {
    torrent.id = [[torrentNode objectForKey:@"id"] unsignedIntegerValue];
    torrent.status = (tr_torrent_activity) [[torrentNode objectForKey:@"status"] unsignedIntegerValue];
    torrent.name = [torrentNode valueForKey:@"name"];
    torrent.totalSize = [[torrentNode valueForKey:@"totalSize"] unsignedIntegerValue];
    torrent.error = (tr_stat_errtype) [[torrentNode objectForKey:@"error"] unsignedIntegerValue];
    torrent.errorString = [torrentNode objectForKey:@"errorString"];
    torrent.eta = [[torrentNode objectForKey:@"eta"] integerValue];
    torrent.percentDone = [[torrentNode objectForKey:@"percentDone"] doubleValue];
}

@end