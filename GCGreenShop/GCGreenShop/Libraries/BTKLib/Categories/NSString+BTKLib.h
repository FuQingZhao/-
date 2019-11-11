//
//  NSString+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BTKLib)

+ (NSString *)stringWithInt:(int)intValue;
+ (NSString *)stringWithInteger:(NSInteger)integer;
+ (NSString *)stringWithFloat:(float)floatValue;
+ (NSString *)stringWithFloat:(float)floatValue decimalNumber:(int)decimalNumber;  // decimalNumber表示保留几位小数
+ (NSString *)stringWithData:(NSData *)data;

+ (NSString *)stringWithMMSSFromSeconds:(NSTimeInterval)secs;
+ (NSString *)stringWithHHMMSSFromSeconds:(NSTimeInterval)secs;


#pragma mark - Helpers

- (BOOL)isBlank;
- (BOOL)isValid;

- (BOOL)is:(NSString *)string;
- (BOOL)isBeginWith:(NSString *)string;
- (BOOL)isEndWith:(NSString *)string;

- (NSString *)replaceString:(NSString *)oldStr withNew:(NSString *)newStr;
- (NSString *)substringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)appendString:(NSString *)string;
- (NSString *)removeString:(NSString *)string;

- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;

- (NSData *)convertToData;

@end
