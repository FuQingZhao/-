//
//  UMSTypeDefine.h
//  UMSSDK
//
//  Created by LinMin on 2017/12/6.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#ifndef UMSTypeDefine_h
#define UMSTypeDefine_h

@class UMSUser;
@class UMSApplyAddFriendData;

/**
 *  登录回调
 */
typedef void(^UMSLoginResult) (UMSUser *user, NSError *error);

/**
 *  注册回调
 */
typedef void(^UMSRegisterResult) (UMSUser *user, NSError *error);

/**
 *  获取用户信息回调
 */
typedef void(^UMSGetUserInfoResult) (UMSUser *user, NSError *error);

/**
 *  更新用户信息回调
 */
typedef void(^UMSUpdateUserInfoResult) (UMSUser *user, NSError *error);

/**
 *  更新用户信息回调
 */
typedef void(^UMSBindPhoneResult) (NSError *error);

/**
 *  找回密码回调
 */
typedef void(^UMSResetPasswordResult) (NSError *error);

/**
 *  退出登录回调
 */
typedef void(^UMSLogoutResult) (NSError *error);

/**
 *  修改密码回调
 */
typedef void(^UMSModifyPasswordResult) (NSError *error);

/**
 *  检查手机号是否存在回调
 */
typedef void(^UMSCheckPhoneResult) (BOOL existed);

/**
 *  获取用户列表回调
 */
typedef void(^UMSGetUserListResult) (NSArray<UMSUser *> *userList, NSError *error);

/**
 申请好友列表
 */
typedef void(^UMSGetApplyAddFriendListResult) (NSArray<UMSApplyAddFriendData *> *list , NSError *error);

/**
 删除好友
 */
typedef void(^UMSDeleteFriendResult) (NSError *error);

/**
 拉黑好友
 */
typedef void(^UMSBlockUserResult) (NSError *error);

/**
 好友申请
 */
typedef void(^UMSAddFriendRequestResult) (NSError *error);

/**
 处理好友申请
 */
typedef void(^UMSDealWithFriendRequestResult) (NSError *error);

/**
 从黑名单移除
 */
typedef void(^UMSRemoveFromBlockListResult) (NSError *error);

/**
 删除粉丝回调
 */
typedef void(^UMSDeleteFansResult) (NSError *error);

/**
 取消关注接口
 */
typedef void(^UMSUnfollowResult) (NSError *error);

/**
 关注接口
 */
typedef void(^UMSFollowResult) (NSError *error);

/**
 *  是否存在关系
 */
typedef void(^UMSIsExistRelationshipResult) (BOOL isExistRelationship, NSError *error);

/**
 *  平台类型
 */
typedef NS_ENUM(NSUInteger, UMSPlatformType) {
    
    // 未知
    UMSPlatformTypeUnknown = 0,
    
    // 新浪微博
    UMSPlatformTypeSinaWeibo = 1,
    
    // QQ
    UMSPlatformTypeQQ = 2,
    
    // 微信
    UMSPlatformTypeWechat = 3,
    
    // 手机
    UMSPlatformTypePhone = 10,
    
    // 邮箱
    UMSPlatformTypeEmail = 11,
    
};

/**
 *  用户关系
 */
typedef NS_ENUM(NSUInteger, UMSRelationship) {
    
    // 没有关系
    UMSRelationshipNoExist = 0,
    
    // 关注
    UMSRelationshipFollow = 1,
    
    // 粉丝
    UMSRelationshipFans = 2,
    
    // 相互关注
    UMSRelationshipCoFollow = 3,
};

/**
 *  处理好友请求状态
 */
typedef NS_ENUM(NSUInteger, UMSDealWithRequestStatus) {
    
    // 所有状态
    UMSDealWithRequestStatusAll = 0,
    
    // 待处理
    UMSDealWithRequestStatusPending = 1,
    
    // 同意
    UMSDealWithRequestStatusAgree = 2,
    
    // 拒绝
    UMSDealWithRequestStatusRefuse = 3,
};

#endif /* UMSTypeDefine_h */
