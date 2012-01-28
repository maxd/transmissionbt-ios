#import <Foundation/Foundation.h>

@class RpcClientContext;
@protocol RpcClientContextDelegate;

@interface RpcClient : NSObject

- (id)initClient:(RpcClientContext *)context;

- (void)start;
- (void)stop;

@property (nonatomic, strong, readonly) RpcClientContext *rpcClientContext;

@end