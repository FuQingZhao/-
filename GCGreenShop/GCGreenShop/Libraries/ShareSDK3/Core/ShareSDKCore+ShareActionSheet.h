//
//  ShareSDKCore+ShareActionSheet.h
//  iNanjing
//
//  Created by LinMin on 2018/3/29.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import "ShareSDKCore.h"
#import <ShareSDK/SSDKTypeDefine.h>
#import "ShareActionSheet.h"

@class ShareOptions;

@interface ShareSDKCore (ShareActionSheet)

+ (ShareOptions *)defaultShareOptionsWithTitle:(NSString *)title
                                qqButtonHidden:(BOOL)qqButtonHidden
                         wxSessionButtonHidden:(BOOL)wxSessionButtonHidden
                        wxTimelineButtonHidden:(BOOL)wxTimelineButtonHidden
                         sinaWeiboButtonHidden:(BOOL)sinaWeiboButtonHidden;

+ (ShareActionSheet *)actionSheetWithShareOptions:(ShareOptions *)shareOptions;

+ (void)showShareActionSheet:(UIView *)view shareOptions:(ShareOptions *)shareOptions result:(void(^)(SSDKPlatformType platformType, SSDKResponseState state, NSError *error))result;

@end


/**
 分享设置
 */
@interface ShareOptions : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL qqButtonHidden;
@property (nonatomic, assign) BOOL wxSessionButtonHidden;
@property (nonatomic, assign) BOOL wxTimelineButtonHidden;
@property (nonatomic, assign) BOOL sinaWeiboButtonHidden;
@end
