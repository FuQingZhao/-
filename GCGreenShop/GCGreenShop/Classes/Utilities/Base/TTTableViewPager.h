//
//  TTTableViewPager.h
//  QQCircle
//
//  Created by Min Lin on 2018/3/7.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import "TTTableViewController.h"

@interface TTTableViewPager : TTTableViewController

/**
 是否已加载过数据
 */
@property (nonatomic, assign) BOOL hasLoadData;

/**
 获取数据
 */
- (void)fetchPageData;

@end
