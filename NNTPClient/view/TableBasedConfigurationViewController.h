//
//  TableBasedConfigurationViewController.h
//  NNTPClient
//
//  Created by Server Cimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSLConnection;

@interface TableBasedConfigurationViewController : UITableViewController <UITextFieldDelegate> {
    NSMutableDictionary *textViews;
    SSLConnection *conn;
}

@property (nonatomic, retain) NSMutableDictionary *textViews;
@property (nonatomic, retain) SSLConnection *conn;

- (NSString *) keyFromIndexPath:(NSIndexPath *)indexPath;
- (UITextField *) getNextTextField:(UITextField *)textField;
- (void)onConnect;
- (void)hideKeyboard;
- (UITableViewCell *) getConnectCell;

@end
