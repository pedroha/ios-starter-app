//
//  HAKNotificationConstants.h
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


#define kBaseURLAddress @"http://localhost:8080/"
#define kHAKNetworkErrorDomain @"HAKNetworkErrorDomain"


#define kRegisterNewUser @"registerNewUser"

#define kLoginUser @"loginUser"

#define kForgotPassword @"forgotPassword"

#define kUpdateUserInfo @"updateUserInfo"


typedef enum HAKNetworkErrors{
    HAKResponseObjectNotDictionary = 1000,
    HAKResponseObjectDoesNotHaveStatusCode
    
} HAKNetworkError;



#pragma mark - Messages For Alerts

#define kMessageLoginUserDoesntExist @"This email address is not registered."

#define kMessageLoginPasswordIsIncorrect @"Incorrect Password."

#define kMessageLoginDefaultErrorMessage @"We're sorry, log-in could not be completed."


#define kMessageForgotPasswordUserDoesntExist @"This email address is not registered."

#define kMessageForgotPasswordDefaultErrorMessage @"We're sorry, this operation could not be completed."


#define kMessageRegisterUserAlreadyExists @"This email address is already registered."

#define kMessageRegisterDefaultErrorMessage @"We're sorry, registration could not be completed."