//
//  TTAppConfiguration.m
//  TTReader
//
//  Created by LinMin on 2017/12/31.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "TTAppConfiguration.h"

@implementation TTAppConfiguration

+ (instancetype)configure {
    static dispatch_once_t onceToken;
    static TTAppConfiguration *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[TTAppConfiguration alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _configure];
    }
    return self;
}

- (NSString *)val {
    NSTimeInterval ti = [NSDate currentTs];
    NSString *str = [NSString stringWithFormat:@"%.0f%@", ti, @"BTK"];
    return [str md5String];
}

+ (NSString *)stringByEncrypt {
    return [TTAppConfiguration configure].val;
}

+ (BOOL)isReviewing {
//    TTVersion *version = [TTAppConfiguration configure].initial.version;
//    return [BTK_SYS_VERSION floatValue] > [version.number floatValue];
    return NO;
}


#pragma mark - 附加方法

- (void)_configure {
    self.defHost = @"http://bus.inj100.jstv.com/";
    self.phpDefHost = @"http://app.elcst.com/index.php";
}

@end
