#import <Foundation/Foundation.h>

@class Torrent;


@interface RpcClientMapper : NSObject

+ (NSArray *)torrentFields;

+ (void)jsonNode:(NSDictionary *)torrentNode toTorrent:(Torrent *)torrent;

@end