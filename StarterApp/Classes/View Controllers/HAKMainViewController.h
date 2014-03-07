//
//  HAKMainViewController.h
//  StarterApp
//
//  Created by Grace on 2/25/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HAKNetworkReachabiltiy;


@interface HAKMainViewController : UIViewController

@property (strong,nonatomic) HAKNetworkReachabiltiy *reachability;


+(HAKMainViewController*) sharedInstance;

-(void)animateToRegistrationView;
-(void)animateToLoginView;
-(void)animateToSuccessViewFromView:(UIView*)view;

@end
