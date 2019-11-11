//
//  NSObject+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -

#undef  AS_STATIC_PROPERTY
#define AS_STATIC_PROPERTY( __name ) \
- (NSString *)__name; \
+ (NSString *)__name;

#if __has_feature(objc_arc)

#undef  DEF_STATIC_PROPERTY
#define DEF_STATIC_PROPERTY( __name ) \
- (NSString *)__name \
{ \
  return (NSString *)[[self class] __name]; \
} \
+ (NSString *)__name \
{ \
  return [NSString stringWithFormat:@"%s", #__name]; \
}

#else

#undef  DEF_STATIC_PROPERTY
#define DEF_STATIC_PROPERTY( __name ) \
- (NSString *)__name \
{ \
  return (NSString *)[[self class] __name]; \
} \
+ (NSString *)__name \
{ \
  return [NSString stringWithFormat:@"%s", #__name]; \
}

#endif

#if __has_feature(objc_arc)

#undef  DEF_STATIC_PROPERTY2
#define DEF_STATIC_PROPERTY2( __name, __prefix ) \
- (NSString *)__name \
{ \
  return (NSString *)[[self class] __name]; \
} \
+ (NSString *)__name \
{ \
  return [NSString stringWithFormat:@"%@.%s", __prefix, #__name]; \
}

#else

#undef  DEF_STATIC_PROPERTY2
#define DEF_STATIC_PROPERTY2( __name, __prefix ) \
- (NSString *)__name \
{ \
  return (NSString *)[[self class] __name]; \
} \
+ (NSString *)__name \
{ \
  return [NSString stringWithFormat:@"%@.%s", __prefix, #__name]; \
}

#endif

#if __has_feature(objc_arc)

#undef  DEF_STATIC_PROPERTY3
#define DEF_STATIC_PROPERTY3( __name, __prefix, __prefix2 ) \
- (NSString *)__name \
{ \
  return (NSString *)[[self class] __name]; \
} \
+ (NSString *)__name \
{ \
  return [NSString stringWithFormat:@"%@.%@.%s", __prefix, __prefix2, #__name]; \
}

#else

#undef  DEF_STATIC_PROPERTY3
#define DEF_STATIC_PROPERTY3( __name, __prefix, __prefix2 ) \
- (NSString *)__name \
{ \
  return (NSString *)[[self class] __name]; \
} \
+ (NSString *)__name \
{ \
  return [NSString stringWithFormat:@"%@.%@.%s", __prefix, __prefix2, #__name]; \
}

#endif

#if __has_feature(objc_arc)

#undef  DEF_STATIC_PROPERTY4
#define DEF_STATIC_PROPERTY4( __name, __value, __prefix, __prefix2 ) \
- (NSString *)__name \
{ \
  return (NSString *)[[self class] __name]; \
} \
+ (NSString *)__name \
{ \
  return [NSString stringWithFormat:@"%@.%@.%s", __prefix, __prefix2, #__value]; \
}

#else

#undef  DEF_STATIC_PROPERTY4
#define DEF_STATIC_PROPERTY4( __name, __value, __prefix, __prefix2 ) \
- (NSString *)__name \
{ \
  return (NSString *)[[self class] __name]; \
} \
+ (NSString *)__name \
{ \
  return [NSString stringWithFormat:@"%@.%@.%s", __prefix, __prefix2, #__value]; \
}

#endif


#pragma mark -

#undef  AS_STATIC_PROPERTY_INT
#define AS_STATIC_PROPERTY_INT( __name ) \
- (NSInteger)__name; \
+ (NSInteger)__name;

#undef  DEF_STATIC_PROPERTY_INT
#define DEF_STATIC_PROPERTY_INT( __name, __value ) \
- (NSInteger)__name \
{ \
  return (NSInteger)[[self class] __name]; \
} \
+ (NSInteger)__name \
{ \
  return __value; \
}

#undef  AS_INT
#define AS_INT    AS_STATIC_PROPERTY_INT

#undef  DEF_INT
#define DEF_INT    DEF_STATIC_PROPERTY_INT


#pragma mark -

#undef  AS_STATIC_PROPERTY_NUMBER
#define AS_STATIC_PROPERTY_NUMBER( __name ) \
- (NSNumber *)__name; \
+ (NSNumber *)__name;

#undef  DEF_STATIC_PROPERTY_NUMBER
#define DEF_STATIC_PROPERTY_NUMBER( __name, __value ) \
- (NSNumber *)__name \
{ \
  return (NSNumber *)[[self class] __name]; \
} \
+ (NSNumber *)__name \
{ \
  return [NSNumber numberWithInt:__value]; \
}

#undef  AS_NUMBER
#define AS_NUMBER    AS_STATIC_PROPERTY_NUMBER

#undef  DEF_NUMBER
#define DEF_NUMBER    DEF_STATIC_PROPERTY_NUMBER


#pragma mark -

#undef  AS_STATIC_PROPERTY_STRING
#define AS_STATIC_PROPERTY_STRING( __name ) \
- (NSString *)__name; \
+ (NSString *)__name;

#undef  DEF_STATIC_PROPERTY_STRING
#define DEF_STATIC_PROPERTY_STRING( __name, __value ) \
- (NSString *)__name \
{ \
  return [[self class] __name]; \
} \
+ (NSString *)__name \
{ \
  return __value; \
}

#undef  AS_STRING
#define AS_STRING    AS_STATIC_PROPERTY_STRING

#undef  DEF_STRING
#define DEF_STRING    DEF_STATIC_PROPERTY_STRING



@interface NSObject (BTKLib)

/// Type Conversion
- (NSNumber *)asNSNumber;
- (NSString *)asNSString;
- (NSDate *)asNSDate;
- (NSData *)asNSData;
- (NSArray *)asNSArray;
- (NSDictionary *)asNSDictionary;
- (NSInteger)asInteger;
- (int)asInt;
- (float)asFloat;
- (BOOL)asBool;


/// Associated Object
/**
 附加一个stong对象
 */
- (void)associateValue:(id)value withKey:(const void *)key; // Strong reference
+ (void)associateValue:(id)value withKey:(const void *)key;

/**
 附加一个weak对象
 */
- (void)weaklyAssociateValue:(id)value withKey:(const void *)key;
+ (void)weaklyAssociateValue:(id)value withKey:(const void *)key;

/**
 根据附加对象的key取出附加对象
 */
- (id)associatedValueForKey:(const void *)key;
+ (id)associatedValueForKey:(const void *)key;


/// Perform Blocks
+ (id)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
- (id)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
+ (void)cancelBlock:(id)block;
+ (void)cancelPreviousPerformBlock:(id)aWrappingBlockHandle __attribute__ ((deprecated));

/**
 异步执行代码块
 */
- (void)performAsynchronous:(void(^)(void))block;

/**
 GCD主线程执行代码块
 */
- (void)performOnMainThread:(void(^)(void))block wait:(BOOL)wait;


/// Notification
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


/// Properties
@property (nonatomic, strong) NSString *stringProperty;
@property (nonatomic, assign) NSInteger integerProperty;

- (NSDictionary *)propertyDictionary;
- (NSDictionary *)dictionaryValue;

- (NSArray *)allPropertyKeys;
+ (NSArray *)classPropertyList;

- (NSArray *)allPropertyKeyPaths;

- (NSArray *)allBasePropertyKeyPaths;
- (BOOL)hasPropertyForKey:(NSString *)key;
- (BOOL)hasIvarForKey:(NSString *)key;
- (id)valueForArrayIndexedKeyPath:(NSString *)keyPath;


/// Runtime
/**
 Exchange methods' implementations.
 
 @param originalMethod Method to exchange.
 @param newMethod Method to exchange.
 */
+ (void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;

/**
 Append a new method to an object.
 
 @param newMethod Method to exchange.
 @param klass Host class.
 */
+ (void)appendMethod:(SEL)newMethod fromClass:(Class)klass;

/**
 Replace a method in an object.
 
 @param method Method to exchange.
 @param klass Host class.
 */
+ (void)replaceMethod:(SEL)method fromClass:(Class)klass;

/**
 Check whether the receiver implements or inherits a specified method up to and exluding a particular class in hierarchy.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)respondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 Check whether a superclass implements or inherits a specified method.
 
 @param selector A selector that identifies a method.
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)superRespondsToSelector:(SEL)selector;

/**
 Check whether a superclass implements or inherits a specified method.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 Check whether the receiver's instances implement or inherit a specified method up to and exluding a particular class in hierarchy.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
+ (BOOL)instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass;

@end
