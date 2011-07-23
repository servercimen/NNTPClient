//
//  SSLConnection.h
//  NNTPClient
//
//  Created by Server Cimen on 7/23/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "openssl_c_wrapper.h"

@interface SSLConnection : NSObject {
    NSString *hostname;
    NSString *port;
    
    connection *c;
}

@property(nonatomic, retain) NSString *hostname;
@property(nonatomic, retain) NSString *port;

+(id) sslConnectionWithHostname:(NSString *)hostname andPort:(NSString *)port;

-(void) connect;
-(void) disconnect;

@end
