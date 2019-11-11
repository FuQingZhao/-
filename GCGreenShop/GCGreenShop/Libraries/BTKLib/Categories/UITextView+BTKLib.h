//
//  UITextView+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/10.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (BTKLib) <UITextViewDelegate>

// Zoom
@property (nonatomic) CGFloat maxFontSize;
@property (nonatomic) CGFloat minFontSize;
@property (nonatomic, getter = isZoomEnabled) BOOL zoomEnabled;

// Placeholder
@property (nonatomic, strong, readonly) UITextView *placeHolderTextView;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 当前选中的字符串范围
 @return NSRange
 */
- (NSRange)selectedRange;

/**
 选中所有文字
 */
- (void)selectAllText;

/**
 选中指定范围的文字
 @param range NSRange范围
 */
- (void)setSelectedRange:(NSRange)range;

/**
 用于计算textview输入情况下的字符数，解决实现限制字符数时，计算不准的问题
 @param text 输入的内容
 */
- (NSInteger)getInputLengthWithText:(NSString *)text;

@end
