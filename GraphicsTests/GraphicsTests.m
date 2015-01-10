//
//  GraphicsTests.m
//  GraphicsTests
//
//  Created by myuon on 2015/01/04.
//  Copyright (c) 2015年 yasu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UIView+Defaults.h"

@interface GraphicsTests : XCTestCase

@end

@implementation GraphicsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testDefaultValues {
    SEL selector = @selector(defaultAnimationDuration);
    NSLog(@"%@: %zf", NSStringFromSelector(selector), [UIView defaultAnimationDuration]);

    selector = @selector(defaultFastAnimationDuration);
    NSLog(@"%@: %zf", NSStringFromSelector(selector), [UIView defaultFastAnimationDuration]);

    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
