#import <SBJson/SBJson.h>
#import "LoadAllTorrentsOperation.h"
#import "RpcClientContext.h"
#import "Torrent.h"
#import "RpcClientMapper.h"


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
    NSDictionary *arguments = [NSDictionary dictionaryWithObjectsAndKeys:[RpcClientMapper torrentFields], @"fields", nil];
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

    NSMutableArray *torrents = [NSMutableArray new];
    for (NSDictionary *torrentNode in torrentsNode) {
        Torrent *torrent = [Torrent new];

        [RpcClientMapper jsonNode:torrentNode toTorrent:torrent];

        [torrents addObject:torrent];
    }
    [context addTorrents:torrents];

    [self handlerSuccess];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self handleFail:error];
}

@end