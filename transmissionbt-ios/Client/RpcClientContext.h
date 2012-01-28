#import <Foundation/Foundation.h>

@class Operation;
@class Torrent;


@interface RpcClientContext : NSObject

@property(nonatomic, strong) Operation* currentOperation;

@property (nonatomic) int updateInterval;
@property (nonatomic, strong, readonly) NSURL *rpcUrl;

@property (nonatomic, strong) NSString *sessionId;

- (NSSet *)torrents;

- (void)addTorrents:(NSSet *)torrents;
- (void)removeTorrents:(NSSet *)torrents;

@end