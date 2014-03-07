//
//  HAKHelperMethodsTests.m
//  StarterApp
//
//  Created by Grace on 3/7/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HAKHelperMethods.h"

@interface HAKHelperMethodsTests : XCTestCase

@end

@implementation HAKHelperMethodsTests

- (void)setUp{
    [super setUp];
}

- (void)tearDown{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

-(void)testThatValidateEmailMethodDoesNotAllowNonEmailAdderesses{
    XCTAssertFalse([HAKHelperMethods validateEmail:@"someone"], @"'someone' should not be a valid email");
    XCTAssertFalse([HAKHelperMethods validateEmail:@"someone@"],@"'someone@' should not be a valid email");
    XCTAssertFalse([HAKHelperMethods validateEmail:@"someone@gmail"],@"'someone@gmail' should not be a valid email");
    XCTAssertFalse([HAKHelperMethods validateEmail:@"someone@gmail."],@"'someone@gmail.' should not be a valid email");
    XCTAssertFalse([HAKHelperMethods validateEmail:@"@gmail"], @"'@gmail' should not be a valid email");
    XCTAssertFalse([HAKHelperMethods validateEmail:@"@gmail.com"], @"'@gmail.com' should not be a valid email");
}
-(void)testThatValidateEmailMethodAllowsAcutalEmailAddresses{
    XCTAssertTrue([HAKHelperMethods validateEmail:@"someone@gmail.com"], @"someone@gmail.com should be a valid email");
    XCTAssertTrue([HAKHelperMethods validateEmail:@"boy@something.co"], @"boy@something.co should be a valid email");
}
-(void)testThatValidatePasswordMethodDoesNotAllowNonValidPasswords{
    XCTAssertFalse([HAKHelperMethods validatePassword:@"s"], @"Passwords less than 3 characters long should not be allowed");
}
-(void)testThatValidatePasswordMethodAllowsValidPasswords{
    XCTAssertTrue([HAKHelperMethods validatePassword:@"unicorns!"], @"Passwords more than 3 characters long should be a valid password");
}


@end
