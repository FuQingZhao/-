//
//  UITableViewCell+BTKLib.h
//  iNanjing
//
//  Created by LinMin on 2017/12/26.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (BTKLib)

/**
 初始化方法
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

/**
 Cell初始化
 
 @params  tableView        tableView
 @params  style            样式
 @params  reuseIdentifier  标识符
 @params  configuration    回调
 */
+ (instancetype)btk_CellForTableView:(UITableView *)tableView
                               style:(UITableViewCellStyle)style
                     reuseIdentifier:(NSString *)reuseIdentifier
                       configuration:(void (^)(UITableViewCell *cell))configuration;

/**
 Cell初始化
 
 @params  tableView        tableView
 @params  reuseIdentifier  标识符
 @params  configuration    回调
 */
+ (instancetype)btk_CellForTableView:(UITableView *)tableView
                     reuseIdentifier:(NSString *)reuseIdentifier
                       configuration:(void (^)(UITableViewCell *cell))configuration;

/**
 返回一个空Cell
 */
+ (instancetype)btk_BlankCellForTableView:(UITableView *)tableView;

@end
