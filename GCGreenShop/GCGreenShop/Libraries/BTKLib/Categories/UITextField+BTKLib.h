//
//  UITextField+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/10.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (BTKLib)

// Padding
@property (nonatomic, assign) CGFloat leftPadding;

/**
 *  identity of this textfield
 */
@property (retain, nonatomic) NSString *identify;

/**
 *  @brief load textfiled input history
 *
 *  @return the history of it's input
 */
- (NSArray *)loadHistroy;

/**
 *  save current input text
 */
- (void)synchronize;

- (void)showHistory;
- (void)hideHistroy;

- (void)clearHistory;

/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)selectedRange;

@end
