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
@property HAKMainViewController *mainVC;
@end

@implementation HAKMainViewControllerTests

- (void)setUp{
    [super setUp];
    self.mainVC = [HAKMainViewController sharedInstance];
    self.mainVC.loginViewController = [[HAKLoginViewController alloc] initWithNib];
    [self.mainVC.view addSubview:self.mainVC.loginViewController.view];
    self.mainVC.registrationViewController = nil;
    self.mainVC.successViewController = nil;
}

- (void)tearDown{
    self.mainVC = nil;
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
    [self.mainVC animateToRegistrationView];
    XCTAssertNotNil([self.mainVC.registrationViewController.view superview], @"The Registration View should be added when animating to it");
}
-(void)testAnimateToLoginViewGoesToLoginView{
    [self.mainVC animateToLoginView];
    XCTAssertNotNil([self.mainVC.loginViewController.view superview], @"The Registration View should be added when animating to it");
}
-(void)testAnimateToSuccessViewGoesToSuccessView{
    [self.mainVC animateToSuccessViewFromView:self.mainVC.registrationViewController.view];
    XCTAssertNotNil([self.mainVC.successViewController.view superview], @"The Registration View should be added when animating to it");
}
-(void)testAnimateLogout{
    self.mainVC.successViewController = [[HAKSuccessViewController alloc] initWithNibName:@"SuccessView" bundle:nil];
    [self.mainVC.view addSubview:self.mainVC.successViewController.view];
    [self.mainVC.loginViewController.view removeFromSuperview];
    [self.mainVC animateLogout];
    XCTAssertNotNil(self.mainVC.loginViewController, @"The login view controller should not be nil");
    XCTAssertNotNil([self.mainVC.loginViewController.view superview], @"The view should be added");
}





@end
