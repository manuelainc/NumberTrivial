//
//  NumbersApiCommunicatorTests.m
//  NumberTrivial
//
//  Created by Sherpa on 14/9/15.
//  Copyright (c) 2015 manuelainc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NumbersApiCommunicator.h"

@interface NumbersApiCommunicatorTests : XCTestCase
@property (nonatomic, strong) NumbersApiCommunicator *api;
@property (nonatomic, strong) NSString *parameter;
@property (nonatomic, strong) NSString *category;
@property (nonatomic) BOOL isRandom;

@end

@implementation NumbersApiCommunicatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _api = [[NumbersApiCommunicator alloc] init];

    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _api = nil;

}

- (void)testUrlConstructor{
    _parameter = @"07/14";
    _category = @"date";
    
    NSString* result = [_api stringCreatorWithParameterValue:_parameter
                                                withCategory:_category
                                                    isRandom:NO];
    
    NSString *expectedString = @"http://numbersapi.com/07/14/date?json";
    
    XCTAssertEqualObjects(result, expectedString, @"El resultado y la api ejemplo deben ser iguales");
    
}

- (void)testRandomUrl{
    
    _parameter = @"";
    _category = @"math";
    
    NSString* result = [_api stringCreatorWithParameterValue:_parameter
                                                withCategory:_category
                                                    isRandom:YES];
    
    NSString *expectedString = @"http://numbersapi.com/random/math?json";
    
    XCTAssertEqualObjects(result, expectedString, @"El resultado y la api ejemplo deben ser iguales");

    
}


@end
