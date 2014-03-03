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

#define kBaseURLAddress @"http://localhost:8080/"


@interface HAKNetwork()

@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;

@end


@implementation HAKNetwork


- (id)init{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLAddress]];
        
        // Uncomment the next 3 lines if you need to monitor the status of internet connectivity / wifi
        //[self setupReachability];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        
    }
    return self;
}


#pragma mark - Main Methods

-(void)registerNewUserWithEmail:(NSString *)email password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName nickname:(NSString *)nickname{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseURLAddress,@"register/"];
    
    NSDictionary *parameters = @{@"email":email,
                                 @"password":password,
                                 @"firstname":firstName,
                                 @"lastname":lastName,
                                 @"nickname":nickname};
    
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DebugLog(@"Register New User responseObject: %@", responseObject);
        [[NSNotificationCenter defaultCenter] postNotificationName:kRegisterNewUserComplete object:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DebugLog(@"Register New User  error: %@", error);
        [[NSNotificationCenter defaultCenter] postNotificationName:kRegisterNewUserError object:error];
    }];
}

-(void)loginUserWithEmail:(NSString *)email andPassword:(NSString *)password{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseURLAddress,@"login/"];
    
    NSDictionary *parameters = @{@"email":email,
                                 @"password":password};
    
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DebugLog(@"Login responseObject: %@", responseObject);
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginUserComplete object:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DebugLog(@"Login  error: %@", error);
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginUserError object:error];
    }];
}

-(void)userForgotPassword:(NSString *)email{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseURLAddress,@"forgotpassword/"];
    
    NSDictionary *parameters = @{@"email":email};
    
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DebugLog(@"Forgot Password responseObject: %@", responseObject);
        [[NSNotificationCenter defaultCenter] postNotificationName:kForgotPasswordComplete object:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DebugLog(@"Forgot Password error: %@", error);
        [[NSNotificationCenter defaultCenter] postNotificationName:kForgotPasswordError object:error];
    }];
}


-(void)updateUserInfoWithEmail:(NSString *)email password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName nickname:(NSString *)nickname{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseURLAddress,@"updateuserinfo/"];
    
    NSDictionary *parameters = @{@"email":email,
                                 @"password":password,
                                 @"firstname":firstName,
                                 @"lastname":lastName,
                                 @"nickname":nickname};
    
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DebugLog(@"Update User Info responseObject: %@", responseObject);
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateUserInfoComplete object:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DebugLog(@"Update Uesr Info  error: %@", error);
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateUserInfoError object:error];
    }];
}






#pragma mark - Reachability

- (void)setupReachability{
    NSOperationQueue *operationQueue = _manager.operationQueue;
    __block HAKNetwork *blockSelf = self;
    [self.manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                blockSelf.connectedToInternet = YES;
                blockSelf.connectedToWifi = NO;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                blockSelf.connectedToInternet = YES;
                blockSelf.connectedToWifi = YES;
                [operationQueue setSuspended:NO];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                blockSelf.connectedToInternet = NO;
                blockSelf.connectedToWifi = NO;
                break;
                
            default:
                blockSelf.connectedToInternet = NO;
                blockSelf.connectedToWifi = NO;
                break;
        }
    }];
    
}




#pragma mark - Application Methods

-(void)restartReachability{
    [self.manager.reachabilityManager startMonitoring];
}
-(void)appWillResignActive{
    [self.manager.reachabilityManager stopMonitoring];
}
-(void)appWillBecomeActive{
    [self.manager.reachabilityManager startMonitoring];
}
- (void)didReceiveMemoryWarning{
    [self.manager.reachabilityManager stopMonitoring];
    [self performSelector:@selector(restartReachability) withObject:nil afterDelay:60];
    
}



@end
