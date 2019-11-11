//
//  BTKMacros.h
//  BTKLib
//
//  Created by Min Lin on 2017/12/25.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#ifndef BTKMacros_h
#define BTKMacros_h

///-----------------
/// Property属性快速声明
///-----------------
#define AS_PROPERTY_STRING(str)            @property (nonatomic, copy)   NSString *str;
#define AS_PROPERTY_INT(intValue)          @property (nonatomic, assign) int intValue;
#define AS_PROPERTY_INTEGER(integerValue)  @property (nonatomic, assign) NSInteger integerValue;
#define AS_PROPERTY_FLOAT(floatValue)      @property (nonatomic, assign) float floatValue;
#define AS_PROPERTY_DICT(dict)             @property (nonatomic, strong) NSDictionary *dict;
#define AS_PROPERTY_MUTABLE_DICT(dictM)    @property (nonatomic, strong) NSMutableDictionary *dictM;
#define AS_PROPERTY_ARRAY(array)           @property (nonatomic, strong) NSArray *array;
#define AS_PROPERTY_MUTABLE_ARRAY(arrayM)  @property (nonatomic, strong) NSMutableArray *arrayM;

///-----------------
/// 单例
///-----------------
#undef  AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef  DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance { \
  return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance { \
  static dispatch_once_t once; \
  static __class * __singleton__; \
  dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
  return __singleton__; \
}


///-----------------
/// 日志控制
///-----------------
#ifdef DEBUG
#define TTLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define TTLog(...)
#endif


///-----------------
/// 验证数据格式
///-----------------
#define NSStringValid(str)       ([str isKindOfClass:[NSString class]] && str != nil)
#define NSDictionaryValid(dict)  ([dict isKindOfClass:[NSDictionary class]] && dict != nil)
#define NSArrayValid(array)      ([array isKindOfClass:[NSArray class]] && array != nil)
#define NSNumberValid(number)    ([number isKindOfClass:[NSNumber class]] && number != nil)
#define NSDataValid(data)        ([data isKindOfClass:[NSData class]] && data != nil)


///-----------------
/// 版本号
///-----------------
#define BTK_BUNDLE_INFO     [[NSBundle mainBundle] infoDictionary]
#define BTK_SYS_VERSION     [BTK_BUNDLE_INFO objectForKey:@"CFBundleShortVersionString"]
#define BTK_SYS_BUILD       [BTK_BUNDLE_INFO objectForKey:@"CFBundleVersion"]
#define BTK_VERSION_BUILD   [NSString stringWithFormat:@"%@.%@", BTK_SYS_VERSION, BTK_SYS_BUILD]
#define BTK_SYS_IDENTIFIER  [BTK_BUNDLE_INFO objectForKey:@"CFBundleIdentifier"]

#endif /* BTKMacros_h */
