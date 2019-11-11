//
//  UMSUserInfoViewBoard.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSUserInfoViewBoard.h"

@interface UMSUserInfoViewBoard ()
@property (nonatomic, strong, readwrite) UITableView *tableView;
@end

NSString* const kUIImageField = @"ImageName";
NSString* const kUITitleField = @"Text";
NSString* const kUILinePaddingField = @"LinePadding";
NSString* const kUIClassField = @"Class";
NSString* const kUIRowHeightField = @"RowHeight";
NSString* const kUINeedLoginField = @"NeedsLogin";

@implementation UMSUserInfoViewBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initData];
    [self _initTableView];
}


#pragma mark - UI

- (void)_initData {
    self.sectionInfoArray = [NSMutableArray arrayWithCapacity:5];
}

- (void)_initTableView {
    self.tableView = [UITableView new];
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.view sendSubviewToBack:self.tableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

@end
