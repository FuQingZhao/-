//
//  UMSUser.h
//  UMSSDK
//
//  Created by LinMin on 2017/12/6.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "UMSTypeDefine.h"
#import "UMSConstellationConstant.h"
#import "UMSZodiacConstant.h"
#import "UMSUserCustomFields.h"

typedef NS_ENUM(NSInteger, UMSGenderConstant) {
    UMSGenderConstantSecret = 0,
    UMSGenderConstantMale,
    UMSGenderConstantFemale
};

@interface UMSUser : NSObject

/**
 *  用户ID
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickname;

/**
 *  头像地址
 */
@property (nonatomic, copy) NSString *avatar;

/**
 *  性别
 */
@property (nonatomic, assign) UMSGenderConstant gender;

/**
 *  生日：修改生日会联动触发修改年龄、星座以及生肖，反之则不会
 */
@property (nonatomic, copy) NSDate *birthday;

/**
 *  年龄
 */
@property (nonatomic, strong) NSNumber *age;

/**
 *  星座
 */
@property (nonatomic, strong) UMSConstellationConstant *constellation;

/**
 *  生肖
 */
@property (nonatomic, strong) UMSZodiacConstant *zodiac;

/**
 *  国家
 */
@property (nonatomic, copy) NSString *country;

/**
 *  省份
 */
@property (nonatomic, copy) NSString *province;

/**
 *  城市
 */
@property (nonatomic, copy) NSString *city;

/**
 *  签名（500个字符以内）
 */
@property (nonatomic, copy) NSString *signature;

/**
 *  邮件
 */
@property (nonatomic, copy) NSString *email;

/**
 *  地址（500个字符以内）
 */
@property (nonatomic, copy) NSString *address;

/**
 *  邮编
 */
@property (nonatomic, assign) NSInteger zipCode;

/**
 *  个人说明（800个字符以内）
 */
@property (nonatomic, copy) NSString *resume;

/**
 *  登录时间
 */
@property (nonatomic, strong) NSDate *loginAt;

/**
 *  手机号
 */
@property (nonatomic, copy) NSString *phone;

/**
 *  地理位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D location;

/**
 *  自定义字段
 */
@property (nonatomic, strong) UMSUserCustomFields *customInfo;

/**
 粉丝数
 */
@property (nonatomic, assign) NSUInteger fansCount;

/**
 关注数
 */
@property (nonatomic, assign) NSUInteger followCount;

/**
 相互关注数
 */
@property (nonatomic, assign) NSUInteger coFollowCount;

/**
 好友数
 */
@property (nonatomic, assign) NSUInteger friendCount;

/**
 是否为好友关系，配合fetchFriendRelationshipWithUser:result:使用
 */
@property (nonatomic, assign) BOOL isFriend;

/**
 粉丝关系，配合fetchFansRelationshipWithUser:result:使用
 */
@property (nonatomic, assign) UMSRelationship fansRelationship;

/**
 是否拉黑，配合fetchBlockRelationshipWithUser:result:使用
 */
@property (nonatomic, assign) BOOL isBlock;

/**
 解析用户登录数据
 
 @param loginRet  登录返回的数据
 */
+ (instancetype)userDataFromLoginRet:(NSDictionary *)loginRet;

/**
 解析查看用户数据
 
 @param fetchRet  查询返回的数据
 */
+ (instancetype)userDataFromFetchRet:(NSDictionary *)fetchRet;

/**
 复制用户信息到当前用户
 */
+ (void)copyUserData:(UMSUser *)tempUser;

@end
