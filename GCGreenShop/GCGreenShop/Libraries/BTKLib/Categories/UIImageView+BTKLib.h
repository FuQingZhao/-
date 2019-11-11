//
//  UIImageView+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/10.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (BTKLib)

/**
 根据bundle中的图片名创建imageview
 @param  imageName bundle中的图片名
 @return imageview
 */
+ (id)imageViewWithImageNamed:(NSString *)imageName;

/**
 根据frame创建imageview
 @param  frame imageview frame
 @return imageview
 */
+ (id)imageViewWithFrame:(CGRect)frame;

/**
 根据frame和图片名称创建imageview
 @param  imageName bundle中的图片名
 @param  frame imageview frame
 @return imageview
 */
+ (id)imageViewWithImage:(NSString *)imageName frame:(CGRect)frame;
+ (id)imageViewWithStretchableImage:(NSString *)imageName frame:(CGRect)frame;

/**
 创建imageview动画
 @param imageArray 图片名称数组
 @param duration   动画时间
 @return imageview
 */
+ (id)imageViewWithImageArray:(NSArray *)imageArray duration:(NSTimeInterval)duration;

/**
 创建可拉伸的图片
 @param imageName 目标图片名称
 */
- (void)setImageWithStretchableImage:(NSString *)imageName;

/**
 创建图片水印
 @param image 目标图片
 @param mark  水印图片
 @param rect  水印图片所在位置
 */
- (void)setImage:(UIImage *)image waterMark:(UIImage *)mark inRect:(CGRect)rect;

/**
 创建文字水印
 @param image      目标图片
 @param markString 水印文字
 @param rect       水印文字所在位置
 @param color      文字颜色
 @param font       字体
 */
- (void)setImage:(UIImage *)image waterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (void)setImage:(UIImage *)image waterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;

/**
 倒影
 */
- (void)reflect;

@end
