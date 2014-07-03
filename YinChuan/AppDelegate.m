//
//  AppDelegate.m
//  YinChuan
//
//  Created by mark on 14-6-10.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "CustomNavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    if (IOS7) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top.jpg"]
                                           forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    } else {
//        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top.jpg"]
//                                           ®forBarMetrics:UIBarMetricsDefault];
        
        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:4.0f
                                                           forBarMetrics:UIBarMetricsDefault];
        
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:51.0/255.0
                                                                   green:143.0/255.0
                                                                    blue:210.0/255.0
                                                                   alpha:1]];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor    = [UIColor whiteColor];
    
    RootViewController *root       = [[RootViewController alloc] init];
    self.window.rootViewController = [[CustomNavigationController alloc]
                                      initWithRootViewController:root];
    [self.window makeKeyAndVisible];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"GZKTTj1Pe1FScRRgKqBUrxEp"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
