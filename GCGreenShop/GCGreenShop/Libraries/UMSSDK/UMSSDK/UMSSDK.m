//
//  UMSSDK.m
//  UMSSDK
//
//  Created by LinMin on 2017/12/6.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSSDK.h"
#import "TTSandboxUtil.h"

#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>

@implementation UMSSDK

+ (void)getVerificationCodeWithPhone:(NSString *)phone
                          verifyType:(VerificationType)verifyType
                              result:(void (^) (id response, NSError *error))handler {
    
    NSString *url = [[UMSAppConfiguration configure].defHost stringByAppendingPathComponent:@"verifycode/addLoginPhoneCode"];
    NSDictionary *queryParams = @{@"phone": phone, @"verifycode": @(verifyType)};
    [BTKNetworkManager JSON:url parameters:queryParams success:^(id responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] asInteger];
        NSString *msg = [[responseObject objectForKey:@"msg"] asNSString];
        if (code == 1) {
            if (handler) { handler(msg, nil); }
        } else {
            if (handler) { handler(nil, [NSError errorWhy:msg]); }
        }
    } failure:^(NSError *error) {
        if (handler) { handler(nil, error); }
    }];
}

+ (void)registerWithPhone:(NSString *)phone
                 password:(NSString *)password
                  smsCode:(NSString *)smscode
                   result:(UMSRegisterResult)handler {
    
    
}

+ (void)loginWithPhone:(NSString *)phone
              password:(NSString *)password
                result:(UMSLoginResult)handler {
    
    
}

+ (void)loginWithPlatformType:(UMSPlatformType)platformType
                       result:(UMSLoginResult)handler {
    
    
}

+ (void)logoutWithResult:(UMSLogoutResult)handler {
    
    UMSUser *currentUser = [UMSSDK currentUser];
    currentUser.uid = nil;
    currentUser.nickname = nil;
    currentUser.avatar = nil;
    
    // 清除登录的信息
    [TTSandboxUtil clearLoginInfo];
    // 清除用户ID
    [TTSandboxUtil storeUserId:nil];
    
    if (handler) { handler(nil); }
}

+ (void)getUserInfo:(NSString *)userId result:(UMSGetUserInfoResult)handler {
    
    
}

+ (void)updateUserInfoWithUser:(UMSUser *)user
                        result:(UMSUpdateUserInfoResult)handler {
    
}

+ (void)resetPasswordWithPhone:(NSString *)phone
                   newPassword:(NSString *)password
                       smsCode:(NSString *)smscode
                        result:(UMSResetPasswordResult)handler {
    
    
}

+ (void)modifyPasswordWithPhone:(NSString *)phone
                    newPassword:(NSString *)newPassword
                    oldPassword:(NSString *)oldPassword
                         result:(UMSModifyPasswordResult)handler {
    
}

+ (void)bindPhoneWithUser:(NSString *)userId
                    phone:(NSString *)phone
                  smsCode:(NSString *)smsCode
               inviteCode:(NSString *)reccode
                   result:(UMSBindPhoneResult)handler {
    
    
}

+ (void)checkPhone:(NSString *)phone result:(UMSCheckPhoneResult)handler {
    
    
}

+ (void)supportedLoginPlatforms:(void (^)(NSArray *supportedPlatforms))handler {
    
    NSMutableArray *supportedPlatforms = [NSMutableArray arrayWithCapacity:3];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        [supportedPlatforms addObject:@"wechat"];
    }
    
    if ([QQApiInterface isQQInstalled] || [QQApiInterface isTIMInstalled]) {
        [supportedPlatforms addObject:@"qq"];
    }
    
//    if ([WeiboSDK isWeiboAppInstalled]) {
//        [supportedPlatforms addObject:@"weibo"];
//    }
    
    if (handler) {
        handler(supportedPlatforms);
    }
}

+ (void)uploadUserAvatarWithImage:(UIImage *)avatar
                     platformType:(UMSPlatformType)platformType
                           result:(void (^) (UIImage *avatar, NSError *error))handler {
    
}

+ (UMSUser *)currentUser {
    return [[self class] sharedUser];
}


#pragma mark - privates

+ (UMSUser *)sharedUser {
    static dispatch_once_t onceToken;
    static UMSUser *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[UMSUser alloc] init];
    });
    return instance;
}

@end
