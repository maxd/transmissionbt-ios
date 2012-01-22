#import <Foundation/Foundation.h>

@class RpcClientContext;
@protocol RpcClientDelegate;

@interface RpcClient : NSObject

- (id)initClient:(RpcClientContext *)context;

- (void)start;
- (void)stop;

@property (nonatomic, unsafe_unretained) id<RpcClientDelegate> delegate;
@property (nonatomic, strong, readonly) RpcClientContext *rpcClientContext;

@end