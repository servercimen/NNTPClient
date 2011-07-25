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
    
    //get newsgroup items;
    [conn write:@"list active"];
    NSString *newsgroupsResponse =  [conn readUntilMessageArrives];
    NSArray *lines = [newsgroupsResponse componentsSeparatedByString:@"\n"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSNumberFormatter * f = [[[NSNumberFormatter alloc] init] autorelease];
    [f setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [f setGeneratesDecimalNumbers:YES];
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
    }
    
    
    //get newsgroup descriptions
    [conn write:@"list newsgroups"];
    newsgroupsResponse =  [conn readUntilMessageArrives];
    lines = [newsgroupsResponse componentsSeparatedByString:@"\n"];
    for(NSString *line in lines)
    {
        if(![line hasPrefix:@"\x0f"] && ![line hasPrefix:@"."]){
            NSLog(@"Decided to process: %@", line);
            NSArray *lineElements = [line componentsSeparatedByString:@"\t"];
            //TODO: fix
            if([dict objectForKey:[lineElements objectAtIndex:0]] != nil){
                ((NewsGroup *)[dict objectForKey:[lineElements objectAtIndex:0]]).title =  [lineElements lastObject];
            }
        }
    }
    
    NSMutableDictionary *groupedNewsGroups = [NSMutableDictionary dictionary];
    for (NSString* key in dict) {
        NewsGroup *news = [dict objectForKey:key];
        
        NSString *groupId = [news
                             getGroupID];
        NSMutableArray *group = [groupedNewsGroups objectForKey:groupId];
        [group sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NewsGroup *news1 = obj1;
            NewsGroup *news2 = obj2;
            
            return [news1.name compare:news2.name];
        }];
        if(group == nil) {
            group = [NSMutableArray array];
        }
        
        [group addObject:news];
        [groupedNewsGroups setObject:group forKey:groupId];
    }
    
    
    return groupedNewsGroups;
}

+(NSArray *) retrieveHeaders:(SSLConnection *)conn andNewsGroup:(NewsGroup *)newsgroup{
    return [NewsGroupParser retrieveHeaders:conn andNewsGroup:newsgroup andLimit:[NSNumber numberWithInt:10]];
}
+(NSArray *) retrieveHeaders:(SSLConnection *)conn andNewsGroup:(NewsGroup *)newsgroup andLimit:(NSNumber *)limit{
    NSArray *headers = [NSArray array];
    NSDecimal *start = newsgroup.high;
    NSDecimal *end = newsgroup.low;
    return nil;
    
}

@end
