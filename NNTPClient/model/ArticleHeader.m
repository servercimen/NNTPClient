//
//  ArticleHeader.m
//  NNTPClient
//
//  Created by cihancimen on 7/25/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import "ArticleHeader.h"


@implementation ArticleHeader

@synthesize headerFieldMapping;
@synthesize path;
@synthesize sender;
@synthesize from;
@synthesize newsgroup;
@synthesize subject;
@synthesize date;
@synthesize messageID;
@synthesize references;
@synthesize replyTo;
@synthesize postingHost;
@synthesize postingDate;
@synthesize xref;
@synthesize cowUser;

-(id) init{
    if (self = [super init]) {
        headerFieldMapping = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"path", @"Path", 
                              @"sender", @"Sender", 
                              @"from", @"From", 
                              @"newsgroup", @"Newsgroups", 
                              @"subject", @"Subject",     
                              @"date", @"Date", 
                              @"messageID", @"Message-ID", 
                              @"references", @"References", 
                              @"replyTo", @"In-Reply-To", 
                              @"postingHost", @"NNTP-Posting-Host", 
                              @"postingDate", @"NNTP-Posting-Date", 
                              @"xref", @"Xref", 
                              @"cowUser", @"CowUser", 
                              nil];

    }
    return self;
}
- (void) setHeader:(NSString *)header withValue:(id)value {
    NSString *field = [headerFieldMapping objectForKey:header];
    object_setInstanceVariable(self, [field UTF8String], [value retain]);
}

- (void) dealloc
{
    [headerFieldMapping release];
    [path release];
    [sender release];
    [from release];
    [newsgroup release];
    [subject release];
    [date release];
    [messageID release];
    [references release];
    [replyTo release];
    [postingHost release];
    [postingDate release];
    [xref  release];
    [cowUser release];
    [super dealloc];
}
@end
