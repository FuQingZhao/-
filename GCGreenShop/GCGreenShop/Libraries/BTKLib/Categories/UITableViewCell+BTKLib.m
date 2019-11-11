//
//  UITableViewCell+BTKLib.m
//  iNanjing
//
//  Created by LinMin on 2017/12/26.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UITableViewCell+BTKLib.h"

@implementation UITableViewCell (BTKLib)

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

+ (instancetype)btk_CellForTableView:(UITableView *)tableView
                               style:(UITableViewCellStyle)style
                     reuseIdentifier:(NSString *)reuseIdentifier
                       configuration:(void (^)(UITableViewCell *cell))configuration {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (configuration) {
            configuration(cell);
        }
    }
    return cell;
}

+ (instancetype)btk_CellForTableView:(UITableView *)tableView
                     reuseIdentifier:(NSString *)reuseIdentifier
                       configuration:(void (^)(UITableViewCell *cell))configuration {
    return [[self class] btk_CellForTableView:tableView
                                        style:UITableViewCellStyleDefault
                              reuseIdentifier:reuseIdentifier
                                configuration:configuration];
}

+ (instancetype)btk_BlankCellForTableView:(UITableView *)tableView {
    static NSString *blankIdentifier = @"BTKBlankIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blankIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithReuseIdentifier:blankIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
