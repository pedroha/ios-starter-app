//
//  HAKRegistrationViewController.h
//  StarterApp
//
//  Created by Grace on 2/25/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HAKNetworkDelegate.h"

@interface HAKRegistrationViewController : UIViewController <HAKNetworkDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordVerifyField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameField;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;



-(void)doneAnimating;
-(id)initWithNib;

- (IBAction)onBackPress:(UIButton *)sender;
- (IBAction)onRegisterPress:(UIButton *)sender;
- (IBAction)backgroundTap:(UIControl *)sender;
- (IBAction)textFieldDoneEditing:(UITextField *)sender;



@end
