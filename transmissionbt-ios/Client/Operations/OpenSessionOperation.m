#import <SBJson/SBJson.h>
#import "OpenSessionOperation.h"
#import "RpcClientContext.h"


@interface OpenSessionOperation () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

- (NSData *)rpcCommand;

@end

@implementation OpenSessionOperation {
    NSURLConnection *connection;
}

- (void)execute {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[context rpcUrl]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[self rpcCommand]];

    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)cancel {
    [connection cancel];
}

- (NSData *)rpcCommand {
    NSDictionary *command = [NSDictionary dictionaryWithObjectsAndKeys:@"session-get", @"method", nil];
    return [[command JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;

    context.sessionId = [httpResponse.allHeaderFields valueForKey:@"X-Transmission-Session-Id"];

    [self handlerSuccess];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self handleFail:error];
}

@end