//
//  TTAppDelegate+Util.m
//  TTReader
//
//  Created by LinMin on 2017/12/31.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "TTAppDelegate+Util.h"
#import <BaiduMobStat/BaiduMobStat.h>
//#import <BMKLocationKit/BMKLocationAuth.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import "TTSandboxUtil.h"

@interface TTAppDelegate ()
//<BMKLocationAuthDelegate>

@end

static NSString* const kUMAppKey = @"5a9f8f5f8f4a9d043c000545";
static NSString* const kBDMobAppId = @"2a8c0b607a";
//static NSString* const kBaiDuKey = @"R5k4nuL4qrHzrWF1GzS43Ao7Uf7ZZo2l";

@implementation TTAppDelegate (Util)

- (void)setupConfigurationWithLaunchOptions:(NSDictionary *)launchOptions {
    
    // 设置Host
    [TTAppConfiguration configure].defHost = @"http://lcapi.elcst.com";
    [TTAppConfiguration configure].phpDefHost = @"http://app.elcst.com/index.php";
    [UMSAppConfiguration configure].defHost = @"http://lcapi.elcst.com/user";
    
    // 日志开关
#ifdef DEBUG
    [BTKNetworkManager openLog];
#endif
}

- (void)configureAnalyticsTool {
    
    /**
     添加友盟统计
     zhaopengfei@elcst.com  Lcst123411
     */
//    [UMConfigure initWithAppkey:kUMAppKey channel:@"App Store"];
//    [MobClick setScenarioType:E_UM_NORMAL];
//    [MobClick setCrashReportEnabled:YES];
    
    /**
     添加百度统计
     13298366392  Lcst123411
     */
//    BaiduMobStat *baiduMob = [BaiduMobStat defaultStat];
//    baiduMob.enableExceptionLog = YES;
//    baiduMob.channelId = @"AppStore";
//    baiduMob.logStrategy = BaiduMobStatLogStrategyAppLaunch;
//    baiduMob.shortAppVersion = BTK_VERSION_BUILD;
//    [baiduMob startWithAppId:kBDMobAppId];
}

- (void)configureKeyboardManager {
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
}

- (void)configureReachability {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"未连接");
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            //
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            //
        }
    }];
}

- (void)configureJPUSHService:(NSDictionary *)launchOptions {
    [BTKJPushManager setupWithOptions:launchOptions];
    [BTKJPushManager setBadge:0];
}

/*定位*/
//- (void)startLocating {
//    //百度地图定位
//    [[TTLocationManager shareInstance] startBMKLocationWithReg:^(BMKUserLocation *loction, NSError *error) {
//        if (error) {
//            TTLog(@"定位失败,失败原因：%@",error);
//        }
//        else
//        {
//            TTLog(@"定位信息：%f,%f",loction.location.coordinate.latitude,loction.location.coordinate.longitude);
//            [UMSSDK currentUser].location = loction.location.coordinate;
////            DDLogError(@"定位信息：%f,%f",loction.location.coordinate.latitude,loction.location.coordinate.longitude);
//        }
//    }];
//}

- (void)startUp {
    
    /**
     启动接口
     */
//    [TTInitialViewModel startUpWithResult:^(TTInitial *initial, NSError *error) {
//        [TTAppConfiguration configure].initial = initial;
//    }];
    
    /**
     自动登录
     */
    NSString *phone = [TTSandboxUtil phoneFromSandbox];
    NSString *password = [TTSandboxUtil passwordFromSandbox];
    NSString *userId = [TTSandboxUtil userIdFromSandbox];
    if ([phone length] > 0 && [password length] > 0) {
        [UMSSDK loginWithPhone:phone password:password result:^(UMSUser *user, NSError *error) {
            [UMSUser copyUserData:user];
            NSLog(@"自动登录成功~");
        }];
    } else if ([userId length] > 0) {
        [UMSSDK getUserInfo:userId result:^(UMSUser *user, NSError *error) {
            [UMSUser copyUserData:user];
            NSLog(@"自动登录成功~");
        }];
    }
}


#pragma mark - UIApplicationDelegate

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //[LCAppVersionUtil checkAppVersion:NO];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [BTKJPushManager setBadge:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [BTKJPushManager setBadge:0];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [BTKJPushManager registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [BTKJPushManager handleRemoteNotification:userInfo];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0 && [BTKJPushManager apnsIsOpen]) {
        
        UIApplicationState state = [UIApplication sharedApplication].applicationState;
        
        // App处于后台时的处理
        if (UIApplicationStateInactive == state || UIApplicationStateBackground == state) {
            [UIApplication sharedApplication].applicationIconBadgeNumber ++;
            [BTKJPushManager handleNotificationWithUserInfo:userInfo];
        }
        // App处于前台时的处理
        else if (UIApplicationStateActive == state) {
            //
        }
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
