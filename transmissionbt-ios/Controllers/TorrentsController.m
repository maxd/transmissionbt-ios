#import "TorrentsController.h"
#import "TorrentsTableController.h"
#import "RpcClientContext.h"
#import "RpcClient.h"


@implementation TorrentsController {
    RpcClient *rpcClient;
    TorrentsTableController *torrentsTableController;
}

@synthesize tblTorrents;

- (id)initTorrentsController:(RpcClient *)client {
    self = [super init];

    if (self) {
        rpcClient = client;

        self.title = NSLocalizedString(@"Torrents", @"Tab bar item title");
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar-torrents.png"];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    torrentsTableController = [[TorrentsTableController alloc] initController:rpcClient.rpcClientContext];
    tblTorrents.delegate = torrentsTableController;
    tblTorrents.dataSource = torrentsTableController;

    rpcClient.rpcClientContext.delegate = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)torrentsChanged:(NSDictionary *)torrents {
    [torrentsTableController reloadData];
    [tblTorrents reloadData];
}

@end
