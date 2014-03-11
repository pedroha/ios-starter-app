//
//  HAKNetworkReachabiltiy.m
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
