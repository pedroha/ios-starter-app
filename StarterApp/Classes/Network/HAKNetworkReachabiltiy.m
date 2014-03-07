//
//  HAKNetworkReachabiltiy.m
//  StarterApp
//
//  Created by Grace on 3/7/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKNetworkReachabiltiy.h"
#import "AFNetworking.h"
#import "HAKNotificationConstants.h"

@interface HAKNetworkReachabiltiy()

@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;

@end


@implementation HAKNetworkReachabiltiy

- (id)init{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLAddress]];
        
        [self setupReachability];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        
    }
    return self;
}




- (void)setupReachability{
    NSOperationQueue *operationQueue = _manager.operationQueue;
    __block HAKNetworkReachabiltiy *blockSelf = self;
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
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
