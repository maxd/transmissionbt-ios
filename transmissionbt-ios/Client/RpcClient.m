#import "RpcClient.h"
#import "OpenSessionOperation.h"
#import "RpcClientContext.h"
#import "LoadAllTorrentsOperation.h"
#import "LoadRecentTorrentsOperation.h"
#import "RpcClientDelegate.h"

@implementation RpcClient {
    RpcClientContext *rpcClientContext;
}

@synthesize delegate;
@synthesize rpcClientContext;

- (id)initClient:(RpcClientContext *)context {
    self = [super init];
    if (self) {
        rpcClientContext = context;

        OpenSessionOperation *openSessionOperation = [[OpenSessionOperation alloc] initOperation:rpcClientContext];
        LoadAllTorrentsOperation *loadAllTorrentsOperation = [[LoadAllTorrentsOperation alloc] initOperation:rpcClientContext];
        LoadRecentTorrentsOperation *loadRecentTorrentsOperation = [[LoadRecentTorrentsOperation alloc] initOperation:rpcClientContext];

        rpcClientContext.currentOperation = openSessionOperation;

        openSessionOperation.successOperation = loadAllTorrentsOperation;
        loadAllTorrentsOperation.successOperation = loadRecentTorrentsOperation;

        [rpcClientContext addObserver:self forKeyPath:@"torrents" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    }

    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [delegate torrentsChanged:rpcClientContext.torrents];
}

- (void)start {
    [rpcClientContext.currentOperation execute];
}

- (void)stop {
    [rpcClientContext.currentOperation cancel];
}

@end