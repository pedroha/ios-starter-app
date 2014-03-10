//
//  HAKLoginViewController.h
//  StarterApp
//
//  Created by Grace on 2/25/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HAKNetworkDelegate.h"

@interface HAKLoginViewController : UIViewController <HAKNetworkDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


-(id)initWithNib;

- (IBAction)onLoginPress:(UIButton *)sender;
- (IBAction)onRegisterPress:(UIButton *)sender;
- (IBAction)onForgotPasswordPress:(UIButton *)sender;

@end
