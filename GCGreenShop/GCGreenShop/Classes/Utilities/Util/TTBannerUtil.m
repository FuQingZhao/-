//
//  TTBannerUtil.m
//  QQCircle
//
//  Created by 付清照 on 2018/3/8.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import "TTBannerUtil.h"

@implementation TTBannerUtil

+ (SDCycleScrollView *)ScrollNetWorkImages:(NSArray *)netImages
{
    CGRect rect = CGRectMake(10.0, 5.f, kScreenWidth - 20.0, 140.0);
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:nil placeholderImage:nil];
    cycleScrollView.layer.cornerRadius = 5.0;
    cycleScrollView.layer.masksToBounds = YES;
    cycleScrollView.imageURLStringsGroup = netImages;
    
    //设置图片视图显示类型
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    //设置轮播视图的分页控件的显示
    cycleScrollView.showPageControl = YES;
    //设置轮播视图分也控件的位置
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //选中圆圈的颜色
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    //底部圆圈颜色
    cycleScrollView.pageDotColor = RGBA(0, 0, 0, 0.6);
    cycleScrollView.autoScroll = YES;
    
    return cycleScrollView;
}

@end
