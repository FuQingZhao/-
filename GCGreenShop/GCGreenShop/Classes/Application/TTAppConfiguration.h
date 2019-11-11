//
//  TTAppConfiguration.h
//  TTReader
//
//  Created by LinMin on 2017/12/31.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTAppConfiguration : NSObject

/**
 App设置单例
 */
+ (instancetype)configure;

/**
 时间偏移
 */
@property (nonatomic, assign) NSInteger ti;

/**
 JAVA域名配置
 */
@property (nonatomic, copy) NSString *defHost;

/**
 PHP域名配置
 */
@property (nonatomic, copy) NSString *phpDefHost;

/**
 加密串
 */
@property (nonatomic, copy) NSString *val;

/**
 获取加密串
 */
+ (NSString *)stringByEncrypt;

/**
 判断是否正在审核中
 */
+ (BOOL)isReviewing;

@end
