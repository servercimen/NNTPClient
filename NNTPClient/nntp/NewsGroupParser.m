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
#import "ArticleHeader.h"

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
    return [NewsGroupParser retrieveHeaders:conn andNewsGroup:newsgroup andLimit:[NSDecimalNumber numberWithInt:10]];
}
+(NSArray *) retrieveHeaders:(SSLConnection *)conn andNewsGroup:(NewsGroup *)newsgroup andLimit:(NSDecimalNumber *)limit{
    NSMutableArray *headers = [NSMutableArray array];
    NSDecimalNumber *start = newsgroup.high;
    NSDecimalNumber *end = newsgroup.low;
    if([start decimalNumberBySubtracting:end] > limit){
        end = [start decimalNumberBySubtracting:limit];
    }

    [conn write:[NSString stringWithFormat:@"GROUP %@", newsgroup.name]];
    [conn readUntilMessageArrives];
    int i = [start intValue];
    i--;
    while(i > [end intValue]) {
        ArticleHeader * header = [NewsGroupParser retrieveArticleHeader:conn andArticle:i];
        if (header) {
            [headers addObject:header];
        }
        i--;
    }
    return headers;
    
}

+(ArticleHeader *) retrieveArticleHeader: (SSLConnection *)conn andArticle:(int)articleID{
    [conn write:[NSString stringWithFormat:@"HEAD %d", articleID]];
    NSString *headResponse = [conn readUntilMessageArrives];
    if ([headResponse hasPrefix:@"423"]) {
        return nil;
    } else if ([headResponse length] == 0){
        return nil;
    } else {
        while ([[headResponse componentsSeparatedByString:@"\n"] count] <= 2) {
            headResponse = [headResponse  stringByAppendingString:[conn readUntilMessageArrives]];
        }
    }
    NSArray *lines = [headResponse componentsSeparatedByString:@"\n"];
    ArticleHeader *header = [[[ArticleHeader alloc] init] autorelease];
    bool valid = false;
    for(NSString *line in lines)
    {
        if(![line hasPrefix:@"\x0f"] && ![line hasPrefix:@"."]){
            for (NSString *fieldKey in [header.headerFieldMapping allKeys] ) {
                if ([line hasPrefix:fieldKey]) {
                    NSArray *parts = [line componentsSeparatedByString:[fieldKey stringByAppendingString:@":"]];
                    id value = [parts objectAtIndex:1];
                    
                    if ([fieldKey isEqualToString:@"References"]) {
                        value = [[parts objectAtIndex:1] componentsSeparatedByString:@" "];
                    }
                    
                    [header setHeader:fieldKey withValue:value];
                    valid = true;
                } else {
                }
            }

        }
    }
    if (valid){
        return header;
    } else {
        return nil;
    }
}

+(NSString *) retrieveArticleBody: (SSLConnection *)conn andArticle:(int) articleID {
    [conn write:[NSString stringWithFormat:@"BODY %d", articleID]];
    NSString *headResponse = [conn readUntilMessageArrives];
}

@end
