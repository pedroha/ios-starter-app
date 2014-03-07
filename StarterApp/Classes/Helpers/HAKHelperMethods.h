//
//  HAKHelperMethods.h
//  StarterApp
//
//  Created by Grace on 2/25/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAKHelperMethods : NSObject

+(void) showAlert:(NSString*)title withMessage:(NSString*)description;
+(BOOL) validateEmail: (NSString *) email;
+(BOOL) validatePassword:(NSString*) password;


@end
