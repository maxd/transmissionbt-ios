#import "Settings.h"

@implementation Settings

static NSUserDefaults* userDefaults = nil;

+ (void)initialize {
    [super initialize];

    userDefaults = [NSUserDefaults standardUserDefaults];
}

+ (NSString *)rpcServerName {
#ifdef DEBUG
    return @"192.168.1.100";
#else
    return [userDefaults stringForKey:@"rpc_server_name"];
#endif
}

+ (int)rpcServerPort {
#ifdef DEBUG
    return 9091;
#else
    return [userDefaults integerForKey:@"rpc_server_port"];
#endif
}

+ (NSString *)rpcServerLogin {
#ifdef DEBUG
    return @"transmission";
#else
    return [userDefaults stringForKey:@"rpc_server_login"];
#endif
}

+ (NSString *)rpcServerPassword {
#ifdef DEBUG
    return @"transmission";
#else
    return [userDefaults stringForKey:@"rpc_server_password"];
#endif
}

@end
