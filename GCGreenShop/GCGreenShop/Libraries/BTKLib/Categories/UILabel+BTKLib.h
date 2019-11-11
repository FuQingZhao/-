//
//  UILabel+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/10.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BTKLib)

- (UILabel *(^)(NSTextAlignment))btk_TextAlignment;
- (UILabel *(^)(UIColor *))btk_BackgroundColor;
- (UILabel *(^)(UIColor *))btk_TextColor;
- (UILabel *(^)(NSString *))btk_Text;
- (UILabel *(^)(float))btk_FontSize;
- (UILabel *(^)(CGRect))btk_Rect;
- (UILabel *(^)(UIView *))btk_AddToSuperView;

/**
 Set this property to YES in order to enable the copy feature. Defaults to NO.
 */
@property (nonatomic) IBInspectable BOOL copyingEnabled;

/**
 Used to enable/disable the internal long press gesture recognizer. Defaults to YES.
 */
@property (nonatomic) IBInspectable BOOL shouldUseLongPressGestureRecognizer;

@end
