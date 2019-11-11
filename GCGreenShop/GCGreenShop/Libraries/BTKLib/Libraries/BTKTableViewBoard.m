//
//  BTKTableViewBoard.m
//  BTKLib
//
//  Created by launching on 2017/10/12.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "TTTableViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface BTKTableViewBoard ()
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (readwrite) NSInteger pageIndex;
@end

/** 默认的PageIndex */
static NSInteger const defPageIndex = 0;

@implementation BTKTableViewBoard

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeAll];
    }
    
    self.tableView = [UITableView new];
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.estimatedRowHeight = 0.0;
    self.tableView.estimatedSectionHeaderHeight = 0.0;
    self.tableView.estimatedSectionFooterHeight = 0.0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setTableFooterView:[UIView new]];
    [self.view addSubview:self.tableView];
    
    [self setSeparatorInsetWithTableView:self.tableView inset:UIEdgeInsetsMake(0.0, kLeftPadding, 0.0, 0.0)];
}

- (void)initData {
    [super initData];
    self.pageIndex = defPageIndex;
}


#pragma mark - Methods

- (void)showsRefreshHeader {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = defPageIndex;
        if (weakSelf.refreshingBlock) {
            weakSelf.refreshingBlock(weakSelf.pageIndex);
        }
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)hidesRefreshHeader {
    self.tableView.mj_header = nil;
}

- (void)showsRefreshFooterWithAuto:(BOOL)autoRefresh {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 上拉刷新
    if (autoRefresh) {
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.pageIndex ++;
            if (weakSelf.refreshingBlock) {
                weakSelf.refreshingBlock(weakSelf.pageIndex);
            }
        }];
    }
    else {
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
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
    self.tableView.mj_footer = nil;
}

- (void)reloadDataWithNoMoreData:(BOOL)hasNoData {
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    if (hasNoData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)reloadData {
    [self reloadDataWithNoMoreData:NO];
}

- (void)cleanNoMoreDataState {
    [self.tableView.mj_footer resetNoMoreData];
}

- (void)autoRefreshing {
    if (self.tableView.mj_header) {
        [self.tableView.mj_header beginRefreshing];
    }
}


#pragma mark - 数据代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

@end
