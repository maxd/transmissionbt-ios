#import "RpcClientContext.h"
#import "Settings.h"
#import "Torrent.h"
#import "RpcClientContextDelegate.h"
#define RPC_URL_TEMPLATE @"http://%@:%@@%@:%d/transmission/rpc"

@implementation RpcClientContext {
    NSMutableDictionary *_torrents;
    NSURL *rpcUrl;
}

@synthesize currentOperation;

@synthesize rpcUrl;
@synthesize updateInterval;
@synthesize sessionId;
@synthesize delegate;


- (id)init {
    self = [super init];

    if (self) {
        rpcUrl = [[NSURL alloc] initWithString:[NSString stringWithFormat:RPC_URL_TEMPLATE, [Settings rpcServerLogin], [Settings rpcServerPassword], [Settings rpcServerName], [Settings rpcServerPort]]];
        updateInterval = 5; //TODO: 5 seconds is default update interval, move to settings
        _torrents = [NSMutableDictionary new];
    }

    return self;
}

- (NSDictionary *)torrents {
    return _torrents;
}

- (void)addTorrents:(NSArray *)newTorrents {
    for (Torrent *newTorrent in newTorrents) {
        [_torrents setObject:newTorrent forKey:[NSNumber numberWithInt:newTorrent.id]];
    }

    [delegate torrentsChanged:_torrents];
}

- (void)removeTorrents:(NSArray *)removedTorrents {
    for (Torrent *removedTorrent in removedTorrents) {
        [_torrents removeObjectForKey:[NSNumber numberWithInt:removedTorrent.id]];
    }

    [delegate torrentsChanged:_torrents];
}

@end