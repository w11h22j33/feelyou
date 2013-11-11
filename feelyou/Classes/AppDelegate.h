//
//  feelyouAppDelegate.h
//  feelyou
//
//  Created by wang hongbo on 12-2-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, strong) UIWindow *window;

@property (readonly,strong,nonatomic)NSManagedObjectContext *managedObjectContext;
@property (readonly,strong,nonatomic)NSManagedObjectModel *managedObjectModel;
@property (readonly,strong,nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

