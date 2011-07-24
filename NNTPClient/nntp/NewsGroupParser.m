//
//  NewsGroupParser.m
//  NNTPClient
//
//  Created by cihancimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import "NewsGroupParser.h"
#import "SSLConnection.h"

@implementation NewsGroupParser

+(NSMutableDictionary *)retrieveNewsGroups:(SSLConnection *)conn{
    [conn write:@"list active"];
    NSString *newsgroupsResponse =  [conn readUntilMessageArrives];
    NSArray *lines = [newsgroupsResponse componentsSeparatedByString:@"\n"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for(NSString *line in lines)
    {
        if(![line hasPrefix:@"\x0f"] && ![line hasPrefix:@"."]){
            NSLog(@"Decided to process: %@", line);
            NSArray *lineElements = [line componentsSeparatedByString:@" "];
            if([lineElements count] == 4){
//            NewsGroup *newsgroup = [NewsGroup initWithName:]
//            [dict setValue: forKey:<#(NSString *)#>]
                
                
            }
        }
        // do something with lineElements
    }
    return dict;
}

@end
