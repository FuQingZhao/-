//
//  BTKTableView.m
//  BTKLib
//
//  Created by launching on 2017/10/12.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "BTKTableView.h"
#import <MJRefresh/MJRefresh.h>

@interface BTKTableView ()
@property (readwrite) NSInteger pageIndex;
@end

@implementation BTKTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pageIndex = 0;
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}


#pragma mark - Methods

- (void)showsRefreshHeader {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 0;
        if (weakSelf.refreshingBlock) {
            weakSelf.refreshingBlock(weakSelf.pageIndex);
        }
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.mj_header.automaticallyChangeAlpha = YES;
}

- (void)hidesRefreshHeader {
    self.mj_header = nil;
}

- (void)showsRefreshFooterWithAuto:(BOOL)autoRefresh {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    
    // 上拉刷新
    if (autoRefresh) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.pageIndex ++;
            if (weakSelf.refreshingBlock) {
                weakSelf.refreshingBlock(weakSelf.pageIndex);
            }
        }];
    }
    else {
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.pageIndex ++;
            if (weakSelf.refreshingBlock) {
                weakSelf.refreshingBlock(weakSelf.pageIndex);
            }
        }];
    }
}

- (void)showsRefreshFooter {
    [self showsRefreshFooterWithAuto:YES];
}

- (void)hidesRefreshFooter {
    self.mj_footer = nil;
}

- (void)reloadDataWithNoMoreData:(BOOL)hasNoData {
    
    [super reloadData];
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    
    if (hasNoData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)reloadData {
    [self reloadDataWithNoMoreData:NO];
}

- (void)cleanNoMoreDataState {
    [self.mj_footer resetNoMoreData];
}

- (void)autoRefreshing {
    if (self.mj_header) {
        [self.mj_header beginRefreshing];
    }
}

@end
