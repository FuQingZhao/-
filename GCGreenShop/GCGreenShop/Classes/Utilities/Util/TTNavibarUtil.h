//
//  TTNavibarUtil.h
//  QQCircle
//
//  Created by Min Lin on 2018/3/7.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const defNaviTitleColor = @"#3c454b";
static CGFloat const defNaviTitleFontSize = 18.5;

@interface TTNavibarUtil : NSObject

// 设置NavigationBar属性
+ (void)customNaviBar;

// 设置背景色
+ (void)configureBackgroundColor:(UIColor *)backgroundColor;

// 设置前景色
+ (void)configureForegroundColor:(UIColor *)foregroundColor;

@end
