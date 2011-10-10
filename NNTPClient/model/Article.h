//
//  Article.h
//  NNTPClient
//
//  Created by cihancimen on 10/4/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleHeader.h"

@interface Article : NSObject {
    NSString *body;
    ArticleHeader *header;
}

@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) ArticleHeader *header;
- (id)initWithBody: (NSString *) body andWithHeader: (ArticleHeader *)header;

@end
