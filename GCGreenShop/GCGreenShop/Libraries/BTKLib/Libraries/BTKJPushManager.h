//
//  BTKJPushManager.h
//  TTReader
//
//  Created by Min Lin on 2018/1/16.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 极光推送管理
 */
@interface BTKJPushManager : NSObject

/**
 单例
 */
+ (instancetype)manager;

/**
 在应用启动的时候调用(AppKey在.m文件里修改)
 */
+ (void)setupWithOptions:(NSDictionary *)options;

/**
 判断推送是否打开
 */
+ (void)judgePushOpenedWithHandler:(void(^)(BOOL open))handler;

/**
 打开推送
 */
+ (void)open;

/**
 关闭推送
 */
+ (void)close;

/**
 在appdelegate注册设备处调用
 */
+ (void)registerDeviceToken:(NSData *)deviceToken;

/**
 调整别名
 */
+ (void)adjustAlias:(NSString *)alias;

/**
 设置角标
 */
+ (void)setBadge:(int)badge;

/**
 获取注册ID
 */
+ (void)fetchRegisterIDCallBack:(void(^)(NSString *registerID))completionHandler;

/**
 处理推送信息
 */
+ (void)handleRemoteNotification:(NSDictionary *)remoteInfo;

/**
 推送是否打开
 */
+ (BOOL)apnsIsOpen;

/**
 处理接收到的通知内容(跳转的处理)
 */
+ (void)handleNotificationWithUserInfo:(NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
