//
//  BTKTableViewCell.m
//  BTKLib
//
//  Created by launching on 2017/10/12.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "BTKTableViewCell.h"

@implementation BTKTableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

+ (instancetype)btk_CellForTableView:(UITableView *)tableView
                               style:(UITableViewCellStyle)style
                     reuseIdentifier:(NSString *)reuseIdentifier
                       configuration:(void (^)(BTKTableViewCell *cell))configuration {
    BTKTableViewCell *cell = (BTKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[BTKTableViewCell alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (configuration) {
            configuration(cell);
        }
    }
    return cell;
}

+ (instancetype)btk_CellForTableView:(UITableView *)tableView
                     reuseIdentifier:(NSString *)reuseIdentifier
                       configuration:(void (^)(BTKTableViewCell *cell))configuration {
    return [[self class] btk_CellForTableView:tableView
                                        style:UITableViewCellStyleDefault
                              reuseIdentifier:reuseIdentifier
                                configuration:configuration];
}

@end
