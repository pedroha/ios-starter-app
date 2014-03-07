//
//  HAKNetwork.h
//  StarterApp
//
//  Created by Grace on 3/3/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HAKNetworkDelegate.h"

@interface HAKNetwork : NSObject


@property (weak, nonatomic) id <HAKNetworkDelegate> delegate;


-(void)registerNewUserWithEmail:(NSString*)email password:(NSString*)password firstName:(NSString*)firstName lastName:(NSString*)lastName nickname:(NSString*)nickname;

-(void)loginUserWithEmail:(NSString*)email andPassword:(NSString*)password;

-(void)userForgotPassword:(NSString*)email;

-(void)updateUserInfoWithEmail:(NSString*)email password:(NSString*)password firstName:(NSString*)firstName lastName:(NSString*)lastName nickname:(NSString*)nickname;

@end
