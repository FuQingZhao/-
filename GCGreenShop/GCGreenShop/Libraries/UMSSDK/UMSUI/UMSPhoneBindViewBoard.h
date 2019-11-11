//
//  UMSPhoneBindViewBoard.h
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSBaseViewBoard.h"

@interface UMSPhoneBindViewBoard : UMSBaseViewBoard

/**
 绑定手机回调
 */
@property (nonatomic, copy) void (^bindHandler) (NSError *error);

- (instancetype)initWithTempUser:(UMSUser *)tempUser;

@end
