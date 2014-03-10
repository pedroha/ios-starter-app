//
//  HAKRegistrationViewControllerTests.m
//  StarterApp
//
//  Created by Grace on 3/7/14.
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


@interface HAKRegistrationViewController ()
@property (strong,nonatomic) HAKNetwork *network;
@end

@interface HAKMainViewController()
@property (strong,nonatomic) HAKLoginViewController *loginViewController;
@property (strong,nonatomic) HAKRegistrationViewController *registrationViewController;
@property (strong,nonatomic) HAKSuccessViewController *successViewController;
@end



@interface HAKRegistrationViewControllerTests : XCTestCase
@property HAKRegistrationViewController *registrationViewController;
@property HAKMockNetwork *network;
@property HAKFakeAlertView *fakeAlert;
@end

@implementation HAKRegistrationViewControllerTests


- (void)setUp{
    [super setUp];
    self.registrationViewController = [[HAKRegistrationViewController alloc] initWithNib];
    [self.registrationViewController view];
    self.network = [[HAKMockNetwork alloc] init];
    self.registrationViewController.network = self.network;
    self.network.registerNewUserCalled = NO;
    
    self.fakeAlert = [HAKFakeAlertView sharedInstance];
    self.fakeAlert.alertHasBeenShown = NO;
}

- (void)tearDown{
    self.registrationViewController = nil;
    self.network = nil;
    self.fakeAlert = nil;
    [super tearDown];
}



-(void)testViewHasRequiredOutlets{
    XCTAssertNotNil(self.registrationViewController.emailField, @"The view controller should have an email field");
    XCTAssertNotNil(self.registrationViewController.passwordField, @"The view controller should have a password field");
    XCTAssertNotNil(self.registrationViewController.passwordVerifyField, @"The view controller should have a password-verify field");
    XCTAssertNotNil(self.registrationViewController.firstNameField, @"The view controller should have a first-name field");
    XCTAssertNotNil(self.registrationViewController.lastNameField, @"The view controller should have a last-name field");
    XCTAssertNotNil(self.registrationViewController.nicknameField, @"The view controller should have a nickname field");
}



#pragma mark - User Input

-(void)testBadInputDoesNotMakeNetworkCall{
    UIButton *fakeButton = [[UIButton alloc] init];
    
    self.registrationViewController.emailField.text = @"not a real email address";
    self.registrationViewController.passwordField.text = @"12345";
    self.registrationViewController.passwordVerifyField.text = @"12345";
    [self.registrationViewController onRegisterPress:fakeButton];
    XCTAssertFalse(self.network.registerNewUserCalled, @"Network methods should not be invoked if the user enters the text fields incorrectly");
    
    self.registrationViewController.emailField.text = @"realEmail@gmail.com";
    self.registrationViewController.passwordField.text = @"a";
    self.registrationViewController.passwordVerifyField.text = @"a";
    [self.registrationViewController onRegisterPress:fakeButton];
    XCTAssertFalse(self.network.registerNewUserCalled, @"Network methods should not be invoked if the user enters the text fields incorrectly");
    
    self.registrationViewController.emailField.text = @"realEmail@gmail.com";
    self.registrationViewController.passwordField.text = @"alohomora!";
    self.registrationViewController.passwordVerifyField.text = @"aloha";
    [self.registrationViewController onRegisterPress:fakeButton];
    XCTAssertFalse(self.network.registerNewUserCalled, @"Network methods should not be invoked if the user enters the text fields incorrectly");
}
-(void)testGoodInputDoesMakeNetworkCall{
    UIButton *fakeButton = [[UIButton alloc] init];
    
    self.registrationViewController.emailField.text = @"realEmail@gmail.com";
    self.registrationViewController.passwordField.text = @"alohomora!";
    self.registrationViewController.passwordVerifyField.text = @"alohomora!";
    [self.registrationViewController onRegisterPress:fakeButton];
    XCTAssertTrue(self.network.registerNewUserCalled, @"Network methods should be invoked if the user enters the text fields correctly");
}
-(void)testBadEmailInputShowsAlert{
    UIButton *fakeButton = [[UIButton alloc] init];
    
    self.registrationViewController.emailField.text = @"not a real email address";
    self.registrationViewController.passwordField.text = @"12345";
    self.registrationViewController.passwordVerifyField.text = @"12345";
    [self.registrationViewController onRegisterPress:fakeButton];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"An alert should be shown if the user enters the text fields incorrectly");
}
-(void)testBadPasswordInputShowsAlert{
    UIButton *fakeButton = [[UIButton alloc] init];
    
    self.registrationViewController.emailField.text = @"realEmail@gmail.com";
    self.registrationViewController.passwordField.text = @"a";
    self.registrationViewController.passwordVerifyField.text = @"a";
    [self.registrationViewController onRegisterPress:fakeButton];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"An alert should be shown if the user enters the text fields incorrectly");
}
-(void)testNonMatchingPasswordInputShowsAlert{
    UIButton *fakeButton = [[UIButton alloc] init];
    
    self.registrationViewController.emailField.text = @"realEmail@gmail.com";
    self.registrationViewController.passwordField.text = @"alohomora!";
    self.registrationViewController.passwordVerifyField.text = @"aloha";
    [self.registrationViewController onRegisterPress:fakeButton];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"An alert should be shown if the user enters the text fields incorrectly");
}







#pragma mark - Network Response

-(void)testNetworkFailureShowsAlertView{
    NSError *error = nil;
    [self.registrationViewController networkFailure:kRegisterNewUser error:error];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"A network failure should invoke an alert");
}

-(void)testBadRequestConditionShowsAlertView{
    NSDictionary *response = @{@"code":@"400",
                               @"message":@"Bad request"};
    [self.registrationViewController networkSuccess:kRegisterNewUser responseDictionary:response];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"A bad request should invoke an alert");
}
-(void)testUserAlreadyExistsConditionShowsAlertView{
    NSDictionary *response = @{@"code":@"401",
                               @"message":@"User already exists"};
    [self.registrationViewController networkSuccess:kRegisterNewUser responseDictionary:response];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"The condition of the user already existing should invoke an alert");
}

-(void)testGoodRequestGoesToSuccessView{
    NSDictionary *response = @{@"code":@"200",
                               @"message":@"Ok"};
    [self.registrationViewController networkSuccess:kRegisterNewUser responseDictionary:response];
    
    XCTAssertNotNil([[HAKMainViewController sharedInstance].successViewController.view superview], @"The success view should be added after successful registration");
}








@end
