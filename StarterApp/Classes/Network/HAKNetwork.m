//
//  HAKNetwork.m
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
