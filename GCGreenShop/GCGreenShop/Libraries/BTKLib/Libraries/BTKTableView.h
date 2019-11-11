//
//  BTKTableView.h
//  BTKLib
//
//  Created by launching on 2017/10/12.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTKRefreshingBlock.h"

/**
 *  带有分页的TableView
 */
@interface BTKTableView : UITableView

@property (readonly) NSInteger pageIndex;
@property (nonatomic, copy) MJRefreshingBlock refreshingBlock;

/**
 显示下拉刷新控件
 */
- (void)showsRefreshHeader;

/**
 隐藏下拉刷新控件
 */
- (void)hidesRefreshHeader;

/**
 显示上拉刷新控件
 autoRefresh  表示是否自动加载更多数据    默认为YES
 */
- (void)showsRefreshFooterWithAuto:(BOOL)autoRefresh;
- (void)showsRefreshFooter;

/**
 隐藏上拉刷新控件
 */
- (void)hidesRefreshFooter;

/**
 刷新数据
 hasNoData  表示是否有更多数据  默认为NO
 */
- (void)reloadDataWithNoMoreData:(BOOL)hasNoData;
- (void)reloadData;

/**
 消除没有更多数据的状态
 */
- (void)cleanNoMoreDataState;

/**
 自动下拉刷新
 */
- (void)autoRefreshing;

@end
