//
//  BTKTableViewCell.h
//  BTKLib
//
//  Created by launching on 2017/10/12.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTKTableViewCell : UITableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

+ (instancetype)btk_CellForTableView:(UITableView *)tableView
                               style:(UITableViewCellStyle)style
                     reuseIdentifier:(NSString *)reuseIdentifier
                       configuration:(void (^)(BTKTableViewCell *cell))configuration;

+ (instancetype)btk_CellForTableView:(UITableView *)tableView
                     reuseIdentifier:(NSString *)reuseIdentifier
                       configuration:(void (^)(BTKTableViewCell *cell))configuration;

@end
