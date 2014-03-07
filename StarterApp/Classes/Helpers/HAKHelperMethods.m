//
//  HAKHelperMethods.m
//  StarterApp
//
//  Created by Grace on 2/25/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKHelperMethods.h"

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


@end
