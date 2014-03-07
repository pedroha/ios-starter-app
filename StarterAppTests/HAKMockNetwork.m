//
//  HAKMockNetwork.m
//  StarterApp
//
//  Created by Grace on 3/7/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKMockNetwork.h"

@implementation HAKMockNetwork


-(void)postToURL:(NSString*)urlString withParameters:(NSDictionary*)parameters name:(NSString*)name{
    self.urlString = urlString;
    self.parameters = parameters;
}


@end
