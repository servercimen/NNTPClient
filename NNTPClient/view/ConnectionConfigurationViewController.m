//
//  ConnectionConfigurationViewController.m
//  NNTPClient
//
//  Created by Server Cimen on 7/23/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import "ConnectionConfigurationViewController.h"
#import "SSLConnection.h"
#import "MessageViewController.h"


@implementation ConnectionConfigurationViewController
@synthesize hostnameField;
@synthesize portField;
@synthesize usernameField;
@synthesize passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [hostnameField release];
    [portField release];
    [usernameField release];
    [passwordField release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setHostnameField:nil];
    [self setPortField:nil];
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onConnect {
    NSString *hostname = hostnameField.text;
    NSString *port = portField.text;
    SSLConnection *conn = [SSLConnection sslConnectionWithHostname:hostname andPort:port];
    [conn connect];

    if([conn isConnected]) {
        MessageViewController *messageView = [[[MessageViewController alloc] init] autorelease];
        messageView.conn = conn;
        [conn write:[NSString stringWithFormat:@"authinfo user %@", self.usernameField.text]];
        [conn write:[NSString stringWithFormat:@"authinfo pass %@", self.passwordField.text]];
        [self.navigationController pushViewController:messageView animated:YES];
        [messageView readMessage:nil];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    NSArray *textViews = [NSArray arrayWithObjects:hostnameField, portField, usernameField, passwordField, nil];
    for (UIView *textView in textViews) {
        if ([textView isFirstResponder] && [touch view] != textView) {
            [textView resignFirstResponder];
        }
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    UITextField *nextField = [self getNextTextField:textField];

    if(nextField == nil)
    {

        [self onConnect];
    }
    else
    {
        [nextField becomeFirstResponder];
    }
    
    return YES;
}

- (UITextField *) getNextTextField:(UITextField *)textField
{
    if (textField == hostnameField)
    {
        return portField;
    }
    else if(textField == portField)
    {
        return usernameField;
    }
    else if(textField == usernameField)
    {
        return passwordField;
    }
    
    return nil;
}

@end
