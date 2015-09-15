//
//  NumbersApiCommunicator.h
//  NumberTrivial
//
//  Created by Sherpa on 13/9/15.
//  Copyright (c) 2015 manuelainc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumbersApiCommunicator : NSObject



- (NSDictionary *)getDictionaryWithParameter:(NSString*)parameter withCategory:(NSString*)category isRandom:(BOOL)random;

- (NSString *)stringCreatorWithParameterValue:(NSString*)parameter
                withCategory:(NSString*)category
                    isRandom:(BOOL)random;

@end
