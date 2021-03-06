//
//  MessageViewController.m
//  NNTPClient
//
//  Created by Server Cimen on 7/23/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import "MessageViewController.h"


@implementation MessageViewController

@synthesize conn;
@synthesize messageField;
@synthesize responseField;

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
    [conn release];
    [messageField release];
    [responseField release];
    
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
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] 
                                   initWithTitle: @"Back" 
                                   style:UIBarButtonItemStylePlain 
                                   target:self 
                                   action:@selector(back)] autorelease];
    self.navigationItem.leftBarButtonItem = backButton;
//    [self performSelectorInBackground:@selector(readMessage:) withObject:nil];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setMessageField:nil];
    [self setResponseField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)sendMessage {
    if(![conn isConnected]){
        NSLog(@"Connection is closed");
        [self back];
        return ;
    }
    [messageField resignFirstResponder];
    NSString * message = self.messageField.text;
    [conn write:message];
    [self readMessage:nil];
    
}

- (IBAction)clearResponseField {
    responseField.text = @"";
}

- (void) readMessage:(NSObject *)obj {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    if(![conn isConnected]){
        NSLog(@"Connection is closed");
        return ;
    }
    NSString *readData = [conn read];
    if(readData != nil)
    {
        [self performSelectorOnMainThread:@selector(appendReadData:) withObject:readData waitUntilDone:YES];
        [self performSelectorInBackground:@selector(readMessage:) withObject:nil];
    }
    [pool release];
}

- (void) appendReadData:(NSString *)data
{
    responseField.text = [responseField.text stringByAppendingString:data];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField == messageField)
    {
        [self sendMessage];
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    NSArray *textViews = [NSArray arrayWithObjects:messageField, responseField, nil];
    for (UIView *textView in textViews) {
        if ([textView isFirstResponder] && [touch view] != textView) {
            [textView resignFirstResponder];
        }
    }
    
    [super touchesBegan:touches withEvent:event];
}

@end
