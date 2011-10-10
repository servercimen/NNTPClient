//
//  ArticleHeader.h
//  NNTPClient
//
//  Created by cihancimen on 7/25/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ArticleHeader : NSObject {
 
    NSDictionary *headerFieldMapping;
    NSString *path;
    NSString *sender;
    NSString *from;
    NSString *newsgroup;
    NSString *subject;
    NSDate *date;
    NSString *messageID;
    NSArray *references;
    NSString *replyTo;
    NSString *postingHost;
    NSDate *postingDate;
    NSString *xref;
    NSString *cowUser;
    
}

@property(nonatomic, readonly) NSDictionary *headerFieldMapping;
@property(nonatomic, retain) NSString *path;
@property(nonatomic, retain) NSString *sender;
@property(nonatomic, retain) NSString *from;
@property(nonatomic, retain) NSString *newsgroup;
@property(nonatomic, retain) NSString *subject;
@property(nonatomic, retain) NSDate *date;
@property(nonatomic, retain) NSString *messageID;
@property(nonatomic, retain) NSArray *references;
@property(nonatomic, retain) NSString *replyTo;
@property(nonatomic, retain) NSString *postingHost;
@property(nonatomic, retain) NSDate *postingDate;
@property(nonatomic, retain) NSString *xref;
@property(nonatomic, retain) NSString *cowUser;

- (void) setHeader:(NSString *)header withValue:(id) value;
    


@end
