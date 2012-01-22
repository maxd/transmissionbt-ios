#import <UIKit/UIKit.h>
#import "RpcClientDelegate.h"

@class RpcClient;

@interface TorrentsController : UIViewController <RpcClientDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tblTorrents;

- (id)initTorrentsController:(RpcClient *)rpcClient;

@end
