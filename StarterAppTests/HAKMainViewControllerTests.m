//
//  HAKMainViewControllerTests.m
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
#import "HAKMainViewController.h"
#import "HAKRegistrationViewController.h"
#import "HAKLoginViewController.h"
#import "HAKSuccessViewController.h"


@interface HAKMainViewController()
@property (strong,nonatomic) HAKLoginViewController *loginViewController;
@property (strong,nonatomic) HAKRegistrationViewController *registrationViewController;
@property (strong,nonatomic) HAKSuccessViewController *successViewController;
@end


@interface HAKMainViewControllerTests : XCTestCase

@end

@implementation HAKMainViewControllerTests

- (void)setUp{
    [super setUp];
    
}

- (void)tearDown{
    
    [super tearDown];
}

-(void)testSharedInstanceOnlyEverMakesOneMainViewController{
    HAKMainViewController *controller1 = [HAKMainViewController sharedInstance];
    HAKMainViewController *controller2 = [HAKMainViewController sharedInstance];
    XCTAssertEqualObjects(controller1, controller2, @"The sharedInstance method should not make more than one instance");
    
    controller1 = nil;
    controller2 = nil;
    controller1 = [HAKMainViewController sharedInstance];
    XCTAssertEqualObjects(controller1, [HAKMainViewController sharedInstance], @"The sharedInstance method should not make more than one instance");
}

-(void)testAnimateToRegistrationViewGoesToRegistrationView{
    HAKMainViewController *mainView = [HAKMainViewController sharedInstance];
    [mainView animateToRegistrationView];
    XCTAssertNotNil([mainView.registrationViewController.view superview], @"The Registration View should be added when animating to it");
}
-(void)testAnimateToLoginViewGoesToLoginView{
    HAKMainViewController *mainView = [HAKMainViewController sharedInstance];
    [mainView animateToLoginView];
    XCTAssertNotNil([mainView.loginViewController.view superview], @"The Registration View should be added when animating to it");
}
-(void)testAnimateToSuccessViewGoesToSuccessView{
    HAKMainViewController *mainView = [HAKMainViewController sharedInstance];
    [mainView animateToSuccessViewFromView:mainView.registrationViewController.view];
    XCTAssertNotNil([mainView.successViewController.view superview], @"The Registration View should be added when animating to it");
}






@end
