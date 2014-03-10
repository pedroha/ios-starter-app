//
//  HAKMainViewController.m
//  StarterApp
//
//  Created by Grace on 2/25/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//


#import "HAKMainViewController.h"
#import "HAKLoginViewController.h"
#import "HAKRegistrationViewController.h"
#import "HAKSuccessViewController.h"
#import "HAKAppDelegate.h"
#import "HAKNetworkReachabiltiy.h"

@interface HAKMainViewController ()
@property (strong,nonatomic) HAKLoginViewController *loginViewController;
@property (strong,nonatomic) HAKRegistrationViewController *registrationViewController;
@property (strong,nonatomic) HAKSuccessViewController *successViewController;
@end

@implementation HAKMainViewController



- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Uncomment the following line if you need to monitor network access
    //self.reachability = [[HAKNetworkReachabiltiy alloc] init];
    
	self.loginViewController = [[HAKLoginViewController alloc] initWithNibName:@"LoginView" bundle:nil];
    [self.view addSubview:self.loginViewController.view];
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


#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];

}



@end

