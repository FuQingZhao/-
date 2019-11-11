//
//  NSUserDefaults+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (BTKLib)

/**
 从沙盒中取数据
 */
+ (id)objectForKey:(NSString *)key;

/**
 把数据存储到沙盒中
 */
+ (void)setObject:(id)object forKey:(NSString *)key;

/**
 根据Key删除沙盒中的数据
 */
+ (void)removeObjectForKey:(NSString *)key;

@end
