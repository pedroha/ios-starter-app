//
//  HAKMainViewController.h
//  StarterApp
//
//  Created by Grace on 2/25/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HAKNetwork;


@interface HAKMainViewController : UIViewController

@property (strong,nonatomic) HAKNetwork *network;


+(HAKMainViewController*) sharedInstance;

-(void)animateToRegistrationView;
-(void)animateToLoginView;

@end
