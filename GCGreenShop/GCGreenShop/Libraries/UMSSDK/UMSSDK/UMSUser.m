//
//  UMSUser.m
//  UMSSDK
//
//  Created by LinMin on 2017/12/6.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSUser.h"

@implementation UMSUser

+ (instancetype)userDataFromLoginRet:(NSDictionary *)loginRet {
    
    NSDictionary *data = [loginRet objectForKey:@"Data"];
    if (![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSDictionary *user = [data objectForKey:@"UserInfo"];
    if (![user isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    /** 解析用户数据 */
    UMSUser *currentUser = [UMSSDK currentUser];
    
    NSString *name = [[user objectForKey:@"truename"] asNSString];
    if (!name.length) {
        name = [[user objectForKey:@"username"] asNSString];
    }
    
    currentUser.uid = [[user objectForKey:@"uid"] asNSString];
    currentUser.nickname = name;
    currentUser.phone = [[user objectForKey:@"phone"] asNSString];
    currentUser.email = [[user objectForKey:@"email"] asNSString];
    currentUser.avatar = [[user objectForKey:@"head_pic"] asNSString];
    currentUser.city = [[user objectForKey:@"address"] asNSString];
    
    NSString *birthday = [[user objectForKey:@"birthday"] asNSString];
    if ([birthday length] > 0) {
        currentUser.birthday = [NSDate dateWithTimeIntervalSince1970:[birthday doubleValue]];
    }
    
    return currentUser;
}

+ (instancetype)userDataFromFetchRet:(NSDictionary *)fetchRet {
    
    NSDictionary *data = [fetchRet objectForKey:@"Data"];
    if (![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSDictionary *userInfo = [data objectForKey:@"UserInfo"];
    if (![userInfo isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    UMSUser *user = [[UMSUser alloc] init];
    
    NSString *name = [[userInfo objectForKey:@"truename"] asNSString];
    if (!name.length) {
        name = [[userInfo objectForKey:@"username"] asNSString];
    }
    
    user.uid = [[userInfo objectForKey:@"uid"] asNSString];
    user.nickname = name;
    user.phone = [[userInfo objectForKey:@"phone"] asNSString];
    user.email = [[userInfo objectForKey:@"email"] asNSString];
    user.avatar = [[userInfo objectForKey:@"head_pic"] asNSString];
    user.city = [[userInfo objectForKey:@"address"] asNSString];
    
    NSString *birthday = [[userInfo objectForKey:@"birthday"] asNSString];
    if ([birthday length] > 0) {
        user.birthday = [NSDate dateWithTimeIntervalSince1970:[birthday doubleValue]];
    }
    
    return user;
}

+ (void)copyUserData:(UMSUser *)tempUser {
    [UMSSDK currentUser].uid = tempUser.uid;
    [UMSSDK currentUser].nickname = tempUser.nickname;
    [UMSSDK currentUser].avatar = tempUser.avatar;
    [UMSSDK currentUser].phone = tempUser.phone;
    [UMSSDK currentUser].city = tempUser.city;
    [UMSSDK currentUser].birthday = tempUser.birthday;
}

@end
