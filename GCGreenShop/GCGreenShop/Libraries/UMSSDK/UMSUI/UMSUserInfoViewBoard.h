//
//  UMSUserInfoViewBoard.h
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSBaseViewBoard.h"

extern NSString* const kUIImageField;        // 图片名
extern NSString* const kUITitleField;        // 标题
extern NSString* const kUILinePaddingField;  // 分隔线的左边距，值小于0表示不需要线
extern NSString* const kUIClassField;        // 点击跳转的ViewController名，为空表示不需要跳转
extern NSString* const kUIRowHeightField;    // Cell高度
extern NSString* const kUINeedLoginField;    // 是否需要登录

@interface UMSUserInfoViewBoard : UMSBaseViewBoard <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) UITableView *tableView;

/** 设置Cell样式 */
@property (nonatomic, copy) NSArray *sectionInfoArray;

@end
