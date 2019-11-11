//
//  UMSRegionConstant.m
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/14.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import "UMSRegionConstant.h"

@implementation UMSRegionConstant

DEF_SINGLETON(UMSRegionConstant)

@end



@implementation UMSRegionGroup
- (instancetype)init {
    self = [super init];
    if (self) {
        self.nodes = [NSMutableArray array];
    }
    return self;
}
@end
