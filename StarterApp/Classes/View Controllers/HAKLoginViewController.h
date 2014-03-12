//
//  HAKLoginViewController.h
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

#import <UIKit/UIKit.h>
#import "HAKNetworkDelegate.h"


/**
 The View Controller in charge of logging in.
*/
@interface HAKLoginViewController : UIViewController <HAKNetworkDelegate>



///---------------------
/// @name Initialization
///---------------------

/** Use this to initialize a new view controller.  (ie don't use initWithNibName:bundle:) */
-(id)initWithNib;



///---------------------
/// @name Required Outlets
///---------------------

/** A text field in which the user enters their email address. */
@property (weak, nonatomic) IBOutlet UITextField *emailField;

/** A text field in which the user enters their password. */
@property (weak, nonatomic) IBOutlet UITextField *passwordField;




///---------------------
/// @name Button Actions
///---------------------


/** Called when the user presses the login button. */
- (IBAction)onLoginPress:(UIButton *)sender;

/** Called when the user presses the register button. */
- (IBAction)onRegisterPress:(UIButton *)sender;

/** Called when the user presses the forget-password button. */
- (IBAction)onForgotPasswordPress:(UIButton *)sender;




///---------------------
/// @name Saving Info
///---------------------


/** Indicates whether the user wants their login info saved, so they don't have to log in the next time they use the app.  Currently it is always set to YES.  Feel free to delete this, and replace it with, for instance, a segmented control. */
@property (assign,nonatomic) BOOL wantsToSaveUserInfo;


@end



