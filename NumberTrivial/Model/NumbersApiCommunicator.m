//
//  NumbersApiCommunicator.m
//  NumberTrivial
//
//  Created by Sherpa on 13/9/15.
//  Copyright (c) 2015 manuelainc. All rights reserved.
//

#import "NumbersApiCommunicator.h"

@interface NumbersApiCommunicator ()
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *constant;
@property (nonatomic) BOOL isRandom;
@end


@implementation NumbersApiCommunicator

- (id)init{
    
    if (self = [super init]) {
        _urlString = @"http://numbersapi.com";
        _constant = @"json";
    }
    
    return  self;
}

- (NSData *)getDataFromUrl:(NSString *)urlString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    
    NSURLResponse *response;
    NSError *error;
    NSData *urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if (error) {
        NSLog(@"ERROR: %@",error);
    }
    
    return urlData;
}

- (NSString *)stringCreatorWithParameterValue:(NSString*)parameter
                      withCategory:(NSString*)category
                          isRandom:(BOOL)random  {
  
    if (random) {
        parameter = @"random";
    }
    
    NSString *urlResult = [NSString stringWithFormat:@"%@/%@/%@?%@", _urlString, parameter, category, _constant];
    
    return urlResult;
    
}

- (NSDictionary *)getDictionaryWithParameter:(NSString*)parameter withCategory:(NSString*)category isRandom:(BOOL)random{
    
    NSString *urlCall = [self stringCreatorWithParameterValue:parameter withCategory:category isRandom:random];
    NSLog(@"urlCall %@", urlCall );
    
    NSData *data = [self getDataFromUrl:urlCall];
    
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return dictionary;
    
}



@end
