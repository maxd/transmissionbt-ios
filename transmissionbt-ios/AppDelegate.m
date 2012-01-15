#import "AppDelegate.h"

#import "TorrentsController.h"
#import "SettingsController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize torrentsController = _torrentsController;
@synthesize settingsController = _settingsController;
@synthesize tabBarController = _tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.torrentsController = [[TorrentsController alloc] initWithNibName:@"TorrentsController" bundle:nil];
    self.settingsController = [[SettingsController alloc] initWithNibName:@"SettingsController" bundle:nil];

    self.tabBarController = [UITabBarController new];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.torrentsController, self.settingsController, nil];

    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
