//
//  HAKMockNetwork.h
//  StarterApp
//
//  Created by Grace on 3/7/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKNetwork.h"

@interface HAKNetwork ()
// normally called when AFNetworking receives response from network
-(void)postSuccessWithResponseObject:(id)responseObject forName:(NSString*)name;
-(void)postFailureWithError:(NSError*)error forName:(NSString*)name;
@end



@interface HAKMockNetwork : HAKNetwork

@property (strong,nonatomic) NSString *urlString;
@property (strong,nonatomic) NSDictionary *parameters;


@property BOOL registerNewUserCalled;
@property BOOL loginCalled;
@property BOOL forgotPasswordCalled;
@end
