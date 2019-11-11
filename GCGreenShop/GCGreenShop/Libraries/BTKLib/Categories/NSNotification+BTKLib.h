//
//  NSNotification+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

///-----------------
/// Notification
///-----------------
#define AS_NOTIFICATION( __name )     AS_STATIC_PROPERTY( __name )
#define DEF_NOTIFICATION( __name )    DEF_STATIC_PROPERTY3( __name, @"notify", [self description] )

#undef  ON_NOTIFICATION
#define ON_NOTIFICATION( __notification ) \
- (void)handleNotification:(NSNotification *)__notification

#undef  ON_NOTIFICATION2
#define ON_NOTIFICATION2( __filter, __notification ) \
- (void)handleNotification_##__filter:(NSNotification *)__notification

#undef  ON_NOTIFICATION3
#define ON_NOTIFICATION3( __class, __name, __notification ) \
- (void)handleNotification_##__class##_##__name:(NSNotification *)__notification


@interface NSNotification (BTKLib)

- (BOOL)is:(NSString *)name;
- (BOOL)isKindOf:(NSString *)prefix;

@end



@interface NSObject (Notification)

+ (NSString *)NOTIFICATION;
+ (NSString *)NOTIFICATION_TYPE;

- (void)handleNotification:(NSNotification *)notification;

- (void)observeNotification:(NSString *)name;
- (void)unobserveNotification:(NSString *)name;
- (void)unobserveAllNotifications;

+ (BOOL)postNotification:(NSString *)name;
+ (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object;

- (BOOL)postNotification:(NSString *)name;
- (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object;

@end
