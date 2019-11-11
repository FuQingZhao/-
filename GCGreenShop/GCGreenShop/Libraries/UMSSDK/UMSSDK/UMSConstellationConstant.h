//
//  UMSConstellationConstant.h
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UMSConstellationConstantAries ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Aries.index])
#define UMSConstellationConstantTaurus ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Taurus.index])
#define UMSConstellationConstantGemini ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Gemini.index])
#define UMSConstellationConstantCancer ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Cancer.index])
#define UMSConstellationConstantLeo ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Leo.index])
#define UMSConstellationConstantVirgo ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Virgo.index])
#define UMSConstellationConstantLibra ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Libra.index])
#define UMSConstellationConstantScorpio ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Scorpio.index])
#define UMSConstellationConstantSagittarius ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Sagittarius.index])
#define UMSConstellationConstantCapricorn ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Rooster.index])
#define UMSConstellationConstantPisces ([UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Pisces.index])


/**
 星座搜索索引
 */
struct UMSConstellationSearchIndex {
    struct UMSAries {
        int index;
    } Aries;
    struct UMSTaurus {
        int index;
    } Taurus;
    struct UMSGemini {
        int index;
    } Gemini;
    struct UMSCancer {
        int index;
    } Cancer;
    struct UMSLeo {
        int index;
    } Leo;
    struct UMSVirgo {
        int index;
    } Virgo;
    struct UMSLibra {
        int index;
    } Libra;
    struct UMSScorpio {
        int index;
    } Scorpio;
    struct UMSSagittarius {
        int index;
    } Sagittarius;
    struct UMSCapricorn {
        int index;
    } Capricorn;
    struct UMSAquarius {
        int index;
    } Aquarius;
    struct UMSPisces {
        int index;
    } Pisces;
};

/**
 星座信息常量定义
 */
@interface UMSConstellationConstant : NSObject

/**
 名字
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 获取星座列表
 
 @return 星座列表
 */
+ (NSArray<UMSConstellationConstant *> *)constellations;

/**
 获取星座信息
 
 @param index 星座索引
 @return 星座信息
 */
+ (UMSConstellationConstant *)getConstellation:(NSInteger)index;

/**
 获取星座搜索位置索引,配合getConstellation使用，如：查找白羊座，则为：[UMSConstellationConstant getConstellation:UMSConstellationConstant.search.Dog.index];
 
 @return 性别信息
 */
+ (struct UMSConstellationSearchIndex)search;

@end
