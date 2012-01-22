#import <Foundation/Foundation.h>

@class RpcClient;
@class RpcClientContext;


@interface TorrentsTableController : NSObject<UITableViewDataSource>

- (id)initController:(RpcClientContext *)context;

- (void)reloadData;

@end