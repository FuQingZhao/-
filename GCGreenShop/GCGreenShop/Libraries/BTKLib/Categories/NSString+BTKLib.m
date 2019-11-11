//
//  NSString+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "NSString+BTKLib.h"

@implementation NSString (BTKLib)

#pragma mark - Type Conversation

+ (NSString *)stringWithInt:(int)intValue {
    return [NSString stringWithFormat:@"%d", intValue];
}

+ (NSString *)stringWithInteger:(NSInteger)integer {
    return [NSString stringWithFormat:@"%ld", (long)integer];
}

+ (NSString *)stringWithFloat:(float)floatValue {
    return [NSString stringWithFormat:@"%.0f", floatValue];
}

+ (NSString *)stringWithFloat:(float)floatValue decimalNumber:(int)decimalNumber {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:decimalNumber];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:floatValue]];
}

+ (NSString *)stringWithData:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringWithMMSSFromSeconds:(NSTimeInterval)secs {
    return [NSString stringWithFormat:@"%02d:%02d", ((int)secs / 60), ((int)secs % 60)];
}

+ (NSString *)stringWithHHMMSSFromSeconds:(NSTimeInterval)secs {
    if (secs >= 3600) {
        int hours = secs / 3600;
        int minutes = (secs - hours * 3600) / 60;
        int seconds = (NSInteger)secs % 60;
        return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
    else {
        return [[self class] stringWithMMSSFromSeconds:secs];
    }
}


#pragma mark - Helpers

// Checking if String is Empty
- (BOOL)isBlank {
    return ([[self trim] isEqualToString:@""]) ? YES : NO;
}

//Checking if String is empty or nil
- (BOOL)isValid {
    return (self == nil || [self isKindOfClass:[NSNull class]]) ? NO :YES;
}

// Trim white space
- (NSString *)trim {
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

- (BOOL)is:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]] || !string) {
        return NO;
    }
    return [self isEqualToString:string];
}

// If my string starts with given string
- (BOOL)isBeginWith:(NSString *)string {
    return ([self hasPrefix:string]) ? YES : NO;
}

// If my string ends with given string
- (BOOL)isEndWith:(NSString *)string {
    return ([self hasSuffix:string]) ? YES : NO;
}

// Replace particular characters in my string with new character
- (NSString *)replaceString:(NSString *)oldStr withNew:(NSString *)newStr {
    return  [self stringByReplacingOccurrencesOfString:oldStr withString:newStr];
}

// Get Substring from particular location to given lenght
- (NSString *)substringFrom:(NSInteger)begin to:(NSInteger)end {
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

// Add substring to main String
- (NSString *)appendString:(NSString *)string {
    if (![string isValid]) return self;
    return [self stringByAppendingString:string];
}

// Remove particular sub string from main string
- (NSString *)removeString:(NSString *)string {
    if (![string isValid]) return self;
    if ([self containsString:string]) {
        NSRange range = [self rangeOfString:string];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

// If my string contains ony letters
- (BOOL)containsOnlyLetters {
    NSCharacterSet *letterCharacterSet = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterSet].location == NSNotFound);
}

// If my string contains only numbers
- (BOOL)containsOnlyNumbers {
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// If my string contains letters and numbers
- (BOOL)containsOnlyNumbersAndLetters {
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}


// Convert string to NSData
- (NSData *)convertToData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

@end
