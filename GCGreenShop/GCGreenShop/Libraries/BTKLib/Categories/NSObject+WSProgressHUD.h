//
//  NSObject+WSProgressHUD.h
//  QQCircle
//
//  Created by Min Lin on 2018/3/11.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WSProgressHUD)

#pragma mark - hud helpers

/**
 加载等待提示框
 */
- (void)showLoadingWithStatus:(NSString *)status;
- (void)showLoadingWithStatus:(NSString *)status maskWithout:(WSProgressHUDMaskWithoutType)withoutType;

/**
 显示提示信息
 */
- (void)showWithStatus:(NSString *)status;

/**
 提示正确信息
 */
- (void)showSuccess:(NSString *)success;

/**
 提示错误信息
 */
- (void)showError:(NSString *)error;

/**
 取消提示
 */
- (void)hideHud;

@end
