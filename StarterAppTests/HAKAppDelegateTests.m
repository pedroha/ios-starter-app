//
//  HAKAppDelegateTests.m
//  StarterApp
//
//  Created by Grace on 3/10/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HAKAppDelegate.h"
#import "HAKMainViewController.h"

@interface HAKAppDelegateTests : XCTestCase
@property HAKAppDelegate *appDelegate;
@property BOOL didFinishLaunchingWithOptionsReturn;
@end

@implementation HAKAppDelegateTests

- (void)setUp{
    [super setUp];
    self.appDelegate = [[HAKAppDelegate alloc] init];
    self.didFinishLaunchingWithOptionsReturn = [self.appDelegate application: nil didFinishLaunchingWithOptions: nil];
}

- (void)tearDown{
    self.appDelegate = nil;
    self.didFinishLaunchingWithOptionsReturn = NO;
    [super tearDown];
}

- (void)testAppDidFinishLaunchingReturnsYES {
    XCTAssertTrue(self.didFinishLaunchingWithOptionsReturn, @"DidFinishLaunchingWithOptions method should return YES");
}
-(void)testAppDelegateHasWindow{
    XCTAssertNotNil(self.appDelegate.window, @"App delegate should have a window");
}
-(void)testThatTheRootViewControllerIsHAKMainViewController{
    XCTAssertTrue([self.appDelegate.window.rootViewController isKindOfClass:[HAKMainViewController class]], @"HAKMainViewController should be the root view controller");
}



@end
