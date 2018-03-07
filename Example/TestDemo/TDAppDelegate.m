//
//  TDAppDelegate.m
//  TestDemo
//
//  Created by wwhisdavid on 03/07/2018.
//  Copyright (c) 2018 wwhisdavid. All rights reserved.
//

#import "TDAppDelegate.h"
#import "TDViewController.h"

@implementation TDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
    TDViewController *vc = [[TDViewController alloc] init];
    UINavigationController *navgationController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navgationController;
    
    return YES;
}

@end
