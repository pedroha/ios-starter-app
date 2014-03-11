//
//  HAKNetwork.m
//  StarterApp
//
//  Created by Grace on 3/3/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKNetwork.h"
#import "AFNetworking.h"
#import "HAKNotificationConstants.h"



@implementation HAKNetwork





-(void)registerNewUserWithEmail:(NSString *)email password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName nickname:(NSString *)nickname{
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseURLAddress,@"register/"];
    NSDictionary *parameters = @{@"email":email,
                                 @"password":password,
                                 @"firstname":firstName,
                                 @"lastname":lastName,
                                 @"nickname":nickname};
    
    [self postToURL:url withParameters:parameters name:kRegisterNewUser];
}

-(void)loginUserWithEmail:(NSString *)email andPassword:(NSString *)password{
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseURLAddress,@"login/"];
    NSDictionary *parameters = @{@"email":email,
                                 @"password":password};
    
    [self postToURL:url withParameters:parameters name:kLoginUser];
}

-(void)userForgotPassword:(NSString *)email{
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseURLAddress,@"forgotpassword/"];
    NSDictionary *parameters = @{@"email":email};
    
    [self postToURL:url withParameters:parameters name:kForgotPassword];
}


-(void)updateUserInfoWithEmail:(NSString *)email password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName nickname:(NSString *)nickname{
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseURLAddress,@"updateuserinfo/"];
    NSDictionary *parameters = @{@"email":email,
                                 @"password":password,
                                 @"firstname":firstName,
                                 @"lastname":lastName,
                                 @"nickname":nickname};
    
    [self postToURL:url withParameters:parameters name:kUpdateUserInfo];
}






#pragma mark 

-(void)postToURL:(NSString*)urlString withParameters:(NSDictionary*)parameters name:(NSString*)name{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self postSuccessWithResponseObject:responseObject forName:name];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //DebugLog(@"Network Failure.  Error = %@  \nResponse = %@",error,operation.responseObject);
        [self postFailureWithError:error forName:name forStatusCode:operation.response.statusCode withResponseObject:operation.responseObject];
    }];
 
}
-(void)postSuccessWithResponseObject:(id)responseObject forName:(NSString*)name{
    if([self postErrorIfResponseObjectIsNotDictionary:responseObject forName:name]) return;
    NSDictionary *dict = (NSDictionary*)responseObject;

    [self.delegate networkSuccess:name responseDictionary:dict];
}
-(void)postFailureWithError:(NSError*)error forName:(NSString*)name forStatusCode:(int)statusCode withResponseObject:(id)responseObject{
    if([self postErrorIfResponseObjectIsNotDictionary:responseObject forName:name]) return;
    NSDictionary *dict = (NSDictionary*)responseObject;
    [self.delegate networkFailure:name error:error statusCode:statusCode responseDictionary:dict];
}
-(BOOL)postErrorIfResponseObjectIsNotDictionary:(id)responseObject forName:(NSString*)name{
    if(![responseObject isKindOfClass:[NSDictionary class]]){
        NSError *error = [NSError errorWithDomain:kHAKNetworkErrorDomain code:HAKResponseObjectNotDictionary userInfo:nil];
        [self.delegate networkFailure:name error:error statusCode:HAKResponseObjectNotDictionary responseDictionary:nil];
        return YES;
    }
    return NO;
}





@end
