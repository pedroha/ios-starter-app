//
//  HAKLoginViewControllerTests.m
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
#import "HAKRegistrationViewController.h"
#import "HAKMockNetwork.h"
#import "HAKNotificationConstants.h"
#import "HAKFakeAlertView.h"
#import "HAKSuccessViewController.h"
#import "HAKMainViewController.h"
#import "HAKLoginViewController.h"
#import "HAKMockHelperMethods.h"



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
@property NSDictionary *fakeResponseDictionary;
@property HAKMockHelperMethods *helper;
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
    self.fakeResponseDictionary = @{@"message":@"fake message"};
    
    self.helper = [HAKMockHelperMethods sharedInstance];
    self.helper.messageShown = nil;
}

- (void)tearDown{
    self.loginViewController = nil;
    self.network = nil;
    self.fakeAlert = nil;
    self.fakeResponseDictionary = nil;
    self.helper = nil;
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




#pragma mark - Network Response Success

-(void)testLoginGoodRequestGoesToSuccessView{
    [self.loginViewController networkSuccess:kLoginUser responseDictionary:self.fakeResponseDictionary];
    XCTAssertNotNil([[HAKMainViewController sharedInstance].successViewController.view superview], @"The success view should be added after successful login");
}
-(void)testForgotPasswordGoodRequestShowsSuccessAlert{
    [self.loginViewController networkSuccess:kForgotPassword responseDictionary:self.fakeResponseDictionary];
    XCTAssertTrue(self.fakeAlert.alertHasBeenShown, @"An alert showing the user to check email should be shown");
}



#pragma mark - Network Response Error

-(void)testLoginStatusCode400ShowsDefaultAlertMessage{
    [self.loginViewController networkFailure:kLoginUser error:nil statusCode:400 responseDictionary:self.fakeResponseDictionary];
    XCTAssertEqualObjects(self.helper.messageShown, kMessageLoginDefaultErrorMessage, @"Status code 400 should show default message");
}
-(void)testLoginStatusCode404ShowsDefaultAlertMessage{
    [self.loginViewController networkFailure:kLoginUser error:nil statusCode:404 responseDictionary:self.fakeResponseDictionary];
    XCTAssertEqualObjects(self.helper.messageShown, kMessageLoginDefaultErrorMessage, @"Status code 404 should show default message");
}
-(void)testLoginStatusCode402ShowsUserDoesntExistMessage{
    [self.loginViewController networkFailure:kLoginUser error:nil statusCode:402 responseDictionary:self.fakeResponseDictionary];
    XCTAssertEqualObjects(self.helper.messageShown, kMessageLoginUserDoesntExist, @"Status code 402 should show custom message");
}
-(void)testLoginStatusCode403ShowsPasswordIncorrectMessage{
    [self.loginViewController networkFailure:kLoginUser error:nil statusCode:403 responseDictionary:self.fakeResponseDictionary];
    XCTAssertEqualObjects(self.helper.messageShown, kMessageLoginPasswordIsIncorrect, @"Status code 403 should show custom message");
}


-(void)testForgotPasswordCode400ShowsDefaultAlertMessage{
    [self.loginViewController networkFailure:kForgotPassword error:nil statusCode:400 responseDictionary:self.fakeResponseDictionary];
    XCTAssertEqualObjects(self.helper.messageShown, kMessageForgotPasswordDefaultErrorMessage, @"Status code 400 should show default message");
}
-(void)testForgotPasswordCode404ShowsDefaultAlertMessage{
    [self.loginViewController networkFailure:kForgotPassword error:nil statusCode:404 responseDictionary:self.fakeResponseDictionary];
    XCTAssertEqualObjects(self.helper.messageShown, kMessageForgotPasswordDefaultErrorMessage, @"Status code 400 should show default message");
}
-(void)testForgotPasswordCode402ShowsUserDoesntExistMessage{
    [self.loginViewController networkFailure:kForgotPassword error:nil statusCode:402 responseDictionary:self.fakeResponseDictionary];
    XCTAssertEqualObjects(self.helper.messageShown, kMessageForgotPasswordUserDoesntExist, @"Status code 402 should show custom message");
}





#pragma mark - Navigation

-(void)testOnRegisterPressGoesToRegistrationView{
    UIButton *fakeButton = [[UIButton alloc] init];
    [self.loginViewController onRegisterPress:fakeButton];
    XCTAssertNotNil([[HAKMainViewController sharedInstance].registrationViewController.view superview], @"Pressing the register button should go to the registration screen");
}









@end
