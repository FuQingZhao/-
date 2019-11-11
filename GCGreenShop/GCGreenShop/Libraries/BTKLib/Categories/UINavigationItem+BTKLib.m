//
//  UINavigationItem+BTKLib.m
//  BTKLib
//
//  Created by Min Lin on 2017/12/25.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "UINavigationItem+BTKLib.h"
#import <objc/runtime.h>

static void *BTKLoaderPositionAssociationKey = &BTKLoaderPositionAssociationKey;
static void *BTKSubstitutedViewAssociationKey = &BTKSubstitutedViewAssociationKey;

@implementation UINavigationItem (BTKLib)

- (void)startAnimatingAt:(BTKNavBarLoaderPosition)position {
    
    // stop previous if animated
    [self stopAnimating];
    
    // hold reference for position to stop at the right place
    objc_setAssociatedObject(self, BTKLoaderPositionAssociationKey, @(position), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIActivityIndicatorView* loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    // substitute bar views to loader and hold reference to them for restoration
    switch (position) {
        case BTKNavBarLoaderPositionLeft:
            objc_setAssociatedObject(self, BTKSubstitutedViewAssociationKey, self.leftBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.leftBarButtonItem.customView = loader;
            break;
            
        case BTKNavBarLoaderPositionCenter:
            objc_setAssociatedObject(self, BTKSubstitutedViewAssociationKey, self.titleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.titleView = loader;
            break;
            
        case BTKNavBarLoaderPositionRight:
            objc_setAssociatedObject(self, BTKSubstitutedViewAssociationKey, self.rightBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.rightBarButtonItem.customView = loader;
            break;
    }
    
    [loader startAnimating];
}

- (void)stopAnimating {
    NSNumber* positionToRestore = objc_getAssociatedObject(self, BTKLoaderPositionAssociationKey);
    id componentToRestore = objc_getAssociatedObject(self, BTKSubstitutedViewAssociationKey);
    
    // restore UI if animation was in a progress
    if (positionToRestore) {
        switch (positionToRestore.intValue) {
            case BTKNavBarLoaderPositionLeft:
                self.leftBarButtonItem.customView = componentToRestore;
                break;
                
            case BTKNavBarLoaderPositionCenter:
                self.titleView = componentToRestore;
                break;
                
            case BTKNavBarLoaderPositionRight:
                self.rightBarButtonItem.customView = componentToRestore;
                break;
        }
    }
    
    objc_setAssociatedObject(self, BTKLoaderPositionAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, BTKSubstitutedViewAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - iOS7 or later styles

- (BOOL)isIOS7 {
    return ([[[UIDevice currentDevice] systemVersion] compare:@"7" options:NSNumericSearch] != NSOrderedAscending);
}

- (UIBarButtonItem *)spacer {
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -15;
    return space;
}

- (void)mk_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    if ([self isIOS7] && leftBarButtonItem) {
        [self mk_setLeftBarButtonItem:nil];
        [self mk_setLeftBarButtonItems:@[[self spacer], leftBarButtonItem]];
    } else {
        if ([self isIOS7]) {
            [self mk_setLeftBarButtonItems:nil];
        }
        [self mk_setLeftBarButtonItem:leftBarButtonItem];
    }
}

- (void)mk_setLeftBarButtonItems:(NSArray *)leftBarButtonItems {
    
    if ([self isIOS7] && leftBarButtonItems && leftBarButtonItems.count > 0) {
        
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:leftBarButtonItems.count + 1];
        [items addObject:[self spacer]];
        [items addObjectsFromArray:leftBarButtonItems];
        
        [self mk_setLeftBarButtonItems:items];
    } else {
        [self mk_setLeftBarButtonItems:leftBarButtonItems];
    }
}

- (void)mk_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    
    if ([self isIOS7] && rightBarButtonItem) {
        [self mk_setRightBarButtonItem:nil];
        
        // Fix position issue in system vc, eg. cancel button in UIImagePickerController
        if (rightBarButtonItem.customView) {
            [self mk_setRightBarButtonItems:@[[self spacer], rightBarButtonItem]];
        } else {
            [self mk_setRightBarButtonItem:rightBarButtonItem];
        }
    } else {
        if ([self isIOS7]) {
            [self mk_setRightBarButtonItems:nil];
        }
        [self mk_setRightBarButtonItem:rightBarButtonItem];
    }
}

- (void)mk_setRightBarButtonItems:(NSArray *)rightBarButtonItems {
    if ([self isIOS7] && rightBarButtonItems && rightBarButtonItems.count > 0) {
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:rightBarButtonItems.count + 1];
        [items addObject:[self spacer]];
        [items addObjectsFromArray:rightBarButtonItems];
        [self mk_setRightBarButtonItems:items];
    } else {
        [self mk_setRightBarButtonItems:rightBarButtonItems];
    }
}

+ (void)mk_swizzle:(SEL)aSelector {
    SEL bSelector = NSSelectorFromString([NSString stringWithFormat:@"mk_%@", NSStringFromSelector(aSelector)]);
    Method m1 = class_getInstanceMethod(self, aSelector);
    Method m2 = class_getInstanceMethod(self, bSelector);
    method_exchangeImplementations(m1, m2);
}

+ (void)load {
    [self mk_swizzle:@selector(setLeftBarButtonItem:)];
    [self mk_swizzle:@selector(setLeftBarButtonItems:)];
    [self mk_swizzle:@selector(setRightBarButtonItem:)];
    [self mk_swizzle:@selector(setRightBarButtonItems:)];
}

@end
