#import "TorrentsTableController.h"
#import "Torrent.h"
#import "RpcClientContext.h"
#import "TorrentCell.h"


@implementation TorrentsTableController {
    RpcClientContext *rpcClientContext;
    NSArray *torrents;
    UINib *cellLoader;
}

static NSString *cellIdentifier = @"TorrentCell";

- (id)initController:(RpcClientContext *)context {
    self = [super init];
    
    if (self) {
        rpcClientContext = context;

        cellLoader = [UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]];

        [self reloadData];
    }

    return self;
}

- (void)reloadData {
    torrents = [[rpcClientContext.torrents allValues] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Torrent *torrent1 = obj1;
        Torrent *torrent2 = obj2;
        return [torrent1.name compare:torrent2.name];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [torrents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Torrent *torrent = [torrents objectAtIndex:(NSUInteger) indexPath.row];

    TorrentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[cellLoader instantiateWithOwner:self options:nil] objectAtIndex:0];
    }
    [cell torrent:torrent];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

@end