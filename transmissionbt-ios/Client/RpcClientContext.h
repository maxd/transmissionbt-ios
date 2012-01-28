#import <Foundation/Foundation.h>

@class Operation;
@class Torrent;
@protocol RpcClientContextDelegate;


@interface RpcClientContext : NSObject

@property(nonatomic, strong) Operation* currentOperation;

@property (nonatomic) int updateInterval;
@property (nonatomic, strong, readonly) NSURL *rpcUrl;

@property (nonatomic, strong) NSString *sessionId;

@property (nonatomic, unsafe_unretained) id<RpcClientContextDelegate> delegate;

- (NSDictionary *)torrents;

- (void)addTorrents:(NSArray *)newTorrents;
- (void)removeTorrents:(NSArray *)removedTorrents;

@end