	//
//  SSLConnection.m
//  NNTPClient
//
//  Created by Server Cimen on 7/23/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import "SSLConnection.h"
#import "openssl_c_wrapper.h"

@implementation SSLConnection

@synthesize hostname;
@synthesize port;

- (id)init {
    self = [super init];
    if (self) {
        c = NULL;
    }
    return self;
}

+(id) sslConnectionWithHostname:(NSString *)hostname andPort:(NSString *)port
{
    SSLConnection *sslConn = [[[SSLConnection alloc] init] autorelease];
    sslConn.hostname = hostname;
    sslConn.port = port;
    
    return sslConn;
}

-(void) connectWithBlock:(void(^)(BOOL result))block
{
    int portNum = [self.port intValue];
    const char *hostnameCStr = [self.hostname UTF8String];
    c = sslConnect(hostnameCStr, portNum);
    if([self isConnected]) {
        block(YES);
    } else {
        block(NO);
    }
}

-(void) disconnect
{
    sslDisconnect(c);
    c = NULL;
}

-(NSString *) read
{
    char *data = sslRead(c);
    if(data != NULL) {
        NSString *newChunk = [NSString stringWithUTF8String:data];
        NSLog(@"\nRead data: \"%@\"%d\n", newChunk, [newChunk length]);
        free(data);
        data = NULL;
        return newChunk;
    }else{
        NSLog(@"\nCan not read data\n");
        return nil;
    }
}

-(NSString *)readUntilMessageArrives
{
    NSString *readData = [self read];
    while(!readData && [self isConnected])
    {
        readData = [self read];
        sleep(100);
    }
    return readData;
}

-(void) write:(NSString *)data
{
    data = [data stringByAppendingString:@"\n"];
    const char *dataCStr = [data UTF8String];
    sslWrite(c, dataCStr);
    NSLog(@"\nWrite data: %@\n", data);
}

-(BOOL) isConnected {
    if(sslIsConnected(c) == 1) {
        return YES;
    }
    
    return NO;
}

- (void)dealloc {
    [hostname release];
    [port release];
    if(c != NULL) {
        [self disconnect];
    }
    
    [super dealloc];
}

@end
