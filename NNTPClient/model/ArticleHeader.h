//
//  ArticleHeader.h
//  NNTPClient
//
//  Created by cihancimen on 7/25/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ArticleHeader : NSObject {
 
    
    NSString *path;
    NSString *from;
    NSString *fromName;
    NSString *newsgroup;
    NSString *subject;
    NSDate *date;
    NSString *messageID;
    NSArray *references;
    NSString *postingHost;
    NSDate *postingDate;
    NSString *xref;
    
}

@property(nonatomic, retain) NSString *path;
@property(nonatomic, retain) NSString *from;
@property(nonatomic, retain) NSString *fromName;
@property(nonatomic, retain) NSString *newsgroup;
@property(nonatomic, retain) NSString *subject;
@property(nonatomic, retain) NSDate *date;
@property(nonatomic, retain) NSString *messageID;
@property(nonatomic, retain) NSArray *references;
@property(nonatomic, retain) NSString *postingHost;
@property(nonatomic, retain) NSDate *postingDate;
@property(nonatomic, retain) NSString *xref;


@end
