//
//  HAKMainViewController.h
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
@class HAKNetworkReachabiltiy;

/** HAKMainViewController is in charge of the other view controllers, and choosing what views the user should be seeing.  It's a singleton - to access it from anywhere, use its sharedInstance method.  For example:
 
    [[HAKMainViewController sharedInstance] animateToLoginView]
*/
@interface HAKMainViewController : UIViewController


///---------------------
/// @name Shared Instance
///---------------------


/** Use this to access HAKMainViewController. 
 @return The shared instance of HAKMainViewController
*/
 +(HAKMainViewController*) sharedInstance;


///---------------------
/// @name Network Reachability
///---------------------


/** This is for monitoring network status, such as wifi availability. */
@property (strong,nonatomic) HAKNetworkReachabiltiy *reachability;


///---------------------
/// @name Animation
///---------------------

/** Animate to the registration view from the login view. */
-(void)animateToRegistrationView;

/** Animate to the login view from the registration view. */
-(void)animateToLoginView;

/** Animate to the success view from any view.
 @param view The current view that the user wishes to animate away from.
*/
-(void)animateToSuccessViewFromView:(UIView*)view;

/** Animate from the success view to the login view. */
-(void)animateLogout;
@end
