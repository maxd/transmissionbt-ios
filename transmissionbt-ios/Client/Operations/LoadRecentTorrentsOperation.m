#import <SBJson/SBJson.h>
#import "LoadRecentTorrentsOperation.h"
#import "RpcClientContext.h"
#import "Torrent.h"
#import "RpcClientMapper.h"

@interface LoadRecentTorrentsOperation () <NSURLConnectionDataDelegate>

- (NSData *)rpcCommand;

@end

@implementation LoadRecentTorrentsOperation {
    NSURLConnection *connection;
    NSMutableData *responseData;

    NSTimer *timer;
}

- (void)execute {
    timer = [NSTimer scheduledTimerWithTimeInterval:context.updateInterval target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
}

- (void)cancel {
    [timer invalidate];

    [connection cancel];
}

- (void)timerHandler:(id)timerHandler {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[context rpcUrl]];
    [request setHTTPMethod:@"POST"];
    [request addValue:context.sessionId forHTTPHeaderField:@"X-Transmission-Session-Id"];
    [request setHTTPBody:[self rpcCommand]];

    responseData = nil;
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (NSData *)rpcCommand {
    NSDictionary *arguments = [NSDictionary dictionaryWithObjectsAndKeys:[RpcClientMapper torrentFields], @"fields", @"recently-active", @"ids", nil];
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

    NSArray *removedTorrentsNode = [argumentsNode objectForKey:@"removed"];
    [context removeTorrents:removedTorrentsNode];

    [self handlerSuccess];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self handleFail:error];
}


@end