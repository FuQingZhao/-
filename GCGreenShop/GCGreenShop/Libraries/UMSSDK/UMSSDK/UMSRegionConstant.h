//
//  UMSRegionConstant.h
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/14.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMSRegionConstant : NSObject

AS_SINGLETON(UMSRegionConstant)

@property (nonatomic, assign) NSInteger provinceId;  // 所属的省ID
@property (nonatomic, copy) NSString *provinceName;  // 所属的省
@property (nonatomic, assign) NSInteger cityId;  // 城市ID
@property (nonatomic, copy) NSString *cityName;  // 城市名称
@property (nonatomic, copy) NSString *pinyin;  // 拼音
@property (nonatomic, copy) NSString *upperFirstLetter;  // 拼音首字母大写

@end


@interface UMSRegionGroup : NSObject
@property (nonatomic, copy) NSString *firstLetter;  // 大写字母
@property (nonatomic, strong) NSMutableArray<UMSRegionConstant *> *nodes;  // 对应城市列表
@end
