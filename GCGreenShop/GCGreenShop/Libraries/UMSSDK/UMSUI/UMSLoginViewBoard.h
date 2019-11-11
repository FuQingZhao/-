//
//  UMSLoginViewBoard.h
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSBaseViewBoard.h"
#import "UMSSDK.h"

static NSString* const kLoginSucceedNotification = @"UMSLoginSucceedNotification";

#define CHECK_USER_LOGINED(from) {                                \
    if ([[UMSSDK currentUser].uid length] == 0) {                 \
        [UMSLoginViewBoard pushLoginFrom:from loginHandler:nil];  \
        return;                                                   \
    }                                                             \
}                                                                 \

@interface UMSLoginViewBoard : UMSBaseViewBoard

/**
 可供自定义的左导航栏按钮
 */
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;

/**
 可供自定义的右导航栏按钮
 */
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

/**
 登录回调
 */
@property (nonatomic, copy) void (^loginHandler) (NSError *error);

/**
 Push方式打开登录页面
 
 @param from 源视图
 @param loginHandler 登录之后的回调
 */
+ (void)pushLoginFrom:(UIViewController *)from loginHandler:(void(^) (NSError *error))loginHandler;

/**
 模态方式打开登录页面
 
 @param from 源视图
 @param loginHandler 登录之后的回调
 */
+ (void)presentLoginFrom:(UIViewController *)from loginHandler:(void(^) (NSError *error))loginHandler;

@end
