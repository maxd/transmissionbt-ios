#import <Foundation/Foundation.h>


@interface StopWatch : NSObject {
    NSString* name;
    NSTimeInterval runTime;
    NSDate* startDate;
}

@property (nonatomic, strong) NSString* name;
@property (nonatomic, readonly) NSTimeInterval runTime;

- (id)initWithName:(NSString *)name;

- (void)start;
- (void)stop;
- (void)statistics;

@end