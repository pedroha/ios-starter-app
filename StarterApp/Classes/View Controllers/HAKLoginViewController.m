//
//  HAKLoginViewController.m
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

#import "HAKLoginViewController.h"
#import "HAKHelperMethods.h"
#import "HAKMainViewController.h"
#import "HAKNetwork.h"
#import "HAKNotificationConstants.h"

@interface HAKLoginViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;
@property (strong,nonatomic) HAKNetwork *network;

- (IBAction)backgroundTap:(UIControl *)sender;
- (IBAction)emailFieldDoneEditing:(UITextField *)sender;
- (IBAction)passwordFieldDoneEditing:(UITextField *)sender;
@end



@implementation HAKLoginViewController

-(id)initWithNib{
    if (self = [super initWithNibName:@"LoginView" bundle:nil]) {
        _network = [[HAKNetwork alloc] init];
        _network.delegate = self;
        _wantsToSaveUserInfo = YES;
    }
    return self;
}

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
-(void)networkFailure:(NSString *)name error:(NSError *)error statusCode:(int)statusCode responseDictionary:(NSDictionary *)responseDictionary{
    if([name isEqualToString:kLoginUser]){
        [self loginErrorForStatusCode:statusCode responseDictionary:responseDictionary];
    }else if([name isEqualToString:kForgotPassword]){
        [self forgotPasswordErrorForStatusCode:statusCode responseDictionary:responseDictionary];
    }
}





#pragma mark - Network Response

-(void)loginSuccessful:(NSDictionary*)dict{
    [[HAKMainViewController sharedInstance] animateToSuccessViewFromView:self.view];
    if(self.wantsToSaveUserInfo){
        [HAKHelperMethods setKeychainUsername:self.emailField.text withPassword:self.passwordField.text];
    }
    
}
-(void)loginErrorForStatusCode:(int)statusCode responseDictionary:(NSDictionary*)responseDictionary{
    if(statusCode == 402){
        [HAKHelperMethods showAlert:@"Login Error" withMessage:kMessageLoginUserDoesntExist];
    }else if(statusCode == 403){
        [HAKHelperMethods showAlert:@"Login Error" withMessage:kMessageLoginPasswordIsIncorrect];
    }else{
        [HAKHelperMethods showAlert:@"Login Error" withMessage:kMessageLoginDefaultErrorMessage];
    }

    // If there's an option to use the app without logging in, put that here.
}

-(void)forgotPasswordSuccessful:(NSDictionary*)dict{
    [HAKHelperMethods showAlert:nil withMessage:[NSString stringWithFormat:@"An email has been sent to %@",self.emailField.text]];
}
-(void)forgotPasswordErrorForStatusCode:(int)statusCode responseDictionary:(NSDictionary*)responseDictionary{
    if(statusCode == 402){
        [HAKHelperMethods showAlert:@"Error" withMessage:kMessageForgotPasswordUserDoesntExist];
    }else{
        [HAKHelperMethods showAlert:@"Error" withMessage:kMessageForgotPasswordDefaultErrorMessage];
    }

    // If there's an option to use the app without logging in, put that here.
}





#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}


@end
