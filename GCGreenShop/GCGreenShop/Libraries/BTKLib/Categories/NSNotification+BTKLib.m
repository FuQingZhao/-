//
//  NSNotification+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "NSNotification+BTKLib.h"

@implementation NSNotification (BTKLib)

- (BOOL)is:(NSString *)name {
    return [self.name isEqualToString:name];
}

- (BOOL)isKindOf:(NSString *)prefix {
    return [self.name hasPrefix:prefix];
}

@end



@implementation NSObject (Notification)

+ (NSString *)NOTIFICATION {
    return [self NOTIFICATION_TYPE];
}

+ (NSString *)NOTIFICATION_TYPE {
    return [NSString stringWithFormat:@"notify.%@.", [self description]];
}

- (void)handleNotification:(NSNotification *)notification {
    // TODO:
}

- (void)observeNotification:(NSString *)notificationName {
    
    NSArray * array = [notificationName componentsSeparatedByString:@"."];
    if ( array && array.count > 1 )
    {
#if defined(__BEE_SELECTOR_STYLE2__) && __BEE_SELECTOR_STYLE2__
        {
            NSString * clazz = (NSString *)[array objectAtIndex:1];
            NSString * name = (NSString *)[array objectAtIndex:2];
            
            NSString * selectorName;
            SEL selector;
            
            selectorName = [NSString stringWithFormat:@"handleNotification_%@_%@:", clazz, name];
            selector = NSSelectorFromString(selectorName);
            
            if ([self respondsToSelector:selector]) {
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:selector
                                                             name:notificationName
                                                           object:nil];
                return;
            }
            
            selectorName = [NSString stringWithFormat:@"handleNotification_%@:", clazz];
            selector = NSSelectorFromString(selectorName);
            
            if ([self respondsToSelector:selector]) {
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:selector
                                                             name:notificationName
                                                           object:nil];
                return;
            }
        }
#endif    // #if defined(__BEE_SMART_SELECTOR2__) && __BEE_SMART_SELECTOR2__
        
#if defined(__BEE_SELECTOR_STYLE1__) && __BEE_SELECTOR_STYLE1__
        {
            // TODO:
        }
#endif    // #if defined(__BEE_SMART_SELECTOR1__) && __BEE_SMART_SELECTOR1__
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:notificationName
                                               object:nil];
}

- (void)unobserveNotification:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
}

- (void)unobserveAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (BOOL)postNotification:(NSString *)name {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
    return YES;
}

+ (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
    return YES;
}

- (BOOL)postNotification:(NSString *)name {
    return [[self class] postNotification:name];
}

- (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object {
    return [[self class] postNotification:name withObject:object];
}

@end
