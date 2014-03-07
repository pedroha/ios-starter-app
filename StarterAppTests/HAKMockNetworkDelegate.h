//
//  HAKMockNetworkDelegate.h
//  StarterApp
//
//  Created by Grace on 3/7/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HAKNetworkDelegate.h"

@interface HAKMockNetworkDelegate : NSObject <HAKNetworkDelegate>

@property BOOL successCalled;
@property BOOL failureCalled;

@property NSError *networkError;
@property NSDictionary *networkResponse;


@end
