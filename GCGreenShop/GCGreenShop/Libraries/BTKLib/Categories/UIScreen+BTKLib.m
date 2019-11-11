//
//  UIScreen+BTKLib.m
//  iNanjing
//
//  Created by Min Lin on 2017/12/27.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UIScreen+BTKLib.h"
#import <YYKit/UIScreen+YYAdd.h>
#import <objc/runtime.h>
#import "sys/utsname.h"

static CGFloat const kiPhone6Pixel = 375.0;

@implementation UIScreen (BTKLib)

+ (BOOL)isIPhoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        // judgment by height when in simulators
        return (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
                CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)));
    }
    BOOL isIPhoneX = [platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"];
    return isIPhoneX;
}

+ (CGFloat)screenWidth {
    CGRect bounds = [[UIScreen mainScreen] currentBounds];
    return bounds.size.width;
}

+ (CGFloat)screenHeight {
    CGRect bounds = [[UIScreen mainScreen] currentBounds];
    return bounds.size.height;
}

+ (CGFloat)pixelThatFits:(CGFloat)pixel {
    CGFloat screenWidth = [UIScreen screenWidth];
    CGFloat pixelAspectRatio = screenWidth / kiPhone6Pixel;
    return floorf(pixelAspectRatio * pixel);
}

+ (UIEdgeInsets)safeEdge {
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        UITabBarController *tabBarController = (UITabBarController *)window.rootViewController;
        return tabBarController.view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

+ (CGFloat)navBarHeight {
    return [[self class] isIPhoneX] ? 88.0 : 64.0;
}

+ (CGFloat)tabBarHeight {
    return [[self class] isIPhoneX] ? 83.0 : 49.0;
}

@end

