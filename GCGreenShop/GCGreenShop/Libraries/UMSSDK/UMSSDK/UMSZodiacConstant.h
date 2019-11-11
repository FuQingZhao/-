//
//  UMSZodiacConstant.h
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UMSZodiacConstantRat ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Rat.index])
#define UMSZodiacConstantOx ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Ox.index])
#define UMSZodiacConstantTiger ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Tiger.index])
#define UMSZodiacConstantRabbit ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Rabbit.index])
#define UMSZodiacConstantDragon ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Dragon.index])
#define UMSZodiacConstantSnake ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Snake.index])
#define UMSZodiacConstantHorse ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Horse.index])
#define UMSZodiacConstantGoat ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Goat.index])
#define UMSZodiacConstantMonkey ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Monkey.index])
#define UMSZodiacConstantRooster ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Rooster.index])
#define UMSZodiacConstantDog ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Dog.index])
#define UMSZodiacConstantPig ([UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Pig.index])

/**
 生肖搜索索引
 */
struct UMSZodiacSearchIndex {
    struct UMSMouse {
        int index;
    } Mouse;
    struct UMSCow {
        int index;
    } Cow;
    struct UMSTiger {
        int index;
    } Tiger;
    struct UMSRabbit {
        int index;
    } Rabbit;
    struct UMSDragon {
        int index;
    } Dragon;
    struct UMSSnake {
        int index;
    } Snake;
    struct UMSHorse {
        int index;
    } Horse;
    struct UMSGoat {
        int index;
    } Goat;
    struct UMSMonkey {
        int index;
    } Monkey;
    struct UMSRooster {
        int index;
    } Rooster;
    struct UMSDog {
        int index;
    } Dog;
    struct UMSPig {
        int index;
    } Pig;
};

@interface UMSZodiacConstant : NSObject

/**
 名字
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 获取生肖列表
 
 @return 生肖列表
 */
+ (NSArray<UMSZodiacConstant *> *)zodiacs;

/**
 获取生肖信息
 
 @param index 生肖索引
 @return 生肖信息
 */
+ (UMSZodiacConstant *)getZodiac:(NSInteger)index;

/**
 获取生肖搜索位置索引,配合getZodiac使用，如：查找生肖狗，则为：[UMSZodiacConstant getZodiac:UMSZodiacConstant.search.Dog.index];
 
 @return 性别信息
 */
+ (struct UMSZodiacSearchIndex)search;

@end
