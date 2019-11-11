//
//  BTKNavigationController.m
//  QQCircle
//
//  Created by Min Lin on 2018/3/11.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import "BTKNavigationController.h"

@interface BTKNavigationController ()

@end

@implementation BTKNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
