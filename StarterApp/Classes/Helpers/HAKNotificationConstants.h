//
//  HAKNotificationConstants.h
//  StarterApp
//
//  Created by Grace on 3/3/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//


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