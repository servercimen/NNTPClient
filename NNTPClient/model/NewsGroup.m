//
//  NewsGroup.m
//  NNTPClient
//
//  Created by cihancimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import "NewsGroup.h"


@implementation NewsGroup

@synthesize title;
@synthesize name;
@synthesize high;
@synthesize low;
@synthesize status;


-(id) initWithName:(NSString *)name andHigh:(NSNumber *)high andLow:(NSNumber *)low andStatus:(NSString *)status
{
    self = [super init];
    if(self)
    {
        self.name = name;
        self.high = high;
        self.low = low;
        self.status = status;
    }
    return self;
}

- (void)dealloc {
    [title release];
    [name release];
    [high release];
    [low release];
    [status release];
    [super dealloc];
}
@end
