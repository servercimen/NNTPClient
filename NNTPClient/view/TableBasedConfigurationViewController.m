//
//  TableBasedConfigurationViewController.m
//  NNTPClient
//
//  Created by Server Cimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import "TableBasedConfigurationViewController.h"
#import "SSLConnection.h"
#import "MessageViewController.h"


@implementation TableBasedConfigurationViewController

@synthesize textViews;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    [textViews release];
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
    self.textViews = [NSMutableDictionary dictionary];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.textViews = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < 2) {
        return 2;
    } 
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return @"Host configuration";
    } else if(section == 1) {
        return @"User credentials";
    }
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;

        
        if(indexPath.section < 2) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
            textField.adjustsFontSizeToFitWidth = YES;
            textField.textColor = [UIColor blackColor];
            
            textField.backgroundColor = [UIColor whiteColor];
            textField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
            textField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
            textField.textAlignment = UITextAlignmentLeft;
            textField.tag = 1;
            
            textField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
            textField.delegate = self;
            [textField setEnabled: YES];
            
            [cell addSubview:textField];
            
            [textField release];
            textField.returnKeyType = UIReturnKeyNext;
            if(indexPath.section == 0) {
                if(indexPath.row == 0) {
                    textField.text = @"news.ceng.metu.edu.tr";
                } else if(indexPath.row == 1) {
                    textField.text = @"563";
                    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                }
            } else if(indexPath.section == 1) {
                if(indexPath.row == 0) {
                    textField.text = @"e1560697";
                } else if(indexPath.row == 1) {
                    textField.text = @"";
                    textField.secureTextEntry = YES;
                    textField.returnKeyType = UIReturnKeyDone;
                }
            }
            [textViews setObject:textField forKey:[self keyFromIndexPath:indexPath]];
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }

    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            cell.textLabel.text = @"Host";
        } else if(indexPath.row == 1) {
            cell.textLabel.text = @"Port";
        }
    } else if(indexPath.section == 1) {
        if(indexPath.row == 0) {
            cell.textLabel.text = @"Username";
        } else if(indexPath.row == 1) {
            cell.textLabel.text = @"Password";
        }
    } else if(indexPath.section == 2) {
        if(indexPath.row == 0) {
            cell.textLabel.text = @"Connect";
        }
    }
    
    
    return cell;
}

- (NSString *) keyFromIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"%dX%d", indexPath.section, indexPath.row];
}

- (NSIndexPath *) indexPathFromKey:(NSString *)key
{
    NSUInteger section;
    NSUInteger row;
    NSArray *comps = [key componentsSeparatedByString:@"X"];
    section = [[comps objectAtIndex:0] intValue];
    row = [[comps objectAtIndex:1] intValue];
    return [NSIndexPath indexPathForRow:row inSection:section];
}

- (void)hideKeyboard
{    
    for (NSString *key in self.textViews) {
        UITextField *textView = [self.textViews objectForKey:key];
        if ([textView isFirstResponder]) {
            [textView resignFirstResponder];
        }
    }
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
    NSString *key = [[textViews allKeysForObject:textField] objectAtIndex:0];
    NSIndexPath *indexPath = [self indexPathFromKey:key];
    NSUInteger row = indexPath.row + 1;
    NSUInteger section = indexPath.section;
    
    if(row >= [self tableView:(UITableView *)self.view numberOfRowsInSection:section]) {
        section++;
        row = 0;
    }
    
    if(section >= [self numberOfSectionsInTableView:(UITableView *)self.view]) {
        return nil;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    return [textViews objectForKey:[self keyFromIndexPath:nextIndexPath]];
}

- (void)onConnect {
    [self hideKeyboard];
    
    UITextField *hostnameField = [self.textViews objectForKey:@"0X0"];
    UITextField *portField = [self.textViews objectForKey:@"0X1"];
    UITextField *usernameField = [self.textViews objectForKey:@"1X0"];
    UITextField *passwordField = [self.textViews objectForKey:@"1X1"];
    NSString *hostname = hostnameField.text;
    NSString *port = portField.text;
    SSLConnection *conn = [SSLConnection sslConnectionWithHostname:hostname andPort:port];
    [conn connect];
    if([conn isConnected]) {
        MessageViewController *messageView = [[[MessageViewController alloc] init] autorelease];
        messageView.conn = conn;
        [conn write:[NSString stringWithFormat:@"authinfo user %@", usernameField.text]];
        [conn write:[NSString stringWithFormat:@"authinfo pass %@", passwordField.text]];
        [self.navigationController pushViewController:messageView animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2 && indexPath.row == 0) {
        [self onConnect];
    }
}

@end
