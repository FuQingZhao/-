//
//  BTKViewBoard.m
//  BTKLib
//
//  Created by launching on 2017/10/12.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "BTKViewBoard.h"
#import "UINavigationController+BTKLib.h"

@interface BTKViewBoard ()
@property (nonatomic, assign, readwrite) BTKTransitType transitType;
@property (nonatomic, strong, readwrite) UIButton *backBarButton;
@end

@implementation BTKViewBoard

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = TTCloudsColor;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
    
    [self customBackIndicatorWithImage:[UIImage imageNamed:@"nav_return"]];
    [self initData];
    [self setUpSubViews];
}

- (void)initData {
    // TODO:
}

- (void)setUpSubViews {
    // TODO:
}

- (void)customBackIndicatorWithImage:(UIImage *)image {
    /*
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationController.navigationBar.backIndicatorImage = image;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = image;
    self.navigationItem.backBarButtonItem = backItem;
     */
    if (!self.isTop) {
        self.backBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBarButton.frame = CGRectMake(0.0, 0.0, 34.0, 34.0);
        if([UIDevice currentDevice].systemVersion.doubleValue >= 11.0){
            self.backBarButton.translatesAutoresizingMaskIntoConstraints = NO;
        }
        self.backBarButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, -6.0, 0.0, 6.0);
        [self.backBarButton setImage:image forState:UIControlStateNormal];
        [self.backBarButton bk_addEventHandler:^(id sender) {
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBarButton];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}


#pragma mark - Methods

- (void)presentModalFrom:(BTKViewBoard *)viewBoard {
    self.transitType = BTKTransitTypeModal;
    BTKNavigationController *navigationController = [[BTKNavigationController alloc] initWithRootViewController:self];
    [viewBoard presentViewController:navigationController animated:YES completion:nil];
}

- (void)popBoard {
    if (self.transitType == BTKTransitTypeModal) {
        [self.navigationController dismiss];
    } else {
        [self.navigationController pop];
    }
}

- (void)popToRoot {
    if (self.transitType == BTKTransitTypeModal) {
        [self.navigationController dismiss];
    } else {
        [self.navigationController popToRoot];
    }
}

@end
