//
//  UIView+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BTKViewBorderRadius(view, radius, width, color) \
[view setCornerRadius:(radius)]; \
[view.layer setMasksToBounds:YES]; \
[view.layer setBorderWidth:(width)]; \
[view.layer setBorderColor:[color CGColor]];

static CGFloat const kDefaultLineThick = 0.6;

@interface UIView (BTKLib)

/**
 添加一条直线
 */
- (CALayer *)drawLineInRect:(CGRect)rect tintColor:(UIColor *)tintColor;
- (CALayer *)drawLineInRect:(CGRect)rect;

/**
 删除直线
 */
- (void)undrawLine;

/**
 在Context中使用DrawRect方式画线
 */
- (void)drawLineInContext:(CGContextRef)context edgeInsets:(UIEdgeInsets)insets;
- (void)drawLineWithEdgeInsets:(UIEdgeInsets)insets;

/**
 在Context中使用DrawRect方式画图形
 */
- (void)drawLineInContext:(CGContextRef)context withHeight:(CGFloat)height;
- (void)drawLineWithHeight:(CGFloat)height;

@end
