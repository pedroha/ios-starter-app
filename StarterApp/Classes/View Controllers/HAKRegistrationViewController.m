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
#import "HAKNetwork.h"

@interface HAKRegistrationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordVerifyField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameField;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;

@property (strong,nonatomic) HAKNetwork *network;

- (IBAction)onBackPress:(UIButton *)sender;
- (IBAction)onRegisterPress:(UIButton *)sender;
- (IBAction)backgroundTap:(UIControl *)sender;
- (IBAction)textFieldDoneEditing:(UITextField *)sender;


@end




@implementation HAKRegistrationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
	for(UIButton *button in self.buttonCollection) button.layer.cornerRadius = 16;
    self.network = [[HAKNetwork alloc] init];
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
    // If first name, last name, or nickname are required for registration, put that code here
    // Otherwise, let them register without that info
    
    [self.network registerNewUserWithEmail:self.emailField.text password:self.passwordField.text firstName:self.firstNameField.text lastName:self.lastNameField.text nickname:self.nicknameField.text];
    
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

- (IBAction)textFieldDoneEditing:(UITextField *)sender {
    int tag = sender.tag;
    if(tag == 6){
        [sender resignFirstResponder];
        [self registerUser];
    }else{
        UITextField *nextField = (UITextField*)[self.view viewWithTag:tag+1];
        [nextField becomeFirstResponder];
    }
}





#pragma mark - Network Delegate Methods

-(void)networkSuccess:(NSString *)name responseDictionary:(NSDictionary *)responseDictionary{
    NSString *statusString = responseDictionary[@"code"];
    NSInteger code = [statusString integerValue];
    if(code == 200){
        [[HAKMainViewController sharedInstance] animateToSuccessViewFromView:self.view];
    }else{
        [HAKHelperMethods showAlert:@"Error" withMessage:responseDictionary[@"error"][@"message"]];
    }
}
-(void)networkFailure:(NSString *)name error:(NSError *)error{
    [HAKHelperMethods showAlert:@"Network error" withMessage:@"We're sorry, registration could not be completed."];
    // If there's an option to use the app without logging in, put that here.
}




#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
