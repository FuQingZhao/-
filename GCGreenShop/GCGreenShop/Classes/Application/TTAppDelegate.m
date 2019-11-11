//
//  AppDelegate.m
//  GCGreenShop
//
//  Created by 付清照 on 2019/11/11.
//  Copyright © 2019 FuQingZhao. All rights reserved.
//

#import "TTAppDelegate.h"
#import "TTAppDelegate+Util.h"

@interface TTAppDelegate ()

@end

@implementation TTAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.launchOptions = launchOptions;
    
    [self configureKeyboardManager];
    [self configureReachability];
    [self configureAnalyticsTool];
    [self configureJPUSHService:launchOptions];
    
    /**
     App启动时，一些信息的配置
     */
    [self setupConfigurationWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 设置根视图
    CYLTabBarController *tabBarController = [TTTabbarUtil tabBarControllerWithConfigure];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    // 自定义导航栏
    [TTNavibarUtil customNaviBar];
    [TTNavibarUtil configureForegroundColor:TT_BLACK_COLOR];
    
    /** 开启定位 */
//    [self startLocating];
    
    // 启动时的请求
//    [self startUp];
    
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
