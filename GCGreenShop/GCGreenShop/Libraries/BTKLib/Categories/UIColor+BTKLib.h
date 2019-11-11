//
//  UIColor+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/10.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef    RGBA
#define RGBA(R,G,B,A)     [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#undef    RGB
#define RGB(R,G,B)        RGBA(R, G, B, 1.0f)

#undef    HEX_RGB
#define HEX_RGB(V)        [UIColor colorWithHex:V]

#undef    HEX_RGBA
#define HEX_RGBA(V, A)    [UIColor colorWithHex:V alpha:A]

#undef    SHORT_RGB
#define SHORT_RGB(V)      [UIColor colorWithShortHex:V]

@interface UIColor (BTKLib)

+ (UIColor *)colorWithHex:(NSUInteger)hex;
+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithShortHex:(NSUInteger)hex;
+ (UIColor *)colorWithShortHex:(NSUInteger)hex alpha:(CGFloat)alpha;

/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor *)gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 withHeight:(int)height;

/**
 *  @brief  获取canvas用的颜色字符串
 *
 *  @return canvas颜色
 */
- (NSString *)canvasColorString;

/**
 *  @brief  获取网页颜色字串
 *
 *  @return 网页颜色
 */
- (NSString *)webColorString;

/**
 *  @brief  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)randomColor;

@end
