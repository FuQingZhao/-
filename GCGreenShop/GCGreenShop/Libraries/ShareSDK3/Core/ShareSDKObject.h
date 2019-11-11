//
//  ShareSDKObject.h
//  iNanjing
//
//  Created by LinMin on 2018/3/29.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/SSDKTypeDefine.h>

@interface ShareSDKObject : NSObject

/**
 分享平台
 */
@property (nonatomic, assign) SSDKPlatformType platform;

/**
 分享内容类型 默认为SSDKContentTypeAuto
 */
@property (nonatomic, assign) SSDKContentType contentType;

/**
 分享的标题
 */
@property (nonatomic, copy) NSString *title;

/**
 分享的内容
 */
@property (nonatomic, copy) NSString *content;

/**
 分享的图片
 */
@property (nonatomic, weak) id pic;

/**
 分享的Web链接
 */
@property (nonatomic, copy) NSString *shareUrl;

@end
