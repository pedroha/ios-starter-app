//
//  HAKRegistrationViewControllerTests.m
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
@property NSDictionary *fakeResponseDictionary;
@property HAKMockHelperMethods *helper;
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
    
    self.helper = [HAKMockHelperMethods sharedInstance];
    self.helper.messageShown = nil;
    
    self.fakeResponseDictionary = @{@"message":@"fake message"};
}

- (void)tearDown{
    self.registrationViewController = nil;
    self.network = nil;
    self.fakeAlert = nil;
    self.helper = nil;
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

-(void)testGoodRequestGoesToSuccessView{
    NSDictionary *response = @{@"code":@"200",
                               @"message":@"Ok"};
    [self.registrationViewController networkSuccess:kRegisterNewUser responseDictionary:response];
    
    XCTAssertNotNil([[HAKMainViewController sharedInstance].successViewController.view superview], @"The success view should be added after successful registration");
}




-(void)testStatusCode400ShowsDefaultAlertMessage{
    [self.registrationViewController networkFailure:kRegisterNewUser error:nil statusCode:400 responseDictionary:self.fakeResponseDictionary];
    XCTAssertEqualObjects(self.helper.messageShown, kMessageRegisterDefaultErrorMessage, @"Status code 400 should show default alert message");
}
-(void)testStatusCode404ShowsDefaultAlertMessage{
    [self.registrationViewController networkFailure:kRegisterNewUser error:nil statusCode:404 responseDictionary:self.fakeResponseDictionary];
    XCTAssertEqualObjects(self.helper.messageShown, kMessageRegisterDefaultErrorMessage, @"Status code 400 should show default alert message");
}
-(void)testStatusCode401ShowsUserAlreadyExistsMessage{
    [self.registrationViewController networkFailure:kRegisterNewUser error:nil statusCode:401 responseDictionary:self.fakeResponseDictionary];
    XCTAssertEqualObjects(self.helper.messageShown, kMessageRegisterUserAlreadyExists, @"Status code 401 should show custom message");
}






@end
