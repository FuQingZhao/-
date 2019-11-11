//
//  ShareSDKCore.h
//  iNanjing
//
//  Created by LinMin on 2018/3/29.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

// 腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

// 微信SDK头文件
#import "WXApi.h"

// 新浪微博SDK头文件，需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
#import "WeiboSDK.h"

@class ShareSDKObject;

@interface ShareSDKCore : NSObject

/**
 *  @brief  根据指定的社交平台登录鉴权
 *
 *  @param  platform        分享平台
 *  @param  completion      授权完成之后的回调处理
 *
 */
+ (void)oauthWithPlatformSSDK:(SSDKPlatformType)platform completion:(SSDKAuthorizeStateChangedHandler)completion;
/**
 *  @brief  根据指定的社交平台取消鉴权
 *
 *  @param  platform       分享平台
 *
 */
+ (void)unOauthWithPlatform:(SSDKPlatformType)platform;

/**
 *  @brief  实现Web端的分享模块
 *
 *  @param  parameters      web分享模块传入参数
 *  @param  completion      授权完成之后的回调处理
 *
 */
+ (void)postWebSnsWithParameters:(NSDictionary *)parameters completion:(SSDKShareStateChangedHandler)completion;

/**
 *  @brief  实现对应平台的本地分享
 *
 *  @param  object          分享的基本信息和分享平台
 *  @param  completion      授权完成之后的回调处理
 *
 */
+ (void)postSnsWithObject:(ShareSDKObject *)object completion:(SSDKShareStateChangedHandler)completion;

/**
 *  @brief  根据已鉴权平台获得对应用户信息
 *
 *  @param  platform        分享平台
 *  @param  completion      授权完成之后的回调处理
 *
 */
+ (void)getUserInfo:(SSDKPlatformType)platform completion:(SSDKGetUserStateChangedHandler)completion;

/**
 *  @brief  根据指定平台判断是否已鉴权
 *
 *  @param  platform    分享平台
 *
 *  @return 是否已鉴权标志
 *
 */
+ (BOOL)isOauthWithPlatform:(SSDKPlatformType)platform;

/**
 *  @brief  第三方登录
 *
 *  @param  platform        分享平台
 *  @param  completion      登录完成之后的回调处理
 *
 */
+ (void)thirdPartyLogInWithPlatform:(SSDKPlatformType)platform completion:(SSDKGetUserStateChangedHandler)completion;

@end
