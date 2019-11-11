//
//  BTKViewBoard.h
//  BTKLib
//
//  Created by launching on 2017/10/12.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BTKTransitType) {
    BTKTransitTypePush = 0,
    BTKTransitTypeModal
};

@interface BTKViewBoard : UIViewController

/**
 是否为TopViewController
 默认为NO
 */
@property (nonatomic, assign) BOOL isTop;

/**
 动画过渡方式，默认为Push
 */
@property (nonatomic, assign, readonly) BTKTransitType transitType;

/**
 返回按钮
 */
@property (nonatomic, strong, readonly) UIButton *backBarButton;

/**
 在此方法中做数据的初始化
 */
- (void)initData;

/**
 在此方法中建立子视图
 */
- (void)setUpSubViews;

/**
 自定义返回按钮
 */
- (void)customBackIndicatorWithImage:(UIImage *)image;

/**
 模态方式弹出
 */
- (void)presentModalFrom:(BTKViewBoard *)viewBoard;

/**
 推出到上一个页面
 */
- (void)popBoard;

/**
 推出到根页面
 */
- (void)popToRoot;

@end
