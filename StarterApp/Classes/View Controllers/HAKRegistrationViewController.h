//
//  HAKRegistrationViewController.h
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


/** The view controller in charge of registration. */
@interface HAKRegistrationViewController : UIViewController <HAKNetworkDelegate>



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

/** A text field in which the user enters their password again, to verify that they entered it correctly. */
@property (weak, nonatomic) IBOutlet UITextField *passwordVerifyField;

/** A text field in which the user enters their first name.  Currently optional, but feel free to make this a requirement. */
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;

/** A text field in which the user enters their last name.  Currently optional, but feel free to make this a requirement. */
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

/** A text field in which the user enters their nickname.  Currently optional, but feel free to make this a requirement. */
@property (weak, nonatomic) IBOutlet UITextField *nicknameField;



///---------------------
/// @name Button Actions
///---------------------

/* Called when the user presses the back button.  Tells HAKMainViewController to animate back to the login screen. */
- (IBAction)onBackPress:(UIButton *)sender;

/** Called when the user presses the register button.  Takes all the info that the user entered into the text fields, and makes a call to the backend API. */
- (IBAction)onRegisterPress:(UIButton *)sender;




///---------------------
/// @name Making Things Pretty
///---------------------

/** An array of buttons to be styled.  All the buttons added to this collection will have their corners rounded. */
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;

/** Called when the animation to the registration view is complete.  Tells the emailField to become the first responder. */
-(void)doneAnimating;


@end
