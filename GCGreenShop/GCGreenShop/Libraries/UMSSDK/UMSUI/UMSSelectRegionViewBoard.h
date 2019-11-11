//
//  UMSSelectRegionViewBoard.h
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSBaseViewBoard.h"
#import "UMSRegionConstant.h"

@interface UMSSelectRegionViewBoard : UMSBaseViewBoard

/**
 选择城市回调
 */
@property (nonatomic, copy) void (^selectRegionHandler) (UMSRegionConstant *region);

@end
