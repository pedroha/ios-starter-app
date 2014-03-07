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