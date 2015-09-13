//
//  JSONResponse.h
//  NumberTrivial
//
//  Created by Sherpa on 13/9/15.
//  Copyright (c) 2015 manuelainc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONResponse : NSObject

@property (nonatomic, strong) NSString *text;  //The text of the fact
@property (nonatomic) BOOL isFound; //If fact is find
@property (nonatomic, strong) NSNumber *number; //number of the fact
@property (nonatomic, strong) NSString *type; //type of the fact
@property (nonatomic, strong) NSString *date; //A day of year associated with some year facts, as a string.
@property (nonatomic, strong) NSString *year; //A year associated with some date facts, as a string.


@end
