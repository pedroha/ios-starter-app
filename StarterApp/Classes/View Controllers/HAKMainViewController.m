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
#import "HAKAppDelegate.h"

@interface HAKMainViewController ()
@property (strong,nonatomic) HAKLoginViewController *loginViewController;
@property (strong,nonatomic) HAKRegistrationViewController *registrationViewController;
@end

@implementation HAKMainViewController



- (void)viewDidLoad{
    [super viewDidLoad];
    
	self.loginViewController = [[HAKLoginViewController alloc] initWithNibName:@"LoginView" bundle:nil];
    [self.view addSubview:self.loginViewController.view];
}



+(id) sharedInstance{
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
    if(self.registrationViewController == nil) self.registrationViewController = [[HAKRegistrationViewController alloc] initWithNibName:@"RegistrationView" bundle:nil];
    
    [self.view addSubview:self.registrationViewController.view];
    [UIView transitionFromView:(self.loginViewController.view)
                        toView:(self.registrationViewController.view)
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:nil];
}

-(void)animateToLoginView{
    if(self.loginViewController == nil) self.loginViewController = [[HAKLoginViewController alloc] initWithNibName:@"LoginView" bundle:nil];
    
    [self.view addSubview:self.registrationViewController.view];
    [UIView transitionFromView:(self.loginViewController.view)
                        toView:(self.registrationViewController.view)
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:nil];
}



#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
    if(self.loginViewController != nil && self.loginViewController.view.superview == nil) self.loginViewController = nil;
    if(self.registrationViewController != nil && self.registrationViewController.view.superview == nil) self.registrationViewController = nil;
    
}



@end

