//
//  NewsGroupViewController.h
//  NNTPClient
//
//  Created by Server Cimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSLConnection;

@interface NewsGroupViewController : UITableViewController {
    NSArray *newsGroupData;
    SSLConnection *conn;
}

@property(nonatomic, retain) NSArray *newsGroupData;
@property(nonatomic, retain) SSLConnection *conn;

- (id) initWithNewsGroupData:(NSArray *)data andSSLConnection:(SSLConnection *)connection;

@end
