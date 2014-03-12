//
//  HAKHelperMethods.h
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

#import <Foundation/Foundation.h>



/** 
 HAKHelperMethods is home to several convenience methods.  Feel free to add more here!
 */

@interface HAKHelperMethods : NSObject


///---------------------
/// @name Alerts
///---------------------

/**
 A more convenient way to display alerts.  One button - "Ok" - and no delegate.
 @param title The title to be shown in the alert.
 @param description The message to be shown in the alert.
*/
+(void) showAlert:(NSString*)title withMessage:(NSString*)description;




///---------------------
/// @name Validation
///---------------------

/**
 Checks to make sure a string looks like an email address.
 @param email The email address you would like to validate.
 @return Returns YES if the email is valid.
*/
+(BOOL) validateEmail: (NSString *) email;


/**
 Checks to make sure a string is a valid password.
 The current constraints are that the password is at least 4 characters.  Feel free to add more constraints!
 @param password The password you would like to validate.
 @return Returns YES if the password is valid. 
*/
+(BOOL) validatePassword:(NSString*) password;




///---------------------
/// @name Keychain
///---------------------

/**
 Fetch the name that is stored in keychain, if any.
 @return The stored username, or nil.
*/
+(NSString*)getKeychainUsername;

/**
 Fetch the password that is stored in keychain, if any.
 @return The stored password, or nil.
*/
+(NSString*)getKeychainPassword;

/**
 Store a username and password in keychain, so the app can remember the user next time they launch it.
 Use this, for example, when you are logging in a user and they would like their info remembered.
 @param userName The username to store.
 @param userPassword The password to store.
*/
+(void)setKeychainUsername:(NSString*)userName withPassword:(NSString*)userPassword;

/**
 Purge anything stored in keychain.
 Use this, for example, when a user logs out of the app.
*/
+(void)resetKeychain;




@end
