//
//  AppDelegate.m
//  生活助手
//
//  Created by 杨晓鸣 on 16/9/19.
//  Copyright © 2016年 杨晓鸣. All rights reserved.
//

#import "AppDelegate.h"
#import "VCBme.h"
#import "VCBFirst.h"
#import "VCBSecond.h"
#import "VCBThird.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    VCBFirst* vcFirst = [[VCBFirst alloc]init];
    VCBSecond* vcSecond = [[VCBSecond alloc]init];
    VCBThird* vcThird = [[VCBThird alloc]init];
    VCBme* vcMe = [[VCBme alloc]init];
    
    //设置控制器的标题
    vcFirst.title = @"微信精选";
    vcSecond.title = @"新闻精选";
    vcThird.title = @"生活助手";
    vcMe.title = @"我的";
    
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vcFirst];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vcSecond];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:vcThird];
    UINavigationController *navMe = [[UINavigationController alloc]initWithRootViewController:vcMe];
    
    NSArray* arrVC = [NSArray arrayWithObjects:nav1,nav2,nav3,navMe, nil];
    
    UITabBarController* tbcVC = [[UITabBarController alloc]init];
    tbcVC.viewControllers = arrVC;
    
    self.window.rootViewController = tbcVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
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
