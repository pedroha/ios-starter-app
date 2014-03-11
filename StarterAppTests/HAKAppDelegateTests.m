//
//  HAKAppDelegateTests.m
//  StarterApp
//
/*
 The MIT License (MIT)
 
 Copyright (c) 2014 The Hackerati, Inc.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
