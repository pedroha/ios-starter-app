//
//  HAKNetwork.h
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
#import "HAKNetworkDelegate.h"



/** HAK Network is responsible for all the communication with the backend API.  
 
 Another class wanting to receive responses from the network should conform to the HAKNetworkDelegate protocol.
*/

@interface HAKNetwork : NSObject

///---------------------
/// @name Delegate
///---------------------


/** The object on which HAKNetwork will call the delegate methods. */
@property (weak, nonatomic) id <HAKNetworkDelegate> delegate;

/** The network call to register a new user.
 @param email The user's email address
 @param password The user's password
 @param firstName The user's first name or nil (the parameter is not required)
 @param lastName The user's last name or nil (the parameter is not required)
 @param nickname The user's nickname or nil (the parameter is not required)
 */




///---------------------
/// @name Network Methods
///---------------------


-(void)registerNewUserWithEmail:(NSString*)email password:(NSString*)password firstName:(NSString*)firstName lastName:(NSString*)lastName nickname:(NSString*)nickname;

/** The network call to login a user.
 @param email The user's email address
 @param password The user's password
 */
-(void)loginUserWithEmail:(NSString*)email andPassword:(NSString*)password;

/** The network call to be made when a user forgets their password.  A successful network call will email them with the option to reset their password.
 @param email The user's email
*/
-(void)userForgotPassword:(NSString*)email;

/** The network call to be made to update a user's personal information
 @param email The user's email address
 @param password The user's password
 @param firstName The user's first name or nil (the parameter is not required)
 @param lastName The user's last name or nil (the parameter is not required)
 @param nickname The user's nickname or nil (the parameter is not required)
*/
-(void)updateUserInfoWithEmail:(NSString*)email password:(NSString*)password firstName:(NSString*)firstName lastName:(NSString*)lastName nickname:(NSString*)nickname;

@end
