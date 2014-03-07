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
#import "HAKNotificationConstants.h"

@interface HAKLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;

@property (strong,nonatomic) HAKNetwork *network;

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
    self.network = [[HAKNetwork alloc] init];
    
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
    
    [self.network loginUserWithEmail:self.emailField.text andPassword:self.passwordField.text];
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
    [self.network userForgotPassword:self.emailField.text];
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







#pragma mark - Network Delegate Methods

-(void)networkSuccess:(NSString *)name responseDictionary:(NSDictionary *)responseDictionary{
    if([name isEqualToString:kLoginUser]){
        [self loginSuccessful:responseDictionary];
    }else if([name isEqualToString:kForgotPassword]){
        [self forgotPasswordSuccessful:responseDictionary];
    }
}
-(void)networkFailure:(NSString *)name error:(NSError *)error{
    if([name isEqualToString:kLoginUser]){
        [self loginError];
    }else if([name isEqualToString:kForgotPassword]){
        [self forgotPasswordError];
    }
}





#pragma mark - Network Response

-(void)loginSuccessful:(NSDictionary*)dict{
    NSString *statusString = dict[@"code"];
    NSInteger code = [statusString integerValue];
    if(code == 200){
        [[HAKMainViewController sharedInstance] animateToSuccessViewFromView:self.view];
    }else{
        [HAKHelperMethods showAlert:@"Error" withMessage:dict[@"error"][@"message"]];
    }
}
-(void)loginError{
    [HAKHelperMethods showAlert:@"Network error" withMessage:@"We're sorry, log-in could not be completed."];
    // If there's an option to use the app without logging in, put that here.
}

-(void)forgotPasswordSuccessful:(NSDictionary*)dict{
    NSString *statusString = dict[@"code"];
    NSInteger code = [statusString integerValue];
    if(code == 200){
        [HAKHelperMethods showAlert:nil withMessage:[NSString stringWithFormat:@"An email has been sent to %@",self.emailField.text]];
    }else{
        [HAKHelperMethods showAlert:@"Error" withMessage:dict[@"error"][@"message"]];
    }
}
-(void)forgotPasswordError{
    [HAKHelperMethods showAlert:@"Network error" withMessage:@"We're sorry, this operation could not be completed."];
    // If there's an option to use the app without logging in, put that here.
}





#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}


@end
