//
//  BTKJPushManager.m
//  TTReader
//
//  Created by Min Lin on 2018/1/16.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import "BTKJPushManager.h"
#import "TTRouterUtil.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

static NSString *appKey = @"a67c24d6c05f16fe2b96112e";
static NSString *channel = @"APP STORE";
static BOOL isProduction = NO;

@interface BTKJPushManager () <JPUSHRegisterDelegate, UNUserNotificationCenterDelegate>
@end

@implementation BTKJPushManager

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    static BTKJPushManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[BTKJPushManager alloc] init];
    });
    return instance;
}

+ (void)setupWithOptions:(NSDictionary *)launchOptions {
    
    CGFloat systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    if (systemVersion >= 10.0) {
        JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:[BTKJPushManager manager]];
    } else if (systemVersion >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    //Required
    //如需继续使用pushConfig.plist文件申明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions
                           appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
}

+ (void)judgePushOpenedWithHandler:(void(^)(BOOL open))handler {
    
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                if (handler) { handler(true); }
            } else {
                if (handler) { handler(false); }
            }
        }];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIUserNotificationType types = [UIApplication sharedApplication].currentUserNotificationSettings.types;
        if (types == UIUserNotificationTypeNone) {
            if (handler) { handler(false); }
        } else {
            if (handler) { handler(true); }
        }
    }
}

+ (void)open {
    if (@available(iOS 10.0, *)) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = [BTKJPushManager manager];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
            }
        }];
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
    }
}

+ (void)close {
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
}

+ (void)registerDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

+ (void)setBadge:(int)badge {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
    [JPUSHService setBadge:badge];
}

+ (void)adjustAlias:(NSString *)alias {
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        //
    } seq:0];
}

+ (void)fetchRegisterIDCallBack:(void(^)(NSString *registerID))completionHandler {
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if (resCode == 0){
            completionHandler(registrationID);
        }
    }];
}

+ (void)handleRemoteNotification:(NSDictionary *)remoteInfo {
    [JPUSHService handleRemoteNotification:remoteInfo];
    [[self class] setBadge:0];
}

+ (BOOL)apnsIsOpen {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    }
    return NO;
}

+ (void)handleNotificationWithUserInfo:(NSDictionary *)userInfo {
    NSInteger dataId = [[userInfo objectForKey:@"ID"] asInteger];
    NSInteger type = [[userInfo objectForKey:@"Type"] asInteger];
    [TTRouterUtil routeToBoardWithPresentingBoard:[TTTabbarUtil currentViewController] dataId:dataId withinType:type];
}


#pragma mark - JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler {
    
    // Required
    NSDictionary *userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            
            [[self class] handleRemoteNotification:userInfo];
            
            if ([[self class] apnsIsOpen]) {
                NSString *title = [NSString stringWithFormat:@"来自%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:userInfo[@"aps"][@"alert"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[self class] handleNotificationWithUserInfo:userInfo];
                }];
                [alertController addAction:cancelAction];
                [alertController addAction:okAction];
                [[TTTabbarUtil currentTabbarController] presentViewController:alertController animated:YES completion:nil];
            }
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionSound);
    } else {
        // Fallback on earlier versions
    } // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
    // Required
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            
            [[self class] handleRemoteNotification:userInfo];
            
            if ([[self class] apnsIsOpen]) {
                [UIApplication sharedApplication].applicationIconBadgeNumber ++;
                [[self class] handleNotificationWithUserInfo:userInfo];
            }
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();  // 系统要求执行这个方法
}

@end
