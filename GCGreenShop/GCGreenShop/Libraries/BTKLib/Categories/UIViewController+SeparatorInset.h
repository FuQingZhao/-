//
//  UIViewController+SeparatorInset.h
//  NIControls
//
//  Created by launching on 15/12/18.
//  Copyright © 2015年 launching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SeparatorInset)

- (void)setSeparatorInsetZeroWithTableView:(UITableView *)tableView;
- (void)setSeparatorInsetWithTableView:(UITableView *)tableView inset:(UIEdgeInsets)inset;

/*
 If you want to implement 'tableView:willDisplayCell:forRowAtIndexPath:' for 
 tableview delegate,you should use this method.
 */
- (void)es_tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
