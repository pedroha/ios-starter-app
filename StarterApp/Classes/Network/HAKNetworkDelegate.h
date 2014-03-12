//
//  HAKNetworkDelegate.h
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
 On network success or error, HAKNetwork will invoke these methods on the delegate.
*/
@protocol HAKNetworkDelegate <NSObject>

/** Called when HAKNetwork receives a successful response from the backend API.
 @param name The name of the action that is taking place.  Use the constants defined in HAKNotificationConstants.
 @param responseDictionary The JSON returned from the server as an NSDictionary.  Currently contains just a message (@{@"message":@"some message from the server"), but feel free to add whatever additional info you like to it.
*/
-(void)networkSuccess:(NSString*)name responseDictionary:(NSDictionary*)responseDictionary;

/** Called when HAKNetwork receives an unsuccessful response from the backend API.
 
 Possible status codes:   (feel free to add more!)
 
    200 Ok
    400 Bad Request
    401 User already exists
    402 User does not exist
    403 Password is incorrect
 
 @param name The name of the action that is taking place.  Use the constants defined in HAKNotificationConstants.
 @param error The error that occured
 @param statusCode The status code from the network response.  For example, status code 403 indicates that the user has entered an incorrect password.  Check the discussion section for other possible status codes.
 
 @param responseDictionary The JSON returned from the server as an NSDictionary.  Currently contains just a message (@{@"message":@"some message from the server"), but feel free to add whatever additional info you like to it.
 */
-(void)networkFailure:(NSString*)name error:(NSError*)error statusCode:(int)statusCode responseDictionary:(NSDictionary*)responseDictionary;



@end
