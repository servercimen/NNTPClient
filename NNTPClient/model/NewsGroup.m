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


-(id) initWithName:(NSString *)name andHigh:(NSDecimalNumber *)high andLow:(NSDecimalNumber *)low andStatus:(NSString *)status
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

-(NSString *) getGroupID {
    NSArray *parts = [name componentsSeparatedByString:@"."];
    if([parts count] > 3){
        return [name substringToIndex:[name rangeOfString:@"." options:NSBackwardsSearch].location];
    }else{
         NSUInteger start= [name rangeOfString:@"." options:NSBackwardsSearch].location;
        if(start != NSNotFound)
        {
            return [name substringFromIndex: start  + 1];
        }else{
            return name;
        }
    }
}

-(NSString *) getGroupName {
    NSArray *parts = [name componentsSeparatedByString:@"."];
    if([parts count] > 3){	
        return [parts objectAtIndex:2];
    }else{
        return @"other";
    }
}

- (void)dealloc {
    [title release];
    [name release];
    [status release];
    [super dealloc];
}
@end
