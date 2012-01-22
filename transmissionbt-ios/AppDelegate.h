#import <UIKit/UIKit.h>

@class TorrentsController;
@class SettingsController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (AppDelegate *)shared;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TorrentsController *torrentsController;
@property (strong, nonatomic) SettingsController *settingsController;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
