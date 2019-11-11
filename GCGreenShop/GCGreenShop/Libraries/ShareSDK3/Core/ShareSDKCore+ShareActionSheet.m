//
//  ShareSDKCore+ShareActionSheet.m
//  iNanjing
//
//  Created by LinMin on 2018/3/29.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import "ShareSDKCore+ShareActionSheet.h"

@implementation ShareSDKCore (ShareActionSheet)

+ (ShareOptions *)defaultShareOptionsWithTitle:(NSString *)title
                                qqButtonHidden:(BOOL)qqButtonHidden
                         wxSessionButtonHidden:(BOOL)wxSessionButtonHidden
                        wxTimelineButtonHidden:(BOOL)wxTimelineButtonHidden
                         sinaWeiboButtonHidden:(BOOL)sinaWeiboButtonHidden {
    ShareOptions *shareOptions = [ShareOptions new];
    shareOptions.title = title;
    shareOptions.qqButtonHidden = qqButtonHidden;
    shareOptions.wxSessionButtonHidden = wxSessionButtonHidden;
    shareOptions.wxTimelineButtonHidden = wxTimelineButtonHidden;
    shareOptions.sinaWeiboButtonHidden = sinaWeiboButtonHidden;
    return shareOptions;
}

+ (ShareActionSheet *)actionSheetWithShareOptions:(ShareOptions *)shareOptions {
    
    NSMutableArray<NSNumber *> *shareList = [NSMutableArray array];
    if (!shareOptions.wxSessionButtonHidden) {
        [shareList addObject:@(SSDKPlatformSubTypeWechatSession)];
    }
    if (!shareOptions.wxTimelineButtonHidden) {
        [shareList addObject:@(SSDKPlatformSubTypeWechatTimeline)];
    }
    if (!shareOptions.qqButtonHidden) {
        [shareList addObject:@(SSDKPlatformTypeQQ)];
    }
    if (!shareOptions.wxTimelineButtonHidden) {
        [shareList addObject:@(SSDKPlatformTypeSinaWeibo)];
    }
    
    ShareActionSheet *actionSheet = [ShareActionSheet actionSheetWithShareList:shareList tappedBlock:^(SSDKPlatformType platformType) {
        //
    }];
    
    return actionSheet;
}

+ (void)showShareActionSheet:(UIView *)view shareOptions:(ShareOptions *)shareOptions result:(void(^)(SSDKPlatformType platformType, SSDKResponseState state, NSError *error))result {
    ShareActionSheet *actionSheet = [[self class] actionSheetWithShareOptions:shareOptions];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [actionSheet showInView:window animation:TTPopupAnimationFromBottom];
}

@end


@implementation ShareOptions
@end
