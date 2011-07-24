//
//  NewsGroupViewController.h
//  NNTPClient
//
//  Created by Server Cimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSLConnection;
@class NewsGroup;

@interface NewsGroupViewController : UITableViewController {
    NSMutableDictionary *newsGroupData;
    SSLConnection *conn;
}

@property(nonatomic, retain) NSMutableDictionary *newsGroupData;
@property(nonatomic, retain) SSLConnection *conn;

- (id) initWithNewsGroupData:(NSMutableDictionary *)data andSSLConnection:(SSLConnection *)connection;
- (NSArray *) getNewsGroupAtIndex:(NSInteger)index;
- (NewsGroup *) getNewsGroupAtIndexPath:(NSIndexPath *)indexPath;
@end
