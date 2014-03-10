//
//  HAKMockMainViewController.m
//  StarterApp
//
//  Created by Grace on 3/10/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKMockMainViewController.h"
#import <objc/runtime.h>

@interface HAKMockMainViewController ()

@end

@implementation HAKMockMainViewController


+(void)load{
    Method originalAlertMethod = class_getClassMethod([HAKMainViewController class], @selector(sharedInstance));
    Method swappedMethod = class_getClassMethod([HAKMockMainViewController class], @selector(sharedInstanceMock));
    method_exchangeImplementations(originalAlertMethod, swappedMethod);
}


- (void)animateToSuccessViewFromView:(UIView *)view{
    self.animateToSuccessViewCalled = YES;
}
+(HAKMockMainViewController*) sharedInstanceMock{
	static HAKMockMainViewController *SharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		SharedInstance = [[HAKMockMainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	});
	return SharedInstance;
}

@end
