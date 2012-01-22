#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FailOperation : NSObject

- (bool)handleError:(NSError *)error operationsContext:(id)operationContext;

@end