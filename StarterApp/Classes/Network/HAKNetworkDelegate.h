//
//  HAKNetworkDelegate.h
//  StarterApp
//
//  Created by Grace on 3/7/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HAKNetworkDelegate <NSObject>

-(void)networkSuccess:(NSString*)name responseDictionary:(NSDictionary*)responseDictionary;

-(void)networkFailure:(NSString*)name error:(NSError*)error;



@end
