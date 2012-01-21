#import <Foundation/Foundation.h>

@interface Settings : NSObject

+ (NSString *)rpcServerName;
+ (int)rpcServerPort;
+ (NSString *)rpcServerLogin;
+ (NSString *)rpcServerPassword;

@end
