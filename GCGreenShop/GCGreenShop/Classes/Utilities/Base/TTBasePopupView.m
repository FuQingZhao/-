//
//  TTBasePopupView.m
//  QQCircle
//
//  Created by Min Lin on 2018/3/8.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import "TTBasePopupView.h"

@interface TTBasePopupView () <CAAnimationDelegate>
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) TTPopupAnimation animationType;
@end

#define defContainerHeight (kScreenHeight * 3.0 / 4.0)

@implementation TTBasePopupView

- (instancetype)initWithContainerHeight:(CGFloat)containerHeight {
    
    CGRect viewFrame = CGRectMake(0.0, 0.0, kScreenWidth, kScreenHeight);
    self = [super initWithFrame:viewFrame];
    if (self) {
        
        self.backgroundView = [UIView new];
        self.backgroundView.frame = self.bounds;
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        self.backgroundView.alpha = 0.0;
        [self addSubview:self.backgroundView];
        
        self.containerView = [UIView new];
        self.containerView.backgroundColor = [UIColor whiteColor];
        self.containerView.size = CGSizeMake(self.width, containerHeight);
        self.containerView.top = self.height;
        [self addSubview:self.containerView];
        
        [self setupSubviews];
    }
    return self;
}

- (instancetype)init {
    return [self initWithContainerHeight:defContainerHeight];
}

- (void)showInView:(UIView *)view animation:(TTPopupAnimation)animation {
    
    self.animationType = animation;
    
    [self.backgroundView setAlpha:1.0];
    [self.containerView setAlpha:1.0];
    [view addSubview:self];
    
    if (animation == TTPopupAnimationFromBottom) {
        [self.containerView setTop:self.height];
        [UIView animateWithDuration:0.35 animations:^{
            [self.backgroundView setAlpha:1.0];
            [self.containerView setBottom:self.height];
        } completion:^(BOOL finished) {
            _showing = YES;
        }];
    }
    else if (animation == TTPopupAnimationFromTop) {
        [self.containerView setBottom:0.0];
        [UIView animateWithDuration:0.35 animations:^{
            [self.backgroundView setAlpha:1.0];
            [self.containerView setTop:0.0];
        } completion:^(BOOL finished) {
            _showing = YES;
        }];
    }
    else if (animation == TTPopupAnimationAlert) {
        [self.containerView setCenter:self.center];
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration = 0.4;
        popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
        popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        popAnimation.delegate = self;
        [self.containerView.layer addAnimation:popAnimation forKey:nil];
    }
    else {
        [self.containerView setCenter:self.center];
        [self.containerView setAlpha:0.0];
        [UIView animateWithDuration:0.35 animations:^{
            [self.backgroundView setAlpha:1.0];
            [self.containerView setAlpha:1.0];
        } completion:^(BOOL finished) {
            _showing = YES;
        }];
    }
}

- (void)dismiss {
    
    if (self.animationType == TTPopupAnimationFromBottom) {
        [UIView animateWithDuration:0.35 animations:^{
            [self.backgroundView setAlpha:0.0];
            [self.containerView setTop:self.height];
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                _showing = NO;
            }
        }];
    }
    else if (self.animationType == TTPopupAnimationFromTop) {
        [UIView animateWithDuration:0.35 animations:^{
            [self.backgroundView setAlpha:0.0];
            [self.containerView setBottom:0.0];
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                _showing = NO;
            }
        }];
    }
    else if (self.animationType == TTPopupAnimationAlert) {
        [UIView animateWithDuration:0.2 animations:^{
            self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                _showing = NO;
            }];
        }];
    }
    else {
        [UIView animateWithDuration:0.35 animations:^{
            [self.backgroundView setAlpha:0.0];
            [self.containerView setAlpha:0.0];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            _showing = NO;
        }];
    }
}

- (void)setupSubviews {
    // TODO:
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _showing = YES;
}

@end
