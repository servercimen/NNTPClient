//
//  NewsGroup.h
//  NNTPClient
//
//  Created by cihancimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NewsGroup : NSObject {

    //Name of the newsgroup
    NSString *name;
    //high water mark for the group
    NSNumber *high;
    //low water mark for the group
    NSNumber *low;
    //status of group
    NSString *status;
    
    
    
    
}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSNumber *high;
@property(nonatomic, retain) NSNumber *low;
@property(nonatomic, retain) NSString *status;

-(id) initWithName: (NSString *)name andHigh:(NSNumber *)high andLow:(NSNumber *)low andStatus:(NSString *)status;

@end
