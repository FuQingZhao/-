//
//  UMSZodiacConstant.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSZodiacConstant.h"

@implementation UMSZodiacConstant

+ (NSArray<UMSZodiacConstant *> *)zodiacs {
    return nil;
}

+ (UMSZodiacConstant *)getZodiac:(NSInteger)index {
    return 0;
}

+ (struct UMSZodiacSearchIndex)search {
    struct UMSZodiacSearchIndex index = {{0}, {1}, {2}, {2}, {2}, {2}, {2}, {2}, {2}, {2}, {2}};
    return index;
}

@end
