#import "SettingsController.h"

@implementation SettingsController

- (id)init {
    self = [super init];

    if (self) {
        self.title = NSLocalizedString(@"Settings", @"Tab bar item title");
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar-settings.png"];
    }

    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end
