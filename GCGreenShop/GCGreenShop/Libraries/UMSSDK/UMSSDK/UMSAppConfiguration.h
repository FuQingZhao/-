//
//  UMSAppConfiguration.h
//  UMSSDK
//
//  Created by LinMin on 2017/12/6.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMSAppConfiguration : NSObject

/**
 App设置单例
 */
+ (instancetype)configure;

/**
 *  服务器时间戳, 用于矫正客户端时间
 */
@property (nonatomic, assign) NSTimeInterval timestamp;

/**
 *  默认请求地址
 */
@property (nonatomic, copy) NSString *defHost;

/**
 *  默认请求端口
 */
@property (nonatomic, copy) NSString *defPort;

/**
 返回图片
 
 @param imageName  图片名
 */
+ (UIImage *)imageWithBundleResource:(NSString *)imageName;

@end
