//
//  UMSUserCustomFields.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSUserCustomFields.h"

@interface UMSUserCustomFields ()
@property (nonatomic, strong) NSMutableDictionary *customInfo;
@end

@implementation UMSUserCustomFields

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (dict && [dict count] > 0) {
            self.customInfo = [NSMutableDictionary dictionaryWithDictionary:dict];
        } else {
            self.customInfo = [NSMutableDictionary dictionary];
        }
    }
    return self;
}

- (instancetype)init {
    return [self initWithDict:nil];
}

- (void)append:(NSDictionary *)data {
    if (data != nil && [data count] > 0) {
        [self.customInfo addEntriesFromDictionary:data];
    }
}

- (void)set:(id)data key:(NSString *)key {
    if (data != nil) {
        [self.customInfo setObject:data forKey:key];
    }
}

- (id)get:(NSString *)key {
    return [self.customInfo objectForKey:key];
}

- (NSDictionary *)dictionaryValue {
    return self.customInfo;
}

@end
