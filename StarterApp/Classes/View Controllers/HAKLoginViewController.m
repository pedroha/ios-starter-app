//
//  HAKLoginViewController.m
//  StarterApp
//
//  Created by Grace on 2/25/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKLoginViewController.h"
#import "HAKHelperMethods.h"
#import "HAKMainViewController.h"
#import "HAKNetwork.h"

@interface HAKLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;

- (IBAction)onLoginPress:(UIButton *)sender;
- (IBAction)onRegisterPress:(UIButton *)sender;
- (IBAction)onForgotPasswordPress:(UIButton *)sender;
- (IBAction)backgroundTap:(UIControl *)sender;
- (IBAction)emailFieldDoneEditing:(UITextField *)sender;
- (IBAction)passwordFieldDoneEditing:(UITextField *)sender;

@end



@implementation HAKLoginViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    //format buttons
	for(UIButton *button in self.buttonCollection) button.layer.cornerRadius = 16;
    UIButton *twoLineButton = (UIButton*)[self.view viewWithTag:1];
    [twoLineButton.titleLabel setTextAlignment: NSTextAlignmentCenter];

}

-(void)login{
    if(![HAKHelperMethods validateEmail:self.emailField.text]){
        [HAKHelperMethods showAlert:nil withMessage:@"Please enter a valid email address."];
        return;
    }
    if(![HAKHelperMethods validatePassword:self.passwordField.text]){
        [HAKHelperMethods showAlert:nil withMessage:@"Please enter a password at least 4 characters long"];
        return;
    }
    
    [[HAKMainViewController sharedInstance].network loginUserWithEmail:self.emailField.text andPassword:self.passwordField.text];
}










#pragma mark - Button Methods

- (IBAction)onLoginPress:(UIButton *)sender {
    [self login];
}

- (IBAction)onRegisterPress:(UIButton *)sender {
    [[HAKMainViewController sharedInstance] animateToRegistrationView];
}

- (IBAction)onForgotPasswordPress:(UIButton *)sender {
    if(![HAKHelperMethods validateEmail:self.emailField.text]){
        [HAKHelperMethods showAlert:nil withMessage:@"Please enter a valid email address."];
        return;
    }
    [[HAKMainViewController sharedInstance].network userForgotPassword:self.emailField.text];
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
    [self login];
}






#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
