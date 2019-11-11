//
//  TTNavibarUtil.m
//  QQCircle
//
//  Created by Min Lin on 2018/3/7.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import "TTNavibarUtil.h"

#import "WRNavigationBar.h"

@implementation TTNavibarUtil

+ (void)customNaviBar {
    
    /*
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"#333333"]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    // Uncomment to change the back indicator image
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage new]];
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    UIColor *naviTitleColor = [UIColor colorWithHexString:defNaviTitleColor];
    UIFont *naviTitleFont = [UIFont systemFontOfSize:defNaviTitleFontSize];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: naviTitleColor, NSFontAttributeName: naviTitleFont};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
     */
    
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor whiteColor]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:TT_BLACK_COLOR];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:TT_BLACK_COLOR];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleDefault];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
//    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}

+ (void)configureBackgroundColor:(UIColor *)backgroundColor {
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:backgroundColor]
//                                       forBarMetrics:UIBarMetricsDefault];
}

+ (void)configureForegroundColor:(UIColor *)foregroundColor {
//    UIColor *naviTitleColor = foregroundColor;
//    UIFont *naviTitleFont = [UIFont systemFontOfSize:defNaviTitleFontSize];
//    NSDictionary *attributes = @{NSForegroundColorAttributeName: naviTitleColor, NSFontAttributeName: naviTitleFont};
//    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
}

@end
