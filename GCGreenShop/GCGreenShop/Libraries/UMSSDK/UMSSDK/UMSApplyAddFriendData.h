//
//  UMSApplyAddFriendData.h
//  UMSSDK
//
//  Created by LinMin on 2017/12/6.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSTypeDefine.h"

@interface UMSApplyAddFriendData : NSObject

/**
 申请好友的用户ID
 */
@property (nonatomic, copy, readonly) NSString *applyId;

/**
 申请好友的用户信息
 */
@property (nonatomic, copy, readonly) NSString *applyMessage;

/**
 申请时间
 */
@property (nonatomic, assign, readonly) NSTimeInterval applyTime;

/**
 申请状态
 */
@property (nonatomic, assign) UMSDealWithRequestStatus requestStatus;

/**
 申请好友的用户
 */
@property (nonatomic, strong, readonly) UMSUser *user;

@end
