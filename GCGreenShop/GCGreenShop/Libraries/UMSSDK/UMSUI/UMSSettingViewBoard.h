//
//  UMSSettingViewBoard.h
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSBaseViewBoard.h"

extern NSString* const kSETImageField;        // 图片名
extern NSString* const kSETTitleField;        // 标题
extern NSString* const kSETValueField;        // 内容
extern NSString* const kSETRowHeightField;    // Cell高度

/** 默认Cell高度 */
static CGFloat const UMSDefSettingRowHeight = 60.0;

@interface UMSSettingViewBoard : UMSBaseViewBoard <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;

/** 设置Cell样式 */
@property (nonatomic, strong) NSMutableArray *rowInfoArray;

@end


@interface UMSSettingTableCell : UITableViewCell
- (void)load:(NSDictionary *)data;
@end
