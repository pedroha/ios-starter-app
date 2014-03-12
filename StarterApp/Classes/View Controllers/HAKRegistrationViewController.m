//
//  HAKRegistrationViewController.m
//  StarterApp
//
/*
 The MIT License (MIT)
 
 Copyright (c) 2014 The Hackerati, Inc.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "HAKRegistrationViewController.h"
#import "HAKMainViewController.h"
#import "HAKHelperMethods.h"
#import "HAKNetwork.h"
#import "HAKNotificationConstants.h"

@interface HAKRegistrationViewController ()

@property (strong,nonatomic) HAKNetwork *network;
- (IBAction)backgroundTap:(UIControl *)sender;
- (IBAction)textFieldDoneEditing:(UITextField *)sender;

@end


//NSBundle bundleForClass:[MyViewController class]]

@implementation HAKRegistrationViewController

-(id)initWithNib{
    if (self = [super initWithNibName:@"RegistrationView" bundle:nil]) {
        _network = [[HAKNetwork alloc] init];
        _network.delegate = self;
    }
    return self;
}


-(void)viewDidLoad{
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
    [[HAKMainViewController sharedInstance] animateToSuccessViewFromView:self.view];
}
-(void)networkFailure:(NSString *)name error:(NSError *)error statusCode:(int)statusCode responseDictionary:(NSDictionary *)responseDictionary{
    if(statusCode == 401){
        [HAKHelperMethods showAlert:@"Error" withMessage:kMessageRegisterUserAlreadyExists];
    }else{
        [HAKHelperMethods showAlert:@"Network error" withMessage:kMessageRegisterDefaultErrorMessage];
    }
    
    // If there's an option to use the app without logging in, put that here.
}




#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
