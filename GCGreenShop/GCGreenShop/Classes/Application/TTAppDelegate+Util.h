//
//  TTAppDelegate+Util.h
//  TTReader
//
//  Created by LinMin on 2017/12/31.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "TTAppDelegate.h"
#import <CYLTabBarController/CYLTabBarController.h>

@interface TTAppDelegate (Util)

/**
 App信息配置
 */
- (void)setupConfigurationWithLaunchOptions:(NSDictionary *)launchOptions;

/**
 配置统计分析工具
 */
- (void)configureAnalyticsTool;

/**
 键盘管理
 */
- (void)configureKeyboardManager;

/**
 网络状态监听
 */
- (void)configureReachability;

/**
 配置极光推送
 */
- (void)configureJPUSHService:(NSDictionary *)launchOptions;

/**
 开始定位
 */
- (void)startLocating;

/**
 启动接口请求
 */
- (void)startUp;

@end
