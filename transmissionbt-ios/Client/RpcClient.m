#import "RpcClient.h"
#import "OpenSessionOperation.h"
#import "RpcClientContext.h"
#import "LoadAllTorrentsOperation.h"
#import "LoadRecentTorrentsOperation.h"

@implementation RpcClient {
    RpcClientContext *rpcClientContext;
}

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
    }

    return self;
}

- (void)start {
    [rpcClientContext.currentOperation execute];
}

- (void)stop {
    [rpcClientContext.currentOperation cancel];
}

@end