#import <UIKit/UIKit.h>
#import "RpcClientContextDelegate.h"

@class RpcClient;

@interface TorrentsController : UIViewController <RpcClientContextDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tblTorrents;

- (id)initTorrentsController:(RpcClient *)rpcClient;

@end
