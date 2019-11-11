//
//  NSObject+WSProgressHUD.m
//  QQCircle
//
//  Created by Min Lin on 2018/3/11.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import "NSObject+WSProgressHUD.h"

@implementation NSObject (WSProgressHUD)

#pragma mark - Hud helpers

- (void)showLoadingWithStatus:(NSString *)status {
    [WSProgressHUD showShimmeringString:status maskType:WSProgressHUDMaskTypeClear maskWithout:WSProgressHUDMaskWithoutNavAndTabbar];
}

- (void)showLoadingWithStatus:(NSString *)status maskWithout:(WSProgressHUDMaskWithoutType)withoutType {
    [WSProgressHUD showShimmeringString:status maskType:WSProgressHUDMaskTypeClear maskWithout:withoutType];
}

- (void)showWithStatus:(NSString *)status {
    [WSProgressHUD showImage:nil status:status maskType:WSProgressHUDMaskTypeClear maskWithout:WSProgressHUDMaskWithoutNavAndTabbar];
}

- (void)showSuccess:(NSString *)success {
    [WSProgressHUD showSuccessWithStatus:success];
}

- (void)showError:(NSString *)error {
    [WSProgressHUD showErrorWithStatus:error];
}

- (void)hideHud {
    [WSProgressHUD dismiss];
}

@end
