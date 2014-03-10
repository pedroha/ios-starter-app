//
//  HAKFakeAlertView.h
//  StarterApp
//
//  Created by Grace on 3/10/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAKFakeAlertView : NSObject
@property BOOL alertHasBeenShown;
+(HAKFakeAlertView*) sharedInstance;
@end


