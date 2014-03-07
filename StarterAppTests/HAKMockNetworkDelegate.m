//
//  HAKMockNetworkDelegate.m
//  StarterApp
//
//  Created by Grace on 3/7/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKMockNetworkDelegate.h"


@implementation HAKMockNetworkDelegate

-(void)networkSuccess:(NSString *)name responseDictionary:(NSDictionary *)responseDictionary{
    self.networkResponse = responseDictionary;
    self.successCalled = YES;
}


-(void)networkFailure:(NSString *)name error:(NSError *)error{
    self.networkError = error;
    self.failureCalled = YES;
}




@end
