//
//  MyClass.m
//  NNTPClient
//
//  Created by cihancimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import "SSLAuth.h"


@implementation SSLAuth

@synthesize conn;

-(id) initWithConnection:(SSLConnection *)connection
{
    self  = [super init];
    if(self)
    {
        self.conn = connection;
    }
    return self;
}
-(BOOL) authenticateWithUsername:(NSString *)username andPassword:(NSString *)password
{
    NSString * userMessage = [NSString stringWithFormat:@"AUTHINFO USER %@", username];
    [conn write:userMessage];
    NSString * userResponse = [conn readUntilMessageArrives];
    if(![userResponse hasPrefix:@"381"])
    {
        return NO;
    }
    
    NSString * passwordMessage = [NSString stringWithFormat:@"AUTHINFO PASS %@", password];
    [conn write:passwordMessage];
    NSString * passwordResponse = [conn readUntilMessageArrives];
    if([passwordResponse hasPrefix:@"281"])
    {
        return YES;
    }else
    {
        return NO;
    }

}

@end