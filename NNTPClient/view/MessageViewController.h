//
//  MessageViewController.h
//  NNTPClient
//
//  Created by Server Cimen on 7/23/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSLConnection.h"

@interface MessageViewController : UIViewController <UITextFieldDelegate> {
    SSLConnection *conn;
    UITextField *messageField;
    UITextView *responseField;
}

@property(nonatomic, retain) SSLConnection *conn;
@property (nonatomic, retain) IBOutlet UITextField *messageField;
@property (nonatomic, retain) IBOutlet UITextView *responseField;
- (IBAction)sendMessage;
- (IBAction)clearResponseField;
- (void) readMessage:(NSObject *) obj;
@end
