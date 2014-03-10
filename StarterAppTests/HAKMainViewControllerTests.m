//
//  HAKMainViewControllerTests.m
//  StarterApp
//
//  Created by Grace on 3/10/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

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
