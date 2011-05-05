//
//  MyTableAppDelegate.h
//  MyTable
//
//  Created by Shaokun Wu on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTableViewController;

@interface MyTableAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MyTableViewController *viewController;

@property (nonatomic, retain) UINavigationController *navigationController;

@end
