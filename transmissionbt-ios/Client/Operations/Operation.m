#import "Operation.h"
#import "FailOperation.h"
#import "RpcClientContext.h"


@implementation Operation {
    NSMutableArray *failOperations;
}

@synthesize successOperation;

- (id)initOperation:(RpcClientContext *)ctx {
    self = [super init];
    if (self) {
        context = ctx;
        failOperations = [NSMutableArray new];
    }

    return self;
}

- (void)execute {
}

- (void)cancel {
}

- (NSArray *)failOperations {
    return [failOperations copy];
}

- (void)addFailOperation:(Operation *)operation {
    [failOperations addObject:operation];
}

- (void)removeFailOperation:(Operation *)operation {
    [failOperations removeObject:operation];
}

- (void)handlerSuccess {
    context.currentOperation = successOperation;
    [successOperation execute];
}

- (void)handleFail:(NSError *)error {
    for (FailOperation *failOperation in failOperations) {
        if ([failOperation handleError:error operationsContext:context])
            break;
    }
}

@end