//
//  HAKLoginViewControllerTests.m
//  StarterApp
//
//  Created by Grace on 3/10/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HAKRegistrationViewController.h"
#import "HAKMockNetwork.h"
#import "HAKNotificationConstants.h"
#import "HAKFakeAlertView.h"
#import "HAKSuccessViewController.h"
#import "HAKMainViewController.h"
#import "HAKLoginViewController.h"



@interface HAKLoginViewController ()
@property (strong,nonatomic) HAKNetwork *network;
@end

@interface HAKMainViewController()
@property (strong,nonatomic) HAKLoginViewController *loginViewController;
@property (strong,nonatomic) HAKRegistrationViewController *registrationViewController;
@property (strong,nonatomic) HAKSuccessViewController *successViewController;
@end



@interface HAKLoginViewControllerTests : XCTestCase
@property HAKLoginViewController *loginViewController;
@property HAKMockNetwork *network;
@property HAKFakeAlertView *fakeAlert;
@property UIButton *fakeButton;
@end

@implementation HAKLoginViewControllerTests

- (void)setUp{
    [super setUp];
    self.loginViewController = [[HAKLoginViewController alloc] initWithNib];
    [self.loginViewController view];
    self.network = [[HAKMockNetwork alloc] init];
    self.loginViewController.network = self.network;
    self.network.loginCalled = NO;
    self.network.forgotPasswordCalled = NO;
    
    self.fakeAlert = [HAKFakeAlertView sharedInstance];
    self.fakeAlert.alertHasBeenShown = NO;
    
    self.fakeButton = [[UIButton alloc] init];
}

- (void)tearDown{
    self.loginViewController = nil;
    self.network = nil;
    self.fakeAlert = nil;
    [super tearDown];
}

-(void)testViewHasRequiredOutlets{
    XCTAssertNotNil(self.loginViewController.emailField, @"The view controller should have an email field");
    XCTAssertNotNil(self.loginViewController.passwordField, @"The view controller should have a password field");
}


#pragma mark - Bad User Input

-(void)testLoginBadInputDoesNotMakeNetworkCall{
    self.loginViewController.emailField.text = @"not email";
    self.loginViewController.passwordField.text = @"12345";
    [self.loginViewController onLoginPress:self.fakeButton];
    XCTAssertFalse(self.network.loginCalled, @"Network methods should not be invoked if the user enters the text fields incorrectly");
    
    self.loginViewController.emailField.text = @"willAndRepresentation@schopenhauer.com";
    self.loginViewController.passwordField.text = @"a";
    [self.loginViewController onLoginPress:self.fakeButton];
    XCTAssertFalse(self.network.loginCalled, @"Network methods should not be invoked if the user enters the text fields incorrectly");
}
-(void)testForgotPasswordBadInputDoesNotMakeNetworkCall{
    self.loginViewController.emailField.text = @"not email";
    [self.loginViewController onForgotPasswordPress:self.fakeButton];
    XCTAssertFalse(self.network.forgotPasswordCalled, @"Network methods should not be invoked if the user enters the text fields incorrectly");
}
-(void)testLoginBadEmailInputShowsAlert{
    self.loginViewController.emailField.text = @"not email";
    self.loginViewController.passwordField.text = @"12345";
    [self.loginViewController onLoginPress:self.fakeButton];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"An alert should be shown if the user enters the text fields incorrectly");
}
-(void)testLoginBadPasswordInputShowsAlert{
    self.loginViewController.emailField.text = @"willAndRepresentation@schopenhauer.com";
    self.loginViewController.passwordField.text = @"a";
    [self.loginViewController onLoginPress:self.fakeButton];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"An alert should be shown if the user enters the text fields incorrectly");
}
-(void)testForgotPasswordBadInputShowsAlert{
    UIButton *fakeButton = [[UIButton alloc] init];
    
    self.loginViewController.emailField.text = @"not email";
    [self.loginViewController onForgotPasswordPress:fakeButton];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"An alert should be shown if the user enters the text fields incorrectly");
}



#pragma mark - Good User Input

-(void)testLoginGoodInputDoesMakeNetworkCall{
    self.loginViewController.emailField.text = @"willAndRepresentation@schopenhauer.com";
    self.loginViewController.passwordField.text = @"alohomora!";
    [self.loginViewController onLoginPress:self.fakeButton];
    XCTAssertTrue(self.network.loginCalled, @"Network methods should be invoked if the user enters the text fields correctly");
}
-(void)testForgotPasswordGoodInputDoesMakeNetworkCall{
    self.loginViewController.emailField.text = @"realEmail@gmail.com";
    [self.loginViewController onForgotPasswordPress:self.fakeButton];
    XCTAssertTrue(self.network.forgotPasswordCalled, @"Network methods should be invoked if the user enters the text fields correctly");
}




#pragma mark - Network Response

-(void)testNetworkFailureShowsAlertView{
    NSError *error = nil;
    [self.loginViewController networkFailure:kLoginUser error:error];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"A network failure should invoke an alert");
    
    [self.loginViewController networkFailure:kForgotPassword error:error];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"A network failure should invoke an alert");
}

-(void)testLoginBadRequestConditionShowsAlertView{
    NSDictionary *response = @{@"code":@"400",
                               @"message":@"Bad request"};
    [self.loginViewController networkSuccess:kLoginUser responseDictionary:response];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"A bad request should invoke an alert");
}
-(void)testLoginWrongPasswordConditionShowsAlertView{
    NSDictionary *response = @{@"code":@"402",
                               @"message":@"Wrong password"};
    [self.loginViewController networkSuccess:kLoginUser responseDictionary:response];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"The condition of the user already existing should invoke an alert");
}

-(void)testForgotPasswordBadRequestConditionShowsAlertView{
    NSDictionary *response = @{@"code":@"400",
                               @"message":@"Bad request"};
    [self.loginViewController networkSuccess:kForgotPassword responseDictionary:response];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"A bad request should invoke an alert");
}


-(void)testLoginGoodRequestGoesToSuccessView{
    NSDictionary *response = @{@"code":@"200",
                               @"message":@"Ok"};
    [self.loginViewController networkSuccess:kLoginUser responseDictionary:response];
    
    XCTAssertNotNil([[HAKMainViewController sharedInstance].successViewController.view superview], @"The success view should be added after successful login");
}
-(void)testForgotPasswordGoodRequestShowsSuccessAlert{
    NSDictionary *response = @{@"code":@"200",
                               @"message":@"Ok"};
    [self.loginViewController networkSuccess:kForgotPassword responseDictionary:response];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"An alert showing the user to check email should be shown");
}




#pragma mark - Navigation

-(void)testOnRegisterPressGoesToRegistrationView{
    UIButton *fakeButton = [[UIButton alloc] init];
    [self.loginViewController onRegisterPress:fakeButton];
    XCTAssertNotNil([[HAKMainViewController sharedInstance].registrationViewController.view superview], @"Pressing the register button should go to the registration screen");
}









@end
