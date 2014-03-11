//
//  HAKFakeAlertView.m
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

#import "HAKFakeAlertView.h"
#import <objc/runtime.h>


/*
@interface UIAlertView (HAKUnitTests)
-(void)showForUnitTest;
@end

@implementation UIAlertView (HAKUnitTests)
-(void)showForUnitTest{
    [HAKFakeAlertView sharedInstance].alertHasBeenShown = YES;
}

@end
*/


@implementation HAKFakeAlertView
+(HAKFakeAlertView*) sharedInstance{
	static HAKFakeAlertView *SharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		SharedInstance = [[HAKFakeAlertView alloc] init];
	});
	return SharedInstance;
}



/*
 All the alert calls are currently going through HAKHelperMethods.
 If this changes, reinstate method swizzling here to test UIAlertView.
 
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalAlertMethod = class_getInstanceMethod([UIAlertView class], @selector(show));
        Method swappedMethod = class_getInstanceMethod([UIAlertView class], @selector(showForUnitTest));
        method_exchangeImplementations(originalAlertMethod, swappedMethod);
    });
}
 */


@end
