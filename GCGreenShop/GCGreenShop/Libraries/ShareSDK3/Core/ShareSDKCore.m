//
//  ShareSDKCore.m
//  iNanjing
//
//  Created by LinMin on 2018/3/29.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import "ShareSDKCore.h"
#import "ShareSDKObject.h"

static NSString* const SHARE_DEFAULT_URL = @"www.jstv.com";
static NSString* const DEFAULT_IMAGE_NAME = @"shareDefaultImage";

@implementation ShareSDKCore

+ (void)initialize {
    
    /**初始化ShareSDK应用
     @param activePlatforms  使用的分享平台集合
     @param importHandler (onImport)  导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)  配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ)]
                             onImport:^(SSDKPlatformType platformType) {
                                 
                                 switch (platformType) {
                                     case SSDKPlatformTypeSinaWeibo:
                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                         break;
                                     case SSDKPlatformTypeWechat:
                                         [ShareSDKConnector connectWeChat:[WXApi class]];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                         break;
                                     default:
                                         break;
                                 }
                             }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                          
                          switch (platformType) {
                              case SSDKPlatformTypeSinaWeibo:
                                  // 设置新浪微博应用信息, 其中authType设置为使用SSO＋Web形式授权
                                  [appInfo SSDKSetupSinaWeiboByAppKey:@"4136929666"
                                                            appSecret:@"44310f0254318bc09d0c79b447bf4e54"
                                                          redirectUri:@"http://www.sina.com.cn"
                                                             authType:SSDKAuthTypeBoth];
                                  break;
                              case SSDKPlatformTypeWechat:
                                  [appInfo SSDKSetupWeChatByAppId:@"wx6a1780428e044f8f"
                                                        appSecret:@"8f10b193ce6f921c407ed8cc0ebd6ccd"];
                                  break;
                              case SSDKPlatformTypeQQ:
                                  [appInfo SSDKSetupQQByAppId:@"100964703"
                                                       appKey:@"309ba09de4dd233ad6d9dc4df3823eb9"
                                                     authType:SSDKAuthTypeBoth];
                                  break;
                              default:
                                  break;
                          }
                      }];
}

+ (void)oauthWithPlatformSSDK:(SSDKPlatformType)platform completion:(SSDKAuthorizeStateChangedHandler)completion {
    [ShareSDK authorize:platform
               settings:@{SSDKAuthSettingKeyScopes : [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil]}
         onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
             completion(state, user, error);
         }];
}

+ (void)unOauthWithPlatform:(SSDKPlatformType)platform {
    [ShareSDK cancelAuthorize:platform];
}

+ (void)postWebSnsWithParameters:(NSDictionary *)parameters completion:(SSDKShareStateChangedHandler)completion {
    
    SSDKPlatformType platformType = SSDKPlatformTypeUnknown;
    
    NSString *platform = [[parameters objectForKey:@"platform"] asNSString];
    if ([platform is:@"FSocialSnsTypeAll"]) {
        platformType = SSDKPlatformTypeAny;
    } else if ([platform is:@"FSocialSnsTypeQQ"]) {
        platformType = SSDKPlatformTypeQQ;
    } else if ([platform is:@"FSocialSnsTypeWechatSession"]) {
        platformType = SSDKPlatformSubTypeWechatSession;
    } else if ([platform is:@"FSocialSnsTypeWechatTimeline"]) {
        platformType = SSDKPlatformSubTypeWechatTimeline;
    } else if ([platform is:@"FSocialSnsTypeSinaWeibo"]) {
        platformType = SSDKPlatformTypeSinaWeibo;
    }
    
    ShareSDKObject *shareObject = [ShareSDKObject new];
    shareObject.platform = platformType;
    shareObject.title = [parameters objectForKey:@"title"];
    shareObject.content = [parameters objectForKey:@"content"];
    shareObject.pic = [parameters objectForKey:@"image"];
    shareObject.shareUrl = [parameters objectForKey:@"webUrl"];
    
    if (platformType == SSDKPlatformTypeAny) {
        //[SSUIShareActionSheetController];
    }
    else {
        [[self class] postSnsWithObject:shareObject completion:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            completion(state, userData, contentEntity, error);
        }];
    }
}

+ (void)postSnsWithObject:(ShareSDKObject *)object completion:(SSDKShareStateChangedHandler)completion {
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    /**
     *  新浪微博和腾讯微博分享出去的内容后面需要带链接
     */
    NSString *actualText = object.content;
    if (object.platform == SSDKPlatformTypeSinaWeibo) {
        actualText = [NSString stringWithFormat:@"%@ %@", object.title, object.shareUrl];
        if ([object.pic isKindOfClass:[UIImage class]]) {
            object.pic = [(UIImage *)object.pic imageByResizeToSize:CGSizeMake(200.0, 200.0)];
        }
        if ([object.shareUrl length] == 0) {
            object.shareUrl = SHARE_DEFAULT_URL;
        }
    } else if (object.platform == SSDKPlatformSubTypeWechatTimeline) {
        actualText = object.title;
    }
    
    /**
     *  新浪微博和腾讯微博不支持网络图片分享(需要申请upload_url_text权限)
     *  需要先下载图片，成功后再分享
     */
    if ([object.pic isKindOfClass:[NSString class]] && [(NSString *)object.pic rangeOfString:@"http://"].location != NSNotFound) {
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager cancelAll];
        [manager loadImageWithURL:[NSURL URLWithString:object.pic]
                          options:SDWebImageScaleDownLargeImages
                         progress:nil
                        completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                            
                            if (!image) { image = BTKIMAGE(DEFAULT_IMAGE_NAME); }
                            [shareParams SSDKSetupShareParamsByText:actualText
                                                             images:@[image]
                                                                url:[NSURL URLWithString:object.shareUrl]
                                                              title:object.title
                                                               type:object.contentType];
                            
                            [ShareSDK share:object.platform
                                 parameters:shareParams
                             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                                 completion(state, userData, contentEntity, error);
                             }];
                        }];
    }
    else {
        
        [shareParams SSDKSetupShareParamsByText:actualText
                                         images:@[object.pic]
                                            url:[NSURL URLWithString:object.shareUrl]
                                          title:object.title
                                           type:object.contentType];
        
        [shareParams SSDKEnableUseClientShare];
        
        [ShareSDK share:object.platform
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             completion(state, userData, contentEntity, error);
         }];
    }
}

+ (void)getUserInfo:(SSDKPlatformType)platform completion:(SSDKGetUserStateChangedHandler)completion {
    [ShareSDK getUserInfo:platform onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        completion(state, user, error);
    }];
}

+ (BOOL)isOauthWithPlatform:(SSDKPlatformType)platform {
    return [ShareSDK hasAuthorized:platform];
}

+ (void)thirdPartyLogInWithPlatform:(SSDKPlatformType)platform completion:(SSDKGetUserStateChangedHandler)completion {
    [SSEThirdPartyLoginHelper loginByPlatform:platform onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        SSDKCredential *credential = user.credential;
        if (credential) {
            completion(SSDKResponseStateSuccess, user, nil);
        }
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        // TODO:
    }];
}

@end
