//
//  UMSAppConfiguration.m
//  UMSSDK
//
//  Created by LinMin on 2017/12/6.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSAppConfiguration.h"

@implementation UMSAppConfiguration

+ (instancetype)configure {
    static dispatch_once_t onceToken;
    static UMSAppConfiguration *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[UMSAppConfiguration alloc] init];
    });
    return instance;
}

+ (UIImage *)imageWithBundleResource:(NSString *)imageName {
    NSString *contents = [[NSBundle mainBundle] pathForResource:@"UMSSDK" ofType:@".bundle"];
    NSString *path = [contents stringByAppendingPathComponent:imageName];
    path = [path stringByAppendingFormat:@"@%@x", @([UIScreen mainScreen].scale)];
    return [UIImage imageWithContentsOfFile:path];
}

@end
