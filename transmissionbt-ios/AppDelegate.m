#import "AppDelegate.h"

#import "TorrentsController.h"
#import "SettingsController.h"
#import "RpcClient.h"
#import "RpcClientContext.h"

@interface AppDelegate ()

- (void)initMainWindow;
- (void)initRpcClient;

@end

@implementation AppDelegate {
    RpcClientContext *rpcClientContext;
    RpcClient *rpcClient;
}

@synthesize window = _window;
@synthesize torrentsController = _torrentsController;
@synthesize settingsController = _settingsController;
@synthesize tabBarController = _tabBarController;

#pragma region - Singleton method

+ (AppDelegate *)shared {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

#pragma region - Application events

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initRpcClient];
    [self initMainWindow];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [rpcClient start];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [rpcClient stop];
}

#pragma region - Init methods

- (void)initMainWindow {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.torrentsController = [[TorrentsController alloc] initTorrentsController:rpcClient];
    self.settingsController = [SettingsController new];

    self.tabBarController = [UITabBarController new];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.torrentsController, self.settingsController, nil];

    self.window.rootViewController = self.tabBarController;
}

- (void)initRpcClient {
    rpcClientContext = [RpcClientContext new];
    rpcClient = [[RpcClient alloc] initClient:rpcClientContext];
}

@end
