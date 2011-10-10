//
//  Article.m
//  NNTPClient
//
//  Created by cihancimen on 10/4/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import "Article.h"

@implementation Article

@synthesize body;
@synthesize header;

- (id)initWithBody: (NSString *) body andWithHeader: (ArticleHeader *)header
{
    self = [super init];
    if (self) {
        self.body = body;
        self.header = header;
    }
    
    return self;
}

@end
