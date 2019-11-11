//
//  ShareSDKObject.m
//  iNanjing
//
//  Created by LinMin on 2018/3/29.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import "ShareSDKObject.h"

@implementation ShareSDKObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentType = SSDKContentTypeAuto;
    }
    return self;
}

@end
