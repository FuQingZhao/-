//
//  UINavigationItem+BTKLib.h
//  BTKLib
//
//  Created by Min Lin on 2017/12/25.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Position to show UIActivityIndicatorView in a navigation bar
 */
typedef NS_ENUM(NSUInteger, BTKNavBarLoaderPosition) {
    BTKNavBarLoaderPositionCenter = 0,
    BTKNavBarLoaderPositionLeft,
    BTKNavBarLoaderPositionRight
};

@interface UINavigationItem (BTKLib)

/**
 Add UIActivityIndicatorView to view hierarchy and start animating immediately
 */
- (void)startAnimatingAt:(BTKNavBarLoaderPosition)position;

/**
 Stop animating, remove UIActivityIndicatorView from view hierarchy and restore item
 */
- (void)stopAnimating;

@end
