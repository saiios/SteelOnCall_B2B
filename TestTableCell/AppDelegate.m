//
//  AppDelegate.m
//  TestTableCell
//
//  Created by administrator on 19/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import "AppDelegate.h"
#import "REFrostedViewController.h"
#import "DEMONavigationController.h"
#import "HomeViewController.h"
#import "LeftPanelViewController.h"
#import "ATAppUpdater.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
BOOL shouldRotate;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
[[ATAppUpdater sharedUpdater] showUpdateWithForce];
    // Override point for customization after application launch.
    _itemsArray = [[NSArray alloc]init];
   
    DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    LeftPanelViewController *menuController = [[LeftPanelViewController alloc] initWithNibName:@"LeftPanelViewController" bundle:nil];
    
    // Create frosted view controller
    //
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    
    // Make it a root controller
    [Fabric with:@[[Crashlytics class]]];

    //
    
//#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
//    
//    
//        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
//        view.backgroundColor=[UIColor colorWithRed:87/225 green:22/225 blue:100/225 alpha:1];
//        [self.window.rootViewController.view addSubview:view];
    
    
    self.window.rootViewController = frostedViewController;
     [self.window makeKeyAndVisible];
    return YES;
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (self.shouldRotate) {
        return UIInterfaceOrientationMaskAll;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
