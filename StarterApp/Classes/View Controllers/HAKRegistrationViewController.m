//
//  HAKRegistrationViewController.m
//  StarterApp
//
//  Created by Grace on 2/25/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKRegistrationViewController.h"
#import "HAKMainViewController.h"
#import "HAKHelperMethods.h"

@interface HAKRegistrationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordVerifyField;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;

- (IBAction)onBackPress:(UIButton *)sender;
- (IBAction)onRegisterPress:(UIButton *)sender;

- (IBAction)backgroundTap:(UIControl *)sender;


- (IBAction)emailFieldDoneEditing:(UITextField *)sender;
- (IBAction)passwordFieldDoneEditing:(UITextField *)sender;
- (IBAction)passwordVerifyFieldDoneEditing:(UITextField *)sender;

@end

@implementation HAKRegistrationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
	for(UIButton *button in self.buttonCollection) button.layer.cornerRadius = 16;
}
-(void)doneAnimating{
    [self.emailField becomeFirstResponder];
}


-(void)registerUser{
    if(![HAKHelperMethods validateEmail:self.emailField.text]){
        [HAKHelperMethods showAlert:nil withMessage:@"Please enter a valid email address."];
        return;
    }
    if(![HAKHelperMethods validatePassword:self.passwordField.text]){
        [HAKHelperMethods showAlert:nil withMessage:@"Please enter a password at least 4 characters long."];
        return;
    }
    if(![self.passwordVerifyField.text isEqualToString:self.passwordField.text]){
        [HAKHelperMethods showAlert:nil withMessage:@"Please make sure the password fields match."];
        return;
    }
    
    // TODO - register user
}



#pragma mark - Button Methods

- (IBAction)onBackPress:(UIButton *)sender {
    [[HAKMainViewController sharedInstance] animateToLoginView];
}

- (IBAction)onRegisterPress:(UIButton *)sender {
    [self registerUser];
}

- (IBAction)backgroundTap:(UIControl *)sender {
    [self.view endEditing:YES];
}






#pragma mark - Text Field Methods

- (IBAction)emailFieldDoneEditing:(UITextField *)sender {
    [self.emailField resignFirstResponder];
    [self.passwordField becomeFirstResponder];
}

- (IBAction)passwordFieldDoneEditing:(UITextField *)sender {
    [self.passwordField resignFirstResponder];
    [self.passwordVerifyField becomeFirstResponder];
}

- (IBAction)passwordVerifyFieldDoneEditing:(UITextField *)sender {
    [self.passwordVerifyField resignFirstResponder];
    [self registerUser];
}






#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
