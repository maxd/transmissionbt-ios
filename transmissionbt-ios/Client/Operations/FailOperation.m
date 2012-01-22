#import "FailOperation.h"


@implementation FailOperation {

}

- (bool)handleError:(NSError *)error operationsContext:(id)operationContext {
    return NO;
}

@end