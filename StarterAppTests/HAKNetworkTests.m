//
//  HAKNetworkTests.m
//  StarterApp
//
//  Created by Grace on 3/7/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HAKMockNetwork.h"
#import "HAKMockNetworkDelegate.h"
#import "HAKNotificationConstants.h"

@interface HAKNetworkTests : XCTestCase
@property HAKMockNetwork *network;
@property HAKMockNetworkDelegate *networkDelegate;
@end

@implementation HAKNetworkTests

- (void)setUp{
    [super setUp];
    self.network = [[HAKMockNetwork alloc] init];
    self.networkDelegate = [[HAKMockNetworkDelegate alloc] init];
    self.network.delegate = self.networkDelegate;
}

- (void)tearDown{
    self.network = nil;
    self.networkDelegate = nil;
    [super tearDown];
}



#pragma mark - URLs correspond to API

-(void)testThatLoginCallsPostToURLWithCorrectURL{
    [self.network loginUserWithEmail:@"test@test.com" andPassword:@"12345"];
    NSString *urlThatShouldBeCalled = [NSString stringWithFormat:@"%@login/",kBaseURLAddress];
    
    XCTAssertEqualObjects(self.network.urlString, urlThatShouldBeCalled, @"The URL string should correspond to the API");
}
-(void)testThatRegistrationCallsPostToURLWithCorrectURL{
    [self.network registerNewUserWithEmail:@"test@test.com" password:@"12345" firstName:@"Paul" lastName:@"Atreides" nickname:@"Muad'dib"];
    NSString *urlThatShouldBeCalled = [NSString stringWithFormat:@"%@register/",kBaseURLAddress];
    
    XCTAssertEqualObjects(self.network.urlString, urlThatShouldBeCalled, @"The URL string should correspond to the API");
}
-(void)testThatForgetPasswordCallsPostToURLWithCorrectURL{
    [self.network userForgotPassword:@"test@test.com"];
    NSString *urlThatShouldBeCalled = [NSString stringWithFormat:@"%@forgotpassword/",kBaseURLAddress];
    
    XCTAssertEqualObjects(self.network.urlString, urlThatShouldBeCalled, @"The URL string should correspond to the API");
}




#pragma mark - JSON corresponds to API

-(void)testThatLoginCallsPostToURLWithCorrectParameters{
    [self.network loginUserWithEmail:@"test@test.com" andPassword:@"12345"];
    NSDictionary *parametersThatShouldBeCalled = @{@"email":@"test@test.com", @"password":@"12345"};
    
    XCTAssertEqualObjects(self.network.parameters, parametersThatShouldBeCalled, @"The parameters should correspond to the API");
}
-(void)testThatRegistrationCallsPostToURLWithCorrectParameters{
    [self.network registerNewUserWithEmail:@"test@test.com" password:@"12345" firstName:@"Paul" lastName:@"Atreides" nickname:@"Muad'dib"];
    NSDictionary *parametersThatShouldBeCalled = @{@"email":@"test@test.com",
                                                   @"password":@"12345",
                                                   @"firstname":@"Paul",
                                                   @"lastname":@"Atreides",
                                                   @"nickname":@"Muad'dib"};
    
    XCTAssertEqualObjects(self.network.parameters, parametersThatShouldBeCalled, @"The parameters should correspond to the API");
}
-(void)testThatForgetPasswordCallsPostToURLWithCorrectParameters{
    [self.network userForgotPassword:@"test@test.com"];
    NSDictionary *parametersThatShouldBeCalled = @{@"email":@"test@test.com"};
    
    XCTAssertEqualObjects(self.network.parameters, parametersThatShouldBeCalled, @"The parameters should correspond to the API");
}






-(void)testNetworkSuccessReturningNonJSONInvokesErrorMethodOnDelegate{
    NSString *responseObject = @"Hey!  This isn't JSON!";
    [self.network postSuccessWithResponseObject:responseObject forName:kLoginUser];
    XCTAssertTrue(self.networkDelegate.failureCalled, @"Non-JSON should invoke a failure-handler method on the delegate");
    XCTAssertFalse(self.networkDelegate.successCalled, @"Non-JSON should not invoke a success-handler on the delegate");
    XCTAssertEqual(HAKResponseObjectNotDictionary, self.networkDelegate.networkError.code, @"The error sent should be HAKResponseObjectNotDictionary");
}

-(void)testNetworkSuccessWithJSONWithStatusCodeInvokesSuccessMethodOnDelegate{
    NSDictionary *responseObject = @{@"code":@"200"};
    [self.network postSuccessWithResponseObject:responseObject forName:kLoginUser];
    XCTAssertTrue(self.networkDelegate.successCalled, @"JSON with a status code should invoke a success-handler method on the delegate");
    XCTAssertFalse(self.networkDelegate.failureCalled, @"JSON with a status code should not invoke a failure-handler on the delegate");
    XCTAssertEqualObjects(self.networkDelegate.networkResponse, responseObject, @"The object sent to the delegate should match the responseObejct");
}

-(void)testNetworkErrorInvokesErrorMethodOnDelegate{
    NSError *error = [NSError errorWithDomain:kHAKNetworkErrorDomain code:1 userInfo:nil];
    [self.network postFailureWithError:error forName:kLoginUser forStatusCode:400 withResponseObject:@{@"message":@"something"}];
    XCTAssertTrue(self.networkDelegate.failureCalled, @"A network error should invoke a failure-handler method on the delegate");
    XCTAssertFalse(self.networkDelegate.successCalled, @"A network error should not invoke a success-handler on the delegate");
}














@end
