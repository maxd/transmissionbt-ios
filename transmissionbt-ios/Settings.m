#import "Settings.h"

@implementation Settings

static NSUserDefaults* userDefaults = nil;

+ (void)initialize {
    [super initialize];

    userDefaults = [NSUserDefaults standardUserDefaults];
}

+ (NSString *)rpcServerName {
    return [userDefaults stringForKey:@"rpc_server_name"];
}

+ (int)rpcServerPort {
    return [userDefaults integerForKey:@"rpc_server_port"];
}

+ (NSString *)rpcServerLogin {
    return [userDefaults stringForKey:@"rpc_server_login"];
}

+ (NSString *)rpcServerPassword {
    return [userDefaults stringForKey:@"rpc_server_password"];
}

@end
