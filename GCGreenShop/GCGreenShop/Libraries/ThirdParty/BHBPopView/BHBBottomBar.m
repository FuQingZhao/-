//
//  BHBBottomBar.m
//  BHBPopViewDemo
//
//  Created by 毕洪博 on 15/8/15.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import "BHBBottomBar.h"
#import "UIImageView+BHBSetImage.h"
#import "UIButton+BHBSetImage.h"
#import "UIView+BHBAnimation.h"

@interface BHBBottomBar ()

@property (nonatomic,weak) UIImageView * background;
@property (nonatomic,weak) UIButton * closeBtn;
@property (nonatomic,weak) UIButton * backBtn;
@property (nonatomic,weak) UIButton * secondCloseBtn;

@end

@implementation BHBBottomBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView * back = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        back.backgroundColor = [UIColor clearColor];
        [self addSubview:back];
        self.background = back;
        
        UIImage *backgImage = [UIImage imageNamed:@"发布背景"];
        UIImageView *closeBackgView = [[UIImageView alloc] initWithImage:backgImage];
        closeBackgView.size = backgImage.size;
        closeBackgView.centerX = self.width / 2.0;
        [self addSubview:closeBackgView];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = closeBackgView.frame;
        [btn setImage:[UIImage imageNamed:@"添加发布"] forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn RevolvingWithTime:.25 andDelta:(M_PI_4)];
        btn.userInteractionEnabled = NO;
        self.closeBtn = btn;
        
        UIButton * backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backbtn.frame = CGRectMake(0, 0, frame.size.width / 2, frame.size.height);
        [backbtn bhb_setImage:@"images.bundle/tabbar_compose_background_icon_return"];
        [backbtn bhb_setBGImage:@"images.bundle/tabbar_compose_left_button"];
        [self addSubview:backbtn];
        [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        backbtn.alpha = 0;
        backbtn.userInteractionEnabled = NO;
        self.backBtn = backbtn;
        
        UIButton * secCloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        secCloseBtn.frame = CGRectMake(frame.size.width / 2, 0, frame.size.width / 2, frame.size.height);
        [secCloseBtn bhb_setImage:@"images.bundle/tabbar_compose_background_icon_close"];
        [secCloseBtn bhb_setBGImage:@"images.bundle/tabbar_compose_right_button"];
        [self addSubview:secCloseBtn];
        [secCloseBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        secCloseBtn.alpha = 0;
        secCloseBtn.userInteractionEnabled = NO;
        self.secondCloseBtn = secCloseBtn;
    }
    return self;
}

- (void)close {
    [self fadeOutWithTime:.25];
    [self btnResetPosition];
    if (self.closeClick) {
        self.closeClick();
    }
}

- (void)back:(UIButton *)btn{
    self.isMoreBar = NO;
    if (self.backClick) {
        self.backClick();
    }
}

- (void)setIsMoreBar:(BOOL)isMoreBar {
    
    _isMoreBar = isMoreBar;
    if (isMoreBar) {
        [UIView animateWithDuration:.25 animations:^{
            self.closeBtn.alpha = 0;
            self.backBtn.alpha = 1;
            self.secondCloseBtn.alpha = 1;
            self.backBtn.userInteractionEnabled = YES;
            self.secondCloseBtn.userInteractionEnabled = YES;
        }];
    } else {
        [UIView animateWithDuration:.25 animations:^{
            self.closeBtn.alpha = 1;
            self.backBtn.alpha = 0;
            self.secondCloseBtn.alpha = 0;
            self.backBtn.userInteractionEnabled = NO;
            self.secondCloseBtn.userInteractionEnabled = NO;
        }];
    }
}

//恢复按钮位置
- (void)btnResetPosition {
    if (self.closeBtn) {
        [self.closeBtn RevolvingWithTime:.25 andDelta:0];
    }
}

@end
