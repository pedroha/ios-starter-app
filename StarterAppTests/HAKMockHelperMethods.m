//
//  HAKMockHelperMethods.m
//  StarterApp
//
//  Created by Grace on 3/11/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKMockHelperMethods.h"
#import "HAKHelperMethods.h"
#import "HAKFakeAlertView.h"
#import <objc/runtime.h>



@interface HAKHelperMethods (HAKUnitTests)
+(void) mock_showAlert:(NSString*)title withMessage:(NSString*)description;
@end

@implementation HAKHelperMethods (HAKUnitTests)

+(void) mock_showAlert:(NSString*)title withMessage:(NSString*)description{
    [HAKMockHelperMethods sharedInstance].messageShown = description;
    [HAKFakeAlertView sharedInstance].alertHasBeenShown = YES;
}
@end





@implementation HAKMockHelperMethods


+(HAKMockHelperMethods*) sharedInstance{
	static HAKMockHelperMethods *SharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		SharedInstance = [[HAKMockHelperMethods alloc] init];
	});
	return SharedInstance;
}
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalAlertMethod = class_getClassMethod([HAKHelperMethods class], @selector(showAlert:withMessage:));
        Method swappedMethod = class_getClassMethod([HAKHelperMethods class], @selector(mock_showAlert:withMessage:));
        method_exchangeImplementations(originalAlertMethod, swappedMethod);
    });
}

@end
