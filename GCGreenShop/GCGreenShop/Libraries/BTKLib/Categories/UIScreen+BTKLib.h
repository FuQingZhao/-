//
//  UIScreen+BTKLib.h
//  iNanjing
//
//  Created by Min Lin on 2017/12/27.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 获取顶部的安全区域(仅iPhoneX可用)
#define BTK_SAFE_TOP          [UIScreen safeEdge].top
/// 获取底部的安全区域(仅iPhoneX可用)
#define BTK_SAFE_BOTTOM       [UIScreen safeEdge].bottom
/// 获取状态栏高度
#define BTK_STATUSBAR_HEIGHT  [UIApplication sharedApplication].statusBarFrame.size.height
/// 获取导航栏总高度
#define BTK_NAVIBAR_HEIGHT    [UIScreen navBarHeight]
/// 获取底部Tabbar高度
#define BTK_TABBAR_HEIGHT     [UIScreen tabBarHeight]

/// 获取像素适配(以iPhone6为标准尺寸)
#define BTK_THAT_FITS(pixel)  [UIScreen pixelThatFits:pixel]

/**
 屏幕尺寸管理
 */
@interface UIScreen (BTKLib)

/**
 是否为iPhoneX
 */
+ (BOOL)isIPhoneX;

/**
 获取屏幕宽和高
 */
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

/**
 屏幕宽高适配(iPhone6为标准尺寸)
 */
+ (CGFloat)pixelThatFits:(CGFloat)pixel;

/**
 获取安全区域
 */
+ (UIEdgeInsets)safeEdge;

/**
 获取顶部导航栏高度
 */
+ (CGFloat)navBarHeight;

/**
 获取底部TabBar高度
 */
+ (CGFloat)tabBarHeight;

@end

