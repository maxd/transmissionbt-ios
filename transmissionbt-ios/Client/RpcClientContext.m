#import "RpcClientContext.h"
#import "Settings.h"
#import "Torrent.h"
#define RPC_URL_TEMPLATE @"http://%@:%@@%@:%d/transmission/rpc"

@implementation RpcClientContext {
    NSMutableSet *_torrents;
    NSURL *rpcUrl;
}

@synthesize currentOperation;

@synthesize rpcUrl;
@synthesize updateInterval;
@synthesize sessionId;


- (id)init {
    self = [super init];

    if (self) {
        rpcUrl = [[NSURL alloc] initWithString:[NSString stringWithFormat:RPC_URL_TEMPLATE, [Settings rpcServerLogin], [Settings rpcServerPassword], [Settings rpcServerName], [Settings rpcServerPort]]];
        updateInterval = 5; //TODO: 5 seconds is default update interval, move to settings
        _torrents = [NSMutableSet new];
    }

    return self;
}

- (NSSet *)torrents {
    return _torrents;
}

- (void)addTorrents:(NSSet *)torrents {
    [_torrents unionSet:torrents];
}

- (void)removeTorrents:(NSSet *)torrents {
    for (Torrent *torrent in torrents) {
        [_torrents removeObject:torrent];
    }
}

- (void)addTorrentsObject:(Torrent *)torrent {
    [_torrents addObject:torrent];
}

- (void)removeTorrentsObject:(Torrent *)torrent {
    [_torrents removeObject:torrent];
}

@end