//
//  NSObject+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "NSObject+BTKLib.h"
#import "NSNotification+BTKLib.h"
#import <objc/runtime.h>

//objc_getAssociatedObject和objc_setAssociatedObject都需要指定一个固定的地址，这个固定的地址值用来表示属性的key，起到一个常量的作用。
static const void *StringProperty = &StringProperty;
static const void *IntegerProperty = &IntegerProperty;

static inline dispatch_time_t dTimeDelay(NSTimeInterval time) {
    int64_t delta = (int64_t)(NSEC_PER_SEC * time);
    return dispatch_time(DISPATCH_TIME_NOW, delta);
}

BOOL method_swizzle(Class klass, SEL origSel, SEL altSel) {
    
    if (!klass) {
        return NO;
    }
    
    Method __block origMethod, __block altMethod;
    
    void (^find_methods)(void) = ^ {
        unsigned methodCount = 0;
        Method *methodList = class_copyMethodList(klass, &methodCount);
        origMethod = altMethod = NULL;
        if (methodList)
            for (unsigned i = 0; i < methodCount; ++i) {
                if (method_getName(methodList[i]) == origSel)
                    origMethod = methodList[i];
                
                if (method_getName(methodList[i]) == altSel)
                    altMethod = methodList[i];
            }
        
        free(methodList);
    };
    
    find_methods();
    
    if (!origMethod) {
        origMethod = class_getInstanceMethod(klass, origSel);
        
        if (!origMethod)
            return NO;
        
        if (!class_addMethod(klass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod)))
            return NO;
    }
    
    if (!altMethod) {
        altMethod = class_getInstanceMethod(klass, altSel);
        
        if (!altMethod)
            return NO;
        
        if (!class_addMethod(klass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod)))
            return NO;
    }
    
    find_methods();
    
    if (!origMethod || !altMethod) {
        return NO;
    }
    
    method_exchangeImplementations(origMethod, altMethod);
    
    return YES;
}

void method_append(Class toClass, Class fromClass, SEL selector) {
    if (!toClass || !fromClass || !selector) {
        return;
    }
    Method method = class_getInstanceMethod(fromClass, selector);
    if (!method) {
        return;
    }
    class_addMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

void method_replace(Class toClass, Class fromClass, SEL selector) {
    if (!toClass || !fromClass || ! selector) {
        return;
    }
    Method method = class_getInstanceMethod(fromClass, selector);
    if (!method) {
        return;
    }
    class_replaceMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

@implementation NSObject (BTKLib)

- (BOOL)isNull {
    return self == [NSNull null];
}


#pragma mark - Type Conversion

- (NSNumber *)asNSNumber {
    if ([self isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)self;
    }
    else if ([self isKindOfClass:[NSString class]]) {
        return [NSNumber numberWithInteger:[(NSString *)self integerValue]];
    }
    else if ([self isKindOfClass:[NSDate class]]) {
        return [NSNumber numberWithDouble:[(NSDate *)self timeIntervalSince1970]];
    }
    else if ([self isKindOfClass:[NSNull class]]) {
        return [NSNumber numberWithInteger:0];
    }
    
    return nil;
}

- (NSString *)asNSString {
    
    if ([self isNull]) {
        return @"";
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    }
    else if ([self isKindOfClass:[NSData class]]) {
        
        NSData *data = (NSData *)self;
        NSString *text = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
        if (nil == text) {
            text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (nil == text) {
                text = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            }
        }
        return text;
    }
    else {
        return [NSString stringWithFormat:@"%@", self];
    }
}

- (NSDate *)asNSDate {
    
    if ([self isNull]) {
        return nil;
    }
    
    if ([self isKindOfClass:[NSDate class]]) {
        return (NSDate *)self;
    }
    else if ([self isKindOfClass:[NSString class]]) {
        
        NSDate *date = nil;
        
        if (nil == date) {
            NSString * format = @"yyyy-MM-dd HH:mm:ss z";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        if (nil == date) {
            NSString * format = @"yyyy/MM/dd HH:mm:ss z";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        if (nil == date) {
            NSString * format = @"yyyy-MM-dd HH:mm:ss";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        if (nil == date) {
            NSString * format = @"yyyy/MM/dd HH:mm:ss";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        return date;
    }
    else {
        return [NSDate dateWithTimeIntervalSince1970:[self asNSNumber].doubleValue];
    }
    
    return nil;
}

- (NSData *)asNSData {
    
    if ([self isNull]) {
        return nil;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        return [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    }
    else if ([self isKindOfClass:[NSData class]]) {
        return (NSData *)self;
    }
    
    return nil;
}

- (NSArray *)asNSArray {
    
    if ([self isNull]) {
        return [NSArray array];
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        return (NSArray *)self;
    }
    else {
        return [NSArray arrayWithObject:self];
    }
}

- (NSDictionary *)asNSDictionary {
    
    if ([self isNull]) {
        return [NSDictionary dictionary];
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)self;
    }
    return nil;
}

- (NSInteger)asInteger {
    return [[self asNSString] integerValue];
}

- (int)asInt {
    return [[self asNSString] intValue];
}

- (float)asFloat {
    return [[self asNSString] floatValue];
}

- (BOOL)asBool {
    return [[self asNSString] boolValue];
}


#pragma mark - Associated Object

- (void)associateValue:(id)value withKey:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

+ (void)associateValue:(id)value withKey:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)weaklyAssociateValue:(id)value withKey:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

+ (void)weaklyAssociateValue:(id)value withKey:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)associatedValueForKey:(const void *)key {
    return objc_getAssociatedObject(self, key);
}

+ (id)associatedValueForKey:(const void *)key {
    return objc_getAssociatedObject(self, key);
}


#pragma mark - Perform Blocks

+ (id)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    
    if (!block) return nil;
    
    __block BOOL cancelled = NO;
    
    void (^wrappingBlock)(BOOL) = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled)block();
    };
    
    wrappingBlock = [wrappingBlock copy];
    
    dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{
        wrappingBlock(NO);
    });
    
    return wrappingBlock;
}

+ (id)performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay {
    
    if (!block) return nil;
    
    __block BOOL cancelled = NO;
    
    void (^wrappingBlock)(BOOL, id) = ^(BOOL cancel, id arg) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block(arg);
    };
    
    wrappingBlock = [wrappingBlock copy];
    
    dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{
        wrappingBlock(NO, anObject);
    });
    
    return wrappingBlock;
}

- (id)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    
    if (!block) return nil;
    
    __block BOOL cancelled = NO;
    
    void (^wrappingBlock)(BOOL) = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block();
    };
    
    wrappingBlock = [wrappingBlock copy];
    
    dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{
        wrappingBlock(NO);
    });
    
    return wrappingBlock;
}

- (id)performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay {
    
    if (!block) return nil;
    
    __block BOOL cancelled = NO;
    
    void (^wrappingBlock)(BOOL, id) = ^(BOOL cancel, id arg) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block(arg);
    };
    
    wrappingBlock = [wrappingBlock copy];
    
    dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{
        wrappingBlock(NO, anObject);
    });
    
    return wrappingBlock;
}

+ (void)cancelBlock:(id)block {
    if (!block) return;
    void (^aWrappingBlock)(BOOL) = (void(^)(BOOL))block;
    aWrappingBlock(YES);
}

+ (void)cancelPreviousPerformBlock:(id)aWrappingBlockHandle {
    [self cancelBlock:aWrappingBlockHandle];
}

- (void)performAsynchronous:(void(^)(void))block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}

- (void)performOnMainThread:(void(^)(void))block wait:(BOOL)shouldWait {
    if (shouldWait) {
        // Synchronous
        dispatch_sync(dispatch_get_main_queue(), block);
    }
    else {
        // Asynchronous
        dispatch_async(dispatch_get_main_queue(), block);
    }
}


#pragma mark - Notification

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
    
    NSArray *array = [notificationName componentsSeparatedByString:@"."];
    if (array && array.count > 1) {
        
#if defined(__BEE_SELECTOR_STYLE2__) && __BEE_SELECTOR_STYLE2__
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
#endif    // #if defined(__BEE_SMART_SELECTOR2__) && __BEE_SMART_SELECTOR2__
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:notificationName
                                               object:nil];
}

- (void)unobserveNotification:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
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


#pragma mark - Add Property

@dynamic stringProperty;

/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
- (void)setStringProperty:(NSString *)stringProperty {
    //use that a static const as the key
    objc_setAssociatedObject(self, StringProperty, stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)stringProperty {
    return objc_getAssociatedObject(self, StringProperty);
}

/**
 *  @brief  catgory runtime实现get set方法增加一个NSInteger属性
 */
- (void)setIntegerProperty:(NSInteger)integerProperty {
    NSNumber *number = [[NSNumber alloc]initWithInteger:integerProperty];
    objc_setAssociatedObject(self, IntegerProperty, number, OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)integerProperty {
    return [objc_getAssociatedObject(self, IntegerProperty) integerValue];
}

- (NSDictionary *)propertyDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList([self class], &outCount);
    for(int i = 0;i < outCount;i++){
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc] initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        id propValue = [self valueForKey:propName];
        if (propValue) {
            [dict setObject:propValue forKey:propName];
        }
    }
    free(props);
    return dict;
}

+ (NSArray *)classPropertyList {
    NSMutableArray *allProperties = [[NSMutableArray alloc] init];
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList(self, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc] initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        if (propName) {
            [allProperties addObject:propName];
        }
    }
    free(props);
    return [NSArray arrayWithArray:allProperties];
}

- (NSDictionary *)dictionaryValue {
    return [self dictionaryWithValuesForKeys:[self allPropertyKeys]];
}

- (NSArray *)allPropertyKeys {
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
    NSMutableArray * propertyNames = [NSMutableArray array];
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNames;
}

- (NSArray *)allPropertyKeyPaths {
    NSMutableArray *allKeyPaths = [NSMutableArray array];
    for (NSString* key in [self allPropertyKeys]) {
        id obj = [self valueForKey:key];
        [allKeyPaths addObject:key];
        [allKeyPaths addObjectsFromArray:[obj allPropertyKeyPathsWithBaseKeyPath:key]];
    }
    return [NSArray arrayWithArray:allKeyPaths];
}

- (NSArray *)allPropertyKeyPathsWithBaseKeyPath:(NSString *)baseKeyPath {
    NSMutableArray *allKeyPaths = [NSMutableArray array];
    for (NSString* key in [self allPropertyKeys]) {
        id obj = [self valueForKey:key];
        NSString *newBasePath = [baseKeyPath stringByAppendingFormat:@".%@", key];
        [allKeyPaths addObject:newBasePath];
        [allKeyPaths addObjectsFromArray:[obj allPropertyKeyPathsWithBaseKeyPath:newBasePath]];
    }
    return [NSArray arrayWithArray:allKeyPaths];
}

- (NSArray *)allBasePropertyKeyPaths {
    NSMutableArray *allKeyPaths = [NSMutableArray array];
    for (NSString* key in [self allPropertyKeys]) {
        id obj = [self valueForKey:key];
        //NSLog(@"%@:%@", key, obj);
        id subKeys = [obj allBasePropertyKeyPathsWithBaseKeyPath:key];
        if    ([subKeys count] > 0) {
            [allKeyPaths addObjectsFromArray:subKeys];
        } else {
            [allKeyPaths addObject:key];
        }
    }
    return [NSArray arrayWithArray:allKeyPaths];
}

- (NSArray *)allBasePropertyKeyPathsWithBaseKeyPath:(NSString *)baseKeyPath {
    NSMutableArray *allKeyPaths = [NSMutableArray array];
    for (NSString* key in [self allPropertyKeys]) {
        id obj = [self valueForKey:key];
        NSString *newBasePath = [baseKeyPath stringByAppendingFormat:@".%@", key];
        id subKeys = [obj allBasePropertyKeyPathsWithBaseKeyPath:newBasePath];
        if    ([subKeys count] > 0) {
            [allKeyPaths addObjectsFromArray:subKeys];
        } else {
            [allKeyPaths addObject:newBasePath];
        }
    }
    return [NSArray arrayWithArray:allKeyPaths];
}

- (BOOL)hasPropertyForKey:(NSString *)key {
    objc_property_t property = class_getProperty([self class], [key UTF8String]);
    return (BOOL)property;
}

- (BOOL)hasIvarForKey:(NSString *)key {
    Ivar ivar = class_getInstanceVariable([self class], [key UTF8String]);
    return (BOOL)ivar;
}

- (id)valueForArrayIndexedKeyPath:(NSString *)keyPath {
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    id object = nil;
    for (NSString* key in keys) {
        if ([object isKindOfClass:[NSArray class]]) {
            NSRange range = [key rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
            if (range.location != NSNotFound) {
                NSString *digitKey = [key substringWithRange:range];
                NSInteger index = [digitKey integerValue];
                BOOL validIndex = (index < [object count])&&(index >= 0);
                if (!validIndex) {
                    NSString *error = [NSString stringWithFormat:@"Index:%zd out of bounds for valueAtKeyPath:@\"%@\" for array:0x%p.count = %zd", index, keyPath, &object, [object count]];
                    NSAssert(validIndex, error);
                }
                object = [object objectAtIndex:index];
            }
        }
        else {
            object = [self valueForKey:key];
        }
    }
    return object;
}


#pragma mark - Runtime

+ (void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod {
    method_swizzle(self.class, originalMethod, newMethod);
}

+ (void)appendMethod:(SEL)newMethod fromClass:(Class)klass {
    method_append(self.class, klass, newMethod);
}

+ (void)replaceMethod:(SEL)method fromClass:(Class)klass {
    method_replace(self.class, klass, method);
}

- (BOOL)respondsToSelector:(SEL)selector untilClass:(Class)stopClass {
    return [self.class instancesRespondToSelector:selector untilClass:stopClass];
}

- (BOOL)superRespondsToSelector:(SEL)selector {
    return [self.superclass instancesRespondToSelector:selector];
}

- (BOOL)superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass {
    return [self.superclass instancesRespondToSelector:selector untilClass:stopClass];
}

+ (BOOL)instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass {
    BOOL __block (^ __weak block_self)(Class klass, SEL selector, Class stopClass);
    BOOL (^block)(Class klass, SEL selector, Class stopClass) = [^(Class klass, SEL selector, Class stopClass) {
        if (!klass || klass == stopClass)
            return NO;
        
        unsigned methodCount = 0;
        Method *methodList = class_copyMethodList(klass, &methodCount);
        
        if (methodList)
            for (unsigned i = 0; i < methodCount; ++i)
                if (method_getName(methodList[i]) == selector)
                    return YES;
        
        return block_self(klass.superclass, selector, stopClass);
    } copy];
    
    block_self = block;
    
    return block(self.class, selector, stopClass);
}

@end
