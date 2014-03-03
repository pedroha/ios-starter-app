//
//  HAKAppDelegate.h
//  StarterApp
//
//  Created by Grace on 2/25/14.
//  Copyright (c) 2014 The Hackerati. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HAKMainViewController;

@interface HAKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) HAKMainViewController *mainView;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
