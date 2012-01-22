#import "TorrentsTableController.h"
#import "Torrent.h"
#import "RpcClientContext.h"


@implementation TorrentsTableController {
    RpcClientContext *rpcClientContext;
    NSArray *torrents;
}

- (id)initController:(RpcClientContext *)context {
    self = [super init];
    
    if (self) {
        rpcClientContext = context;
        [self reloadData];
    }

    return self;
}

- (void)reloadData {
    torrents = [[rpcClientContext.torrents allObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Torrent *torrent1 = obj1;
        Torrent *torrent2 = obj2;
        return [torrent1.name compare:torrent2.name];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [torrents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TorrentCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    Torrent *torrent = [torrents objectAtIndex:(NSUInteger) indexPath.row];

    cell.textLabel.text = torrent.name;

    return cell;
}


@end