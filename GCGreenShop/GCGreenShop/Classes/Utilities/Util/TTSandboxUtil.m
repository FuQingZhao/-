//
//  TTSandboxUtil.m
//  QQCircle
//
//  Created by Min Lin on 2018/3/9.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import "TTSandboxUtil.h"

#define BM_HIS_KEY @"BM_HIS_KEY"

@implementation TTSandboxUtil

+ (void)storeUserId:(NSString *)uid {
    if ([uid length] > 0) {
        [NSUserDefaults setObject:uid forKey:kSandboxUserId];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSandboxUserId];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSString *)userIdFromSandbox {
    return [NSUserDefaults objectForKey:kSandboxUserId];
}

+ (void)storePhone:(NSString *)phone {
    if ([phone length] > 0) {
        [NSUserDefaults setObject:phone forKey:kSandboxPhone];
    }
}

+ (void)storePassword:(NSString *)password {
    if ([password length] > 0) {
        [NSUserDefaults setObject:password forKey:kSandboxPassword];
    }
}

+ (NSString *)phoneFromSandbox {
    return [NSUserDefaults objectForKey:kSandboxPhone];
}

+ (NSString *)passwordFromSandbox {
    return [NSUserDefaults objectForKey:kSandboxPassword];
}

+ (void)clearLoginInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kSandboxPhone];
    [userDefaults removeObjectForKey:kSandboxPassword];
    [userDefaults synchronize];
}

+ (NSArray *)getHistory
{
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:BM_HIS_KEY];
    return array;
}

+ (void)insertHistory:(NSString *)hisString
{
    if (hisString) {
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:BM_HIS_KEY];
        NSMutableArray *his = [[NSMutableArray alloc] initWithArray:array];
        for (int i = 0; i < his.count; i++) {
            NSDictionary *dic = his[i];
            NSString *text = [dic objectForKey:@"Name"];
            if ([text isEqualToString:hisString]) {
                [his removeObjectAtIndex:i];
            }
        }
        [his insertObject:@{@"Name":hisString} atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:his forKey:BM_HIS_KEY];
    }
}

+ (void)removeAllHistory
{
    [NSUserDefaults removeObjectForKey:BM_HIS_KEY];
}

@end
