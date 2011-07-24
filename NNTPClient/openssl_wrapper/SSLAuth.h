//
//  SSLAuth.h
//  NNTPClient
//
//  Created by cihancimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSLConnection.h"

@interface SSLAuth: NSObject {
    SSLConnection *conn;
}

@property(nonatomic, retain) SSLConnection *conn;

-(id) initWithConnection: (SSLConnection * )connection;
-(BOOL) authenticateWithUsername: (NSString *)username andPassword: (NSString *) password;
@end
