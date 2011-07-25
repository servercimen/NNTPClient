//
//  NewsGroupParser.h
//  NNTPClient
//
//  Created by cihancimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSLConnection.h"
#import "NewsGroup.h"
#import "ArticleHeader.h"

@interface NewsGroupParser : NSObject {
    
}

+(NSMutableDictionary *) retrieveNewsGroups: (SSLConnection *)conn;
+(NSArray *) retrieveHeaders:(SSLConnection *)conn andNewsGroup:(NewsGroup *) newsgroup;
+(NSArray *) retrieveHeaders:(SSLConnection *)conn andNewsGroup:(NewsGroup *) newsgroup andLimit:(NSDecimalNumber *)limit;
+(ArticleHeader *) retrieveArticleHeader: (SSLConnection *)conn andArticle:(int) articleID;

@end
