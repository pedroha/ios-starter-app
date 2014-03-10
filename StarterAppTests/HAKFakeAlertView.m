//
//  HAKFakeAlertView.m
//  StarterApp
//
//  Created by Grace on 3/10/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKFakeAlertView.h"
#import <objc/runtime.h>

@interface UIAlertView (HAKUnitTests)
-(void)showForUnitTest;
@end

@implementation UIAlertView (HAKUnitTests)
-(void)showForUnitTest{
    [HAKFakeAlertView sharedInstance].alertHasBeenShown = YES;
}

@end



@implementation HAKFakeAlertView
+(HAKFakeAlertView*) sharedInstance{
	static HAKFakeAlertView *SharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		SharedInstance = [[HAKFakeAlertView alloc] init];
	});
	return SharedInstance;
}
+(void)load{
    Method originalAlertMethod = class_getInstanceMethod([UIAlertView class], @selector(show));
    Method swappedMethod = class_getInstanceMethod([UIAlertView class], @selector(showForUnitTest));
    method_exchangeImplementations(originalAlertMethod, swappedMethod);
}
@end
