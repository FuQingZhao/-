//
//  NSArray+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "NSArray+BTKLib.h"

@implementation NSArray (BTKLib)

- (id)objectWithIndex:(NSUInteger)index {
    if (index < self.count) {
        return self[index];
    } else {
        return nil;
    }
}

- (NSString *)stringWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return @"";
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}

- (NSNumber *)numberWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        return [formatter numberFromString:(NSString *)value];
    }
    return nil;
}

- (NSArray *)arrayWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)dictionaryWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)integerWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (BOOL)boolWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (float)floatWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

- (double)doubleWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

- (CGPoint)pointWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    CGPoint point = CGPointFromString(value);
    return point;
}

- (CGSize)sizeWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    CGSize size = CGSizeFromString(value);
    return size;
}

- (CGRect)rectWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    CGRect rect = CGRectFromString(value);
    return rect;
}

- (NSUInteger)lastObjectIndex {
    if ([self count] > 0) {
        return [self count] - 1;
    }
    return NSNotFound;
}

@end


#pragma --mark NSMutableArray setter

@implementation NSMutableArray (SafeAccess)

- (void)addObj:(id)obj {
    if (obj != nil) {
        [self addObject:obj];
    }
}

- (void)addString:(NSString *)str {
    if (str.length > 0 && ![str isKindOfClass:[NSNull class]]) {
        [self addObject:str];
    }
}

- (void)addBool:(BOOL)b {
    [self addObject:@(b)];
}

- (void)addInt:(int)i {
    [self addObject:@(i)];
}

- (void)addInteger:(NSInteger)integer {
    [self addObject:@(integer)];
}

- (void)addFloat:(float)f {
    [self addObject:[NSNumber numberWithFloat:f]];
}

- (void)addPoint:(CGPoint)point {
    [self addObject:NSStringFromCGPoint(point)];
}

- (void)addSize:(CGSize)size {
    [self addObject:NSStringFromCGSize(size)];
}

- (void)addRect:(CGRect)rect {
    [self addObject:NSStringFromCGRect(rect)];
}

@end
