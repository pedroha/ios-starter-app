//
//  HAKHelperMethods.m
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

#import "HAKHelperMethods.h"
#import "KeychainItemWrapper.h"

@implementation HAKHelperMethods

+(void) showAlert:(NSString*)title withMessage:(NSString*)description{
    UIAlertView* message = [[UIAlertView alloc]
                            initWithTitle:title
                            message:description
                            delegate:self
                            cancelButtonTitle:@"Ok"
                            otherButtonTitles:nil];
    [message show];
}

+(BOOL) validateEmail: (NSString *) email {
    //makes sure it looks like an email address
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:email]){
        return YES;
    }
    return NO;
}

+(BOOL) validatePassword:(NSString*) password{
    //if you have further constraints for what a password should be, implement it here
    if(password.length > 3){
        return YES;
    }
    return NO;
}




#pragma mark - Keychain

+(NSString*)getKeychainUsername{
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserCredentials" accessGroup:nil];
    NSString *userName = [keychain objectForKey:(__bridge id)(kSecAttrAccount)];
    return userName;
}
+(NSString*)getKeychainPassword{
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserCredentials" accessGroup:nil];
    NSString *userPassword = [keychain objectForKey:(__bridge id)(kSecValueData)];
    return userPassword;
}

+(void)setKeychainUsername:(NSString*)userName withPassword:(NSString*)userPassword{
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserCredentials" accessGroup:nil];
    [keychain setObject:(__bridge id)(kSecAttrAccessibleWhenUnlocked) forKey:(__bridge id)(kSecAttrAccessible)];
    [keychain setObject:userName forKey:(__bridge id)(kSecAttrAccount)];
    [keychain setObject:userPassword forKey:(__bridge id)(kSecValueData)];
    keychain = nil;
}
+(void)resetKeychain{
    KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserCredentials" accessGroup:nil];
    [keychain resetKeychainItem];
}













@end
