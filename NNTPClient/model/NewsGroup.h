//
//  NewsGroup.h
//  NNTPClient
//
//  Created by cihancimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NewsGroup : NSObject {

    
    //Description of the newsgroup
    NSString *title;
    //Name of the newsgroup
    NSString *name;
    //high water mark for the group
    NSDecimalNumber *high;
    //low water mark for the group
    NSDecimalNumber *low;
    //status of group
    NSString *status;
    
    
    
    
}
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSDecimalNumber *high;
@property(nonatomic, retain) NSDecimalNumber *low;
@property(nonatomic, retain) NSString *status;

-(id) initWithName: (NSString *)name andHigh:(NSDecimalNumber *)high andLow:(NSDecimalNumber *)low andStatus:(NSString *)status;
//logical group name
-(NSString *) getGroupID;
-(NSString *) getGroupName;
@end
