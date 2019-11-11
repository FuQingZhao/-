//
//  TTSandboxUtil.h
//  QQCircle
//
//  Created by Min Lin on 2018/3/9.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kSandboxUserId = @"UMSSandboxUserId";
static NSString * const kSandboxPhone = @"UMSSandboxPhone";
static NSString * const kSandboxPassword = @"UMSSandboxPassword";

@interface TTSandboxUtil : NSObject

/**
 存储用户ID
 */
+ (void)storeUserId:(NSString *)uid;

/**
 从沙盒中取出用户ID
 */
+ (NSString *)userIdFromSandbox;

/**
 存储用户手机号
 */
+ (void)storePhone:(NSString *)phone;

/**
 存储用户密码
 */
+ (void)storePassword:(NSString *)password;

/**
 从沙盒中获取用户手机号码
 */
+ (NSString *)phoneFromSandbox;

/**
 从沙盒中获取密码
 */
+ (NSString *)passwordFromSandbox;

/**
 清除保存的手机号和密码
 */
+ (void)clearLoginInfo;

/**
 删除历史记录
 */
+ (void)removeAllHistory;

/**
 取出历史记录
 */
+ (NSArray *)getHistory;

/**
 存储历史记录
 */
+ (void)insertHistory:(NSString *)hisString;

@end
