//
//  HAKHelperMethodsTests.m
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
#import "HAKHelperMethods.h"
#import "KeychainItemWrapper.h"


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


-(void)testThatSetKeychainWorks{
    [HAKHelperMethods setKeychainUsername:@"testName" withPassword:@"horsebatterystaplecorrect"];
    
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserCredentials" accessGroup:nil];
    NSString *userName = [keychain objectForKey:(__bridge id)(kSecAttrAccount)];
    NSString *userPassword = [keychain objectForKey:(__bridge id)(kSecValueData)];
    
    XCTAssertEqualObjects(userName, @"testName", @"The keychain kSecAttrAccount should be set to 'testName'");
    XCTAssertEqualObjects(userPassword, @"horsebatterystaplecorrect", @"The keychain kSecValueData should be set to 'horsebatterystaplecorrect'");
}
-(void)testThatGetKeychainWorks{
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserCredentials" accessGroup:nil];
    [keychain setObject:(__bridge id)(kSecAttrAccessibleWhenUnlocked) forKey:(__bridge id)(kSecAttrAccessible)];
    [keychain setObject:@"testName" forKey:(__bridge id)(kSecAttrAccount)];
    [keychain setObject:@"horsebatterystaplecorrect" forKey:(__bridge id)(kSecValueData)];
    keychain = nil;
    
    NSString *username = [HAKHelperMethods getKeychainUsername];
    NSString *password = [HAKHelperMethods getKeychainPassword];
    
    XCTAssertEqualObjects(username, @"testName", @"username should be set to 'testName'");
    XCTAssertEqualObjects(password, @"horsebatterystaplecorrect", @"password should be set to 'horsebatterystaplecorrect'");
}
-(void)testThatResetKeychainWorks{
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserCredentials" accessGroup:nil];
    [keychain setObject:(__bridge id)(kSecAttrAccessibleWhenUnlocked) forKey:(__bridge id)(kSecAttrAccessible)];
    [keychain setObject:@"testName" forKey:(__bridge id)(kSecAttrAccount)];
    [keychain setObject:@"horsebatterystaplecorrect" forKey:(__bridge id)(kSecValueData)];
    keychain = nil;
    
    [HAKHelperMethods resetKeychain];
    
    NSString *userName = [keychain objectForKey:(__bridge id)(kSecAttrAccount)];
    NSString *userPassword = [keychain objectForKey:(__bridge id)(kSecValueData)];

    XCTAssertNil(userName, @"Reset keychain should set username to nil");
    XCTAssertNil(userPassword, @"Reset keychain should set password to nil");    
}








@end
