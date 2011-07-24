//
//  NewsGroupParser.h
//  NNTPClient
//
//  Created by cihancimen on 7/24/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSLConnection.h"

@interface NewsGroupParser : NSObject {
    
}

+(NSMutableDictionary *) retrieveNewsGroups: (SSLConnection *)conn;

@end
