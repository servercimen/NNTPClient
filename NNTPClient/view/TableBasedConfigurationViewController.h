//
//  TableBasedConfigurationViewController.h
//  NNTPClient
//
//  Created by Server Cimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableBasedConfigurationViewController : UITableViewController <UITextFieldDelegate> {
    NSMutableDictionary *textViews;
}

@property (nonatomic, retain) NSMutableDictionary *textViews;

- (NSString *) keyFromIndexPath:(NSIndexPath *)indexPath;
- (UITextField *) getNextTextField:(UITextField *)textField;
- (void)onConnect;

@end
