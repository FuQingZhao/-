//
//  UMSUserCustomFields.h
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMSUserCustomFields : NSObject

/**
 初始化数据模型
 
 @param dict 初始化数据
 @return 数据模型
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 设置数据
 
 @param data 字典数据
 */
- (void)append:(NSDictionary *)data;

/**
 设置数据
 
 @param data 数据
 @param key 名称
 */
- (void)set:(id)data key:(NSString *)key;

/**
 获取数据
 
 @param key 名称
 */
- (id)get:(NSString *)key;

/**
 返回一个字典结构
 
 @return 字段数据对象
 */
- (NSDictionary *)dictionaryValue;

@end
