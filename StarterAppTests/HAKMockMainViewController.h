//
//  HAKMockMainViewController.h
//  StarterApp
//
//  Created by Grace on 3/10/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import "HAKMainViewController.h"

@interface HAKMockMainViewController : HAKMainViewController
@property BOOL animateToSuccessViewCalled;
+(HAKMockMainViewController*) sharedInstanceMock;
@end
