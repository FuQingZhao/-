//
//  UMSSDK+Relationship.m
//  UMSSDK
//
//  Created by LinMin on 2017/12/6.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSSDK+Relationship.h"

@implementation UMSSDK (Relationship)

#pragma mark - 好友关系接口

+ (void)deleteFriendWithUser:(UMSUser *)user
                      result:(UMSDeleteFriendResult)handler {
    
}

+ (void)getInvitedFriendListWithUser:(UMSUser *)user
                              status:(UMSDealWithRequestStatus)status
                             pageNum:(NSUInteger)pageNum
                            pageSize:(NSUInteger)pageSize
                              result:(UMSGetApplyAddFriendListResult)handler {
    
}

+ (void)addFriendRequestWithUser:(UMSUser *)user
                         message:(NSString *)message
                          result:(UMSAddFriendRequestResult)handler {
    
}

+ (void)dealWithFriendRequestWithUser:(UMSUser *)user
                                reply:(UMSDealWithRequestStatus)status
                               result:(UMSDealWithFriendRequestResult)handler {
    
}

+ (void)getFriendListWithUser:(UMSUser *)user
                      pageNum:(NSUInteger)pageNum
                     pageSize:(NSUInteger)pageSize
                       result:(UMSGetUserListResult)handler {
    
}


#pragma mark - 用户接口

+ (void)getUserInfoWithUserID:(NSString *)userID
                       result:(UMSGetUserInfoResult)handler {
    
}

+ (void)blockUser:(UMSUser *)user
           result:(UMSBlockUserResult)handler {
    
}

+ (void)getBlockedUserListWithUser:(UMSUser *)user
                           pageNum:(NSUInteger)pageNum
                          pageSize:(NSUInteger)pageSize
                            result:(UMSGetUserListResult)handler {
    
}

+ (void)removeFromBlockedUserListWithUser:(UMSUser *)user
                                   result:(UMSRemoveFromBlockListResult)handler {
    
}


#pragma mark - 最近登录列表

+ (void)getRecentLoginUserListWithPageNum:(NSUInteger)pageNum
                                 pageSize:(NSUInteger)pageSize
                                   result:(UMSGetUserListResult)handler {
    
}


#pragma mark - 粉丝接口

+ (void)unfollowUserWithUser:(UMSUser *)user
                      result:(UMSUnfollowResult)handler {
    
}

+ (void)followWithUser:(UMSUser *)user
                result:(UMSFollowResult)handler {
    
}

+ (void)getFansListWithUser:(UMSUser *)user
               relationship:(UMSRelationship)relationship
                    pageNum:(NSUInteger)pageNum
                   pageSize:(NSUInteger)pageSize
                     result:(UMSGetUserListResult)handler {
    
}


#pragma mark - 搜索

+ (void)searchForUserWithKey:(NSString *)key
                     pageNum:(NSUInteger)pageNum
                    pageSize:(NSUInteger)pageSize
                      result:(UMSGetUserListResult)handler {
    
}

@end
