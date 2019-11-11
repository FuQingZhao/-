//
//  TTTabbarUtil.h
//  QQCircle
//
//  Created by Min Lin on 2018/3/7.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CYLTabBarController/CYLTabBarController.h>
#import "BTKNavigationController.h"

@interface TTTabbarUtil : NSObject

/**
 注册中间加号按钮
 */
+ (void)registerPlusButton;

/**
 按照参数配置TabBarController
 */
+ (CYLTabBarController *)tabBarControllerWithConfigure;

/**
 根据Index获取对应的ViewController
 */
+ (UIViewController *)viewBoardWithTabBarAtIndex:(NSUInteger)index withClass:(Class)className;

/**
 当前的TabbarController
 */
+ (CYLTabBarController *)currentTabbarController;

/**
 当前正选中的Item对应的NavigationController
 */
+ (BTKNavigationController *)currentNavigationController;

/**
 当前正选中的Item对应的ViewController
 */
+ (UIViewController *)currentViewController;

@end
