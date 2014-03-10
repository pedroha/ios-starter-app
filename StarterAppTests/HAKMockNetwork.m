//
//  HAKMockNetwork.m
//  StarterApp
//
//  Created by Grace on 3/7/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKMockNetwork.h"

@implementation HAKMockNetwork


-(void)postToURL:(NSString*)urlString withParameters:(NSDictionary*)parameters name:(NSString*)name{
    self.urlString = urlString;
    self.parameters = parameters;
}


-(void)registerNewUserWithEmail:(NSString *)email password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName nickname:(NSString *)nickname{
    [super registerNewUserWithEmail:email password:password firstName:firstName lastName:lastName nickname:nickname];
    self.registerNewUserCalled = YES;
}

-(void)loginUserWithEmail:(NSString *)email andPassword:(NSString *)password{
    [super loginUserWithEmail:email andPassword:password];
    self.loginCalled = YES;
}

-(void)userForgotPassword:(NSString *)email{
    [super userForgotPassword:email];
    self.forgotPasswordCalled = YES;
}
@end
