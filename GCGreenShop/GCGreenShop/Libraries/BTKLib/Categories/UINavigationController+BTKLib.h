//
//  UINavigationController+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/10.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (BTKLib)

/**
 动画Push一个视图控制器
 @param  controller viewcontroler
 @param  transition 动画方式
 */
- (void)pushViewController:(UIViewController *)controller transition:(UIViewAnimationTransition)transition;
- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition;

/**
 寻找Navigation中的某个viewcontroler对象
 @param className viewcontroler名称
 @return viewcontroler对象
 */
- (id)findViewController:(NSString *)className;

/**
 判断是否只有一个RootViewController
 @return 是否只有一个RootViewController
 */
- (BOOL)isOnlyContainRootViewController;

/**
 RootViewController
 @return RootViewController
 */
- (UIViewController *)rootViewController;

/**
 返回指定的viewcontroler
 @param className 指定viewcontroler类名
 @param animated  是否动画
 @return pop之后的viewcontrolers
 */
- (NSArray<UIViewController *> *)popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;

/**
 pop n层
 @param level  n层
 @param animated  是否动画
 @return pop之后的viewcontrolers
 */
- (NSArray<UIViewController *> *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;

/**
 推出
 @return pop之后的viewcontroler
 */
- (UIViewController *)pop;

/**
 pop到根目录
 @return pop之后的viewcontrolers
 */
- (NSArray<UIViewController *> *)popToRoot;

/**
 取消模态视图
 */
- (void)dismiss;

@end
