//
//  SingleGroupViewController.h
//  NNTPClient
//
//  Created by cihancimen on 10/4/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSLConnection.h"

@interface SingleGroupViewController : UITableViewController{
    NSArray *mailHeaders;
    SSLConnection *conn;
}

@property (nonatomic, retain) NSArray *mailHeaders;
@property (nonatomic, retain) SSLConnection *conn;

- (id) initWithMailHeaders:(NSArray *)headers andSSLConnection:(SSLConnection *)connection;

@end
