//
//  NewsGroupParser.m
//  NNTPClient
//
//  Created by cihancimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import "NewsGroupParser.h"
#import "SSLConnection.h"
#import "NewsGroup.h"

@implementation NewsGroupParser

+(NSMutableDictionary *)retrieveNewsGroups:(SSLConnection *)conn{
    [conn write:@"list active"];
    NSString *newsgroupsResponse =  [conn readUntilMessageArrives];
    NSArray *lines = [newsgroupsResponse componentsSeparatedByString:@"\n"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    for(NSString *line in lines)
    {
        if(![line hasPrefix:@"\x0f"] && ![line hasPrefix:@"."]){
            NSLog(@"Decided to process: %@", line);
            NSArray *lineElements = [line componentsSeparatedByString:@" "];
            if([lineElements count] == 4){
                NewsGroup *newsgroup = [[NewsGroup alloc] initWithName:[lineElements objectAtIndex:0] andHigh:[f numberFromString:[lineElements objectAtIndex:1]] andLow:[f numberFromString:[lineElements objectAtIndex:2]] andStatus:[lineElements objectAtIndex:3]];
                [dict setValue:newsgroup forKey:[newsgroup name]];
            }
        }
        // do something with lineElements
    }
    return dict;
}

@end
