//
//  ConnectionConfigurationViewController.h
//  NNTPClient
//
//  Created by Server Cimen on 7/23/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConnectionConfigurationViewController : UIViewController {
    
    UITextField *hostnameField;
    UITextField *portField;
    UITextField *usernameField;
    UITextField *passwordField;
}
- (IBAction)onConnect;
@property (nonatomic, retain) IBOutlet UITextField *hostnameField;
@property (nonatomic, retain) IBOutlet UITextField *portField;
@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

@end
