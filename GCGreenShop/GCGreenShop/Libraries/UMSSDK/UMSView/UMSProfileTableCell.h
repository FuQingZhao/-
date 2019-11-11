//
//  UMSProfileTableCell.h
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/10.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* const kPROTitleField = @"Text";
static NSString* const kPROValueField = @"Value";
static NSString* const kPROLinePaddingField = @"LinePadding";
static NSString* const kPRORowHeightField = @"RowHeight";
static NSString* const kPROTableCellType = @"TableCellType";

typedef NS_ENUM(NSInteger, UMSProfileCellStyle) {
    UMSProfileCellStyleNormal = 0,   // 标准的Cell样式
    UMSProfileCellStyleWithAvatar    // 带头像的Cell样式
};

static CGFloat const defProfileNormalHeight = 56.0;
static CGFloat const defProfileAvatarHeight = 60.0;

@interface UMSProfileTableCell : UITableViewCell

/** linePadding的值小于0时，表示不需要画线 */
@property (nonatomic, assign) CGFloat linePadding;

- (void)configureDetailWithObject:(id)obj;

@end
