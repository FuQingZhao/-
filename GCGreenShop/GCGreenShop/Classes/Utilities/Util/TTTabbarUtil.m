//
//  TTTabbarUtil.m
//  QQCircle
//
//  Created by Min Lin on 2018/3/7.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import "TTTabbarUtil.h"

#import "TTHomeTableViewBoard.h"
#import "TTShopHomeTableViewBoard.h"
#import "TTClassificationTableViewBoard.h"
#import "TTShoppingCartTableViewBoard.h"
#import "TTUserInfoTableViewBoard.h"

@implementation TTTabbarUtil

//+ (void)registerPlusButton {
//    return [TTIssueButton registerPlusButton];
//}

+ (CYLTabBarController *)tabBarControllerWithConfigure {
    
//    [[self class] registerPlusButton];
    
    NSArray *viewControllers = [[self class] viewControllers];
    NSArray *tabBarItemsAttributes = [[self class] tabBarItemsAttributes];
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:viewControllers
                                                                               tabBarItemsAttributes:tabBarItemsAttributes];
    [[self class] customizeTabBarAppearance:tabBarController];
    
    return tabBarController;
}

+ (UIViewController *)viewBoardWithTabBarAtIndex:(NSUInteger)index withClass:(Class)className {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UITabBarController *tabBarController = (UITabBarController *)window.rootViewController;
    UINavigationController *navBoard = [tabBarController.viewControllers objectWithIndex:index];
    NSArray *viewControllers = [navBoard viewControllers];
    for (UIViewController *viewController in viewControllers) {
        if ([viewController isKindOfClass:className]) {
            return viewController;
        }
    }
    return nil;
}

+ (CYLTabBarController *)currentTabbarController {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CYLTabBarController *tabBarController = (CYLTabBarController *)window.rootViewController;
    if ([tabBarController isKindOfClass:[CYLTabBarController class]]) {
        return tabBarController;
    }
    return nil;
}

+ (BTKNavigationController *)currentNavigationController {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CYLTabBarController *tabBarController = (CYLTabBarController *)window.rootViewController;
    NSInteger currentIndex = tabBarController.selectedIndex;
    BTKNavigationController *navBoard = [tabBarController.viewControllers objectWithIndex:currentIndex];
    return navBoard;
}

+ (UIViewController *)currentViewController {
    UINavigationController *curNav = [[self class] currentNavigationController];
    return [curNav topViewController];
}


#pragma mark - Private Methods

+ (NSArray<BTKViewBoard *> *)viewControllers {
    
    TTHomeTableViewBoard *homeBoard = [TTHomeTableViewBoard new];
    homeBoard.title = @"";
    homeBoard.tabBarItem.title = @"首页";
    homeBoard.isTop = YES;
    BTKNavigationController *homeNavi = [[BTKNavigationController alloc] initWithRootViewController:homeBoard];
    
    TTShopHomeTableViewBoard *shopHomeBoard = [TTShopHomeTableViewBoard new];
    shopHomeBoard.title = @"店铺";
    shopHomeBoard.tabBarItem.title = @"店铺";
    shopHomeBoard.isTop = YES;
    BTKNavigationController *shopHomeNavi = [[BTKNavigationController alloc] initWithRootViewController:shopHomeBoard];
    
    TTClassificationTableViewBoard *classificationBoard = [TTClassificationTableViewBoard new];
    classificationBoard.title = @"分类";
    classificationBoard.tabBarItem.title = @"分类";
    classificationBoard.isTop = YES;
    BTKNavigationController *classificationNavi = [[BTKNavigationController alloc] initWithRootViewController:classificationBoard];
    
    TTShoppingCartTableViewBoard *shoppingBoard = [TTShoppingCartTableViewBoard new];
    shoppingBoard.title = @"购物车";
    shoppingBoard.tabBarItem.title = @"购物车";
    shoppingBoard.isTop = YES;
    BTKNavigationController *shoppingNavi = [[BTKNavigationController alloc] initWithRootViewController:shoppingBoard];
    
    TTUserInfoTableViewBoard *userInfoBoard = [TTUserInfoTableViewBoard new];
    userInfoBoard.title = @"个人";
    userInfoBoard.tabBarItem.title = @"个人";
    userInfoBoard.isTop = YES;
    BTKNavigationController *userInfoNavi = [[BTKNavigationController alloc] initWithRootViewController:userInfoBoard];
    
    NSArray *viewControllers = @[homeNavi, shopHomeNavi, classificationNavi, shoppingNavi, userInfoNavi];
    
    return viewControllers;
}

+ (NSArray<NSDictionary *> *)tabBarItemsAttributes {
    
    NSDictionary *homeTabBarItemsAttributes = @{
                                                    CYLTabBarItemTitle : @"首页",
                                                    CYLTabBarItemImage : @"collection",
                                                    CYLTabBarItemSelectedImage : @"collection_fill"
                                                    };
    NSDictionary *shopHomeTabBarItemsAttributes = @{
                                                     CYLTabBarItemTitle : @"店铺",
                                                     CYLTabBarItemImage : @"service",
                                                     CYLTabBarItemSelectedImage : @"service_fill"
                                                     };
    NSDictionary *classificationTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"分类",
                                                  CYLTabBarItemImage : @"shop",
                                                  CYLTabBarItemSelectedImage : @"shop_fill"
                                                  };
    NSDictionary *shoppingTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"购物车",
                                                 CYLTabBarItemImage : @"people",
                                                 CYLTabBarItemSelectedImage : @"people_fill"
                                                 };
    NSDictionary *userInfoTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"个人",
                                                 CYLTabBarItemImage : @"people",
                                                 CYLTabBarItemSelectedImage : @"people_fill"
                                                 };
    NSArray *tabBarItemsAttributes = @[
                                       homeTabBarItemsAttributes,
                                       shopHomeTabBarItemsAttributes,
                                       classificationTabBarItemsAttributes,
                                       shoppingTabBarItemsAttributes,
                                       userInfoTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

+ (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = TT_Black_COLOR;
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = TTGreenColor;
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [tabBar setTitlePositionAdjustment:UIOffsetMake(0.0, -3.0)];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    /*
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]`;
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    if (@available(iOS 10, *)) {
        [tabBarController hideTabBadgeBackgroundSeparator];
    }
     */
}

@end
