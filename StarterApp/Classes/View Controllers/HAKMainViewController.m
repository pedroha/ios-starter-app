//
//  HAKMainViewController.m
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


#import "HAKMainViewController.h"
#import "HAKLoginViewController.h"
#import "HAKRegistrationViewController.h"
#import "HAKSuccessViewController.h"
#import "HAKAppDelegate.h"
#import "HAKNetworkReachabiltiy.h"
#import "HAKHelperMethods.h"

@interface HAKMainViewController ()
@property (strong,nonatomic) HAKLoginViewController *loginViewController;
@property (strong,nonatomic) HAKRegistrationViewController *registrationViewController;
@property (strong,nonatomic) HAKSuccessViewController *successViewController;
@end

@implementation HAKMainViewController



- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Uncomment the following line if you need to monitor network access
    //[self setupReachability];
    
    if([self isUserInfoSavedInKeychain]){
        self.successViewController = [[HAKSuccessViewController alloc] initWithNibName:@"SuccessView" bundle:nil];
        [self.view addSubview:self.successViewController.view];
    }else{
        self.loginViewController = [[HAKLoginViewController alloc] initWithNib];
        [self.view addSubview:self.loginViewController.view];
    }

}

-(void)setupReachability{
    self.reachability = [[HAKNetworkReachabiltiy alloc] init];
}

-(BOOL)isUserInfoSavedInKeychain{
    NSString *userName = [HAKHelperMethods getKeychainUsername];
    NSString *userPassword = [HAKHelperMethods getKeychainPassword];
    
    if(userName.length > 0 && userPassword.length > 0){
        return YES;
    }
    return NO;
}




+(HAKMainViewController*) sharedInstance{
    // Use [HAKMainViewController sharedInstance] in any class to access the shared instance
    
	static HAKMainViewController *SharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		SharedInstance = [[HAKMainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	});
	return SharedInstance;
}



#pragma mark - View Controllers

-(void)animateToRegistrationView{
    if(self.registrationViewController == nil) self.registrationViewController = [[HAKRegistrationViewController alloc] initWithNib];
    
    [self.view addSubview:self.registrationViewController.view];
    
    [UIView transitionFromView:(self.loginViewController.view)
                        toView:(self.registrationViewController.view)
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:^(BOOL finished){
                        [self.loginViewController.view removeFromSuperview];
                        self.loginViewController = nil;
                        [self.registrationViewController doneAnimating];
                    }];
}

-(void)animateToLoginView{
    if(self.loginViewController == nil) self.loginViewController = [[HAKLoginViewController alloc] initWithNib];
    
    [self.view addSubview:self.loginViewController.view];
    
    [UIView transitionFromView:(self.registrationViewController.view)
                        toView:(self.loginViewController.view)
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished){
                        [self.registrationViewController.view removeFromSuperview];
                        self.registrationViewController = nil;
                    }];
}

-(void)animateToSuccessViewFromView:(UIView*)view{
    if(self.successViewController == nil) self.successViewController = [[HAKSuccessViewController alloc] initWithNibName:@"SuccessView" bundle:nil];
    
    [self.view addSubview:self.successViewController.view];
    
    [UIView transitionFromView:view
                        toView:(self.successViewController.view)
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished){
                        [view removeFromSuperview];
                        self.registrationViewController = nil;
                        self.loginViewController = nil;
                    }];
}

-(void)animateLogout{
    [HAKHelperMethods resetKeychain];
    
    if(self.loginViewController == nil) self.loginViewController = [[HAKLoginViewController alloc] initWithNib];
    [self.view addSubview:self.loginViewController.view];
    
    [UIView transitionFromView:self.successViewController.view
                        toView:self.loginViewController.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:^(BOOL finished) {
                        [self.successViewController.view removeFromSuperview];
                        self.successViewController = nil;
                    }];
}


#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];

}



@end

