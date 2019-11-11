//
//  NSUserDefaults+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "NSUserDefaults+BTKLib.h"

@implementation NSUserDefaults (BTKLib)

+ (id)objectForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:key];
}

+ (void)setObject:(id)object forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:object forKey:key];
    [userDefaults synchronize];
}

+ (void)removeObjectForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

@end
