//
//  UMSSDK.h
//  UMSSDK
//
//  Created by LinMin on 2017/12/6.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSTypeDefine.h"
#import "UMSUser.h"
#import "UMSAppConfiguration.h"

typedef NS_ENUM(NSInteger, VerificationType) {
    VerificationTypeRegister = 1,
    VerificationTypeResetPassword,
    VerificationTypePhoneBind,
    VerificationTypeSMSLogin
};

@interface UMSSDK : NSObject

/**
 获取注册短信验证码
 
 @param phone    手机号
 @param verifyType 验证方式
 @param handler  请求结果
 */
+ (void)getVerificationCodeWithPhone:(NSString *)phone
                          verifyType:(VerificationType)verifyType
                              result:(void (^) (id response, NSError *error))handler;

/**
 用户注册
 
 @param phone    手机号
 @param password 密码
 @param smscode  短信验证码
 @param reccode  推荐码
 @param handler  注册结果
 */
+ (void)registerWithPhone:(NSString *)phone
                 password:(NSString *)password
                  smsCode:(NSString *)smscode
                   result:(UMSRegisterResult)handler;

/**
 用户登录
 
 @param phone    手机号
 @param password 密码
 @param handler  登录结果
 */
+ (void)loginWithPhone:(NSString *)phone
              password:(NSString *)password
                result:(UMSLoginResult)handler;
/**
 第三方登录
 
 @param platformType 社交账号类型
 @param handler      第三方登录结果
 */
+ (void)loginWithPlatformType:(UMSPlatformType)platformType
                       result:(UMSLoginResult)handler;

/**
 退出登录
 
 @param handler 退出登录结果
 */
+ (void)logoutWithResult:(UMSLogoutResult)handler;

/**
 获取注册的用户资料
 
 @param handler 获取用户资料结果
 */
+ (void)getUserInfo:(NSString *)userId result:(UMSGetUserInfoResult)handler;

/**
 更新用户资料
 
 @param user    用户模型
 @param handler 更新用户资料结果
 */
+ (void)updateUserInfoWithUser:(UMSUser *)user
                        result:(UMSUpdateUserInfoResult)handler;

/**
 重置密码
 
 @param phone    手机号
 @param password 密码
 @param smscode  短信验证码
 @param handler  重置密码结果
 */
+ (void)resetPasswordWithPhone:(NSString *)phone
                   newPassword:(NSString *)password
                       smsCode:(NSString *)smscode
                        result:(UMSResetPasswordResult)handler;

/**
 修改密码
 
 @param phone       手机号
 @param newPassword 新密码
 @param oldPassword 旧密码
 @param handler     修改密码结果
 */
+ (void)modifyPasswordWithPhone:(NSString *)phone
                    newPassword:(NSString *)newPassword
                    oldPassword:(NSString *)oldPassword
                         result:(UMSModifyPasswordResult)handler;

/**
 修改密码
 
 @param phone    手机号
 @param smsCode  短信验证码
 @param reccode  推荐码
 @param handler  绑定手机号结果
 */
+ (void)bindPhoneWithUser:(NSString *)userId
                    phone:(NSString *)phone
                  smsCode:(NSString *)smsCode
               inviteCode:(NSString *)reccode
                   result:(UMSBindPhoneResult)handler;

/**
 检查手机号是否存在
 
 @param phone    手机号
 @param handler  检查手机号结果
 */
+ (void)checkPhone:(NSString *)phone result:(UMSCheckPhoneResult)handler;

/**
 支持第三方登录的平台
 
 @param handler 支持第三方登录的平台
 */
+ (void)supportedLoginPlatforms:(void (^)(NSArray *supportedPlatforms))handler;

/**
 上传头像
 
 @param avatar  需要上传的图片
 @param platformType  图片来源
 @param handler 上传图片处理结果
 */
+ (void)uploadUserAvatarWithImage:(UIImage *)avatar
                     platformType:(UMSPlatformType)platformType
                           result:(void (^) (UIImage *avatar, NSError *error))handler;

/**
 获取当前用户
 
 @return 当前用户
 */
+ (UMSUser *)currentUser;

@end
