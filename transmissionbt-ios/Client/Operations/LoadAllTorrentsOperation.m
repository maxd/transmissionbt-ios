#import <SBJson/SBJson.h>
#import "LoadAllTorrentsOperation.h"
#import "RpcClientContext.h"
#import "Torrent.h"


@interface LoadAllTorrentsOperation () <NSURLConnectionDataDelegate>

- (NSData *)rpcCommand;

@end

@implementation LoadAllTorrentsOperation {
    NSURLConnection *connection;
    NSMutableData *responseData;
}

- (void)execute {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[context rpcUrl]];
    [request setHTTPMethod:@"POST"];
    [request addValue:context.sessionId forHTTPHeaderField:@"X-Transmission-Session-Id"];
    [request setHTTPBody:[self rpcCommand]];

    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)cancel {
    [connection cancel];
}

- (NSData *)rpcCommand {
    NSArray *fields = [NSArray arrayWithObjects:@"id", @"status", @"name", @"totalSize", @"error", @"errorString", @"eta", @"leftUntilDone", nil];
    NSDictionary *arguments = [NSDictionary dictionaryWithObjectsAndKeys:fields, @"fields", nil];
    NSDictionary *command = [NSDictionary dictionaryWithObjectsAndKeys:@"torrent-get", @"method", arguments, @"arguments", nil];
    return [[command JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(responseData == nil) {
   		responseData = [[NSMutableData alloc] initWithData:data];
   	} else {
   		[responseData appendData:data];
   	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *content = [[NSString alloc] initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
    NSDictionary *json = [content JSONValue];

    NSDictionary *argumentsNode = [json objectForKey:@"arguments"];
    NSArray *torrentsNode = [argumentsNode objectForKey:@"torrents"];

    NSMutableSet *torrents = [NSMutableSet new];
    for (NSDictionary *torrentNode in torrentsNode) {
        Torrent *torrent = [Torrent new];
        torrent.id = [[torrentNode objectForKey:@"id"] unsignedIntegerValue];
        torrent.status = (tr_torrent_activity) [[torrentNode objectForKey:@"status"] unsignedIntegerValue];
        torrent.name = [torrentNode valueForKey:@"name"];
        torrent.totalSize = [[torrentNode valueForKey:@"totalSize"] unsignedIntegerValue];
        torrent.error = (tr_stat_errtype) [[torrentNode objectForKey:@"error"] unsignedIntegerValue];
        torrent.errorString = [torrentNode objectForKey:@"errorString"];
        torrent.eta = [[torrentNode objectForKey:@"eta"] integerValue];
        torrent.percentDone = [[torrentNode objectForKey:@"percentDone"] doubleValue];

        [torrents addObject:torrent];
    }
    [context addTorrents:torrents];

    [self handlerSuccess];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self handleFail:error];
}

@end