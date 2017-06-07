//
//  AppDelegate.h
//  TestTableCell
//
//  Created by administrator on 19/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain)NSArray *itemsArray;
@property(assign,nonatomic)BOOL shouldRotate;


@end

