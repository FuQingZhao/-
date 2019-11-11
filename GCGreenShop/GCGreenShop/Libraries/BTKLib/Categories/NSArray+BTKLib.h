//
//  NSArray+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (BTKLib)

- (id)objectWithIndex:(NSUInteger)index;
- (NSString *)stringWithIndex:(NSUInteger)index;
- (NSNumber *)numberWithIndex:(NSUInteger)index;
- (NSArray *)arrayWithIndex:(NSUInteger)index;
- (NSDictionary *)dictionaryWithIndex:(NSUInteger)index;
- (NSInteger)integerWithIndex:(NSUInteger)index;
- (BOOL)boolWithIndex:(NSUInteger)index;
- (float)floatWithIndex:(NSUInteger)index;
- (double)doubleWithIndex:(NSUInteger)index;
- (NSDate *)dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
- (CGPoint)pointWithIndex:(NSUInteger)index;
- (CGSize)sizeWithIndex:(NSUInteger)index;
- (CGRect)rectWithIndex:(NSUInteger)index;

/**
 获取数组最后一个内容的Index
 如果数组为空返回NSNotFound
 */
- (NSUInteger)lastObjectIndex;

@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(SafeAccess)

- (void)addObj:(id)obj;
- (void)addString:(NSString *)str;
- (void)addBool:(BOOL)b;
- (void)addInt:(int)i;
- (void)addInteger:(NSInteger)integer;
- (void)addFloat:(float)f;
- (void)addPoint:(CGPoint)point;
- (void)addSize:(CGSize)size;
- (void)addRect:(CGRect)rect;

@end
