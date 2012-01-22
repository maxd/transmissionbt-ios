#import <Foundation/Foundation.h>

@class RpcClientContext;


@interface Operation : NSObject {
@protected
    RpcClientContext *context;
}

- (id)initOperation:(RpcClientContext *)context;

- (void)execute;
- (void)cancel;

- (NSArray *)failOperations;
- (void)addFailOperation:(Operation *)operation;
- (void)removeFailOperation:(Operation *)operation;

- (void)handlerSuccess;
- (void)handleFail:(NSError *)error;

@property (nonatomic, strong) Operation *successOperation;

@end