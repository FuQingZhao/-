//
//  UMSConstellationConstant.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSConstellationConstant.h"

@implementation UMSConstellationConstant

+ (NSArray<UMSConstellationConstant *> *)constellations {
    return nil;
}

+ (UMSConstellationConstant *)getConstellation:(NSInteger)index {
    return nil;
}

+ (struct UMSConstellationSearchIndex)search {
    struct UMSConstellationSearchIndex index = {{0}, {1}, {2}, {2}, {2}, {2}, {2}, {2}, {2}, {2}, {2}};
    return index;
}

@end
