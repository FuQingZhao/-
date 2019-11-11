//
//  NSDictionary+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BTKLib)

- (BOOL)hasKey:(id)key;
- (NSString *)stringForKey:(id)key;
- (BOOL)boolForKey:(id)key;
- (int)intForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (NSUInteger)unsignedIntegerForKey:(id)key;
- (float)floatForKey:(id)key;
- (double)doubleForKey:(id)key;
- (long long)longlongForKey:(id)key;

/**
 *  @brief  合并两个NSDictionary
 *
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;

/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict;

/**
 *  @brief  将url参数转换成NSDictionary
 *
 *  @param query url参数
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)dictionaryWithURLQuery:(NSString *)query;

/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)URLQueryString;

@end


#pragma --mark NSMutableDictionary setter

@interface NSMutableDictionary(SafeAccess)

- (void)setObj:(id)i forKey:(NSString *)key;
- (void)setString:(NSString *)i forKey:(NSString *)key;
- (void)setBool:(BOOL)i forKey:(NSString *)key;
- (void)setInt:(int)i forKey:(NSString *)key;
- (void)setInteger:(NSInteger)i forKey:(NSString *)key;
- (void)setUnsignedInteger:(NSUInteger)i forKey:(NSString *)key;
- (void)setFloat:(float)i forKey:(NSString *)key;
- (void)setDouble:(double)i forKey:(NSString *)key;
- (void)setLongLong:(long long)i forKey:(NSString *)key;

@end
