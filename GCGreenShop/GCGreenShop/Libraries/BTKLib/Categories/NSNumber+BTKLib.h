//
//  NSNumber+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSNumber (BTKLib)

/**
 *  把字符串转化为ASCII码数组
 */
+ (NSArray *)asciiCodesWithString:(NSString *)string;

/**
 *  把字符串首字母转化为ASCII
 */
+ (int)asciiCodeWithFirstLetterOfString:(NSString *)string;

/**
 *  转换为CGFloat类型的值
 */
- (CGFloat)CGFloatValue;

/**
 *  初始化为CGFloat类型的NSNumber
 */
- (id)initWithCGFloat:(CGFloat)value;
+ (NSNumber *)numberWithCGFloat:(CGFloat)value;

/**
 *  展示
 */
- (NSString *)displayNumberWithDigit:(NSInteger)digit;
- (NSString *)displayPercentageWithDigit:(NSInteger)digit;

/**
 *  四舍五入
 */
- (NSNumber *)roundWithDigit:(NSUInteger)digit;

/**
 *  向上取整
 */
- (NSNumber *)ceilWithDigit:(NSUInteger)digit;

/**
 *  向下取整
 */
- (NSNumber *)floorWithDigit:(NSUInteger)digit;

@end
