//
//  UMSIndicatorTextView.h
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/9.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const defTextViewHeight = 53.0;      // 默认输入框的高度

@interface UMSIndicatorTextView : UIView

@property (nonatomic, strong, readonly) UITextField *innerTextField;
@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, copy, readonly) NSString *text;

@end
