//
//  TTBasePopupView.h
//  QQCircle
//
//  Created by Min Lin on 2018/3/8.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TTPopupAnimation) {
    TTPopupAnimationEaseInEaseOut,
    TTPopupAnimationAlert,
    TTPopupAnimationFromTop,
    TTPopupAnimationFromBottom,
    TTPopupAnimationDefault = TTPopupAnimationEaseInEaseOut
};

@interface TTBasePopupView : UIView

@property (nonatomic, strong, readonly) UIView *backgroundView;
@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, readonly, getter=isShowing) BOOL showing;

// 初始化
- (instancetype)initWithContainerHeight:(CGFloat)containerHeight;

// 显示/隐藏
- (void)showInView:(UIView *)view animation:(TTPopupAnimation)animation;
- (void)dismiss;

// 创建子视图
- (void)setupSubviews;

@end
