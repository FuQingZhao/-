//
//  UIFont+BTKLib.m
//  BTKLib
//
//  Created by Min Lin on 2017/12/25.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "UIFont+BTKLib.h"

#define IS_IPHONE_6       ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS  ([[UIScreen mainScreen] bounds].size.height == 736.0f)

// 这里设置iPhone6放大的字号数
#define IPHONE6_INCREMENT      2
#define IPHONE6_PLUS_INCREMENT 3

@implementation UIFont (BTKLib)

+ (CGFloat)adjustPointSize:(CGFloat)pointSize {
    if (IS_IPHONE_6) {
        return pointSize + IPHONE6_INCREMENT;
    } else if (IS_IPHONE_6_PLUS) {
        return pointSize + IPHONE6_PLUS_INCREMENT;
    } else {
        return pointSize;
    }
}

@end
